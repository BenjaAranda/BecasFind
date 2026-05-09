package com.becasfind.api.models.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "documentos_requeridos")
public class DocumentoRequerido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_documento")
    private Long idDocumento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_beca", nullable = false)
    private Beca beca;

    @Column(name = "nombre_documento", nullable = false, length = 255)
    private String nombreDocumento;

    @Column(name = "es_obligatorio", nullable = false)
    private Boolean esObligatorio = true;
}
