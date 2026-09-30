package com.becasfind.api.tests;

import com.becasfind.api.models.dtos.BecaRequest;
import com.becasfind.api.models.dtos.CoberturaDTO;
import com.becasfind.api.services.BecaService;
import com.becasfind.api.services.FavoritoService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_CLASS)
class MonetaryCoverageTest extends BaseTest {
    @Autowired BecaService becas;
    @Autowired FavoritoService favoritos;

    private BecaRequest request(String name, String amount, String currency, String period) {
        var r = new BecaRequest();
        r.setNombre(name);
        r.setIdInstitucion(1L);
        r.setIdTipoBeca(1L);
        r.setEstadoActiva(true);
        r.setFechaCierrePostulacion(LocalDate.of(2030, 12, 31));
        r.setMontoCobertura("Texto original: " + name);
        if (currency != null) {
            var c = new CoberturaDTO();
            c.setTipo("MONETARIA");
            c.setImporte(amount == null ? null : new BigDecimal(amount));
            c.setMoneda(currency);
            c.setPeriodicidad(period);
            r.setCobertura(c);
        }
        return r;
    }

    private List<Long> ids(String sort, int page, int size) {
        return becas.buscarBecas(null, null, null, "Monetaria-", null, null, null, sort,
                PageRequest.of(page, size)).map(b -> b.getIdBeca()).getContent();
    }

    @Test @Transactional
    void numericSortingGroupsUnitsAndKeepsUnknownAmountsLastAcrossPages() {
        long high = becas.create(1L, request("Monetaria-alta", "10000", "CLP", "ANUAL")).getIdBeca();
        long low = becas.create(1L, request("Monetaria-baja", "900", "CLP", "ANUAL")).getIdBeca();
        long zero = becas.create(1L, request("Monetaria-cero", "0", "CLP", "ANUAL")).getIdBeca();
        long monthly = becas.create(1L, request("Monetaria-mes", "1", "CLP", "MENSUAL")).getIdBeca();
        long usd = becas.create(1L, request("Monetaria-dólar", "1.25", "USD", "ANUAL")).getIdBeca();
        long unknown = becas.create(1L, request("Monetaria-desconocida", null, null, null)).getIdBeca();
        long tie = becas.create(1L, request("Monetaria-empate", "900", "CLP", "ANUAL")).getIdBeca();
        assertEquals(List.of(zero, low, tie, high, monthly, usd, unknown), ids("montoAsc", 0, 100));
        assertEquals(List.of(high, low, tie, zero, monthly, usd, unknown), ids("montoDesc", 0, 100));
        assertEquals(List.of(tie, high), ids("montoAsc", 1, 2));
        assertEquals(7, becas.buscarBecas(null, null, 2L, "Monetaria-", null, null, null,
                "montoAsc", PageRequest.of(0, 2)).getTotalElements());
    }

    @Test @Transactional
    void detailListAndFavoritesPreserveExactDecimalAndOriginalText() {
        var r = request("Cobertura decimal", "1234.56", "USD", "UNICA");
        long id = becas.create(1L, r).getIdBeca();
        var d = becas.findById(id);
        assertEquals(r.getMontoCobertura(), d.getMontoCobertura());
        assertEquals(0, new BigDecimal("1234.56").compareTo(d.getCobertura().getImporte()));
        favoritos.guardar("estudiante@duoc.cl", id);
        var favorite = favoritos.listar("estudiante@duoc.cl").stream().filter(b -> b.getIdBeca() == id).findFirst().orElseThrow();
        assertEquals("USD", favorite.getCobertura().getMoneda());
        assertEquals("UNICA", favorite.getCobertura().getPeriodicidad());
    }

    @Test @Transactional
    void legacyEditsPreserveMetadataOnlyIfCoverageTextIsUnchanged() {
        var r = request("Cobertura heredada", "900", "CLP", "ANUAL");
        long id = becas.create(1L, r).getIdBeca();
        r.setCobertura(null);
        becas.update(id, r);
        assertNotNull(becas.findById(id).getCobertura().getImporte());
        r.setMontoCobertura("Ahora cubre transporte");
        becas.update(id, r);
        assertEquals("DESCONOCIDA", becas.findById(id).getCobertura().getTipo());
        assertNull(becas.findById(id).getCobertura().getImporte());
    }

