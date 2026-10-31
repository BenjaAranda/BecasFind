import type {Page} from '@playwright/test';
export async function contrastFailures(page:Page){return page.evaluate(()=>{
   const canvas=document.createElement('canvas');canvas.width=canvas.height=1;const ctx=canvas.getContext('2d',{willReadFrequently:true})!;
   const rgba=(color:string)=>{ctx.clearRect(0,0,1,1);ctx.fillStyle=color;ctx.fillRect(0,0,1,1);return [...ctx.getImageData(0,0,1,1).data];};
   const light=(c:number[])=>c.slice(0,3).map(x=>{x/=255;return x<=.04045?x/12.92:((x+.055)/1.055)**2.4;}).reduce((n,x,i)=>n+x*[.2126,.7152,.0722][i],0);
   const failures:unknown[]=[];
   for(const el of document.querySelectorAll('label,h1,h2,h3,p,a,button,span')){
    if(![...el.childNodes].some(n=>n.nodeType===3&&n.textContent?.trim()) || !el.getBoundingClientRect().width || (el.closest('button') as HTMLButtonElement)?.disabled)continue;
    const style=getComputedStyle(el);if(style.visibility==='hidden')continue;
    let bg=[255,255,255,255];const ancestors:Element[]=[];for(let e:Element|null=el;e;e=e.parentElement)ancestors.unshift(e);
    for(const e of ancestors){const c=rgba(getComputedStyle(e).backgroundColor);bg=c.slice(0,3).map((v,i)=>v*c[3]/255+bg[i]*(1-c[3]/255)).concat(255);}
    const fg=rgba(style.color).slice(0,3);const a=light(fg),b=light(bg);const ratio=(Math.max(a,b)+.05)/(Math.min(a,b)+.05);const large=parseFloat(style.fontSize)>=24||(parseFloat(style.fontSize)>=18.66&&parseInt(style.fontWeight)>=700);
    if(ratio+0.02<(large?3:4.5))failures.push({text:el.textContent?.trim().slice(0,70),ratio:ratio.toFixed(2),color:style.color});
   }
   return failures;
});}
