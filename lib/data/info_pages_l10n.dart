import 'package:flutter/widgets.dart';

import '../screens/info_text_screen.dart';

/// Bilgi sayfalarının ([InfoPages]) yerelleştirilmiş paragrafları.
///
/// Türkçe metinler [InfoPages] içinde (varsayılan/fallback) ve hukuk danışmanı
/// gözden geçirmesinden geçmiştir. Buradaki en/es/ru/fr/ar sürümleri o
/// gözden geçirilmiş Türkçe metnin çevirileridir; hukuki bağlayıcılık için
/// Türkçe metin esastır, çeviriler ideal olarak ana dili konuşan bir çevirmence
/// doğrulanmalıdır.
///
/// DOLDURULACAK: [Veri Sorumlusu / Spor Okulu Unvanı ve Adresi] gibi köşeli
/// parantezli alanlar gerçek okul bilgileriyle doldurulmalıdır.
/// [pageId]: 'contact' | 'terms' | 'kvkk' | 'privacy'.
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
        'sports school management, including requests concerning your personal '
        'data.',
    'Email: mefepalta@gmail.com',
    'Phone: (543) 484 78 30',
    'Working hours: Weekdays 09:00 - 18:00',
  ],
  'terms': [
    'By using this application, you are deemed to have accepted the following '
        'terms of use.',
    'The application is provided for tracking the student, coach and parent '
        'processes of the sports school. You are responsible for the security '
        'of your account and the confidentiality of your login information; '
        'you must notify the school management without delay of any '
        'unauthorized use of your account.',
    'Attempting to access, modify or delete records outside your '
        'authorization is prohibited. In case of a violation, the school '
        'management may suspend or terminate the relevant account.',
    'The application is provided "as is". Except in cases of intent or gross '
        'negligence, the school assumes no liability for indirect damages '
        'that may arise from interruptions, errors or data losses. These '
        'terms may be updated from time to time; the current version is the '
        'one published within the application.',
  ],
  'kvkk': [
    'This privacy notice has been prepared pursuant to Article 10 of the '
        'Turkish Personal Data Protection Law No. 6698 ("KVKK") by '
        '[Sports School Trade Name and Address], acting in its capacity as '
        'data controller.',
    'Data processed: identity data (name-surname), contact data (email, '
        'phone), visual data (profile photo), and the student\'s attendance, '
        'performance and payment records. Where the student is under 18, '
        'their data is processed within the framework of the consent and '
        'supervision of their parent or legal guardian.',
    'Purposes of processing: management of enrollment and training '
        'processes, communication with parents and coaches, tracking of '
        'attendance and payments, and fulfillment of legal obligations.',
    'Legal bases: the processing is based on Article 5/2(c) of the KVKK '
        '(necessity for the establishment or performance of a contract), '
        'Article 5/2(ç) (compliance with a legal obligation) and Article '
        '5/2(f) (legitimate interests of the data controller); in cases '
        'falling outside these bases, your explicit consent is sought.',
    'Method of collection: your data is collected electronically and by '
        'automated means through the mobile application.',
    'Transfers: your data is shared, only to the extent required by the '
        'service, with cloud and notification infrastructure providers '
        '(e.g. Google Firebase) acting as data processors, and with '
        'authorized public authorities where legally required. As the '
        'servers of these providers may be located abroad, such transfers '
        'are carried out in accordance with Article 9 of the KVKK.',
    'Retention: your data is retained for as long as required by the '
        'processing purposes and the statutory limitation periods, after '
        'which it is deleted, destroyed or anonymized.',
    'Under Article 11 of the KVKK you have the right to: learn whether your '
        'data is processed, request information, learn the purpose of '
        'processing and whether it is used accordingly, know the third '
        'parties to whom it is transferred, request correction, deletion or '
        'destruction, object to results arising from automated analysis, and '
        'claim compensation for damages. Requests are concluded free of '
        'charge within 30 days at the latest, pursuant to Article 13 of the '
        'KVKK.',
  ],
  'privacy': [
    'Your personal data is processed solely for the purpose of providing the '
        'sports school services. Apart from the cloud and notification '
        'infrastructure providers used to operate the service, it is not '
        'shared with third parties, except where required by law.',
    'The information collected is limited to account information such as '
        'name, email, phone and profile photo, together with the student\'s '
        'attendance, performance and payment records. This information is '
        'stored on secure infrastructure and access is restricted on a '
        'role-based authorization basis.',
    'You can edit your account information from the profile screen; to '
        'request its deletion, you can contact the school management through '
        'the contact channels. Requests are concluded within 30 days at the '
        'latest.',
  ],
};

