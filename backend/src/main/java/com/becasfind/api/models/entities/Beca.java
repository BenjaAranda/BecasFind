package com.becasfind.api.models.entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "becas", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombre", "id_institucion"})})
public class Beca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_beca")
    private Long idBeca;

    @Column(name = "public_id", nullable = false, unique = true, updatable = false)
    @org.hibernate.annotations.ColumnDefault("RANDOM_UUID()")
    private java.util.UUID publicId = java.util.UUID.randomUUID();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_institucion", nullable = false)
    private Institucion institucion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_tipo_beca", nullable = false)
    private TipoBeca tipoBeca;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario_creador", nullable = false)
    private Usuario usuarioCreador;

    @Column(nullable = false, length = 255)
    private String nombre;

    @Column(name = "descripcion_corta", columnDefinition = "TEXT")
    private String descripcionCorta;

    @Column(name = "descripcion_larga", columnDefinition = "TEXT")
    private String descripcionLarga;

    @Column(name = "monto_cobertura", length = 255)
    private String montoCobertura;

    @Column(name = "cobertura_tipo", nullable = false, length = 20)
    @org.hibernate.annotations.ColumnDefault("'DESCONOCIDA'")
    private String coberturaTipo = "DESCONOCIDA";
    @Column(name = "cobertura_importe", precision = 18, scale = 2)
    private java.math.BigDecimal coberturaImporte;
    @Column(name = "cobertura_moneda", length = 3)
    private String coberturaMoneda;
    @Column(name = "cobertura_periodicidad", length = 20)
    private String coberturaPeriodicidad;
    @Column(name = "cobertura_porcentaje", precision = 5, scale = 2)
    private java.math.BigDecimal coberturaPorcentaje;

    // Old clients and CSV keep metadata only while the original source text is unchanged.
    public void setMontoCobertura(String texto) {
        if (!java.util.Objects.equals(montoCobertura, texto)) {
            coberturaTipo = "DESCONOCIDA";
            coberturaImporte = null;
            coberturaMoneda = null;
            coberturaPeriodicidad = null;
            coberturaPorcentaje = null;
        }
        montoCobertura = texto;
    }


    @Column(name = "fecha_inicio_postulacion")
    private LocalDate fechaInicioPostulacion;

    @Column(name = "fecha_cierre_postulacion", nullable = false)
    private LocalDate fechaCierrePostulacion;

    @Column(name = "url_oficial", length = 500)
    private String urlOficial;

    @Column(name = "estado_activa", nullable = false)
    private Boolean estadoActiva = true;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "becas_regiones",
            joinColumns = @JoinColumn(name = "id_beca"),
            inverseJoinColumns = @JoinColumn(name = "id_region")
    )
    private Set<Region> regiones = new HashSet<>();

    @OneToOne(mappedBy = "beca", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private RequisitoPerfil requisitoPerfil;

    @OneToMany(mappedBy = "beca", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<DocumentoRequerido> documentosRequeridos = new ArrayList<>();
}
