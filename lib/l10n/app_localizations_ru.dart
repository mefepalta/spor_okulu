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
}
