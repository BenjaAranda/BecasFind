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
@Table(name = "instituciones")
public class Institucion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_institucion")
    private Long idInstitucion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_tipo_inst", nullable = false)
    private TipoInstitucion tipoInstitucion;

    @Column(nullable = false, unique = true, length = 20)
    private String rut;

    @Column(nullable = false, length = 255)
    private String nombre;

    @Column(name = "sitio_web", length = 255)
    private String sitioWeb;

    @Column(name = "contacto_email", length = 255)
    private String contactoEmail;
}
