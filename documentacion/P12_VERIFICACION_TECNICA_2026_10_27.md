# P12: verificación técnica del 27 de octubre de 2026

**Corte local anterior a la aceptación remota.** Este informe heredado conserva los resultados de la otra sesión. Sus pendientes de correo, navegador y catálogo quedaron sustituidos por la evidencia real posterior del 27/10 en [P12_DESPLIEGUE.md](../infra/P12_DESPLIEGUE.md). No ejecutar de nuevo la configuración por las instrucciones históricas de este documento.

Este informe corresponde al trabajo técnico. La revisión de fuentes, calendario y
activación de becas continúa en otro chat; sus archivos y scripts no se modifican.

## Resultado local

- `npm run build`: aprobado. TypeScript y Vite compilan. Vite muestra una advertencia
  de deprecación de `module.register()` con el runtime Node instalado.
- `npm run lint`: aprobado, código de salida 0.
- Backend con Java 17 y Maven de IntelliJ: `compile test` aprobado para
  `GmailResetEmailServiceTest` y `ResendResetEmailServiceTest`: 12 pruebas,
  cero fallos/errores/omitidas. Son pruebas locales con proveedores simulados;
  no certifican envío real desde Oracle. No se instaló ni activó otro proveedor.
- Sintaxis de todos los scripts PowerShell de `infra` y de sus 25 scripts Python:
  correcta en el corte de esta revisión.
- Playwright: se intentaron los recorridos existentes de búsqueda anónima, sesión,
  recuperación y perfil/favoritos en Chromium. El entorno rechazó el arranque del
  navegador con `browserType.launch: spawn EPERM`. No se ejecutaron las interacciones
  y no se acredita ninguna prueba visual ni de integración con Oracle por este intento.

Estos resultados corresponden al árbol local. No acreditan que la preview de Vercel
o la imagen desplegada contengan todos los cambios locales. Se debe relacionar el
commit y los artefactos antes del cierre de P12.

## Comprobación de correo preparada

`infra/check-p12-smtp.py` comprueba conexión a smtp.gmail.com:587, STARTTLS obligatorio,
certificado con nombre de servidor y EHLO tras TLS. Usa la biblioteca estándar de
Python. No lee archivos de secretos, no autentica, no envía mensajes ni cambia el backend.

Validación local del script: sintaxis y ayuda correctas; tres comprobaciones con
servidor simulado aprobadas (validación de certificado/nombre, rechazo sin STARTTLS
y error de conexión sin volcar contenido). No se realizó conexión real a Gmail.

Ejecutar desde la terminal Ubuntu de Oracle, cuando el archivo esté allí:

```bash
python3 infra/check-p12-smtp.py --output /tmp/becasfind-smtp-check.json
```

Alternativa directa desde **PowerShell de Windows**, sin copiar el archivo:

```powershell
& "C:\Users\benja\Documents\BecasFind\infra\check-p12-smtp.ps1"
```

El wrapper usa la clave protegida `~/.ssh/becasfind`, comprueba la identidad SSH
conocida y transmite el comprobador a `python3 -` en Oracle. Puede pedir la frase
de la clave SSH en la terminal. Su sintaxis fue validada; la ejecución remota sigue
pendiente y no se presenta como aprobada.

Para copiarlo desde PowerShell en Windows:

```powershell
scp -i "$HOME\.ssh\becasfind" "C:\Users\benja\Documents\BecasFind\infra\check-p12-smtp.py" ubuntu@155.181.41.231:~/becasfind-p12/infra/
```

En Ubuntu, primero `cd ~/becasfind-p12`. El éxito exige `conexion_tls: true` y salida 0.
Un resultado local del PC no acredita conectividad desde Oracle. Una conexión TLS
correcta tampoco acredita autenticación, envío ni recepción.

El correo remoto sigue pendiente: una nueva contraseña de aplicación de Gmail debe
introducirse en el destino de forma privada. Después corresponde probar la recuperación
con una cuenta de prueba autorizada, preservando la cuenta ADMIN del usuario.

No se crearon recursos, contrataron servicios ni promovieron despliegues en esta revisión.
P12 permanece abierta; P13/P14 conservan su autorización por fase.
