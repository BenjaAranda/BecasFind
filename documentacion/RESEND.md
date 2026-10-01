# Resend: configuración pendiente del usuario

Resend entrega los correos transaccionales que permiten recuperar una contraseña de BecasFind. El backend ya construye el enlace de un uso, lo envía mediante su API y valida errores; el frontend permite solicitarlo y cambiar la contraseña. No se usa para almacenar las becas ni para alojar la web.

Resend ofrece un plan Free; la aplicación debe permanecer en ese plan, sin activar sobrecostes ni contratar servicios. La navegación pública no depende del correo. Referencia: [plan gratuito](https://resend.com/pricing). No se autoriza comprar un dominio: el envío general debe resolverse dentro del presupuesto cero antes de habilitarlo.

## Primera prueba sin comprar un dominio

1. Crear la cuenta en https://resend.com/signup con el correo propio y completar su verificación. El usuario debe introducir contraseña, OAuth/MFA y los códigos de verificación.
2. Abrir https://resend.com/api-keys y crear una clave dedicada a BecasFind con permiso Sending access. Guardarla al crearla; su valor no se podrá volver a consultar. No pegarla en el chat ni en el frontend.
3. En backend/.env (archivo privado e ignorado por Git), completar:

```dotenv
RESET_EMAIL_ENABLED=true
RESEND_API_KEY=valor_privado_obtenido_en_resend
RESET_EMAIL_FROM=BecasFind <onboarding@resend.dev>
FRONTEND_URL=http://localhost:5173
```

FRONTEND_URL es el origen del frontend realmente usado para la prueba. HTTP local solo está permitido con el perfil dev. Conservar las variables de base de datos/JWT existentes. No subir .env a GitHub.

4. Informar en el chat que la clave quedó en backend/.env e indicar el correo propio de la cuenta Resend (sin compartir la clave). Con esos datos puedo completar la configuración y ejecutar una prueba de recuperación autorizada a tu bandeja: recepción, enlace, cambio de contraseña, login y rechazo del enlace reutilizado.

El remitente onboarding@resend.dev permite una primera prueba **solo al correo asociado a tu cuenta Resend**. No permite enviar recuperación a otros estudiantes. Referencia oficial: [restricción del dominio de pruebas](https://resend.com/docs/knowledge-base/403-error-resend-dev-domain).

## Antes de enviar a usuarios reales

Agregar un dominio propio bajo https://resend.com/domains, configurar sus registros DNS según Resend y esperar su verificación. Usar un remitente de ese dominio, por ejemplo recuperacion@tu-dominio; no se ha reservado ni comprado ningún dominio en esta entrega. FRONTEND_URL deberá ser el origen HTTPS público. Estos cambios y la comprobación del entorno público pertenecen al despliegue, que no se inició.

Las claves permanecen exclusivamente en el backend. Consultar [gestión de claves](https://resend.com/docs/dashboard/api-keys/introduction) para permisos y restricciones. Las condiciones/cuotas del proveedor deben comprobarse al crear la cuenta; no se promete servicio gratuito ilimitado.

## Estado real

P09 está pendiente porque el usuario confirmó que no tiene cuenta ni configuración. Las pruebas con proveedor simulado no demuestran llegada a una bandeja real. No se ha enviado ningún correo externo ni se ha creado una cuenta en nombre del usuario.
