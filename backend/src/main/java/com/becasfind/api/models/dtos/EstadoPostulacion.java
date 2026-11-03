package com.becasfind.api.models.dtos;

import java.time.LocalDate;
import java.time.ZoneId;

public enum EstadoPostulacion {
    ABIERTA, CERRADA, PROXIMA, FECHAS_POR_CONFIRMAR, EN_REVISION;

    public static EstadoPostulacion calcular(Boolean activa, LocalDate inicio, LocalDate cierre) {
        return calcular(activa, inicio, cierre, LocalDate.now(ZoneId.of("America/Santiago")));
    }

    public static EstadoPostulacion calcular(Boolean activa, LocalDate inicio, LocalDate cierre, LocalDate hoy) {
        if (cierre != null && cierre.isBefore(hoy)) return CERRADA;
        if (inicio != null && cierre != null && !cierre.isBefore(inicio) && inicio.isAfter(hoy)) return PROXIMA;
        if (Boolean.TRUE.equals(activa) && cierre != null && (inicio == null || !inicio.isAfter(hoy))) return ABIERTA;
        return FECHAS_POR_CONFIRMAR;
    }
}
