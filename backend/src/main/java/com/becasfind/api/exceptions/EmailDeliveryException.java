package com.becasfind.api.exceptions;

/** Mensaje deliberadamente genérico: nunca incluye la clave, el token o el cuerpo del proveedor. */
public class EmailDeliveryException extends RuntimeException {
    public EmailDeliveryException() {
        super("No se pudo entregar el correo de recuperación");
    }
}
