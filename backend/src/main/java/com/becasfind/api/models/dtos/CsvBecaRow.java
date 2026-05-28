package com.becasfind.api.models.dtos;

import com.opencsv.bean.CsvBindByName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CsvBecaRow {

    @CsvBindByName(column = "nombre", required = true)
    private String nombre;

    @CsvBindByName(column = "institucion", required = true)
    private String institucion;

    @CsvBindByName(column = "tipo_beca")
    private String tipoBeca;

    @CsvBindByName(column = "monto")
    private String monto;

    @CsvBindByName(column = "fecha_inicio")
    private String fechaInicio;

    @CsvBindByName(column = "fecha_cierre")
    private String fechaCierre;

    @CsvBindByName(column = "rsh_maximo")
    private String rshMaximo;

    @CsvBindByName(column = "nem_minimo")
    private String nemMinimo;

    @CsvBindByName(column = "regiones")
    private String regiones;

    @CsvBindByName(column = "descripcion")
    private String descripcion;

    @CsvBindByName(column = "descripcion_larga")
    private String descripcionLarga;

    @CsvBindByName(column = "url")
    private String url;

    @CsvBindByName(column = "documentos_requeridos")
    private String documentosRequeridos;
}
