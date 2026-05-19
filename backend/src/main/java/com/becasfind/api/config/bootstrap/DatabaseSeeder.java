package com.becasfind.api.config.bootstrap;

import com.becasfind.api.models.entities.Rol;
import com.becasfind.api.models.entities.Usuario;
import com.becasfind.api.repositories.RolRepository;
import com.becasfind.api.repositories.UsuarioRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Component
@Order(1)
@Profile("!test")
public class DatabaseSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(DatabaseSeeder.class);

    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PasswordEncoder passwordEncoder;

    public DatabaseSeeder(UsuarioRepository usuarioRepository,
                          RolRepository rolRepository,
                          PasswordEncoder passwordEncoder) {
        this.usuarioRepository = usuarioRepository;
        this.rolRepository = rolRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) {
        seedAdminUser();
        seedStudentUser();
    }

    private void seedAdminUser() {
        Rol rolAdmin = rolRepository.findByNombreRol("ADMIN")
                .orElseThrow(() -> new IllegalStateException("Rol ADMIN no encontrado en la base de datos"));

        Usuario admin = usuarioRepository.findByEmail("admin@becasfind.cl").orElse(null);

        if (admin != null) {
            admin.setPasswordHash(passwordEncoder.encode("admin123"));
            admin.setActivo(true);
            usuarioRepository.save(admin);
            log.info("Usuario admin existente actualizado con nuevo hash BCrypt: admin@becasfind.cl");
        } else {
            admin = new Usuario();
            admin.setEmail("admin@becasfind.cl");
            admin.setPasswordHash(passwordEncoder.encode("admin123"));
            admin.setNombreCompleto("Admin BecasFind");
            admin.setRol(rolAdmin);
            admin.setActivo(true);
            usuarioRepository.save(admin);
            log.info("Usuario admin creado exitosamente: admin@becasfind.cl");
        }
    }

    private void seedStudentUser() {
        Rol rolStudent = rolRepository.findByNombreRol("STUDENT")
                .orElseThrow(() -> new IllegalStateException("Rol STUDENT no encontrado en la base de datos"));

        Usuario estudiante = usuarioRepository.findByEmail("estudiante@duoc.cl").orElse(null);

        if (estudiante != null) {
            estudiante.setPasswordHash(passwordEncoder.encode("admin123"));
            estudiante.setActivo(true);
            usuarioRepository.save(estudiante);
            log.info("Usuario estudiante existente actualizado con nuevo hash BCrypt: estudiante@duoc.cl");
        } else {
            estudiante = new Usuario();
            estudiante.setEmail("estudiante@duoc.cl");
            estudiante.setPasswordHash(passwordEncoder.encode("admin123"));
            estudiante.setNombreCompleto("Maria Gonzalez");
            estudiante.setRol(rolStudent);
            estudiante.setActivo(true);
            usuarioRepository.save(estudiante);
            log.info("Usuario estudiante creado exitosamente: estudiante@duoc.cl");
        }
    }
}
