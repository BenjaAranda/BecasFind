package com.becasfind.api.repositories;

import com.becasfind.api.models.entities.PasswordResetToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {

    Optional<PasswordResetToken> findByToken(String token);

    @Modifying
    @Query("DELETE FROM PasswordResetToken t WHERE t.usuario.idUsuario = :idUsuario")
    void deleteByUsuarioId(@Param("idUsuario") Long idUsuario);

    @Modifying
    @Query("DELETE FROM PasswordResetToken t WHERE t.fechaExpiracion < :now")
    void deleteExpiredTokens(@Param("now") LocalDateTime now);
}
