import 'package:flutter/widgets.dart';

import '../screens/info_text_screen.dart';

/// Bilgi sayfalarının ([InfoPages]) yerelleştirilmiş paragrafları.
///
/// Türkçe metinler [InfoPages] içinde (varsayılan/fallback); burada en/es/ru/fr.
/// [pageId]: 'contact' | 'terms' | 'kvkk' | 'privacy'.
///
/// NOT: Makine çevirisidir ve örnek/taslak içeriktir; KVKK/Kullanım Koşulları/
/// Gizlilik gibi hukuki metinlerin nihai hâli bir hukuk danışmanınca gözden
/// geçirilmelidir.
List<String> localizedInfoParagraphs(String pageId, Locale locale) {
  final byId = _infoByLocale[locale.languageCode];
  final paragraphs = byId?[pageId];
  if (paragraphs != null) {
    return paragraphs;
  }
  // Türkçe (ve eksik diller) için InfoPages içindeki içerik.
  switch (pageId) {
    case 'contact':
      return InfoPages.contact;
    case 'terms':
      return InfoPages.terms;
    case 'kvkk':
      return InfoPages.kvkk;
    case 'privacy':
      return InfoPages.privacy;
    default:
      return const <String>[];
  }
}

const Map<String, Map<String, List<String>>> _infoByLocale = {
  'en': _en,
  'es': _es,
  'ru': _ru,
  'fr': _fr,
  'ar': _ar,
};

// ============================ ENGLISH =======================================
const Map<String, List<String>> _en = {
  'contact': [
    'You can reach us for any questions, suggestions or requests regarding the '
        'sports school management.',
    'Email: iletisim@sporokulu.com',
    'Phone: (555) 000 00 00',
    'Working hours: Weekdays 09:00 - 18:00',
  ],
  'terms': [
    'By using this application, you are deemed to have accepted the following '
        'terms.',
    'The application is provided for tracking the student, coach and parent '
        'processes of the sports school. You are responsible for the security '
        'of your account and the confidentiality of your login information.',
    'The accuracy of the data within the application is ensured by the school '
        'management. Attempting to access or modify records outside your '
        'authorization is prohibited.',
    'This text is sample content; the final terms of use will be updated by '
        'the school management.',
  ],
  'kvkk': [
    'Under the Turkish Personal Data Protection Law No. 6698 ("KVKK"), as the '
        'sports school, in our capacity as data controller, we process your '
        'personal data within the framework explained below.',
    'Data processed: name-surname, email, phone and profile photo, together '
        'with the student\'s attendance, performance and payment records. This '
        'data is processed solely for carrying out educational and '
        'administrative processes.',
    'Your personal data is stored on secure infrastructure to the extent '
        'required by the service; it is not shared with third parties except '
        'for legal obligations.',
    'Pursuant to Article 11 of the KVKK, you have the right to access your '
        'data, request its correction or deletion, and object to its '
        'processing. You can submit your requests to the school management.',
    'This text is sample/draft content; the final KVKK disclosure text will be '
        'updated by the school management.',
  ],
  'privacy': [
    'Your personal data is processed solely for the purpose of providing the '
        'sports school services and is not shared with third parties.',
    'The information collected is limited to account information such as name, '
        'email, phone and profile photo. This information is stored on secure '
        'infrastructure.',
    'You can edit your account information from the profile screen; to request '
        'its deletion, you can contact the school management.',
    'This text is sample content; the final privacy policy will be updated by '
        'the school management.',
  ],
};

// ============================ SPANISH =======================================
const Map<String, List<String>> _es = {
  'contact': [
    'Puedes contactarnos para cualquier pregunta, sugerencia o solicitud '
        'relacionada con la dirección de la escuela deportiva.',
    'Correo: iletisim@sporokulu.com',
    'Teléfono: (555) 000 00 00',
    'Horario: Días laborables 09:00 - 18:00',
  ],
  'terms': [
    'Al usar esta aplicación, se considera que aceptas las siguientes '
        'condiciones.',
    'La aplicación se ofrece para el seguimiento de los procesos de '
        'estudiantes, entrenadores y padres de la escuela deportiva. Eres '
        'responsable de la seguridad de tu cuenta y de la confidencialidad de '
        'tus datos de acceso.',
    'La exactitud de los datos dentro de la aplicación la garantiza la '
        'dirección de la escuela. Está prohibido intentar acceder a registros '
        'fuera de tu autorización o modificarlos.',
    'Este texto es contenido de ejemplo; las condiciones de uso finales serán '
        'actualizadas por la dirección de la escuela.',
  ],
  'kvkk': [
    'En el marco de la Ley de Protección de Datos Personales de Turquía n.º '
        '6698 ("KVKK"), como escuela deportiva y en calidad de responsable del '
        'tratamiento, tratamos tus datos personales según se explica a '
        'continuación.',
    'Datos tratados: nombre y apellidos, correo, teléfono y foto de perfil, '
        'junto con los registros de asistencia, rendimiento y pagos del '
        'estudiante. Estos datos se tratan únicamente para llevar a cabo los '
        'procesos educativos y administrativos.',
    'Tus datos personales se almacenan en una infraestructura segura en la '
        'medida que requiere el servicio; no se comparten con terceros salvo '
        'por obligaciones legales.',
    'Conforme al artículo 11 de la KVKK, tienes derecho a acceder a tus datos, '
        'solicitar su rectificación o supresión y oponerte a su tratamiento. '
        'Puedes dirigir tus solicitudes a la dirección de la escuela.',
    'Este texto es contenido de ejemplo/borrador; el texto informativo final '
        'de la KVKK será actualizado por la dirección de la escuela.',
  ],
  'privacy': [
    'Tus datos personales se tratan únicamente con el fin de prestar los '
        'servicios de la escuela deportiva y no se comparten con terceros.',
    'La información recopilada se limita a datos de la cuenta como nombre, '
        'correo, teléfono y foto de perfil. Esta información se almacena en una '
        'infraestructura segura.',
    'Puedes editar la información de tu cuenta desde la pantalla de perfil; '
        'para solicitar su eliminación, puedes contactar con la dirección de '
        'la escuela.',
    'Este texto es contenido de ejemplo; la política de privacidad final será '
        'actualizada por la dirección de la escuela.',
  ],
};

