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
  String get changePasswordTitle => 'Cambiar contraseña';

  @override
  String get currentPasswordLabel => 'Contraseña actual';

  @override
  String get newPasswordLabel => 'Nueva contraseña';

  @override
  String get passwordChangeSuccess => 'Tu contraseña se ha actualizado.';

  @override
  String get passwordChangeWrongCurrent =>
      'La contraseña actual es incorrecta.';

  @override
  String get passwordChangeError =>
      'No se pudo cambiar la contraseña. Inténtalo de nuevo.';

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
  String get dayShortMon => 'Lun';

  @override
  String get dayShortTue => 'Mar';

  @override
  String get dayShortWed => 'Mié';

  @override
  String get dayShortThu => 'Jue';

  @override
  String get dayShortFri => 'Vie';

  @override
  String get dayShortSat => 'Sáb';

  @override
  String get dayShortSun => 'Dom';

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
  String groupSubtitle(String branch, String coach, int count, int capacity) {
    return '$branch\nEntrenador: $coach • $count/$capacity estudiantes';
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

  @override
  String get attendanceDeleteTitle => 'Eliminar asistencia';

  @override
  String attendanceDeleteConfirm(String group, String date) {
    return '¿Seguro que quieres eliminar el registro de asistencia de $group - $date';
  }

  @override
  String get attendanceDeleted => 'Registro de asistencia eliminado.';

  @override
  String get attendanceEmptyTitle => 'Aún no hay registros de asistencia';

  @override
  String get attendanceEmptyAdmin =>
      'Usa el botón + de abajo a la derecha para añadir un nuevo registro de asistencia.';

  @override
  String get attendanceEmptyNoGroup =>
      'Para tomar asistencia, primero añade al menos un grupo y un estudiante.';

  @override
  String get attendanceEmptyViewer =>
      'Aún no hay registros de asistencia. Aparecerán aquí cuando el administrador añada asistencia.';

  @override
  String attendanceCountLine(int present, int absent) {
    return 'Presentes: $present • Ausentes: $absent';
  }

  @override
  String get takeAttendanceTitle => 'Tomar asistencia';

  @override
  String get editAttendanceTitle => 'Editar asistencia';

  @override
  String get selectGroupFirst => 'Primero selecciona un grupo.';

  @override
  String get fieldGroup => 'Grupo';

  @override
  String get groupRequired => 'Debes seleccionar un grupo.';

  @override
  String get fieldDate => 'Fecha';

  @override
  String studentsCountTitle(int count) {
    return 'Estudiantes ($count)';
  }

  @override
  String get groupNoStudentsTitle => 'No hay estudiantes en este grupo.';

  @override
  String get groupNoStudentsBody =>
      'Puedes añadir estudiantes desde los detalles del grupo.';

  @override
  String get saveAttendance => 'Guardar asistencia';

  @override
  String get attendanceNeedGroupStudent =>
      'Para tomar asistencia, primero debes añadir al menos un grupo y un estudiante.';

  @override
  String get attendanceDetailTitle => 'Detalle de asistencia';

  @override
  String get presentStudentsTitle => 'Estudiantes presentes';

  @override
  String get noPresentStudents => 'No hay estudiantes presentes.';

  @override
  String get absentStudentsTitle => 'Estudiantes ausentes';

  @override
  String get noAbsentStudents => 'No hay estudiantes ausentes.';

  @override
  String get backToAttendanceList => 'Volver a la lista de asistencia';

  @override
  String get childAttendanceEmptyTitle => 'No hay registros de asistencia';

  @override
  String get childAttendanceEmptyBody =>
      'Aún no se ha creado ningún registro de asistencia que incluya a su hijo.';

  @override
  String attendedOfLessons(int total, int present) {
    return 'Asistió a $present de $total clases';
  }

  @override
  String percentValue(int percent) {
    return '$percent %';
  }

  @override
  String get paymentDeleteTitle => 'Eliminar pago';

  @override
  String paymentDeleteConfirm(String name, String period) {
    return '¿Seguro que quieres eliminar el registro de pago de $name - $period';
  }

  @override
  String get paymentDeleted => 'Registro de pago eliminado.';

  @override
  String get periodLabel => 'Período:';

  @override
  String get allPeriods => 'Todos los períodos';

  @override
  String get paymentsSearchHint => 'Buscar pagos';

  @override
  String get paymentsEmptyTitle => 'Aún no hay registros de pago';

  @override
  String get paymentsEmptyAdmin =>
      'Usa el botón + de abajo a la derecha para añadir un nuevo registro de pago.';

  @override
  String get paymentsEmptyNoStudent =>
      'Para añadir un pago, primero añade al menos un estudiante.';

  @override
  String get paymentsEmptyViewer =>
      'Aún no hay registros de pago. Aparecerán aquí cuando el administrador añada un pago.';

  @override
  String paymentsNoStatusResults(String status) {
    return 'No hay registros con estado \"$status\". Elige otro filtro o \"Todos\".';
  }

  @override
  String get remindTooltip => 'Enviar recordatorio';

  @override
  String get noParentPhone =>
      'El teléfono del padre del estudiante no está registrado.';

  @override
  String get paymentCollectedLabel => 'Cobrado';

  @override
  String recordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count registros',
      one: '1 registro',
    );
    return '$_temp0';
  }

  @override
  String get paymentDetailTitle => 'Detalle del pago';

  @override
  String get fieldPeriod => 'Mes / Período';

  @override
  String get fieldAmount => 'Importe';

  @override
  String get fieldStatus => 'Estado';

  @override
  String get fieldNote => 'Nota';

  @override
  String get noNote => 'Sin nota.';

  @override
  String get remindViaWhatsApp => 'Recordar por WhatsApp';

  @override
  String get editPaymentTitle => 'Editar pago';

  @override
  String get backToPaymentList => 'Volver a la lista de pagos';

  @override
  String get addPaymentTitle => 'Añadir nuevo pago';

  @override
  String get paymentNeedStudent =>
      'Para añadir un pago, primero debes añadir al menos un estudiante.';

  @override
  String get studentRequired => 'Debes seleccionar un estudiante.';

  @override
  String get periodEmpty => 'El mes / período no puede estar vacío.';

  @override
  String get amountEmpty => 'El importe no puede estar vacío.';

  @override
  String get amountMustBeNumber => 'El importe debe ser un número.';

  @override
  String get amountPositive => 'El importe debe ser mayor que 0.';

  @override
  String get amountTooHigh => 'El importe parece demasiado alto.';

  @override
  String get statusRequired => 'Debes seleccionar un estado.';

  @override
  String get noteHint => 'Nota opcional';

  @override
  String get selectStudentFirst => 'Primero selecciona un estudiante.';

  @override
  String get savePayment => 'Guardar pago';

  @override
  String get leaveReported => 'Solicitud de ausencia enviada.';

  @override
  String get leaveDeleteTitle => 'Eliminar solicitud de ausencia';

  @override
  String get leaveDeleteConfirm =>
      '¿Quieres eliminar esta solicitud de ausencia?';

  @override
  String get newLeave => 'Nueva solicitud de ausencia';

  @override
  String get leaveEmptyTitle => 'No hay solicitudes de ausencia';

  @override
  String get leaveEmptyParent =>
      'Aún no has enviado ninguna solicitud de ausencia. Usa el botón de abajo a la derecha para añadir una.';

  @override
  String get leaveEmptyStaff =>
      'Aún no se ha enviado ninguna solicitud de ausencia.';

  @override
  String get cancelLeaveAction => 'Cancelar';

  @override
  String get reasonRequired => 'Por favor, escribe un motivo.';

  @override
  String dateWithValue(String date) {
    return 'Fecha: $date';
  }

  @override
  String get fieldReason => 'Motivo';

  @override
  String get reasonHint => 'Ej.: Informe médico, visita familiar...';

  @override
  String get sendAction => 'Enviar';

  @override
  String get performanceAnalysisTitle => 'Análisis de rendimiento';

  @override
  String recordAddError(Object error) {
    return 'No se pudo añadir el registro: $error';
  }

  @override
  String recordDeleteError(Object error) {
    return 'No se pudo eliminar el registro: $error';
  }

  @override
  String get recordDeleteTitle => 'Eliminar registro';

  @override
  String performanceDeleteConfirm(String date) {
    return '¿Seguro que quieres eliminar el registro de rendimiento con fecha $date?';
  }

  @override
  String get noStudentFound => 'No se encontró ningún estudiante';

  @override
  String get performanceEmptyManage =>
      'Para introducir rendimiento, primero debe añadirse un estudiante.';

  @override
  String get performanceEmptyParent =>
      'Aún no se ha asignado ningún estudiante a tu cuenta. Ponte en contacto con la dirección de la escuela deportiva.';

  @override
  String get addPerformance => 'Añadir rendimiento';

  @override
  String get noPerformanceForStudent =>
      'Aún no hay registros de rendimiento para este estudiante.';

  @override
  String get comparisonByDate => 'Comparación por fecha';

  @override
  String get recordsTitle => 'Registros';

  @override
  String get selectAction => 'Elegir';

  @override
  String get scoresLabel => 'Puntuaciones (0-100)';

  @override
  String get metricJump => 'Salto';

  @override
  String get metricSpeed => 'Velocidad';

  @override
  String get metricEndurance => 'Resistencia';

  @override
  String get metricFlexibility => 'Flexibilidad';

  @override
  String get metricBallControl => 'Control del balón';

  @override
  String get announcementDeleteTitle => 'Eliminar anuncio';

  @override
  String announcementDeleteConfirm(String title) {
    return '¿Seguro que quieres eliminar el anuncio titulado $title';
  }

  @override
  String get announcementDeleted => 'Anuncio eliminado.';

  @override
  String get announcementsEmptyTitle => 'Aún no hay anuncios';

  @override
  String get announcementsEmptyAdmin =>
      'Usa el botón + de abajo a la derecha para añadir un nuevo anuncio.';

  @override
  String get announcementsEmptyViewer =>
      'Aún no hay anuncios. Aparecerán aquí cuando el administrador añada un anuncio.';

  @override
  String get announcementDetailTitle => 'Detalle del anuncio';

  @override
  String get fieldTitle => 'Título';

  @override
  String get fieldTargetAudience => 'Público objetivo';

  @override
  String get editAnnouncementTitle => 'Editar anuncio';

  @override
  String get backToAnnouncementList => 'Volver a la lista de anuncios';

  @override
  String get addAnnouncementTitle => 'Añadir nuevo anuncio';

  @override
  String get titleHint => 'Cambio de horario de entrenamiento';

  @override
  String get titleEmpty => 'El título no puede estar vacío.';

  @override
  String get titleMinLength => 'El título debe tener al menos 3 caracteres.';

  @override
  String get fieldContent => 'Contenido';

  @override
  String get contentHint => 'Escribe el contenido del anuncio...';

  @override
  String get contentEmpty => 'El contenido no puede estar vacío.';

  @override
  String get contentMinLength =>
      'El contenido debe tener al menos 10 caracteres.';

  @override
  String get audienceRequired => 'Debes seleccionar un público objetivo.';

  @override
  String get saveAnnouncement => 'Guardar anuncio';

  @override
  String get audienceEveryone => 'Todos';

  @override
  String eventAddError(Object error) {
    return 'No se pudo añadir el evento: $error';
  }

  @override
  String eventDeleteError(Object error) {
    return 'No se pudo eliminar el evento: $error';
  }

  @override
  String get eventDeleteTitle => 'Eliminar evento';

  @override
  String eventDeleteConfirm(String title) {
    return '¿Quieres eliminar el evento $title?';
  }

  @override
  String get eventsEmptyTitle => 'No hay eventos planificados';

  @override
  String get eventsEmptyManage =>
      'Usa el botón + de abajo a la derecha para añadir un nuevo evento.';

  @override
  String get eventsEmptyViewer =>
      'Los eventos aparecerán aquí cuando los entrenadores los planifiquen.';

  @override
  String get addEvent => 'Añadir evento';

  @override
  String get selectAttendanceFirst =>
      'Por favor, selecciona primero el estado de asistencia.';

  @override
  String get responseAlreadySaved => 'Tu respuesta ya está guardada.';

  @override
  String responseSendError(Object error) {
    return 'No se pudo enviar la respuesta: $error';
  }

  @override
  String get responseSent => 'Tu respuesta ha sido enviada.';

  @override
  String attendingCount(int count) {
    return 'Asistirá: $count';
  }

  @override
  String notAttendingCount(int count) {
    return 'No asistirá: $count';
  }

  @override
  String eventDateLabel(String date) {
    return 'Fecha del evento: $date';
  }

  @override
  String get willAttend => 'Asistirá';

  @override
  String get willNotAttend => 'No asistirá';

  @override
  String get sendingLabel => 'Enviando...';

  @override
  String get sentLabel => 'Enviado';

  @override
  String get addEventTitle => 'Nuevo evento';

  @override
  String get fieldEventName => 'Nombre del evento';

  @override
  String get eventNameHint => 'Partido amistoso';

  @override
  String get eventNameEmpty => 'El nombre del evento no puede estar vacío.';

  @override
  String get fieldDescriptionOptional => 'Descripción (opcional)';

  @override
  String get saveEvent => 'Guardar evento';

  @override
  String get cashDeleteTitle => 'Eliminar registro';

  @override
  String cashDeleteConfirm(String title) {
    return '¿Quieres eliminar el registro \"$title\"?';
  }

  @override
  String get newCashEntry => 'Nuevo registro';

  @override
  String get cashEmptyTitle => 'La caja está vacía';

  @override
  String get cashEmptyBody =>
      'Aún no hay registros de ingresos/gastos. Añade el primer registro con el botón de abajo a la derecha.';

  @override
  String get currentBalance => 'Saldo actual';

  @override
  String get totalIncome => 'Ingresos totales';

  @override
  String get totalExpense => 'Gastos totales';

  @override
  String get titleRequired => 'Por favor, escribe un título.';

  @override
  String get amountInvalid => 'Por favor, introduce un importe válido.';

  @override
  String get cashTitleHint => 'Ej.: cuotas de marzo, alquiler de la sala...';

  @override
  String get fieldAmountCurrency => 'Importe (₺)';

  @override
  String get fieldCategory => 'Categoría';

  @override
  String get fieldNoteOptional => 'Nota (opcional)';

  @override
  String get equipmentDeleteTitle => 'Eliminar artículo';

  @override
  String equipmentDeleteConfirm(String name) {
    return '¿Quieres eliminar el registro \"$name\"?';
  }

  @override
  String get newEquipment => 'Nuevo artículo';

  @override
  String get equipmentEmptyTitle => 'El almacén está vacío';

  @override
  String get equipmentEmptyManage =>
      'Aún no hay artículos. Añade el primer registro con el botón de abajo a la derecha.';

  @override
  String get equipmentEmptyViewer =>
      'Aún no se han añadido artículos al almacén.';

  @override
  String get noResultTitle => 'Sin resultados';

  @override
  String get noResultInCategory => 'No hay artículos en esta categoría.';

  @override
  String get equipmentSummaryTitle => 'Resumen del almacén';

  @override
  String get metricVariety => 'Tipos';

  @override
  String get metricTotalQuantity => 'Cantidad total';

  @override
  String get metricAttention => 'Atención';

  @override
  String assignedPrefix(String who) {
    return 'Asignado: $who';
  }

  @override
  String get editEquipment => 'Editar artículo';

  @override
  String get fieldEquipmentName => 'Nombre del artículo';

  @override
  String get equipmentNameHint => 'Ej.: balón de fútbol, camiseta...';

  @override
  String get equipmentNameRequired =>
      'Por favor, escribe el nombre del artículo.';

  @override
  String get quantityMustBePositive => 'La cantidad debe ser mayor que 0.';

  @override
  String get fieldQuantity => 'Cantidad';

  @override
  String get fieldAssignedOptional => 'Asignado a (opcional)';

  @override
  String get assignedHint => 'Quién / dónde';

  @override
  String get conditionGood => 'En buen estado';

  @override
  String get conditionMaintenance => 'En mantenimiento';

  @override
  String get conditionWorn => 'Desgastado';

  @override
  String get generalSummary => 'Resumen general';

  @override
  String get paymentSummary => 'Resumen de pagos';

  @override
  String get paidPayments => 'Pagos realizados';

  @override
  String get pendingPayments => 'Pagos pendientes';

  @override
  String get statusComment => 'Resumen del estado';

  @override
  String get reportsNoData =>
      'Aún no hay suficientes datos. A medida que se añadan registros de estudiantes, grupos y pagos, aquí aparecerá un resumen general del estado.';

  @override
  String reportsSummary(
    int students,
    int coaches,
    int groups,
    int payments,
    int paid,
    int pending,
  ) {
    return 'El sistema tiene $students estudiantes, $coaches entrenadores y $groups grupos. De $payments registros de pago en total, $paid están pagados y $pending pendientes.';
  }

  @override
  String get notificationsEmptyTitle => 'No hay notificaciones';

  @override
  String get notificationsEmptyBody =>
      'No hay notificaciones para mostrar en este momento.';

  @override
  String get noRecordsTitle => 'Sin registros';

  @override
  String get noNotificationsInCategory =>
      'No hay notificaciones en esta categoría.';

  @override
  String get aiStaffSuggestion1 => 'Resume este mes';

  @override
  String get aiStaffSuggestion2 => '¿A qué debo prestar atención?';

  @override
  String get aiStaffSuggestion3 =>
      'Redacta un mensaje breve para un padre sobre una ausencia';

  @override
  String get aiStaffSuggestion4 => 'Da 3 consejos para mejorar los cobros';

  @override
  String get aiParentSuggestion1 => 'Resume la situación de mi hijo/a';

  @override
  String get aiParentSuggestion2 => '¿Cómo está la asistencia?';

  @override
  String get aiParentSuggestion3 => 'Explica mi estado de pago';

  @override
  String get aiParentSuggestion4 => '¿Qué sugieres para su progreso?';

  @override
  String get aiStudentSuggestion1 => 'Resume mi situación';

  @override
  String get aiStudentSuggestion2 => '¿Cómo está mi asistencia?';

  @override
  String get aiStudentSuggestion3 => 'Comenta mi rendimiento';

  @override
  String get aiStudentSuggestion4 => '¿Qué sugieres para mejorar?';

  @override
  String get sportekaiNotReadyTitle => 'SporTekAi aún no está listo';

  @override
  String get sportekaiNotReadyBody =>
      'Para usar el asistente de IA, debe definirse la dirección del Cloudflare Worker (SPORTEKAI_ENDPOINT). Configuración: cloudflare/README.md';

  @override
  String get sportekaiGreeting => '¡Hola! Soy SporTekAi ✨';

  @override
  String get sportekaiHint => 'Pregunta a SporTekAi...';

  @override
  String get aiResponseLanguage => 'español';

  @override
  String get videoOpenError => 'No se pudo abrir el video.';

  @override
  String get watchIntroVideo => 'Ver el video de presentación';

  @override
  String get youtubeHowToPlay => 'cómo se juega';

  @override
  String get fullNameHint => 'Juan Pérez';

  @override
  String get monthJanuary => 'Enero';

  @override
  String get monthFebruary => 'Febrero';

  @override
  String get monthMarch => 'Marzo';

  @override
  String get monthApril => 'Abril';

  @override
  String get monthMay => 'Mayo';

  @override
  String get monthJune => 'Junio';

  @override
  String get monthJuly => 'Julio';

  @override
  String get monthAugust => 'Agosto';

  @override
  String get monthSeptember => 'Septiembre';

  @override
  String get monthOctober => 'Octubre';

  @override
  String get monthNovember => 'Noviembre';

  @override
  String get monthDecember => 'Diciembre';

  @override
  String get chatTitle => 'Chat del club';

  @override
  String get chatHint => 'Escribe un mensaje…';

  @override
  String get chatEmptyTitle => 'Aún no hay mensajes';

  @override
  String get chatEmptyBody => 'Sé el primero en enviar un mensaje.';

  @override
  String get chatLoadError =>
      'No se pudo cargar el chat. Es posible que no tengas acceso.';

  @override
  String get chatEditTitle => 'Editar mensaje';

  @override
  String get chatDeleteTitle => 'Eliminar mensaje';

  @override
  String get chatDeleteConfirm => '¿Eliminar este mensaje?';

  @override
  String get chatEdited => 'editado';

  @override
  String get scheduleTitle => 'Horario de clases';

  @override
  String get scheduleViewDay => 'Día';

  @override
  String get scheduleViewWeek => 'Semana';

  @override
  String get scheduleTodayLabel => 'Hoy';

  @override
  String get todayLessonsTitle => 'Clases de hoy';

  @override
  String get todayNoLessons => 'Hoy no hay clases.';

  @override
  String get scheduleTakeAttendance => 'Registrar asistencia';

  @override
  String get scheduleConflictTitle => 'Conflicto';

  @override
  String get scheduleConflictBody => 'Hay una clase que se solapa a esta hora:';

  @override
  String get scheduleSaveAnyway => 'Guardar igualmente';

  @override
  String get scheduleAddTitle => 'Añadir clase';

  @override
  String get scheduleEditTitle => 'Editar clase';

  @override
  String get scheduleEmptyTitle => 'El horario está vacío';

  @override
  String get scheduleEmptyBody => 'Aún no se han añadido clases.';

  @override
  String get scheduleEmptyBodyManage =>
      'Añade la primera clase con el botón +.';

  @override
  String get scheduleNoLesson => 'Sin clases';

  @override
  String get scheduleDayLabel => 'Día';

  @override
  String get scheduleStartLabel => 'Inicio';

  @override
  String get scheduleEndLabel => 'Fin';

  @override
  String get scheduleGroupLabel => 'Grupo';

  @override
  String get scheduleCoachLabel => 'Entrenador';

  @override
  String get scheduleDeleteTitle => 'Eliminar clase';

  @override
  String get scheduleDeleteConfirm => '¿Eliminar esta clase?';

  @override
  String get scheduleNeedsGroupCoach =>
      'Primero añade un grupo y un entrenador.';

  @override
  String get scheduleLoadError => 'No se pudo cargar el horario.';
}