// ============================ SPANISH =======================================
const Map<String, List<String>> _es = {
  'contact': [
    'Puedes contactarnos para cualquier pregunta, sugerencia o solicitud '
        'relacionada con la dirección de la escuela deportiva, incluidas las '
        'solicitudes relativas a tus datos personales.',
    'Correo: mefepalta@gmail.com',
    'Teléfono: (543) 484 78 30',
    'Horario: Días laborables 09:00 - 18:00',
  ],
  'terms': [
    'Al usar esta aplicación, se considera que aceptas las siguientes '
        'condiciones de uso.',
    'La aplicación se ofrece para el seguimiento de los procesos de '
        'estudiantes, entrenadores y padres de la escuela deportiva. Eres '
        'responsable de la seguridad de tu cuenta y de la confidencialidad de '
        'tus datos de acceso; debes notificar sin demora a la dirección de la '
        'escuela cualquier uso no autorizado de tu cuenta.',
    'Está prohibido intentar acceder, modificar o eliminar registros fuera '
        'de tu autorización. En caso de infracción, la dirección de la '
        'escuela podrá suspender o cancelar la cuenta correspondiente.',
    'La aplicación se ofrece "tal cual". Salvo en casos de dolo o '
        'negligencia grave, la escuela no asume responsabilidad por daños '
        'indirectos derivados de interrupciones, errores o pérdidas de '
        'datos. Estas condiciones pueden actualizarse periódicamente; la '
        'versión vigente es la publicada dentro de la aplicación.',
  ],
  'kvkk': [
    'Este texto informativo ha sido preparado conforme al artículo 10 de la '
        'Ley de Protección de Datos Personales de Turquía n.º 6698 ("KVKK") '
        'por [Denominación y dirección de la escuela deportiva], en calidad '
        'de responsable del tratamiento.',
    'Datos tratados: datos de identidad (nombre y apellidos), datos de '
        'contacto (correo, teléfono), datos visuales (foto de perfil) y los '
        'registros de asistencia, rendimiento y pagos del estudiante. Cuando '
        'el estudiante sea menor de 18 años, sus datos se tratan en el marco '
        'del consentimiento y la supervisión de su padre, madre o tutor '
        'legal.',
    'Finalidades del tratamiento: gestión de los procesos de inscripción y '
        'formación, comunicación con padres y entrenadores, seguimiento de '
        'asistencia y pagos, y cumplimiento de obligaciones legales.',
    'Bases jurídicas: el tratamiento se basa en el artículo 5/2(c) de la '
        'KVKK (necesidad para la celebración o ejecución de un contrato), el '
        'artículo 5/2(ç) (cumplimiento de una obligación legal) y el '
        'artículo 5/2(f) (interés legítimo del responsable); en los casos no '
        'cubiertos por estas bases se solicita tu consentimiento explícito.',
    'Método de recogida: tus datos se recogen por medios electrónicos y '
        'automatizados a través de la aplicación móvil.',
    'Transferencias: tus datos se comparten, solo en la medida que requiere '
        'el servicio, con proveedores de infraestructura en la nube y de '
        'notificaciones (p. ej. Google Firebase) que actúan como encargados '
        'del tratamiento, y con autoridades públicas competentes cuando la '
        'ley lo exija. Dado que los servidores de estos proveedores pueden '
        'estar situados en el extranjero, dichas transferencias se realizan '
        'conforme al artículo 9 de la KVKK.',
    'Conservación: tus datos se conservan durante el tiempo requerido por '
        'las finalidades del tratamiento y los plazos legales de '
        'prescripción, tras lo cual se eliminan, destruyen o anonimizan.',
    'Conforme al artículo 11 de la KVKK tienes derecho a: saber si tus datos '
        'se tratan, solicitar información, conocer la finalidad del '
        'tratamiento y si se usan conforme a ella, conocer los terceros a '
        'los que se transfieren, solicitar su rectificación, supresión o '
        'destrucción, oponerte a resultados derivados de análisis '
        'automatizados y reclamar la indemnización de los daños. Las '
        'solicitudes se resuelven gratuitamente en un plazo máximo de 30 '
        'días, conforme al artículo 13 de la KVKK.',
  ],
  'privacy': [
    'Tus datos personales se tratan únicamente con el fin de prestar los '
        'servicios de la escuela deportiva. Aparte de los proveedores de '
        'infraestructura en la nube y de notificaciones utilizados para '
        'operar el servicio, no se comparten con terceros, salvo obligación '
        'legal.',
    'La información recopilada se limita a datos de la cuenta como nombre, '
        'correo, teléfono y foto de perfil, junto con los registros de '
        'asistencia, rendimiento y pagos del estudiante. Esta información se '
        'almacena en una infraestructura segura y el acceso está restringido '
        'según roles autorizados.',
    'Puedes editar la información de tu cuenta desde la pantalla de perfil; '
        'para solicitar su eliminación, puedes contactar con la dirección de '
        'la escuela a través de los canales de contacto. Las solicitudes se '
        'resuelven en un plazo máximo de 30 días.',
  ],
};