// ============================ RUSSIAN =======================================
const Map<String, List<String>> _ru = {
  'contact': [
    'Вы можете связаться с нами по любым вопросам, предложениям и запросам, '
        'касающимся руководства спортивной школы.',
    'Эл. почта: iletisim@sporokulu.com',
    'Телефон: (555) 000 00 00',
    'Часы работы: будни 09:00 - 18:00',
  ],
  'terms': [
    'Используя это приложение, вы считаетесь принявшими следующие условия.',
    'Приложение предоставляется для отслеживания процессов учеников, тренеров '
        'и родителей спортивной школы. Вы несёте ответственность за '
        'безопасность своей учётной записи и конфиденциальность данных для '
        'входа.',
    'Точность данных в приложении обеспечивается руководством школы. Попытки '
        'получить доступ к записям вне ваших полномочий или изменить их '
        'запрещены.',
    'Этот текст является примерным содержанием; окончательные условия '
        'использования будут обновлены руководством школы.',
  ],
  'kvkk': [
    'В рамках Закона Турции о защите персональных данных № 6698 («KVKK») мы '
        'как спортивная школа в качестве оператора данных обрабатываем ваши '
        'персональные данные в описанных ниже рамках.',
    'Обрабатываемые данные: имя и фамилия, эл. почта, телефон и фото профиля, '
        'а также записи о посещаемости, результатах и платежах ученика. Эти '
        'данные обрабатываются исключительно для ведения образовательных и '
        'административных процессов.',
    'Ваши персональные данные хранятся в защищённой инфраструктуре в объёме, '
        'необходимом для услуги; они не передаются третьим лицам, кроме '
        'случаев, предусмотренных законом.',
    'В соответствии со статьёй 11 KVKK вы имеете право на доступ к своим '
        'данным, требование их исправления или удаления и возражение против их '
        'обработки. Свои запросы вы можете направлять руководству школы.',
    'Этот текст является примерным/черновым содержанием; окончательный '
        'информационный текст KVKK будет обновлён руководством школы.',
  ],
  'privacy': [
    'Ваши персональные данные обрабатываются исключительно в целях '
        'предоставления услуг спортивной школы и не передаются третьим лицам.',
    'Собираемая информация ограничивается данными учётной записи, такими как '
        'имя, эл. почта, телефон и фото профиля. Эта информация хранится в '
        'защищённой инфраструктуре.',
    'Вы можете редактировать данные своей учётной записи на экране профиля; '
        'чтобы запросить их удаление, вы можете связаться с руководством '
        'школы.',
    'Этот текст является примерным содержанием; окончательная политика '
        'конфиденциальности будет обновлена руководством школы.',
  ],
};

