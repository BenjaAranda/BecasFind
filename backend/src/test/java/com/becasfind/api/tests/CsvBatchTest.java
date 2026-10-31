package com.becasfind.api.tests;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DelegatingDataSource;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import com.becasfind.api.services.BecaImportService;
import javax.sql.DataSource;
import java.lang.reflect.Proxy;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import static org.junit.jupiter.api.Assertions.*;

@Import(CsvBatchTest.Measurement.class)
class CsvBatchTest extends BaseTest {
    static final List<Integer> batches = new CopyOnWriteArrayList<>();
    @Autowired BecaImportService importer;

    @Test void fiftyOneScholarshipsUseRealJdbcBatches() {
        StringBuilder csv = new StringBuilder("nombre,institucion,tipo_beca,monto,fecha_inicio,fecha_cierre,rsh_maximo,nem_minimo,regiones,descripcion,descripcion_larga,url\n");
        for (int i = 0; i < 51; i++) csv.append("Batch medida ").append(i).append(",DUOC UC,Beca de Arancel,100,2026-01-01,2026-12-31,,,RM,Educación,Enseñanza,https://example.com/becas\n");
        batches.clear();
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin@becasfind.cl", null, List.of()));
        try {
            var result = importer.importarDesdeCsv(new MockMultipartFile("file", "batch.csv", "text/csv", csv.toString().getBytes(StandardCharsets.UTF_8)));
            assertEquals(0, result.getErrores(), result.getMensajesError().toString());
            assertEquals(51, result.getCreadas());
            assertEquals(51, batches.stream().mapToInt(Integer::intValue).sum(), "JDBC INSERT observados: " + batches);
            System.out.println("Observed scholarship JDBC batches: " + batches);
            assertTrue(batches.contains(50), "Debe existir un batch efectivo de 50: " + batches);
        } finally { SecurityContextHolder.clearContext(); }
    }

    @TestConfiguration
    static class Measurement {
        @Bean static BeanPostProcessor measureJdbc() {
            return new BeanPostProcessor() {
                @Override public Object postProcessAfterInitialization(Object bean, String name) {
                    if (!(bean instanceof DataSource source)) return bean;
                    return new DelegatingDataSource(source) {
                        @Override public Connection getConnection() throws java.sql.SQLException { return wrap(super.getConnection()); }
                        @Override public Connection getConnection(String user, String password) throws java.sql.SQLException { return wrap(super.getConnection(user, password)); }
                    };
                }
            };
        }
        static Connection wrap(Connection connection) {
            return (Connection) Proxy.newProxyInstance(Connection.class.getClassLoader(), new Class<?>[]{Connection.class}, (proxy, method, args) -> {
                try {
                    Object result = method.invoke(connection, args);
                    if (method.getName().equals("prepareStatement") && args[0] instanceof String sql && sql.toLowerCase(java.util.Locale.ROOT).startsWith("insert into becas ")) {
                        PreparedStatement statement = (PreparedStatement) result;
                        int[] size = {0};
                        return Proxy.newProxyInstance(PreparedStatement.class.getClassLoader(), new Class<?>[]{PreparedStatement.class}, (p, m, a) -> {
                            try {
                                Object value = m.invoke(statement, a);
                                if (m.getName().equals("addBatch")) size[0]++;
                                if (m.getName().equals("executeBatch")) { batches.add(size[0]); size[0] = 0; }
                                if (m.getName().equals("clearBatch")) size[0] = 0;
                                return value;
                            } catch (InvocationTargetException ex) { throw ex.getCause(); }
                        });
                    }
                    return result;
                } catch (InvocationTargetException ex) { throw ex.getCause(); }
            });
        }
    }
}