// ============================ RUSSIAN =======================================
const Map<String, List<String>> _ru = {
  'contact': [
    'Вы можете связаться с нами по любым вопросам, предложениям и запросам, '
        'касающимся руководства спортивной школы, включая запросы, '
        'относящиеся к вашим персональным данным.',
    'Эл. почта: mefepalta@gmail.com',
    'Телефон: (543) 484 78 30',
    'Часы работы: будни 09:00 - 18:00',
  ],
  'terms': [
    'Используя это приложение, вы считаетесь принявшими следующие условия '
        'использования.',
    'Приложение предоставляется для отслеживания процессов учеников, '
        'тренеров и родителей спортивной школы. Вы несёте ответственность за '
        'безопасность своей учётной записи и конфиденциальность данных для '
        'входа; о любом несанкционированном использовании вашей учётной '
        'записи вы обязаны незамедлительно уведомить руководство школы.',
    'Запрещены попытки доступа к записям вне ваших полномочий, их изменения '
        'или удаления. В случае нарушения руководство школы может '
        'приостановить или закрыть соответствующую учётную запись.',
    'Приложение предоставляется «как есть». За исключением случаев умысла '
        'или грубой неосторожности школа не несёт ответственности за '
        'косвенные убытки, которые могут возникнуть из-за перебоев, ошибок '
        'или потери данных. Настоящие условия могут время от времени '
        'обновляться; действующей является версия, опубликованная в '
        'приложении.',
  ],
  'kvkk': [
    'Настоящий информационный текст подготовлен в соответствии со статьёй '
        '10 Закона Турции о защите персональных данных № 6698 («KVKK») '
        '[наименование и адрес спортивной школы], выступающей в качестве '
        'оператора данных.',
    'Обрабатываемые данные: идентификационные данные (имя и фамилия), '
        'контактные данные (эл. почта, телефон), визуальные данные (фото '
        'профиля), а также записи о посещаемости, результатах и платежах '
        'ученика. Если ученику не исполнилось 18 лет, его данные '
        'обрабатываются в рамках согласия и под контролем родителя или '
        'законного представителя.',
    'Цели обработки: ведение процессов зачисления и обучения, связь с '
        'родителями и тренерами, учёт посещаемости и платежей, а также '
        'исполнение правовых обязанностей.',
    'Правовые основания: обработка осуществляется на основании статьи '
        '5/2(c) KVKK (необходимость для заключения или исполнения '
        'договора), статьи 5/2(ç) (исполнение правовой обязанности) и '
        'статьи 5/2(f) (законный интерес оператора); в случаях, не '
        'охватываемых этими основаниями, запрашивается ваше явное согласие.',
    'Способ сбора: ваши данные собираются в электронной форме '
        'автоматизированными средствами через мобильное приложение.',
    'Передача данных: ваши данные передаются только в объёме, необходимом '
        'для услуги, поставщикам облачной инфраструктуры и инфраструктуры '
        'уведомлений (например, Google Firebase), действующим в качестве '
        'обработчиков данных, а также уполномоченным государственным '
        'органам в предусмотренных законом случаях. Поскольку серверы этих '
        'поставщиков могут находиться за рубежом, такая передача '
        'осуществляется в соответствии со статьёй 9 KVKK.',
    'Хранение: ваши данные хранятся в течение срока, необходимого для целей '
        'обработки, и установленных законом сроков давности, после чего '
        'удаляются, уничтожаются или анонимизируются.',
    'В соответствии со статьёй 11 KVKK вы имеете право: узнать, '
        'обрабатываются ли ваши данные, запросить информацию, узнать цель '
        'обработки и используются ли данные в соответствии с ней, знать '
        'третьих лиц, которым они передаются, требовать их исправления, '
        'удаления или уничтожения, возражать против результатов '
        'автоматизированного анализа и требовать возмещения убытков. '
        'Запросы рассматриваются бесплатно в срок не более 30 дней согласно '
        'статье 13 KVKK.',
  ],
  'privacy': [
    'Ваши персональные данные обрабатываются исключительно в целях '
        'предоставления услуг спортивной школы. Помимо поставщиков облачной '
        'инфраструктуры и инфраструктуры уведомлений, используемых для '
        'работы сервиса, они не передаются третьим лицам, за исключением '
        'случаев, предусмотренных законом.',
    'Собираемая информация ограничивается данными учётной записи, такими '
        'как имя, эл. почта, телефон и фото профиля, а также записями о '
        'посещаемости, результатах и платежах ученика. Эта информация '
        'хранится в защищённой инфраструктуре, доступ ограничен на основе '
        'ролей и полномочий.',
    'Вы можете редактировать данные своей учётной записи на экране профиля; '
        'для запроса их удаления вы можете обратиться к руководству школы '
        'через каналы связи. Запросы рассматриваются в срок не более 30 '
        'дней.',
  ],
};

