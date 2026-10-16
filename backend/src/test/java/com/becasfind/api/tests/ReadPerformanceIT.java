package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ConnectionCallback;
import java.util.*;
import java.util.concurrent.*;
import java.nio.file.*;
import static org.junit.jupiter.api.Assertions.*;

// Explicit PostgreSQL measurement; not part of the default H2 unit suite.
class ReadPerformanceIT extends BaseTest {
    @Autowired JdbcTemplate jdbc;
    @Test void boundedReadLatencyWithFiveThousandScholarshipsAndFourReaders() throws Exception {
        assertEquals("PostgreSQL", jdbc.execute((ConnectionCallback<String>)c -> c.getMetaData().getDatabaseProductName()));
        jdbc.update("insert into becas (id_institucion,id_tipo_beca,id_usuario_creador,nombre,descripcion_corta,fecha_cierre_postulacion,estado_activa) select 1,1,1,'Read benchmark '||i,'Educación de prueba',date '2099-12-31',true from generate_series(1,5000) i");
        jdbc.update("insert into requisitos_perfil (id_beca,rsh_maximo_porcentaje,nem_minimo) select id_beca,80,5.0 from becas where nombre like 'Read benchmark %'");
        jdbc.execute("analyze becas");
        jdbc.execute("analyze requisitos_perfil");
        String token = studentToken();
        Map<String,Object> request=Map.of("query","Read benchmark","rsh",60,"nem",5.5,"regionId",1,"sort","fechaAsc","size",20,"page",0);
        for(int i=0;i<10;i++) assertEquals(200,post("/api/becas/buscar",token,request,Map.class).getStatusCode().value());
        ExecutorService pool=Executors.newFixedThreadPool(4);
        List<Double> durations=new ArrayList<>();
        try {
            List<Callable<Double>> reads=new ArrayList<>();
            for(int i=0;i<80;i++) reads.add(()->{
                long start=System.nanoTime();
                var response=post("/api/becas/buscar",token,request,Map.class);
                assertEquals(200,response.getStatusCode().value());
                Map<?,?> data=(Map<?,?>)response.getBody().get("data");
                assertEquals(5000,((Number)data.get("totalElements")).intValue());
                assertEquals(20,((List<?>)data.get("content")).size());
                return (System.nanoTime()-start)/1_000_000.0;
            });
            for(Future<Double> read:pool.invokeAll(reads,90,TimeUnit.SECONDS))durations.add(read.get());
        }finally{pool.shutdownNow();}
        Collections.sort(durations);
        double p50=durations.get(39),p95=durations.get(75),max=durations.get(79);
        String report=String.format(Locale.ROOT,"{\"rows\":5000,\"readers\":4,\"warmup\":10,\"samples\":80,\"p50Ms\":%.2f,\"p95Ms\":%.2f,\"maxMs\":%.2f,\"budgetP95Ms\":1000,\"scope\":\"local PostgreSQL HTTP search; fixtures; not production\"}",p50,p95,max);
        System.out.println("READ_PERFORMANCE "+report);
        Path out=Path.of(System.getProperty("becas.performance.output","target/performance-read.json"));Files.createDirectories(out.toAbsolutePath().getParent());Files.writeString(out,report,java.nio.charset.StandardCharsets.UTF_8);
        assertTrue(p95<1000,"p95 exceeded local synthetic budget: "+report);
    }
}
