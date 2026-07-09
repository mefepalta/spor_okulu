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

  @override
  String get fieldPhone => 'Teléfono';

  @override
  String get branchEmpty => 'La disciplina no puede estar vacía.';

  @override
  String get coachesSearchHint => 'Buscar entrenadores';

  @override
  String get coachesEmptyTitle => 'Aún no hay entrenadores';

  @override
  String get coachesEmptyAdmin =>
      'Usa el botón + de la esquina inferior derecha para añadir un nuevo entrenador.';

  @override
  String get coachesEmptyViewer =>
      'Aún no hay registros de entrenadores. Aparecerán aquí cuando un administrador añada uno.';

  @override
  String coachSubtitle(String branch, String phone) {
    return '$branch • $phone';
  }

  @override
  String get coachDeleteTitle => 'Eliminar entrenador';

  @override
  String coachDeleteConfirm(String name) {
    return '¿Seguro que quieres eliminar a $name';
  }

  @override
  String get coachDeleted => 'Entrenador eliminado.';

  @override
  String get coachDetailTitle => 'Detalles del entrenador';

  @override
  String get editCoach => 'Editar entrenador';

  @override
  String get backToCoachList => 'Volver a la lista de entrenadores';

  @override
  String get addCoach => 'Añadir nuevo entrenador';

  @override
  String get saveCoach => 'Guardar entrenador';

  @override
  String get phoneEmpty => 'El número de teléfono no puede estar vacío.';

  @override
  String get phoneFormat => 'El teléfono debe tener el formato 05XXXXXXXXX.';

  @override
  String get timeEmpty => 'La hora no puede estar vacía.';

  @override
  String get timeFormat => 'La hora debe tener el formato 18:00.';

  @override
  String get dateEmpty => 'La fecha no puede estar vacía.';

  @override
  String get dateFormat => 'La fecha debe tener el formato 24.06.2026.';

  @override
  String get branchRequired => 'Debe seleccionarse una disciplina.';

  @override
  String get dayMonday => 'Lunes';

  @override
  String get dayTuesday => 'Martes';

  @override
  String get dayWednesday => 'Miércoles';

  @override
  String get dayThursday => 'Jueves';

  @override
  String get dayFriday => 'Viernes';

  @override
  String get daySaturday => 'Sábado';

  @override
  String get daySunday => 'Domingo';

  @override
  String get groupsSearchHint => 'Buscar grupos';

  @override
  String get groupsEmptyTitle => 'Aún no hay grupos';

  @override
  String get groupsEmptyAdd =>
      'Usa el botón + de la esquina inferior derecha para añadir un nuevo grupo.';

  @override
  String get groupsEmptyNoCoach =>
      'Añade primero al menos un entrenador para crear un grupo.';

  @override
  String get groupsEmptyViewer =>
      'Aún no hay registros de grupos. Aparecerán aquí cuando un administrador añada uno.';

  @override
  String groupSubtitle(
    String branch,
    String schedule,
    String coach,
    int count,
    int capacity,
  ) {
    return '$branch • $schedule\nEntrenador: $coach • $count/$capacity estudiantes';
  }

  @override
  String get groupDeleteTitle => 'Eliminar grupo';

  @override
  String groupDeleteConfirm(String name) {
    return '¿Seguro que quieres eliminar el grupo $name';
  }

  @override
  String get groupDeleted => 'Grupo eliminado.';

  @override
  String get groupDetailTitle => 'Detalles del grupo';

  @override
  String get unknownStudent => 'Estudiante desconocido';

  @override
  String get fieldGroupName => 'Nombre del grupo';

  @override
  String get fieldSchedule => 'Horario';

  @override
  String get fieldCapacity => 'Capacidad';

  @override
  String get fieldDay => 'Día';

  @override
  String get fieldTime => 'Hora';

  @override
  String capacityPeople(int count, int capacity) {
    return '$count/$capacity personas';
  }

  @override
  String membersTitle(int count) {
    return 'Miembros ($count)';
  }

  @override
  String get noMembersAssigned => 'Aún no hay estudiantes asignados.';

  @override
  String get editGroup => 'Editar grupo';

  @override
  String get backToGroupList => 'Volver a la lista de grupos';

  @override
  String get addGroup => 'Añadir nuevo grupo';

  @override
  String get saveGroup => 'Guardar grupo';

  @override
  String get groupsNeedCoach =>
      'Debes añadir primero al menos un entrenador para crear un grupo.';

  @override
  String get groupNameEmpty => 'El nombre del grupo no puede estar vacío.';

  @override
  String get groupNameMinLength =>
      'El nombre del grupo debe tener al menos 2 caracteres.';

  @override
  String get coachRequired => 'Debes seleccionar un entrenador.';

  @override
  String get dayRequired => 'Debes seleccionar un día.';

  @override
  String get capacityEmpty => 'La capacidad no puede estar vacía.';

  @override
  String get capacityMustBeNumber => 'La capacidad debe ser un número.';

  @override
  String get capacityPositive => 'La capacidad debe ser mayor que 0.';

  @override
  String get capacityMax => 'La capacidad no debe superar 100.';

  @override
  String get membersLabel => 'Miembros';

  @override
  String get noStudentSelected => 'Ningún estudiante seleccionado';

  @override
  String studentsSelected(int count) {
    return '$count estudiantes seleccionados';
  }

  @override
  String get membersNeedStudents =>
      'Primero se necesitan registros de estudiantes para añadir miembros.';

  @override
  String get selectCoachFirst => 'Primero debes seleccionar un entrenador.';

  @override
  String studentsExceedCapacity(int count, int capacity) {
    return 'El número de estudiantes seleccionados ($count) supera la capacidad ($capacity).';
  }

  @override
  String get selectMembersTitle => 'Seleccionar miembros';

  @override
  String selectedCount(int count) {
    return '$count seleccionados';
  }

  @override
  String selectedCountOf(int count, int capacity) {
    return '$count/$capacity seleccionados';
  }

  @override
  String get capacityExceeded => 'Capacidad superada';

  @override
  String get noStudentsTitle => 'Sin estudiantes';

  @override
  String get noStudentsBody => 'Primero deben añadirse estudiantes.';

  @override
  String studentBranchAge(String branch, int age) {
    return '$branch • $age años';
  }

  @override
  String get usersSearchHint => 'Buscar correo';

  @override
  String get usersEmptyTitle => 'Sin usuarios';

  @override
  String get usersEmptyBody => 'Aún no hay usuarios registrados.';

  @override
  String get noEmail => '(sin correo)';

  @override
  String get youLabel => '(tú)';

  @override
  String get cannotChangeOwnRole => 'No puedes cambiar tu propio rol aquí.';

  @override
  String get roleUpdateError => 'Se produjo un error al actualizar el rol.';

  @override
  String userRoleUpdated(String email, String role) {
    return '$email → actualizado a $role.';
  }

  @override
  String get changeRoleTitle => 'Cambiar rol';

  @override
  String get parentAssignHint =>
      'La asignación de estudiantes se hace desde la pantalla \"Padres\".';

  @override
  String get studentAssignHint =>
      'La vinculación de estudiantes se hace desde la pantalla \"Cuentas de estudiantes\".';

  @override
  String get parentsEmptyTitle => 'Aún no hay padres';

  @override
  String get parentsEmptyBody =>
      'Usa el botón + de abajo a la derecha para añadir un padre. El padre debe registrarse primero en la app.';

  @override
  String get parentAdded => 'Padre añadido.';

  @override
  String get parentAddError => 'Ocurrió un error al añadir el padre.';

  @override
  String get removeParentTitle => 'Quitar padre';

  @override
  String removeParentConfirm(String email) {
    return '$email dejará de ser padre y se eliminarán las asignaciones de estudiantes. ¿Continuar?';
  }

  @override
  String get removeAction => 'Quitar';

  @override
  String get addParentTitle => 'Añadir padre';

  @override
  String get addParentHint =>
      'Introduce el correo del padre registrado en la app. El padre debe registrarse primero.';

  @override
  String get noStudentAssigned => 'Sin estudiante asignado';

  @override
  String studentsAssigned(String names) {
    return 'Estudiantes: $names';
  }

  @override
  String get assignStudentsTitle => 'Asignar estudiantes';

  @override
  String accountAssignHeader(String label, String email) {
    return '$label: $email';
  }

  @override
  String get studentAccountAdded => 'Cuenta de estudiante añadida.';

  @override
  String get studentAccountAddError =>
      'Ocurrió un error al añadir la cuenta de estudiante.';

  @override
  String get removeAccountTitle => 'Quitar cuenta';

  @override
  String removeAccountConfirm(String email) {
    return '$email dejará de ser estudiante y se eliminará la vinculación de estudiante. ¿Continuar?';
  }

  @override
  String get studentAccountsEmptyTitle => 'Aún no hay cuentas de estudiante';

  @override
  String get studentAccountsEmptyBody =>
      'Usa el botón + de abajo a la derecha para añadir una cuenta de estudiante. El estudiante debe registrarse primero en la app.';

  @override
  String get studentNotLinked => 'Sin estudiante vinculado';

  @override
  String studentLinked(String name) {
    return 'Estudiante: $name';
  }

  @override
  String get addStudentAccountTitle => 'Añadir cuenta de estudiante';

  @override
  String get addStudentAccountHint =>
      'Introduce el correo del estudiante registrado en la app. El estudiante debe registrarse primero.';

  @override
  String get accountLabelStudent => 'Cuenta de estudiante';

  @override
  String photoPickError(Object error) {
    return 'No se pudo elegir la foto: $error';
  }

  @override
  String get profileUpdated => 'Perfil actualizado.';

  @override
  String profileSaveError(Object error) {
    return 'No se pudo guardar: $error';
  }

  @override
  String get pickPhoto => 'Elegir foto';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get nameTooLong => 'El nombre es demasiado largo.';

  @override
  String get phoneTooLong => 'El teléfono es demasiado largo.';

  @override
  String get commonSaving => 'Guardando...';
}