// ============================ FRENCH ========================================
const Map<String, List<String>> _fr = {
  'contact': [
    'Vous pouvez nous contacter pour toute question, suggestion ou demande '
        'concernant la direction de l\'école de sport, y compris les demandes '
        'relatives à vos données personnelles.',
    'E-mail : mefepalta@gmail.com',
    'Téléphone : (543) 484 78 30',
    'Horaires : en semaine 09:00 - 18:00',
  ],
  'terms': [
    'En utilisant cette application, vous êtes réputé avoir accepté les '
        'conditions d\'utilisation suivantes.',
    'L\'application est fournie pour le suivi des processus des élèves, '
        'entraîneurs et parents de l\'école de sport. Vous êtes responsable de '
        'la sécurité de votre compte et de la confidentialité de vos '
        'identifiants ; vous devez signaler sans délai à la direction de '
        'l\'école toute utilisation non autorisée de votre compte.',
    'Il est interdit de tenter d\'accéder à des enregistrements hors de '
        'votre autorisation, de les modifier ou de les supprimer. En cas de '
        'violation, la direction de l\'école peut suspendre ou clôturer le '
        'compte concerné.',
    'L\'application est fournie « en l\'état ». Sauf en cas de dol ou de '
        'faute lourde, l\'école n\'assume aucune responsabilité pour les '
        'dommages indirects pouvant résulter d\'interruptions, d\'erreurs ou '
        'de pertes de données. Les présentes conditions peuvent être mises à '
        'jour ; la version en vigueur est celle publiée dans l\'application.',
  ],
  'kvkk': [
    'Le présent texte d\'information a été préparé conformément à l\'article '
        '10 de la loi turque n° 6698 sur la protection des données '
        'personnelles (« KVKK ») par [dénomination et adresse de l\'école de '
        'sport], agissant en qualité de responsable du traitement.',
    'Données traitées : données d\'identité (nom et prénom), données de '
        'contact (e-mail, téléphone), données visuelles (photo de profil), '
        'ainsi que les enregistrements de présence, de performance et de '
        'paiement de l\'élève. Lorsque l\'élève a moins de 18 ans, ses '
        'données sont traitées dans le cadre du consentement et de la '
        'surveillance de son parent ou tuteur légal.',
    'Finalités du traitement : gestion des processus d\'inscription et de '
        'formation, communication avec les parents et les entraîneurs, suivi '
        'des présences et des paiements, et respect des obligations légales.',
    'Bases juridiques : le traitement repose sur l\'article 5/2(c) de la '
        'KVKK (nécessité pour la conclusion ou l\'exécution d\'un contrat), '
        'l\'article 5/2(ç) (respect d\'une obligation légale) et l\'article '
        '5/2(f) (intérêt légitime du responsable du traitement) ; dans les '
        'cas non couverts par ces bases, votre consentement explicite est '
        'demandé.',
    'Méthode de collecte : vos données sont collectées par voie électronique '
        'et par des moyens automatisés via l\'application mobile.',
    'Transferts : vos données sont partagées, uniquement dans la mesure '
        'requise par le service, avec des fournisseurs d\'infrastructure '
        'cloud et de notifications (p. ex. Google Firebase) agissant en tant '
        'que sous-traitants, ainsi qu\'avec les autorités publiques '
        'compétentes lorsque la loi l\'exige. Les serveurs de ces '
        'fournisseurs pouvant être situés à l\'étranger, ces transferts sont '
        'effectués conformément à l\'article 9 de la KVKK.',
    'Conservation : vos données sont conservées pendant la durée requise par '
        'les finalités du traitement et les délais légaux de prescription, '
        'puis supprimées, détruites ou anonymisées.',
    'Conformément à l\'article 11 de la KVKK, vous avez le droit de : savoir '
        'si vos données sont traitées, demander des informations, connaître '
        'la finalité du traitement et vérifier si elles sont utilisées '
        'conformément à celle-ci, connaître les tiers auxquels elles sont '
        'transférées, demander leur rectification, leur suppression ou leur '
        'destruction, vous opposer aux résultats issus d\'analyses '
        'automatisées et demander réparation des dommages. Les demandes sont '
        'traitées gratuitement dans un délai maximal de 30 jours, '
        'conformément à l\'article 13 de la KVKK.',
  ],
  'privacy': [
    'Vos données personnelles sont traitées uniquement dans le but de '
        'fournir les services de l\'école de sport. En dehors des '
        'fournisseurs d\'infrastructure cloud et de notifications utilisés '
        'pour faire fonctionner le service, elles ne sont pas partagées avec '
        'des tiers, sauf obligation légale.',
    'Les informations collectées se limitent aux informations de compte '
        'telles que le nom, l\'e-mail, le téléphone et la photo de profil, '
        'ainsi qu\'aux enregistrements de présence, de performance et de '
        'paiement de l\'élève. Ces informations sont conservées sur une '
        'infrastructure sécurisée et l\'accès est restreint selon les rôles '
        'autorisés.',
    'Vous pouvez modifier les informations de votre compte depuis l\'écran '
        'de profil ; pour en demander la suppression, vous pouvez contacter '
        'la direction de l\'école via les canaux de contact. Les demandes '
        'sont traitées dans un délai maximal de 30 jours.',
  ],
};