    @Test @Transactional
    void percentagesAndNonMonetaryBenefitsNeverBecomeCurrencyAmounts() {
        var r = request("Cobertura porcentual", null, null, null);
        var c = new CoberturaDTO(); c.setTipo("PORCENTUAL"); c.setPorcentaje(new BigDecimal("75.50"));
        r.setCobertura(c);
        long id = becas.create(1L, r).getIdBeca();
        assertNull(becas.findById(id).getCobertura().getImporte());
        assertEquals(0, new BigDecimal("75.5").compareTo(becas.findById(id).getCobertura().getPorcentaje()));
        c.setTipo("NO_MONETARIA"); c.setPorcentaje(null);
        becas.update(id, r);
        assertEquals("NO_MONETARIA", becas.findById(id).getCobertura().getTipo());
    }

    @Test
    void invalidMetadataIsRejectedOverHttpBeforeWrites() {
        String token = adminToken();
        for (var coverage : List.of(
                Map.of("tipo", "MONETARIA", "importe", -1, "moneda", "CLP"),
                Map.of("tipo", "MONETARIA", "importe", 1),
                Map.of("tipo", "MONETARIA", "importe", 1, "moneda", "ZZZ"),
                Map.of("tipo", "MONETARIA", "importe", "1.001", "moneda", "CLP"),
                Map.of("tipo", "MONETARIA", "importe", "10000000000000000", "moneda", "CLP"),
                Map.of("tipo", "PORCENTUAL", "porcentaje", 101),
                Map.of("tipo", "NO_MONETARIA", "importe", 1),
                Map.of("tipo", "MONETARIA", "periodicidad", "DIARIA"))) {
            var payload = Map.of("nombre", "Cobertura inválida", "idInstitucion", 1,
                    "idTipoBeca", 1, "estadoActiva", true, "fechaCierrePostulacion", "2030-12-31", "cobertura", coverage);
            assertEquals(400, post("/api/becas", token, payload, Map.class).getStatusCode().value());
        }
        assertTrue(becas.buscarBecas(null, null, null, "Cobertura inválida", null, null, null,
                "fechaAsc", PageRequest.of(0, 10)).isEmpty());
    }

    @Test
    void httpDecimalStringsPreserveMaximumPrecisionAndPersistAcrossRequests() {
        String token = adminToken();
        var request = request("Cobertura precisión HTTP", "9999999999999999.99", "CLP", "ANUAL");
        var response = post("/api/becas", token, request, Map.class);
        assertEquals(201, response.getStatusCode().value());
        var data = (Map<?, ?>) response.getBody().get("data");
        long id = ((Number) data.get("idBeca")).longValue();
        try {
            assertEquals("9999999999999999.99", ((Map<?, ?>) data.get("cobertura")).get("importe"));
            var detail = (Map<?, ?>) get("/api/becas/" + publicScholarshipId(id), null, Map.class).getBody().get("data");
            assertEquals("9999999999999999.99", ((Map<?, ?>) detail.get("cobertura")).get("importe"));
        } finally { delete("/api/becas/" + id, token); }
    }

    @Test
    void explicitUnknownClearsMetadataAndInvalidServiceUpdateRollsBack() {
        var r = request("Cobertura controlada", "900", "CLP", null);
        long id = becas.create(1L, r).getIdBeca();
        r.getCobertura().setImporte(new BigDecimal("-1"));
        assertThrows(IllegalArgumentException.class, () -> becas.update(id, r));
        assertEquals(0, new BigDecimal("900").compareTo(becas.findById(id).getCobertura().getImporte()));
        var unknown = new CoberturaDTO(); unknown.setTipo("DESCONOCIDA");
        r.setCobertura(unknown);
        becas.update(id, r);
        assertNull(becas.findById(id).getCobertura().getImporte());
        becas.delete(id);
    }
}
