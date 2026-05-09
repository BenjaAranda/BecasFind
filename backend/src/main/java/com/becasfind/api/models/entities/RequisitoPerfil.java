package com.becasfind.api.models.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "requisitos_perfil")
public class RequisitoPerfil {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_requisito")
    private Long idRequisito;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_beca", nullable = false, unique = true)
    private Beca beca;

    @Column(name = "rsh_maximo_porcentaje")
    private Integer rshMaximoPorcentaje;

    @Column(name = "nem_minimo", precision = 3, scale = 1)
    private BigDecimal nemMinimo;

    @Column(name = "paes_minimo")
    private Integer paesMinimo;

    @Column(name = "es_para_primer_anio", nullable = false)
    private Boolean esParaPrimerAnio = false;

    @Column(name = "es_para_curso_superior", nullable = false)
    private Boolean esParaCursoSuperior = false;
}
