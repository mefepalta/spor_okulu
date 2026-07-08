// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonOk => 'Aceptar';

  @override
  String get commonResend => 'Reenviar';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleCoach => 'Entrenador';

  @override
  String get roleParent => 'Padre/Madre';

  @override
  String get roleStudent => 'Estudiante';

  @override
  String get roleViewer => 'Espectador';

  @override
  String get roleUnknown => 'Desconocido';

  @override
  String get loginHeading => 'Gestión de Escuela Deportiva';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'example@sporokulu.com';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginLoading => 'Iniciando sesión...';

  @override
  String get forgotPassword => 'Olvidé mi contraseña';

  @override
  String get noAccountRegister => '¿No tienes una cuenta? Regístrate';

  @override
  String get emailEmpty => 'El correo electrónico no puede estar vacío.';

  @override
  String get emailInvalid => 'Introduce un correo electrónico válido.';

  @override
  String get passwordEmpty => 'La contraseña no puede estar vacía.';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get emailNotVerifiedTitle => 'Correo no verificado';

  @override
  String get emailNotVerifiedBody =>
      'Para activar tu cuenta, toca el enlace de verificación enviado a tu correo. Si no ha llegado, podemos enviarlo de nuevo.';

  @override
  String get verificationResent =>
      'Correo de verificación reenviado. Revisa también tu carpeta de spam.';

  @override
  String get rejectedTitle => 'Tu solicitud fue rechazada';

  @override
  String get rejectedBody =>
      'Tu solicitud de rol fue rechazada por un administrador. Tu cuenta se está cerrando.';

  @override
  String get resetPasswordNeedEmail =>
      'Primero introduce tu correo electrónico para restablecer la contraseña.';

  @override
  String get resetPasswordSent =>
      'Se ha enviado un enlace para restablecer la contraseña a tu correo electrónico.';

  @override
  String get resetPasswordError =>
      'Se produjo un error al restablecer la contraseña.';

  @override
  String get resetInvalidEmail => 'Introduce un correo electrónico válido.';

  @override
  String get resetUserNotFound =>
      'No hay ningún usuario registrado con este correo electrónico.';

  @override
  String get userNotFound => 'Usuario no encontrado.';

  @override
  String loginCheckError(Object error) {
    return 'Se produjo un error durante la comprobación de inicio de sesión: $error';
  }

  @override
  String get authInvalidEmail =>
      'La dirección de correo electrónico no es válida.';

  @override
  String get authUserDisabled => 'Esta cuenta de usuario está deshabilitada.';

  @override
  String get authWrongCredentials =>
      'Correo electrónico o contraseña incorrectos.';

  @override
  String get authNetwork =>
      'No se pudo conectar a internet. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get authOperationNotAllowed =>
      'El inicio de sesión con correo/contraseña no está habilitado en la Consola de Firebase.';

  @override
  String get authConfigNotFound =>
      'No se encontró la configuración de Firebase Authentication. Comprueba los ajustes de la Consola de Firebase.';

  @override
  String get authAppNotAuthorized =>
      'Esta app de Android no parece estar autorizada para el proyecto de Firebase.';

  @override
  String get authInvalidApiKey =>
      'La clave de API de Firebase parece no ser válida.';

  @override
  String get authTooManyRequests =>
      'Demasiados intentos de inicio de sesión. Inténtalo de nuevo más tarde.';

  @override
  String authGenericWithCode(String code) {
    return 'No se pudo iniciar sesión. Código de error: $code';
  }

  @override
  String get registerTitle => 'Registrarse';

  @override
  String get registerHeading => 'Crear una cuenta nueva';

  @override
  String get firstNameLabel => 'Nombre';

  @override
  String get lastNameLabel => 'Apellidos';

  @override
  String get passwordAgainLabel => 'Confirmar contraseña';

  @override
  String get passwordAgainEmpty =>
      'La confirmación de la contraseña no puede estar vacía.';

  @override
  String get passwordsDontMatch => 'Las contraseñas no coinciden.';

  @override
  String get accountType => 'Tu tipo de cuenta';

  @override
  String get selectionSentToAdmin =>
      'Tu selección se enviará para la aprobación del administrador.';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get registerLoading => 'Guardando...';

  @override
  String requiredField(String label) {
    return '$label no puede estar vacío.';
  }

  @override
  String get registerSuccess =>
      'Cuenta creada. Toca el enlace de verificación enviado a tu correo. Tu solicitud de rol se ha enviado para la aprobación del administrador.';

  @override
  String get registerGenericError => 'Se produjo un error durante el registro.';

  @override
  String get emailAlreadyInUse => 'Este correo electrónico ya está en uso.';

  @override
  String get passwordTooWeak =>
      'La contraseña es demasiado débil. Usa al menos 6 caracteres.';

  @override
  String registerErrorWith(Object error) {
    return 'Error de registro: $error';
  }

  @override
  String get userNotCreated => 'No se pudo crear el usuario.';

  @override
  String get roleRequestsTitle => 'Solicitudes de rol';

  @override
  String get noPendingRequests => 'No hay solicitudes pendientes';

  @override
  String get noPendingRequestsBody =>
      'Las solicitudes de rol de los nuevos registros aparecen aquí.';

  @override
  String get approveTitle => 'Aprobar solicitud';

  @override
  String approveConfirm(String name, String role) {
    return '$name será ascendido a $role. ¿Lo apruebas?';
  }

  @override
  String get approveAction => 'Aprobar';

  @override
  String approvedSnack(String name, String role) {
    return '$name ahora es $role.';
  }

  @override
  String get rejectTitle => 'Rechazar solicitud';

  @override
  String rejectConfirm(String name) {
    return 'La solicitud de $name será rechazada y la cuenta eliminada. Esto no se puede deshacer. ¿Continuar?';
  }

  @override
  String get rejectAction => 'Rechazar';

  @override
  String rejectedSnack(String name) {
    return 'La solicitud de $name fue rechazada.';
  }

  @override
  String requestLabel(String role) {
    return 'Solicitud: $role';
  }

  @override
  String get genericOperationError =>
      'Se produjo un error durante la operación.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileUserFallback => 'Usuario';

  @override
  String get roleDescAdmin =>
      'Puede añadir, editar y eliminar todos los registros.';

  @override
  String get roleDescCoach =>
      'Puede gestionar los registros de asistencia y anuncios. Puede ver otros registros.';

  @override
  String get roleDescParent =>
      'Puede seguir el rendimiento de su hijo/a y responder a la participación en eventos.';

  @override
  String get roleDescStudent =>
      'Puede ver su propia información de asistencia y rendimiento.';

  @override
  String get roleDescViewer =>
      'Puede ver los registros, pero no puede hacer cambios.';

  @override
  String get childrenSectionStudent => 'Mi información de estudiante';

  @override
  String get childrenSectionParent => 'Mis estudiantes';

  @override
  String get authorityTitle => 'Permisos';

  @override
  String get appearanceTitle => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get backgroundEffectTitle => 'Efecto de fondo';

  @override
  String get backgroundEffectDesc =>
      'Alto: olas + partículas · Medio: solo olas · Bajo: fondo liso.';

  @override
  String get backgroundHigh => 'Alto';

  @override
  String get backgroundMedium => 'Medio';

  @override
  String get backgroundLow => 'Bajo';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get editAccount => 'Editar cuenta';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String get whatsappSupport => 'Soporte por WhatsApp';

  @override
  String get kvkkTitle => 'Aviso de Protección de Datos Personales';

  @override
  String get termsTitle => 'Términos de uso';

  @override
  String get privacyTitle => 'Política de privacidad';

  @override
  String get appVersionLabel => 'Versión de la app';

  @override
  String get logout => 'Cerrar sesión';
}