// ============================ FRENCH ========================================
const Map<String, List<String>> _fr = {
  'contact': [
    'Vous pouvez nous contacter pour toute question, suggestion ou demande '
        'concernant la direction de l\'école de sport.',
    'E-mail : iletisim@sporokulu.com',
    'Téléphone : (555) 000 00 00',
    'Horaires : en semaine 09:00 - 18:00',
  ],
  'terms': [
    'En utilisant cette application, vous êtes réputé avoir accepté les '
        'conditions suivantes.',
    'L\'application est fournie pour le suivi des processus des élèves, '
        'entraîneurs et parents de l\'école de sport. Vous êtes responsable de '
        'la sécurité de votre compte et de la confidentialité de vos '
        'identifiants.',
    'L\'exactitude des données dans l\'application est assurée par la direction '
        'de l\'école. Il est interdit de tenter d\'accéder à des '
        'enregistrements hors de votre autorisation ou de les modifier.',
    'Ce texte est un contenu d\'exemple ; les conditions d\'utilisation '
        'définitives seront mises à jour par la direction de l\'école.',
  ],
  'kvkk': [
    'Dans le cadre de la loi turque n° 6698 sur la protection des données '
        'personnelles (« KVKK »), en tant qu\'école de sport et en qualité de '
        'responsable du traitement, nous traitons vos données personnelles '
        'dans le cadre décrit ci-dessous.',
    'Données traitées : nom et prénom, e-mail, téléphone et photo de profil, '
        'ainsi que les enregistrements de présence, de performance et de '
        'paiement de l\'élève. Ces données sont traitées uniquement pour la '
        'conduite des processus éducatifs et administratifs.',
    'Vos données personnelles sont conservées sur une infrastructure sécurisée '
        'dans la mesure requise par le service ; elles ne sont pas partagées '
        'avec des tiers, sauf obligations légales.',
    'Conformément à l\'article 11 de la KVKK, vous avez le droit d\'accéder à '
        'vos données, de demander leur rectification ou leur suppression et de '
        'vous opposer à leur traitement. Vous pouvez adresser vos demandes à '
        'la direction de l\'école.',
    'Ce texte est un contenu d\'exemple/de brouillon ; le texte d\'information '
        'KVKK définitif sera mis à jour par la direction de l\'école.',
  ],
  'privacy': [
    'Vos données personnelles sont traitées uniquement dans le but de fournir '
        'les services de l\'école de sport et ne sont pas partagées avec des '
        'tiers.',
    'Les informations collectées se limitent aux informations de compte telles '
        'que le nom, l\'e-mail, le téléphone et la photo de profil. Ces '
        'informations sont conservées sur une infrastructure sécurisée.',
    'Vous pouvez modifier les informations de votre compte depuis l\'écran de '
        'profil ; pour en demander la suppression, vous pouvez contacter la '
        'direction de l\'école.',
    'Ce texte est un contenu d\'exemple ; la politique de confidentialité '
        'définitive sera mise à jour par la direction de l\'école.',
  ],
};

// ============================ ARABIC ========================================
const Map<String, List<String>> _ar = {
  'contact': [
    'يمكنك التواصل معنا لأي سؤال أو اقتراح أو طلب يتعلق بإدارة مدرسة الرياضة.',
    'البريد الإلكتروني: iletisim@sporokulu.com',
    'الهاتف: (555) 000 00 00',
    'ساعات العمل: أيام الأسبوع 09:00 - 18:00',
  ],
  'terms': [
    'باستخدامك لهذا التطبيق، تُعتبر قد قبلت الشروط التالية.',
    'يُقدَّم التطبيق لمتابعة عمليات الطلاب والمدربين وأولياء الأمور في مدرسة '
        'الرياضة. أنت مسؤول عن أمان حسابك وسرية بيانات دخولك.',
    'تضمن إدارة المدرسة دقة البيانات داخل التطبيق. يُحظر محاولة الوصول إلى سجلات '
        'خارج صلاحيتك أو تعديلها.',
    'هذا النص محتوى نموذجي؛ سيتم تحديث شروط الاستخدام النهائية من قبل إدارة '
        'المدرسة.',
  ],
  'kvkk': [
    'في إطار قانون حماية البيانات الشخصية التركي رقم 6698 ("KVKK")، نقوم بصفتنا '
        'مدرسة رياضية وبوصفنا المسؤول عن البيانات بمعالجة بياناتك الشخصية ضمن '
        'الإطار الموضَّح أدناه.',
    'البيانات المُعالَجة: الاسم واللقب والبريد الإلكتروني والهاتف وصورة الملف '
        'الشخصي، إلى جانب سجلات حضور الطالب وأدائه ومدفوعاته. تُعالَج هذه '
        'البيانات فقط لأجل تنفيذ العمليات التعليمية والإدارية.',
    'تُخزَّن بياناتك الشخصية على بنية تحتية آمنة بالقدر الذي تتطلبه الخدمة؛ ولا '
        'تُشارَك مع أطراف ثالثة إلا للالتزامات القانونية.',
    'وفقاً للمادة 11 من قانون KVKK، لديك الحق في الوصول إلى بياناتك وطلب '
        'تصحيحها أو حذفها والاعتراض على معالجتها. يمكنك تقديم طلباتك إلى إدارة '
        'المدرسة.',
    'هذا النص محتوى نموذجي/مسودة؛ سيتم تحديث نص إشعار KVKK النهائي من قبل إدارة '
        'المدرسة.',
  ],
  'privacy': [
    'تُعالَج بياناتك الشخصية فقط لغرض تقديم خدمات مدرسة الرياضة ولا تُشارَك مع '
        'أطراف ثالثة.',
    'تقتصر المعلومات المُجمَّعة على معلومات الحساب مثل الاسم والبريد الإلكتروني '
        'والهاتف وصورة الملف الشخصي. تُخزَّن هذه المعلومات على بنية تحتية آمنة.',
    'يمكنك تعديل معلومات حسابك من شاشة الملف الشخصي؛ ولطلب حذفها يمكنك التواصل '
        'مع إدارة المدرسة.',
    'هذا النص محتوى نموذجي؛ سيتم تحديث سياسة الخصوصية النهائية من قبل إدارة '
        'المدرسة.',
  ],
};
