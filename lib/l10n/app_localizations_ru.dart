// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonOk => 'ОК';

  @override
  String get commonResend => 'Отправить снова';

  @override
  String get roleAdmin => 'Администратор';

  @override
  String get roleCoach => 'Тренер';

  @override
  String get roleParent => 'Родитель';

  @override
  String get roleStudent => 'Ученик';

  @override
  String get roleViewer => 'Наблюдатель';

  @override
  String get roleUnknown => 'Неизвестно';

  @override
  String get loginHeading => 'Управление спортивной школой';

  @override
  String get emailLabel => 'Эл. почта';

  @override
  String get emailHint => 'example@sporokulu.com';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get loginLoading => 'Выполняется вход...';

  @override
  String get forgotPassword => 'Забыли пароль';

  @override
  String get noAccountRegister => 'Нет аккаунта? Зарегистрируйтесь';

  @override
  String get emailEmpty => 'Эл. почта не может быть пустой.';

  @override
  String get emailInvalid => 'Введите корректный адрес эл. почты.';

  @override
  String get passwordEmpty => 'Пароль не может быть пустым.';

  @override
  String get passwordMinLength =>
      'Пароль должен содержать не менее 6 символов.';

  @override
  String get emailNotVerifiedTitle => 'Эл. почта не подтверждена';

  @override
  String get emailNotVerifiedBody =>
      'Чтобы активировать аккаунт, перейдите по ссылке подтверждения, отправленной на вашу почту. Если письмо не пришло, мы можем отправить его снова.';

  @override
  String get verificationResent =>
      'Письмо с подтверждением отправлено снова. Проверьте также папку «Спам».';

  @override
  String get rejectedTitle => 'Ваша заявка отклонена';

  @override
  String get rejectedBody =>
      'Ваша заявка на роль отклонена администратором. Ваш аккаунт закрывается.';

  @override
  String get resetPasswordNeedEmail =>
      'Сначала введите адрес эл. почты, чтобы сбросить пароль.';

  @override
  String get resetPasswordSent =>
      'Ссылка для сброса пароля отправлена на ваш адрес эл. почты.';

  @override
  String get resetPasswordError => 'Произошла ошибка при сбросе пароля.';

  @override
  String get resetInvalidEmail => 'Введите корректный адрес эл. почты.';

  @override
  String get resetUserNotFound =>
      'Пользователь с таким адресом эл. почты не найден.';

  @override
  String get userNotFound => 'Пользователь не найден.';

  @override
  String loginCheckError(Object error) {
    return 'Произошла ошибка при проверке входа: $error';
  }

  @override
  String get authInvalidEmail => 'Адрес эл. почты недействителен.';

  @override
  String get authUserDisabled => 'Этот аккаунт пользователя отключён.';

  @override
  String get authWrongCredentials => 'Неверная эл. почта или пароль.';

  @override
  String get authNetwork =>
      'Не удалось подключиться к интернету. Проверьте соединение и повторите попытку.';

  @override
  String get authOperationNotAllowed =>
      'Вход по эл. почте/паролю не включён в консоли Firebase.';

  @override
  String get authConfigNotFound =>
      'Конфигурация Firebase Authentication не найдена. Проверьте настройки консоли Firebase.';

  @override
  String get authAppNotAuthorized =>
      'Это приложение Android, по-видимому, не авторизовано для проекта Firebase.';

  @override
  String get authInvalidApiKey =>
      'Ключ API Firebase, по-видимому, недействителен.';

  @override
  String get authTooManyRequests =>
      'Слишком много попыток входа. Повторите попытку позже.';

  @override
  String authGenericWithCode(String code) {
    return 'Не удалось войти. Код ошибки: $code';
  }

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get registerHeading => 'Создать новый аккаунт';

  @override
  String get firstNameLabel => 'Имя';

  @override
  String get lastNameLabel => 'Фамилия';

  @override
  String get passwordAgainLabel => 'Подтвердите пароль';

  @override
  String get passwordAgainEmpty => 'Подтверждение пароля не может быть пустым.';

  @override
  String get passwordsDontMatch => 'Пароли не совпадают.';

  @override
  String get accountType => 'Тип вашего аккаунта';

  @override
  String get selectionSentToAdmin =>
      'Ваш выбор будет отправлен на утверждение администратору.';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get registerLoading => 'Сохранение...';

  @override
  String requiredField(String label) {
    return '$label не может быть пустым.';
  }

  @override
  String get registerSuccess =>
      'Аккаунт создан. Перейдите по ссылке подтверждения, отправленной на вашу почту. Ваша заявка на роль отправлена на утверждение администратору.';

  @override
  String get registerGenericError => 'Произошла ошибка при регистрации.';

  @override
  String get emailAlreadyInUse => 'Этот адрес эл. почты уже используется.';

  @override
  String get passwordTooWeak =>
      'Пароль слишком слабый. Используйте не менее 6 символов.';

  @override
  String registerErrorWith(Object error) {
    return 'Ошибка регистрации: $error';
  }

  @override
  String get userNotCreated => 'Не удалось создать пользователя.';

  @override
  String get roleRequestsTitle => 'Заявки на роль';

  @override
  String get noPendingRequests => 'Нет ожидающих заявок';

  @override
  String get noPendingRequestsBody =>
      'Заявки на роль от новых регистраций появляются здесь.';

  @override
  String get approveTitle => 'Одобрить заявку';

  @override
  String approveConfirm(String name, String role) {
    return '$name будет повышен(а) до роли «$role». Одобрить?';
  }

  @override
  String get approveAction => 'Одобрить';

  @override
  String approvedSnack(String name, String role) {
    return '$name теперь $role.';
  }

  @override
  String get rejectTitle => 'Отклонить заявку';

  @override
  String rejectConfirm(String name) {
    return 'Заявка «$name» будет отклонена, а аккаунт удалён. Это действие необратимо. Продолжить?';
  }

  @override
  String get rejectAction => 'Отклонить';

  @override
  String rejectedSnack(String name) {
    return 'Заявка «$name» отклонена.';
  }

  @override
  String requestLabel(String role) {
    return 'Запрос: $role';
  }

  @override
  String get genericOperationError =>
      'Произошла ошибка при выполнении операции.';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileUserFallback => 'Пользователь';

  @override
  String get roleDescAdmin =>
      'Может добавлять, редактировать и удалять все записи.';

  @override
  String get roleDescCoach =>
      'Может управлять записями посещаемости и объявлениями. Может просматривать другие записи.';

  @override
  String get roleDescParent =>
      'Может отслеживать успехи своего ребёнка и отвечать на участие в мероприятиях.';

  @override
  String get roleDescStudent =>
      'Может просматривать свою посещаемость и данные об успеваемости.';

  @override
  String get roleDescViewer =>
      'Может просматривать записи, но не может вносить изменения.';

  @override
  String get childrenSectionStudent => 'Мои данные ученика';

  @override
  String get childrenSectionParent => 'Мои ученики';

  @override
  String get authorityTitle => 'Права доступа';

  @override
  String get appearanceTitle => 'Внешний вид';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get backgroundEffectTitle => 'Эффект фона';

  @override
  String get backgroundEffectDesc =>
      'Высокий: волны + частицы · Средний: только волны · Низкий: простой фон.';

  @override
  String get backgroundHigh => 'Высокий';

  @override
  String get backgroundMedium => 'Средний';

  @override
  String get backgroundLow => 'Низкий';

  @override
  String get languageTitle => 'Язык';

  @override
  String get languageSystem => 'Система';

  @override
  String get editAccount => 'Редактировать аккаунт';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get whatsappSupport => 'Поддержка в WhatsApp';

  @override
  String get kvkkTitle => 'Уведомление о защите персональных данных';

  @override
  String get termsTitle => 'Условия использования';

  @override
  String get privacyTitle => 'Политика конфиденциальности';

  @override
  String get appVersionLabel => 'Версия приложения';

  @override
  String get logout => 'Выйти';

  @override
  String get commonAll => 'Все';

  @override
  String get commonAdd => 'Добавить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get viewAction => 'Открыть';

  @override
  String get statusPaid => 'Оплачено';

  @override
  String get statusPending => 'Ожидает';

  @override
  String get statusOverdue => 'Просрочено';

  @override
  String get leaveStatusPending => 'На рассмотрении';

  @override
  String get leaveStatusApproved => 'Одобрено';

  @override
  String get leaveStatusRejected => 'Отклонено';

  @override
  String get drawerMainPanel => 'Главная панель';

  @override
  String get sectionRecords => 'Записи';

  @override
  String get sectionOperations => 'Операции';

  @override
  String get sectionClub => 'Клуб';

  @override
  String get sectionGeneral => 'Общее';

  @override
  String get sectionMyChild => 'Мой ребёнок';

  @override
  String get sectionMe => 'Я';

  @override
  String get navStudents => 'Ученики';

  @override
  String get navCoaches => 'Тренеры';

  @override
  String get navGroups => 'Группы';

  @override
  String get navParents => 'Родители';

  @override
  String get navStudentAccounts => 'Аккаунты учеников';

  @override
  String get navAttendance => 'Посещаемость';

  @override
  String get navLeaveRequests => 'Заявки на отсутствие';

  @override
  String get navPayments => 'Платежи';

  @override
  String get navPerformance => 'Успеваемость';

  @override
  String get navEvents => 'Мероприятия';

  @override
  String get navEquipment => 'Инвентарь';

  @override
  String get navAnnouncements => 'Объявления';

  @override
  String get navClubCash => 'Касса клуба';

  @override
  String get navReports => 'Отчёты';

  @override
  String get navSports => 'Виды спорта';

  @override
  String get navUsers => 'Пользователи';

  @override
  String get navReportAbsence => 'Сообщить об отсутствии';

  @override
  String get navMyPerformance => 'Моя успеваемость';

  @override
  String get navMyAttendance => 'Моя посещаемость';

  @override
  String get notificationsTooltip => 'Уведомления';

  @override
  String get notifCategoryAnnouncement => 'Объявление';

  @override
  String get notifCategoryPayment => 'Платёж';

  @override
  String get notifCategoryLeave => 'Отсутствие';

  @override
  String get notifCategoryAbsence => 'Пропуск';

  @override
  String get leaveWaitingApproval => 'Ожидает одобрения';

  @override
  String notifLeaveTitle(String name) {
    return '$name • отсутствие';
  }

  @override
  String notifAbsenceTitle(String name) {
    return '$name отсутствовал(а)';
  }

  @override
  String errorLoadingData(Object error) {
    return 'Произошла ошибка при загрузке данных: $error';
  }

  @override
  String get reminderDialogTitle => 'Новое напоминание';

  @override
  String get reminderDialogHint => 'Напр.: Заказать инвентарь во вторник';

  @override
  String get newAnnouncementPublished => 'Опубликовано новое объявление.';

  @override
  String newAnnouncementsPublished(int count) {
    return 'Опубликовано новых объявлений: $count.';
  }

  @override
  String get remindersTitle => 'Быстрые напоминания';

  @override
  String get remindersEmpty => 'Вы ещё не добавили ни одного напоминания.';

  @override
  String get aiIntroParent =>
      'Я знаю текущую сводку по вашему ребёнку. Выберите один из вариантов ниже или задайте свой вопрос.';

  @override
  String get aiIntroStudent =>
      'Я знаю твою текущую ситуацию. Выбери один из вариантов ниже или задай свой вопрос.';

  @override
  String get aiIntroStaff =>
      'Я знаю текущую сводку по вашему клубу. Выберите один из вариантов ниже или задайте свой вопрос.';

  @override
  String get viewerWelcomeSubtitle => 'Добро пожаловать в спортивную школу.';

  @override
  String get requestPendingTitle => 'Ваша заявка рассматривается';

  @override
  String requestPendingMessage(String role) {
    return 'Ваша заявка на роль «$role» ожидает одобрения администратора. После одобрения вы получите доступ к соответствующей панели.';
  }

  @override
  String get requestApprovedTitle => 'Ваша заявка одобрена';

  @override
  String get requestApprovedMessage =>
      'Просто выйдите и войдите снова, чтобы увидеть свою новую роль.';

  @override
  String get roleNotAssignedTitle => 'Вам ещё не назначена роль';

  @override
  String get roleNotAssignedMessage =>
      'Когда администратор назначит вам роль, вы получите доступ к соответствующей панели.';

  @override
  String get greetingMorning => 'Доброе утро';

  @override
  String get greetingAfternoon => 'Добрый день';

  @override
  String get greetingEvening => 'Добрый вечер';

  @override
  String get studentGreetingSubtitle => 'Твоё текущее состояние ниже.';

  @override
  String parentGreetingSubtitleOne(String name) {
    return '$name • текущая сводка';
  }

  @override
  String get parentGreetingSubtitleMany =>
      'Текущая сводка по вашим детям ниже.';

  @override
  String get staffGreetingSubtitle => 'Текущая сводка по вашему клубу ниже.';

  @override
  String highlightOverdueDues(String amount) {
    return 'Просроченные взносы: $amount';
  }

  @override
  String get highlightGreatAttendance =>
      'Твоя посещаемость отличная, так держать! 🎯';

  @override
  String get highlightWatchAttendance =>
      'Давай немного последим за посещаемостью';

  @override
  String get highlightPlannedEvent =>
      'Есть запланированное мероприятие, не пропусти';

  @override
  String get highlightAllGood => 'Всё выглядит хорошо 👍';

  @override
  String highlightPaymentsPending(int count) {
    return 'Платежей, требующих внимания: $count';
  }

  @override
  String highlightLeavePending(int count) {
    return 'Заявок на отсутствие, ожидающих одобрения: $count';
  }

  @override
  String get highlightNoPending => 'У вас нет незавершённых задач, отлично 👍';

  @override
  String get statPerformance => 'Успеваемость';

  @override
  String get statEvent => 'Мероприятие';

  @override
  String get statAnnouncement => 'Объявление';

  @override
  String get statMyChild => 'Мой ребёнок';

  @override
  String get statStudent => 'Ученик';

  @override
  String get statCoach => 'Тренер';

  @override
  String get statGroup => 'Группа';

  @override
  String noteNew(int count) {
    return '$count новых';
  }

  @override
  String noteWaiting(int count) {
    return '$count в ожидании';
  }

  @override
  String get attendanceSummaryTitle => 'Сводка посещаемости';

  @override
  String get attendanceEmpty => 'Записей о посещаемости пока нет.';

  @override
  String get metricLessons => 'Занятия';

  @override
  String get metricRecords => 'Записи';

  @override
  String get metricPresent => 'Присутствовал';

  @override
  String get metricAbsent => 'Отсутствовал';

  @override
  String get metricAttendanceRate => 'Посещаемость';

  @override
  String get absenceNoteOne => '1 новая запись об отсутствии';

  @override
  String absenceNoteMany(int count) {
    return 'Новых записей об отсутствии: $count';
  }

  @override
  String get financeSummaryTitle => 'Финансовая сводка';

  @override
  String get financeEmpty => 'Записей о платежах пока нет.';

  @override
  String get metricCollected => 'Собрано';

  @override
  String get metricPending => 'Ожидается';

  @override
  String get metricOverdue => 'Просрочено';

  @override
  String get clubCashTitle => 'Касса клуба';

  @override
  String get ledgerAction => 'Журнал';

  @override
  String get clubCashEmpty => 'Движений по кассе пока нет.';

  @override
  String get metricBalance => 'Касса';

  @override
  String get metricIncome => 'Доход';

  @override
  String get metricExpense => 'Расход';

  @override
  String unpaidDuesTitle(int count) {
    return 'Неоплаченные взносы ($count)';
  }

  @override
  String moreStudents(int count) {
    return '+$count учеников ещё';
  }

  @override
  String get latestAnnouncementTitle => 'Последнее объявление';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonEdit => 'Изменить';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get searchNoResults => 'Ничего не найдено';

  @override
  String get searchNoResultsBody => 'Попробуйте изменить текст поиска.';

  @override
  String get fieldFullName => 'Имя и фамилия';

  @override
  String get fieldAge => 'Возраст';

  @override
  String get fieldBranch => 'Дисциплина';

  @override
  String get fieldParentPhone => 'Телефон родителя';

  @override
  String get studentsSearchHint => 'Поиск учеников';

  @override
  String get studentsEmptyTitle => 'Учеников пока нет';

  @override
  String get studentsEmptyAdmin =>
      'Нажмите кнопку + в правом нижнем углу, чтобы добавить ученика.';

  @override
  String get studentsEmptyViewer =>
      'Записей об учениках пока нет. Они появятся здесь, когда администратор добавит ученика.';

  @override
  String studentSubtitle(String branch, int age, String phone) {
    return '$branch • $age лет\nРодитель: $phone';
  }

  @override
  String get studentDeleteTitle => 'Удалить ученика';

  @override
  String studentDeleteConfirm(String name) {
    return 'Вы уверены, что хотите удалить: $name';
  }

  @override
  String get studentDeleted => 'Ученик удалён.';

  @override
  String get studentDetailTitle => 'Данные ученика';

  @override
  String get editStudent => 'Изменить ученика';

  @override
  String get backToStudentList => 'Назад к списку учеников';

  @override
  String get addStudent => 'Добавить ученика';

  @override
  String get saveStudent => 'Сохранить ученика';

  @override
  String get fullNameEmpty => 'Имя и фамилия не могут быть пустыми.';

  @override
  String get fullNameMinLength =>
      'Имя и фамилия должны содержать не менее 3 символов.';

  @override
  String get ageEmpty => 'Возраст не может быть пустым.';

  @override
  String get ageMustBeNumber => 'Возраст должен быть числом.';

  @override
  String get agePositive => 'Возраст должен быть больше 0.';

  @override
  String get ageTooHigh => 'Возраст выглядит слишком большим.';

  @override
  String get fieldPhone => 'Телефон';

  @override
  String get branchEmpty => 'Дисциплина не может быть пустой.';

  @override
  String get coachesSearchHint => 'Поиск тренеров';

  @override
  String get coachesEmptyTitle => 'Тренеров пока нет';

  @override
  String get coachesEmptyAdmin =>
      'Нажмите кнопку + в правом нижнем углу, чтобы добавить тренера.';

  @override
  String get coachesEmptyViewer =>
      'Записей о тренерах пока нет. Они появятся здесь, когда администратор добавит тренера.';

  @override
  String coachSubtitle(String branch, String phone) {
    return '$branch • $phone';
  }

  @override
  String get coachDeleteTitle => 'Удалить тренера';

  @override
  String coachDeleteConfirm(String name) {
    return 'Вы уверены, что хотите удалить: $name';
  }

  @override
  String get coachDeleted => 'Тренер удалён.';

  @override
  String get coachDetailTitle => 'Данные тренера';

  @override
  String get editCoach => 'Изменить тренера';

  @override
  String get backToCoachList => 'Назад к списку тренеров';

  @override
  String get addCoach => 'Добавить тренера';

  @override
  String get saveCoach => 'Сохранить тренера';

  @override
  String get phoneEmpty => 'Номер телефона не может быть пустым.';

  @override
  String get phoneFormat => 'Телефон должен быть в формате 05XXXXXXXXX.';

  @override
  String get timeEmpty => 'Время не может быть пустым.';

  @override
  String get timeFormat => 'Время должно быть в формате 18:00.';

  @override
  String get dateEmpty => 'Дата не может быть пустой.';

  @override
  String get dateFormat => 'Дата должна быть в формате 24.06.2026.';

  @override
  String get branchRequired => 'Необходимо выбрать дисциплину.';

  @override
  String get dayMonday => 'Понедельник';

  @override
  String get dayTuesday => 'Вторник';

  @override
  String get dayWednesday => 'Среда';

  @override
  String get dayThursday => 'Четверг';

  @override
  String get dayFriday => 'Пятница';

  @override
  String get daySaturday => 'Суббота';

  @override
  String get daySunday => 'Воскресенье';

  @override
  String get dayShortMon => 'Пн';

  @override
  String get dayShortTue => 'Вт';

  @override
  String get dayShortWed => 'Ср';

  @override
  String get dayShortThu => 'Чт';

  @override
  String get dayShortFri => 'Пт';

  @override
  String get dayShortSat => 'Сб';

  @override
  String get dayShortSun => 'Вс';

  @override
  String get groupsSearchHint => 'Поиск групп';

  @override
  String get groupsEmptyTitle => 'Групп пока нет';

  @override
  String get groupsEmptyAdd =>
      'Нажмите кнопку + в правом нижнем углу, чтобы добавить группу.';

  @override
  String get groupsEmptyNoCoach =>
      'Сначала добавьте хотя бы одного тренера, чтобы создать группу.';

  @override
  String get groupsEmptyViewer =>
      'Записей о группах пока нет. Они появятся здесь, когда администратор добавит группу.';

  @override
  String groupSubtitle(
    String branch,
    String schedule,
    String coach,
    int count,
    int capacity,
  ) {
    return '$branch • $schedule\nТренер: $coach • $count/$capacity учеников';
  }

  @override
  String get groupDeleteTitle => 'Удалить группу';

  @override
  String groupDeleteConfirm(String name) {
    return 'Вы уверены, что хотите удалить группу $name';
  }

  @override
  String get groupDeleted => 'Группа удалена.';

  @override
  String get groupDetailTitle => 'Данные группы';

  @override
  String get unknownStudent => 'Неизвестный ученик';

  @override
  String get fieldGroupName => 'Название группы';

  @override
  String get fieldSchedule => 'Расписание';

  @override
  String get fieldCapacity => 'Вместимость';

  @override
  String get fieldDay => 'День';

  @override
  String get fieldTime => 'Время';

  @override
  String capacityPeople(int count, int capacity) {
    return '$count/$capacity чел.';
  }

  @override
  String membersTitle(int count) {
    return 'Участники ($count)';
  }

  @override
  String get noMembersAssigned => 'Ученики ещё не назначены.';

  @override
  String get editGroup => 'Изменить группу';

  @override
  String get backToGroupList => 'Назад к списку групп';

  @override
  String get addGroup => 'Добавить группу';

  @override
  String get saveGroup => 'Сохранить группу';

  @override
  String get groupsNeedCoach =>
      'Сначала нужно добавить хотя бы одного тренера, чтобы создать группу.';

  @override
  String get groupNameEmpty => 'Название группы не может быть пустым.';

  @override
  String get groupNameMinLength =>
      'Название группы должно содержать не менее 2 символов.';

  @override
  String get coachRequired => 'Необходимо выбрать тренера.';

  @override
  String get dayRequired => 'Необходимо выбрать день.';

  @override
  String get capacityEmpty => 'Вместимость не может быть пустой.';

  @override
  String get capacityMustBeNumber => 'Вместимость должна быть числом.';

  @override
  String get capacityPositive => 'Вместимость должна быть больше 0.';

  @override
  String get capacityMax => 'Вместимость не должна превышать 100.';

  @override
  String get membersLabel => 'Участники';

  @override
  String get noStudentSelected => 'Ученики не выбраны';

  @override
  String studentsSelected(int count) {
    return 'Выбрано учеников: $count';
  }

  @override
  String get membersNeedStudents =>
      'Чтобы добавить участников, сначала нужны записи об учениках.';

  @override
  String get selectCoachFirst => 'Сначала необходимо выбрать тренера.';

  @override
  String studentsExceedCapacity(int count, int capacity) {
    return 'Число выбранных учеников ($count) превышает вместимость ($capacity).';
  }

  @override
  String get selectMembersTitle => 'Выбрать участников';

  @override
  String selectedCount(int count) {
    return 'Выбрано: $count';
  }

  @override
  String selectedCountOf(int count, int capacity) {
    return 'Выбрано $count/$capacity';
  }

  @override
  String get capacityExceeded => 'Вместимость превышена';

  @override
  String get noStudentsTitle => 'Нет учеников';

  @override
  String get noStudentsBody => 'Сначала нужно добавить учеников.';

  @override
  String studentBranchAge(String branch, int age) {
    return '$branch • $age лет';
  }

  @override
  String get usersSearchHint => 'Поиск по эл. почте';

  @override
  String get usersEmptyTitle => 'Нет пользователей';

  @override
  String get usersEmptyBody => 'Зарегистрированных пользователей пока нет.';

  @override
  String get noEmail => '(нет эл. почты)';

  @override
  String get youLabel => '(вы)';

  @override
  String get cannotChangeOwnRole => 'Здесь нельзя изменить собственную роль.';

  @override
  String get roleUpdateError => 'Произошла ошибка при обновлении роли.';

  @override
  String userRoleUpdated(String email, String role) {
    return '$email → обновлено на «$role».';
  }

  @override
  String get changeRoleTitle => 'Изменить роль';

  @override
  String get parentAssignHint =>
      'Назначение учеников выполняется на экране «Родители».';

  @override
  String get studentAssignHint =>
      'Сопоставление учеников выполняется на экране «Аккаунты учеников».';

  @override
  String get parentsEmptyTitle => 'Родителей пока нет';

  @override
  String get parentsEmptyBody =>
      'Нажмите кнопку + внизу справа, чтобы добавить родителя. Родитель должен сначала зарегистрироваться в приложении.';

  @override
  String get parentAdded => 'Родитель добавлен.';

  @override
  String get parentAddError => 'Произошла ошибка при добавлении родителя.';

  @override
  String get removeParentTitle => 'Удалить родителя';

  @override
  String removeParentConfirm(String email) {
    return '$email больше не будет родителем, а привязки учеников будут удалены. Продолжить?';
  }

  @override
  String get removeAction => 'Удалить';

  @override
  String get addParentTitle => 'Добавить родителя';

  @override
  String get addParentHint =>
      'Введите адрес электронной почты родителя, зарегистрированный в приложении. Родитель должен сначала зарегистрироваться.';

  @override
  String get noStudentAssigned => 'Ученик не назначен';

  @override
  String studentsAssigned(String names) {
    return 'Ученики: $names';
  }

  @override
  String get assignStudentsTitle => 'Назначить учеников';

  @override
  String accountAssignHeader(String label, String email) {
    return '$label: $email';
  }

  @override
  String get studentAccountAdded => 'Аккаунт ученика добавлен.';

  @override
  String get studentAccountAddError =>
      'Произошла ошибка при добавлении аккаунта ученика.';

  @override
  String get removeAccountTitle => 'Удалить аккаунт';

  @override
  String removeAccountConfirm(String email) {
    return '$email больше не будет учеником, а привязка ученика будет удалена. Продолжить?';
  }

  @override
  String get studentAccountsEmptyTitle => 'Аккаунтов учеников пока нет';

  @override
  String get studentAccountsEmptyBody =>
      'Нажмите кнопку + внизу справа, чтобы добавить аккаунт ученика. Ученик должен сначала зарегистрироваться в приложении.';

  @override
  String get studentNotLinked => 'Ученик не привязан';

  @override
  String studentLinked(String name) {
    return 'Ученик: $name';
  }

  @override
  String get addStudentAccountTitle => 'Добавить аккаунт ученика';

  @override
  String get addStudentAccountHint =>
      'Введите адрес электронной почты ученика, зарегистрированный в приложении. Ученик должен сначала зарегистрироваться.';

  @override
  String get accountLabelStudent => 'Аккаунт ученика';

  @override
  String photoPickError(Object error) {
    return 'Не удалось выбрать фото: $error';
  }

  @override
  String get profileUpdated => 'Профиль обновлён.';

  @override
  String profileSaveError(Object error) {
    return 'Не удалось сохранить: $error';
  }

  @override
  String get pickPhoto => 'Выбрать фото';

  @override
  String get removePhoto => 'Удалить фото';

  @override
  String get nameTooLong => 'Имя слишком длинное.';

  @override
  String get phoneTooLong => 'Номер телефона слишком длинный.';

  @override
  String get commonSaving => 'Сохранение...';

  @override
  String get attendanceDeleteTitle => 'Удалить посещаемость';

  @override
  String attendanceDeleteConfirm(String group, String date) {
    return 'Вы уверены, что хотите удалить запись посещаемости $group - $date';
  }

  @override
  String get attendanceDeleted => 'Запись посещаемости удалена.';

  @override
  String get attendanceEmptyTitle => 'Записей о посещаемости пока нет';

  @override
  String get attendanceEmptyAdmin =>
      'Нажмите кнопку + внизу справа, чтобы добавить новую запись посещаемости.';

  @override
  String get attendanceEmptyNoGroup =>
      'Чтобы отметить посещаемость, сначала добавьте хотя бы одну группу и ученика.';

  @override
  String get attendanceEmptyViewer =>
      'Записей о посещаемости пока нет. Они появятся здесь, когда администратор добавит посещаемость.';

  @override
  String attendanceCountLine(int present, int absent) {
    return 'Присутствовали: $present • Отсутствовали: $absent';
  }

  @override
  String get takeAttendanceTitle => 'Отметить посещаемость';

  @override
  String get editAttendanceTitle => 'Изменить посещаемость';

  @override
  String get selectGroupFirst => 'Сначала выберите группу.';

  @override
  String get fieldGroup => 'Группа';

  @override
  String get groupRequired => 'Необходимо выбрать группу.';

  @override
  String get fieldDate => 'Дата';

  @override
  String studentsCountTitle(int count) {
    return 'Ученики ($count)';
  }

  @override
  String get groupNoStudentsTitle => 'В этой группе нет учеников.';

  @override
  String get groupNoStudentsBody =>
      'Вы можете добавить учеников в деталях группы.';

  @override
  String get saveAttendance => 'Сохранить посещаемость';

  @override
  String get attendanceNeedGroupStudent =>
      'Чтобы отметить посещаемость, сначала нужно добавить хотя бы одну группу и ученика.';

  @override
  String get attendanceDetailTitle => 'Детали посещаемости';

  @override
  String get presentStudentsTitle => 'Присутствующие ученики';

  @override
  String get noPresentStudents => 'Присутствующих учеников нет.';

  @override
  String get absentStudentsTitle => 'Отсутствующие ученики';

  @override
  String get noAbsentStudents => 'Отсутствующих учеников нет.';

  @override
  String get backToAttendanceList => 'Назад к списку посещаемости';

  @override
  String get childAttendanceEmptyTitle => 'Нет записей о посещаемости';

  @override
  String get childAttendanceEmptyBody =>
      'Запись посещаемости с участием вашего ребёнка ещё не создана.';

  @override
  String attendedOfLessons(int total, int present) {
    return 'Посещено $present из $total занятий';
  }

  @override
  String percentValue(int percent) {
    return '$percent%';
  }

  @override
  String get paymentDeleteTitle => 'Удалить платёж';

  @override
  String paymentDeleteConfirm(String name, String period) {
    return 'Вы уверены, что хотите удалить запись о платеже $name - $period';
  }

  @override
  String get paymentDeleted => 'Запись о платеже удалена.';

  @override
  String get periodLabel => 'Период:';

  @override
  String get allPeriods => 'Все периоды';

  @override
  String get paymentsSearchHint => 'Поиск платежей';

  @override
  String get paymentsEmptyTitle => 'Записей о платежах пока нет';

  @override
  String get paymentsEmptyAdmin =>
      'Нажмите кнопку + внизу справа, чтобы добавить новую запись о платеже.';

  @override
  String get paymentsEmptyNoStudent =>
      'Чтобы добавить платёж, сначала добавьте хотя бы одного ученика.';

  @override
  String get paymentsEmptyViewer =>
      'Записей о платежах пока нет. Они появятся здесь, когда администратор добавит платёж.';

  @override
  String paymentsNoStatusResults(String status) {
    return 'Нет записей со статусом «$status». Выберите другой фильтр или «Все».';
  }

  @override
  String get remindTooltip => 'Отправить напоминание';

  @override
  String get noParentPhone => 'Телефон родителя ученика не сохранён.';

  @override
  String get paymentCollectedLabel => 'Собрано';

  @override
  String recordCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count записи',
      many: '$count записей',
      few: '$count записи',
      one: '1 запись',
    );
    return '$_temp0';
  }

  @override
  String get paymentDetailTitle => 'Детали платежа';

  @override
  String get fieldPeriod => 'Месяц / период';

  @override
  String get fieldAmount => 'Сумма';

  @override
  String get fieldStatus => 'Статус';

  @override
  String get fieldNote => 'Заметка';

  @override
  String get noNote => 'Без заметки.';

  @override
  String get remindViaWhatsApp => 'Напомнить через WhatsApp';

  @override
  String get editPaymentTitle => 'Изменить платёж';

  @override
  String get backToPaymentList => 'Назад к списку платежей';

  @override
  String get addPaymentTitle => 'Добавить новый платёж';

  @override
  String get paymentNeedStudent =>
      'Чтобы добавить платёж, сначала нужно добавить хотя бы одного ученика.';

  @override
  String get studentRequired => 'Необходимо выбрать ученика.';

  @override
  String get periodEmpty => 'Месяц / период не может быть пустым.';

  @override
  String get amountEmpty => 'Сумма не может быть пустой.';

  @override
  String get amountMustBeNumber => 'Сумма должна быть числом.';

  @override
  String get amountPositive => 'Сумма должна быть больше 0.';

  @override
  String get amountTooHigh => 'Сумма выглядит слишком большой.';

  @override
  String get statusRequired => 'Необходимо выбрать статус.';

  @override
  String get noteHint => 'Необязательная заметка';

  @override
  String get selectStudentFirst => 'Сначала выберите ученика.';

  @override
  String get savePayment => 'Сохранить платёж';

  @override
  String get leaveReported => 'Заявка на пропуск отправлена.';

  @override
  String get leaveDeleteTitle => 'Удалить заявку на пропуск';

  @override
  String get leaveDeleteConfirm => 'Вы хотите удалить эту заявку на пропуск?';

  @override
  String get newLeave => 'Новая заявка на пропуск';

  @override
  String get leaveEmptyTitle => 'Заявок на пропуск нет';

  @override
  String get leaveEmptyParent =>
      'Вы ещё не отправили ни одной заявки на пропуск. Используйте кнопку внизу справа, чтобы добавить.';

  @override
  String get leaveEmptyStaff => 'Заявки на пропуск ещё не отправлены.';

  @override
  String get cancelLeaveAction => 'Отменить';

  @override
  String get reasonRequired => 'Пожалуйста, укажите причину.';

  @override
  String dateWithValue(String date) {
    return 'Дата: $date';
  }

  @override
  String get fieldReason => 'Причина';

  @override
  String get reasonHint => 'Напр.: медицинская справка, семейный визит...';

  @override
  String get sendAction => 'Отправить';

  @override
  String get performanceAnalysisTitle => 'Анализ результатов';

  @override
  String recordAddError(Object error) {
    return 'Не удалось добавить запись: $error';
  }

  @override
  String recordDeleteError(Object error) {
    return 'Не удалось удалить запись: $error';
  }

  @override
  String get recordDeleteTitle => 'Удалить запись';

  @override
  String performanceDeleteConfirm(String date) {
    return 'Вы уверены, что хотите удалить запись результатов от $date?';
  }

  @override
  String get noStudentFound => 'Ученик не найден';

  @override
  String get performanceEmptyManage =>
      'Чтобы вводить результаты, сначала нужно добавить ученика.';

  @override
  String get performanceEmptyParent =>
      'К вашему аккаунту ещё не привязан ни один ученик. Пожалуйста, свяжитесь с руководством спортивной школы.';

  @override
  String get addPerformance => 'Добавить результат';

  @override
  String get noPerformanceForStudent =>
      'Для этого ученика ещё нет записей результатов.';

  @override
  String get comparisonByDate => 'Сравнение по датам';

  @override
  String get recordsTitle => 'Записи';

  @override
  String get selectAction => 'Выбрать';

  @override
  String get scoresLabel => 'Баллы (0-100)';

  @override
  String get metricJump => 'Прыжок';

  @override
  String get metricSpeed => 'Скорость';

  @override
  String get metricEndurance => 'Выносливость';

  @override
  String get metricFlexibility => 'Гибкость';

  @override
  String get metricBallControl => 'Владение мячом';

  @override
  String get announcementDeleteTitle => 'Удалить объявление';

  @override
  String announcementDeleteConfirm(String title) {
    return 'Вы уверены, что хотите удалить объявление с заголовком $title';
  }

  @override
  String get announcementDeleted => 'Объявление удалено.';

  @override
  String get announcementsEmptyTitle => 'Объявлений пока нет';

  @override
  String get announcementsEmptyAdmin =>
      'Нажмите кнопку + внизу справа, чтобы добавить новое объявление.';

  @override
  String get announcementsEmptyViewer =>
      'Объявлений пока нет. Они появятся здесь, когда администратор добавит объявление.';

  @override
  String get announcementDetailTitle => 'Детали объявления';

  @override
  String get fieldTitle => 'Заголовок';

  @override
  String get fieldTargetAudience => 'Целевая аудитория';

  @override
  String get editAnnouncementTitle => 'Изменить объявление';

  @override
  String get backToAnnouncementList => 'Назад к списку объявлений';

  @override
  String get addAnnouncementTitle => 'Добавить новое объявление';

  @override
  String get titleHint => 'Изменение времени тренировки';

  @override
  String get titleEmpty => 'Заголовок не может быть пустым.';

  @override
  String get titleMinLength =>
      'Заголовок должен содержать не менее 3 символов.';

  @override
  String get fieldContent => 'Содержание';

  @override
  String get contentHint => 'Напишите содержание объявления...';

  @override
  String get contentEmpty => 'Содержание не может быть пустым.';

  @override
  String get contentMinLength =>
      'Содержание должно содержать не менее 10 символов.';

  @override
  String get audienceRequired => 'Необходимо выбрать целевую аудиторию.';

  @override
  String get saveAnnouncement => 'Сохранить объявление';

  @override
  String get audienceEveryone => 'Все';

  @override
  String eventAddError(Object error) {
    return 'Не удалось добавить событие: $error';
  }

  @override
  String eventDeleteError(Object error) {
    return 'Не удалось удалить событие: $error';
  }

  @override
  String get eventDeleteTitle => 'Удалить событие';

  @override
  String eventDeleteConfirm(String title) {
    return 'Вы хотите удалить событие $title?';
  }

  @override
  String get eventsEmptyTitle => 'Запланированных событий нет';

  @override
  String get eventsEmptyManage =>
      'Нажмите кнопку + внизу справа, чтобы добавить новое событие.';

  @override
  String get eventsEmptyViewer =>
      'События появятся здесь, когда тренеры их запланируют.';

  @override
  String get addEvent => 'Добавить событие';

  @override
  String get selectAttendanceFirst =>
      'Пожалуйста, сначала выберите статус участия.';

  @override
  String get responseAlreadySaved => 'Ваш ответ уже сохранён.';

  @override
  String responseSendError(Object error) {
    return 'Не удалось отправить ответ: $error';
  }

  @override
  String get responseSent => 'Ваш ответ отправлен.';

  @override
  String attendingCount(int count) {
    return 'Придут: $count';
  }

  @override
  String notAttendingCount(int count) {
    return 'Не придут: $count';
  }

  @override
  String eventDateLabel(String date) {
    return 'Дата события: $date';
  }

  @override
  String get willAttend => 'Придёт';

  @override
  String get willNotAttend => 'Не придёт';

  @override
  String get sendingLabel => 'Отправка...';

  @override
  String get sentLabel => 'Отправлено';

  @override
  String get addEventTitle => 'Новое событие';

  @override
  String get fieldEventName => 'Название события';

  @override
  String get eventNameHint => 'Товарищеский матч';

  @override
  String get eventNameEmpty => 'Название события не может быть пустым.';

  @override
  String get fieldDescriptionOptional => 'Описание (необязательно)';

  @override
  String get saveEvent => 'Сохранить событие';

  @override
  String get cashDeleteTitle => 'Удалить запись';

  @override
  String cashDeleteConfirm(String title) {
    return 'Вы хотите удалить запись «$title»?';
  }

  @override
  String get newCashEntry => 'Новая запись';

  @override
  String get cashEmptyTitle => 'Касса пуста';

  @override
  String get cashEmptyBody =>
      'Записей о доходах/расходах пока нет. Добавьте первую запись кнопкой внизу справа.';

  @override
  String get currentBalance => 'Текущий баланс';

  @override
  String get totalIncome => 'Всего доходов';

  @override
  String get totalExpense => 'Всего расходов';

  @override
  String get titleRequired => 'Пожалуйста, введите название.';

  @override
  String get amountInvalid => 'Пожалуйста, введите корректную сумму.';

  @override
  String get cashTitleHint => 'Напр.: взносы за март, аренда зала...';

  @override
  String get fieldAmountCurrency => 'Сумма (₺)';

  @override
  String get fieldCategory => 'Категория';

  @override
  String get fieldNoteOptional => 'Заметка (необязательно)';

  @override
  String get equipmentDeleteTitle => 'Удалить предмет';

  @override
  String equipmentDeleteConfirm(String name) {
    return 'Вы хотите удалить запись «$name»?';
  }

  @override
  String get newEquipment => 'Новый предмет';

  @override
  String get equipmentEmptyTitle => 'Склад пуст';

  @override
  String get equipmentEmptyManage =>
      'Предметов пока нет. Добавьте первую запись кнопкой внизу справа.';

  @override
  String get equipmentEmptyViewer =>
      'На склад ещё не добавлено ни одного предмета.';

  @override
  String get noResultTitle => 'Нет результатов';

  @override
  String get noResultInCategory => 'В этой категории нет предметов.';

  @override
  String get equipmentSummaryTitle => 'Сводка по складу';

  @override
  String get metricVariety => 'Виды';

  @override
  String get metricTotalQuantity => 'Всего штук';

  @override
  String get metricAttention => 'Внимание';

  @override
  String assignedPrefix(String who) {
    return 'Закреплено: $who';
  }

  @override
  String get editEquipment => 'Изменить предмет';

  @override
  String get fieldEquipmentName => 'Название предмета';

  @override
  String get equipmentNameHint => 'Напр.: футбольный мяч, форма...';

  @override
  String get equipmentNameRequired => 'Пожалуйста, введите название предмета.';

  @override
  String get quantityMustBePositive => 'Количество должно быть больше 0.';

  @override
  String get fieldQuantity => 'Количество';

  @override
  String get fieldAssignedOptional => 'Закреплено за (необязательно)';

  @override
  String get assignedHint => 'У кого / где';

  @override
  String get conditionGood => 'Исправно';

  @override
  String get conditionMaintenance => 'На обслуживании';

  @override
  String get conditionWorn => 'Изношено';

  @override
  String get generalSummary => 'Общая сводка';

  @override
  String get paymentSummary => 'Сводка по платежам';

  @override
  String get paidPayments => 'Оплаченные платежи';

  @override
  String get pendingPayments => 'Ожидающие платежи';

  @override
  String get statusComment => 'Обзор состояния';

  @override
  String get reportsNoData =>
      'Пока недостаточно данных. По мере добавления записей об учениках, группах и платежах здесь появится общая сводка состояния.';

  @override
  String reportsSummary(
    int students,
    int coaches,
    int groups,
    int payments,
    int paid,
    int pending,
  ) {
    return 'В системе $students учеников, $coaches тренеров и $groups групп. Из $payments записей о платежах $paid оплачено, $pending ожидают.';
  }

  @override
  String get notificationsEmptyTitle => 'Нет уведомлений';

  @override
  String get notificationsEmptyBody => 'Сейчас нет уведомлений для показа.';

  @override
  String get noRecordsTitle => 'Нет записей';

  @override
  String get noNotificationsInCategory => 'В этой категории нет уведомлений.';

  @override
  String get aiStaffSuggestion1 => 'Подведи итоги этого месяца';

  @override
  String get aiStaffSuggestion2 => 'На что мне стоит обратить внимание?';

  @override
  String get aiStaffSuggestion3 =>
      'Составь короткое сообщение родителю о пропуске';

  @override
  String get aiStaffSuggestion4 => 'Дай 3 совета по улучшению сбора платежей';

  @override
  String get aiParentSuggestion1 => 'Кратко опиши ситуацию моего ребёнка';

  @override
  String get aiParentSuggestion2 => 'Как обстоят дела с посещаемостью?';

  @override
  String get aiParentSuggestion3 => 'Объясни мой статус оплаты';

  @override
  String get aiParentSuggestion4 => 'Что посоветуешь для его развития?';

  @override
  String get aiStudentSuggestion1 => 'Кратко опиши мою ситуацию';

  @override
  String get aiStudentSuggestion2 => 'Как моя посещаемость?';

  @override
  String get aiStudentSuggestion3 => 'Прокомментируй мои результаты';

  @override
  String get aiStudentSuggestion4 => 'Что посоветуешь для улучшения?';

  @override
  String get sportekaiNotReadyTitle => 'SporTekAi ещё не готов';

  @override
  String get sportekaiNotReadyBody =>
      'Чтобы использовать ИИ-ассистента, необходимо указать адрес Cloudflare Worker (SPORTEKAI_ENDPOINT). Настройка: cloudflare/README.md';

  @override
  String get sportekaiGreeting => 'Привет! Я SporTekAi ✨';

  @override
  String get sportekaiHint => 'Спросите SporTekAi...';

  @override
  String get aiResponseLanguage => 'русском языке';

  @override
  String get videoOpenError => 'Не удалось открыть видео.';

  @override
  String get watchIntroVideo => 'Посмотреть вводное видео';

  @override
  String get youtubeHowToPlay => 'как играть';

  @override
  String get fullNameHint => 'Иван Иванов';

  @override
  String get monthJanuary => 'Январь';

  @override
  String get monthFebruary => 'Февраль';

  @override
  String get monthMarch => 'Март';

  @override
  String get monthApril => 'Апрель';

  @override
  String get monthMay => 'Май';

  @override
  String get monthJune => 'Июнь';

  @override
  String get monthJuly => 'Июль';

  @override
  String get monthAugust => 'Август';

  @override
  String get monthSeptember => 'Сентябрь';

  @override
  String get monthOctober => 'Октябрь';

  @override
  String get monthNovember => 'Ноябрь';

  @override
  String get monthDecember => 'Декабрь';

  @override
  String get chatTitle => 'Чат клуба';

  @override
  String get chatHint => 'Написать сообщение…';

  @override
  String get chatEmptyTitle => 'Сообщений пока нет';

  @override
  String get chatEmptyBody => 'Отправьте первое сообщение.';

  @override
  String get chatLoadError =>
      'Не удалось загрузить чат. Возможно, у вас нет доступа.';

  @override
  String get chatEditTitle => 'Редактировать сообщение';

  @override
  String get chatDeleteTitle => 'Удалить сообщение';

  @override
  String get chatDeleteConfirm => 'Удалить это сообщение?';

  @override
  String get chatEdited => 'изменено';

  @override
  String get scheduleTitle => 'Расписание занятий';

  @override
  String get scheduleViewDay => 'День';

  @override
  String get scheduleViewWeek => 'Неделя';

  @override
  String get scheduleAddTitle => 'Добавить занятие';

  @override
  String get scheduleEditTitle => 'Изменить занятие';

  @override
  String get scheduleEmptyTitle => 'Расписание пусто';

  @override
  String get scheduleEmptyBody => 'Занятия ещё не добавлены.';

  @override
  String get scheduleEmptyBodyManage => 'Добавьте первое занятие кнопкой +.';

  @override
  String get scheduleNoLesson => 'Нет занятий';

  @override
  String get scheduleDayLabel => 'День';

  @override
  String get scheduleStartLabel => 'Начало';

  @override
  String get scheduleEndLabel => 'Конец';

  @override
  String get scheduleGroupLabel => 'Группа';

  @override
  String get scheduleCoachLabel => 'Тренер';

  @override
  String get scheduleDeleteTitle => 'Удалить занятие';

  @override
  String get scheduleDeleteConfirm => 'Удалить это занятие?';

  @override
  String get scheduleNeedsGroupCoach => 'Сначала добавьте группу и тренера.';

  @override
  String get scheduleLoadError => 'Не удалось загрузить расписание.';
}