// ============================ ARABIC ========================================
const Map<String, List<String>> _ar = {
  'contact': [
    'يمكنك التواصل معنا لأي سؤال أو اقتراح أو طلب يتعلق بإدارة مدرسة الرياضة، '
        'بما في ذلك الطلبات المتعلقة ببياناتك الشخصية.',
    'البريد الإلكتروني: mefepalta@gmail.com',
    'الهاتف: (543) 484 78 30',
    'ساعات العمل: أيام الأسبوع 09:00 - 18:00',
  ],
  'terms': [
    'باستخدامك لهذا التطبيق، تُعتبر قد قبلت شروط الاستخدام التالية.',
    'يُقدَّم التطبيق لمتابعة عمليات الطلاب والمدربين وأولياء الأمور في مدرسة '
        'الرياضة. أنت مسؤول عن أمان حسابك وسرية بيانات دخولك؛ وعليك إبلاغ '
        'إدارة المدرسة دون تأخير عند أي استخدام غير مصرَّح به لحسابك.',
    'يُحظر محاولة الوصول إلى سجلات خارج صلاحيتك أو تعديلها أو حذفها. وفي حال '
        'المخالفة يجوز لإدارة المدرسة تعليق الحساب المعني أو إغلاقه.',
    'يُقدَّم التطبيق "كما هو". وباستثناء حالات العمد أو الإهمال الجسيم، لا '
        'تتحمل المدرسة مسؤولية الأضرار غير المباشرة التي قد تنشأ عن الانقطاعات '
        'أو الأخطاء أو فقدان البيانات. قد تُحدَّث هذه الشروط من وقت لآخر؛ '
        'والنسخة السارية هي المنشورة داخل التطبيق.',
  ],
  'kvkk': [
    'أُعدَّ نص الإفصاح هذا وفقاً للمادة 10 من قانون حماية البيانات الشخصية '
        'التركي رقم 6698 ("KVKK") من قبل [اسم مدرسة الرياضة وعنوانها] بصفتها '
        'المسؤول عن البيانات.',
    'البيانات المُعالَجة: بيانات الهوية (الاسم واللقب)، وبيانات الاتصال '
        '(البريد الإلكتروني والهاتف)، والبيانات المرئية (صورة الملف الشخصي)، '
        'إلى جانب سجلات حضور الطالب وأدائه ومدفوعاته. وإذا كان الطالب دون سن '
        '18، تُعالَج بياناته في إطار موافقة وليّ أمره أو الوصي القانوني عليه '
        'وتحت إشرافه.',
    'أغراض المعالجة: إدارة عمليات التسجيل والتدريب، والتواصل مع أولياء الأمور '
        'والمدربين، ومتابعة الحضور والمدفوعات، والوفاء بالالتزامات القانونية.',
    'الأسس القانونية: تستند المعالجة إلى المادة 5/2(c) من قانون KVKK (ضرورة '
        'إبرام العقد أو تنفيذه)، والمادة 5/2(ç) (الوفاء بالتزام قانوني)، '
        'والمادة 5/2(f) (المصلحة المشروعة للمسؤول عن البيانات)؛ وفي الحالات '
        'الخارجة عن هذه الأسس تُطلب موافقتك الصريحة.',
    'طريقة الجمع: تُجمَع بياناتك إلكترونياً وبوسائل آلية عبر تطبيق الهاتف '
        'المحمول.',
    'نقل البيانات: تُشارَك بياناتك، فقط بالقدر الذي تتطلبه الخدمة، مع مزودي '
        'البنية التحتية السحابية وبنية الإشعارات (مثل Google Firebase) '
        'بوصفهم معالجي بيانات، ومع الجهات الحكومية المختصة عند اقتضاء '
        'القانون. ونظراً لاحتمال وجود خوادم هؤلاء المزودين خارج البلاد، يُنفَّذ '
        'هذا النقل وفقاً للمادة 9 من قانون KVKK.',
    'مدة الاحتفاظ: يُحتفَظ ببياناتك طوال المدة التي تتطلبها أغراض المعالجة '
        'ومدد التقادم القانونية، ثم تُحذف أو تُتلف أو تُجعل مجهولة الهوية.',
    'وفقاً للمادة 11 من قانون KVKK، لديك الحق في: معرفة ما إذا كانت بياناتك '
        'تُعالَج، وطلب المعلومات، ومعرفة غرض المعالجة ومدى استخدامها وفقاً له، '
        'ومعرفة الأطراف الثالثة التي تُنقل إليها، وطلب تصحيحها أو حذفها أو '
        'إتلافها، والاعتراض على النتائج الناشئة عن التحليل الآلي، والمطالبة '
        'بالتعويض عن الأضرار. وتُنجَز الطلبات مجاناً خلال 30 يوماً على الأكثر '
        'وفقاً للمادة 13 من قانون KVKK.',
  ],
  'privacy': [
    'تُعالَج بياناتك الشخصية فقط لغرض تقديم خدمات مدرسة الرياضة. وباستثناء '
        'مزودي البنية التحتية السحابية وبنية الإشعارات المستخدمين لتشغيل '
        'الخدمة، لا تُشارَك مع أطراف ثالثة إلا عند اقتضاء القانون.',
    'تقتصر المعلومات المُجمَّعة على معلومات الحساب مثل الاسم والبريد '
        'الإلكتروني والهاتف وصورة الملف الشخصي، إلى جانب سجلات حضور الطالب '
        'وأدائه ومدفوعاته. تُخزَّن هذه المعلومات على بنية تحتية آمنة ويُقيَّد '
        'الوصول إليها على أساس الأدوار والصلاحيات.',
    'يمكنك تعديل معلومات حسابك من شاشة الملف الشخصي؛ ولطلب حذفها يمكنك '
        'التواصل مع إدارة المدرسة عبر قنوات الاتصال. وتُنجَز الطلبات خلال 30 '
        'يوماً على الأكثر.',
  ],
};
