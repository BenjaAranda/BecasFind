import { chromium } from '@playwright/test';
import { spawn } from 'node:child_process';
import { gzipSync } from 'node:zlib';
import { readFileSync,readdirSync,mkdirSync,writeFileSync } from 'node:fs';
const assets=readdirSync('dist/assets').map(name=>({name,gzip:gzipSync(readFileSync('dist/assets/'+name)).length}));
const js=assets.filter(a=>a.name.endsWith('.js')).reduce((n,a)=>n+a.gzip,0),css=assets.filter(a=>a.name.endsWith('.css')).reduce((n,a)=>n+a.gzip,0);
if(js>150*1024||css>30*1024)throw new Error('Bundle budget exceeded');
const server=spawn(process.execPath,['node_modules/vite/bin/vite.js','preview','--host','127.0.0.1','--port','5199','--strictPort'],{stdio:'ignore'});
let browser;
try{
 for(let i=0;i<100;i++){try{if((await fetch('http://127.0.0.1:5199')).ok)break;}catch{}await new Promise(r=>setTimeout(r,100));}
 browser=await chromium.launch();const measurements=[];
 for(const mode of ['desktop-local','mobile-throttled'])for(let run=0;run<5;run++){
  const context=await browser.newContext({viewport:{width:mode==='desktop-local'?1280:390,height:900}});
  const page=await context.newPage();
  if(mode==='mobile-throttled'){const cdp=await context.newCDPSession(page);await cdp.send('Emulation.setCPUThrottlingRate',{rate:4});await cdp.send('Network.enable');await cdp.send('Network.emulateNetworkConditions',{offline:false,latency:80,downloadThroughput:200000,uploadThroughput:100000});}
  await page.addInitScript(()=>{window.__metrics={lcp:0,cls:0};new PerformanceObserver(list=>{for(const e of list.getEntries())window.__metrics.lcp=e.startTime;}).observe({type:'largest-contentful-paint',buffered:true});new PerformanceObserver(list=>{for(const e of list.getEntries())if(!e.hadRecentInput)window.__metrics.cls+=e.value;}).observe({type:'layout-shift',buffered:true});});
  await page.goto('http://127.0.0.1:5199');await page.locator('h1').waitFor();await page.waitForTimeout(1000);
  const metric=await page.evaluate(()=>({...window.__metrics,fcp:performance.getEntriesByName('first-contentful-paint')[0]?.startTime}));measurements.push({mode,run,...metric});await context.close();
 }
 const median=(xs)=>xs.sort((a,b)=>a-b)[Math.floor(xs.length/2)];const results=['desktop-local','mobile-throttled'].map(mode=>({mode,lcpMedian:median(measurements.filter(m=>m.mode===mode).map(m=>m.lcp)),clsMax:Math.max(...measurements.filter(m=>m.mode===mode).map(m=>m.cls))}));
 const report={timestamp:new Date().toISOString(),jsGzip:js,cssGzip:css,assets,measurements,results,limits:{lcpMedian:2500,clsMax:.1,jsGzip:150*1024,cssGzip:30*1024},scope:'Built landing page; local preview; mobile CPU x4, latency 80ms, download 200000 B/s. Synthetic, not production/RUM.'};
 mkdirSync('performance-report',{recursive:true});writeFileSync('performance-report/frontend.json',JSON.stringify(report,null,2));console.log(JSON.stringify(report,null,2));
 if(results.some(r=>r.lcpMedian<=0||r.lcpMedian>2500||r.clsMax>.1))throw new Error('Rendering budget exceeded');
}finally{if(browser)await browser.close();server.kill();}
