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

  @override
  String get commonAll => 'Todos';

  @override
  String get commonAdd => 'Añadir';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get viewAction => 'Ver';

  @override
  String get statusPaid => 'Pagado';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusOverdue => 'Vencido';

  @override
  String get leaveStatusPending => 'Pendiente';

  @override
  String get leaveStatusApproved => 'Aprobado';

  @override
  String get leaveStatusRejected => 'Rechazado';

  @override
  String get drawerMainPanel => 'Panel principal';

  @override
  String get sectionRecords => 'Registros';

  @override
  String get sectionOperations => 'Operaciones';

  @override
  String get sectionClub => 'Club';

  @override
  String get sectionGeneral => 'General';

  @override
  String get sectionMyChild => 'Mi hijo/a';

  @override
  String get sectionMe => 'Yo';

  @override
  String get navStudents => 'Estudiantes';

  @override
  String get navCoaches => 'Entrenadores';

  @override
  String get navGroups => 'Grupos';

  @override
  String get navParents => 'Padres';

  @override
  String get navStudentAccounts => 'Cuentas de estudiantes';

  @override
  String get navAttendance => 'Asistencia';

  @override
  String get navLeaveRequests => 'Justificantes';

  @override
  String get navPayments => 'Pagos';

  @override
  String get navPerformance => 'Rendimiento';

  @override
  String get navEvents => 'Eventos';

  @override
  String get navEquipment => 'Inventario';

  @override
  String get navAnnouncements => 'Anuncios';

  @override
  String get navClubCash => 'Caja del club';

  @override
  String get navReports => 'Informes';

  @override
  String get navSports => 'Deportes';

  @override
  String get navUsers => 'Usuarios';

  @override
  String get navReportAbsence => 'Notificar ausencia';

  @override
  String get navMyPerformance => 'Mi rendimiento';

  @override
  String get navMyAttendance => 'Mi asistencia';

  @override
  String get notificationsTooltip => 'Notificaciones';

  @override
  String get notifCategoryAnnouncement => 'Anuncio';

  @override
  String get notifCategoryPayment => 'Pago';

  @override
  String get notifCategoryLeave => 'Justificante';

  @override
  String get notifCategoryAbsence => 'Ausencia';

  @override
  String get leaveWaitingApproval => 'En espera de aprobación';

  @override
  String notifLeaveTitle(String name) {
    return '$name • justificante';
  }

  @override
  String notifAbsenceTitle(String name) {
    return '$name estuvo ausente';
  }

  @override
  String errorLoadingData(Object error) {
    return 'Se produjo un error al cargar los datos: $error';
  }

  @override
  String get reminderDialogTitle => 'Nuevo recordatorio';

  @override
  String get reminderDialogHint => 'Ej.: Pedir material el martes';

  @override
  String get newAnnouncementPublished => 'Se publicó un nuevo anuncio.';

  @override
  String newAnnouncementsPublished(int count) {
    return 'Se publicaron $count nuevos anuncios.';
  }

  @override
  String get remindersTitle => 'Recordatorios rápidos';

  @override
  String get remindersEmpty => 'Aún no has añadido ningún recordatorio.';

  @override
  String get aiIntroParent =>
      'Conozco el resumen actual de tu hijo/a. Puedes elegir una de las opciones de abajo o escribir tu propia pregunta.';

  @override
  String get aiIntroStudent =>
      'Conozco tu estado actual. Puedes elegir una de las opciones de abajo o escribir tu propia pregunta.';

  @override
  String get aiIntroStaff =>
      'Conozco el resumen actual de tu club. Puedes elegir una de las opciones de abajo o escribir tu propia pregunta.';

  @override
  String get viewerWelcomeSubtitle => 'Bienvenido/a a la escuela deportiva.';

  @override
  String get requestPendingTitle => 'Tu solicitud está en revisión';

  @override
  String requestPendingMessage(String role) {
    return 'Tu solicitud para ser $role está pendiente de la aprobación del administrador. Una vez aprobada, podrás acceder al panel correspondiente.';
  }

  @override
  String get requestApprovedTitle => 'Tu solicitud fue aprobada';

  @override
  String get requestApprovedMessage =>
      'Solo tienes que cerrar sesión y volver a iniciarla para ver tu nuevo rol.';

  @override
  String get roleNotAssignedTitle => 'Tu rol aún no ha sido asignado';

  @override
  String get roleNotAssignedMessage =>
      'Cuando un administrador te asigne un rol, accederás al panel correspondiente.';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get studentGreetingSubtitle => 'Tu estado actual está abajo.';

  @override
  String parentGreetingSubtitleOne(String name) {
    return '$name • resumen actual';
  }

  @override
  String get parentGreetingSubtitleMany =>
      'El resumen actual de tus hijos está abajo.';

  @override
  String get staffGreetingSubtitle =>
      'El resumen actual de tu club está abajo.';

  @override
  String highlightOverdueDues(String amount) {
    return 'Cuotas vencidas: $amount';
  }

  @override
  String get highlightGreatAttendance =>
      '¡Tu asistencia es excelente, sigue así! 🎯';

  @override
  String get highlightWatchAttendance => 'Vigilemos un poco la asistencia';

  @override
  String get highlightPlannedEvent =>
      'Hay un evento planificado, no te lo pierdas';

  @override
  String get highlightAllGood => 'Todo parece estar bien 👍';

  @override
  String highlightPaymentsPending(int count) {
    return '$count pagos en espera de seguimiento';
  }

  @override
  String highlightLeavePending(int count) {
    return '$count justificantes en espera de aprobación';
  }

  @override
  String get highlightNoPending => 'No tienes tareas pendientes, ¡genial! 👍';

  @override
  String get statPerformance => 'Rendimiento';

  @override
  String get statEvent => 'Evento';

  @override
  String get statAnnouncement => 'Anuncio';

  @override
  String get statMyChild => 'Mi hijo/a';

  @override
  String get statStudent => 'Estudiante';

  @override
  String get statCoach => 'Entrenador';

  @override
  String get statGroup => 'Grupo';

  @override
  String noteNew(int count) {
    return '$count nuevos';
  }

  @override
  String noteWaiting(int count) {
    return '$count pendientes';
  }

  @override
  String get attendanceSummaryTitle => 'Resumen de asistencia';

  @override
  String get attendanceEmpty => 'Aún no hay registros de asistencia.';

  @override
  String get metricLessons => 'Clases';

  @override
  String get metricRecords => 'Registros';

  @override
  String get metricPresent => 'Presente';

  @override
  String get metricAbsent => 'Ausente';

  @override
  String get metricAttendanceRate => 'Asistencia';

  @override
  String get absenceNoteOne => '1 nuevo registro de ausencia';

  @override
  String absenceNoteMany(int count) {
    return '$count nuevos registros de ausencia';
  }

  @override
  String get financeSummaryTitle => 'Resumen financiero';

  @override
  String get financeEmpty => 'Aún no hay registros de pago.';

  @override
  String get metricCollected => 'Cobrado';

  @override
  String get metricPending => 'Pendiente';

  @override
  String get metricOverdue => 'Vencido';

  @override
  String get clubCashTitle => 'Caja del club';

  @override
  String get ledgerAction => 'Libro';

  @override
  String get clubCashEmpty => 'Aún no hay movimientos de caja.';

  @override
  String get metricBalance => 'Caja';

  @override
  String get metricIncome => 'Ingresos';

  @override
  String get metricExpense => 'Gastos';

  @override
  String unpaidDuesTitle(int count) {
    return 'Cuotas impagadas ($count)';
  }

  @override
  String moreStudents(int count) {
    return '+$count estudiantes más';
  }

  @override
  String get latestAnnouncementTitle => 'Último anuncio';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get searchNoResults => 'No se encontraron resultados';

  @override
  String get searchNoResultsBody => 'Prueba a cambiar el texto de búsqueda.';

  @override
  String get fieldFullName => 'Nombre completo';

  @override
  String get fieldAge => 'Edad';

  @override
  String get fieldBranch => 'Disciplina';

  @override
  String get fieldParentPhone => 'Teléfono del padre/madre';

  @override
  String get studentsSearchHint => 'Buscar estudiantes';

  @override
  String get studentsEmptyTitle => 'Aún no hay estudiantes';

  @override
  String get studentsEmptyAdmin =>
      'Usa el botón + de la esquina inferior derecha para añadir un nuevo estudiante.';

  @override
  String get studentsEmptyViewer =>
      'Aún no hay registros de estudiantes. Aparecerán aquí cuando un administrador añada uno.';

  @override
  String studentSubtitle(String branch, int age, String phone) {
    return '$branch • $age años\nPadre/Madre: $phone';
  }

  @override
  String get studentDeleteTitle => 'Eliminar estudiante';

  @override
  String studentDeleteConfirm(String name) {
    return '¿Seguro que quieres eliminar a $name';
  }

  @override
  String get studentDeleted => 'Estudiante eliminado.';

  @override
  String get studentDetailTitle => 'Detalles del estudiante';

  @override
  String get editStudent => 'Editar estudiante';

  @override
  String get backToStudentList => 'Volver a la lista de estudiantes';

  @override
  String get addStudent => 'Añadir nuevo estudiante';

  @override
  String get saveStudent => 'Guardar estudiante';

  @override
  String get fullNameEmpty => 'El nombre completo no puede estar vacío.';

  @override
  String get fullNameMinLength =>
      'El nombre completo debe tener al menos 3 caracteres.';

  @override
  String get ageEmpty => 'La edad no puede estar vacía.';

  @override
  String get ageMustBeNumber => 'La edad debe ser un número.';

  @override
  String get agePositive => 'La edad debe ser mayor que 0.';

  @override
  String get ageTooHigh => 'La edad parece demasiado alta.';
}
