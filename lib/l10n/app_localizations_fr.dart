// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonOk => 'OK';

  @override
  String get commonResend => 'Renvoyer';

  @override
  String get roleAdmin => 'Administrateur';

  @override
  String get roleCoach => 'Entraîneur';

  @override
  String get roleParent => 'Parent';

  @override
  String get roleStudent => 'Élève';

  @override
  String get roleViewer => 'Observateur';

  @override
  String get roleUnknown => 'Inconnu';

  @override
  String get loginHeading => 'Gestion d\'école de sport';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'example@sporokulu.com';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginLoading => 'Connexion en cours...';

  @override
  String get forgotPassword => 'Mot de passe oublié';

  @override
  String get noAccountRegister => 'Pas de compte ? Inscrivez-vous';

  @override
  String get emailEmpty => 'L\'e-mail ne peut pas être vide.';

  @override
  String get emailInvalid => 'Saisissez un e-mail valide.';

  @override
  String get passwordEmpty => 'Le mot de passe ne peut pas être vide.';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit comporter au moins 6 caractères.';

  @override
  String get emailNotVerifiedTitle => 'E-mail non vérifié';

  @override
  String get emailNotVerifiedBody =>
      'Pour activer votre compte, appuyez sur le lien de vérification envoyé à votre e-mail. S\'il n\'est pas arrivé, nous pouvons le renvoyer.';

  @override
  String get verificationResent =>
      'E-mail de vérification renvoyé. Vérifiez aussi votre dossier spam.';

  @override
  String get rejectedTitle => 'Votre demande a été refusée';

  @override
  String get rejectedBody =>
      'Votre demande de rôle a été refusée par un administrateur. Votre compte est en cours de fermeture.';

  @override
  String get resetPasswordNeedEmail =>
      'Saisissez d\'abord votre adresse e-mail pour réinitialiser votre mot de passe.';

  @override
  String get resetPasswordSent =>
      'Un lien de réinitialisation du mot de passe a été envoyé à votre adresse e-mail.';

  @override
  String get resetPasswordError =>
      'Une erreur s\'est produite lors de la réinitialisation du mot de passe.';

  @override
  String get resetInvalidEmail => 'Saisissez une adresse e-mail valide.';

  @override
  String get resetUserNotFound =>
      'Aucun utilisateur n\'est enregistré avec cette adresse e-mail.';

  @override
  String get userNotFound => 'Utilisateur introuvable.';

  @override
  String loginCheckError(Object error) {
    return 'Une erreur s\'est produite lors de la vérification de la connexion : $error';
  }

  @override
  String get authInvalidEmail => 'L\'adresse e-mail n\'est pas valide.';

  @override
  String get authUserDisabled => 'Ce compte utilisateur est désactivé.';

  @override
  String get authWrongCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get authNetwork =>
      'Impossible de se connecter à Internet. Vérifiez votre connexion et réessayez.';

  @override
  String get authOperationNotAllowed =>
      'La connexion par e-mail/mot de passe n\'est pas activée dans la console Firebase.';

  @override
  String get authConfigNotFound =>
      'Configuration Firebase Authentication introuvable. Vérifiez les paramètres de la console Firebase.';

  @override
  String get authAppNotAuthorized =>
      'Cette application Android ne semble pas autorisée pour le projet Firebase.';

  @override
  String get authInvalidApiKey => 'La clé d\'API Firebase semble non valide.';

  @override
  String get authTooManyRequests =>
      'Trop de tentatives de connexion. Réessayez plus tard.';

  @override
  String authGenericWithCode(String code) {
    return 'Échec de la connexion. Code d\'erreur : $code';
  }

  @override
  String get registerTitle => 'S\'inscrire';

  @override
  String get registerHeading => 'Créer un nouveau compte';

  @override
  String get firstNameLabel => 'Prénom';

  @override
  String get lastNameLabel => 'Nom';

  @override
  String get passwordAgainLabel => 'Confirmer le mot de passe';

  @override
  String get passwordAgainEmpty =>
      'La confirmation du mot de passe ne peut pas être vide.';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get accountType => 'Votre type de compte';

  @override
  String get selectionSentToAdmin =>
      'Votre sélection sera envoyée pour approbation à l\'administrateur.';

  @override
  String get registerButton => 'S\'inscrire';

  @override
  String get registerLoading => 'Enregistrement...';

  @override
  String requiredField(String label) {
    return '$label ne peut pas être vide.';
  }

  @override
  String get registerSuccess =>
      'Compte créé. Appuyez sur le lien de vérification envoyé à votre e-mail. Votre demande de rôle a été envoyée pour approbation à l\'administrateur.';

  @override
  String get registerGenericError =>
      'Une erreur s\'est produite lors de l\'inscription.';

  @override
  String get emailAlreadyInUse => 'Cette adresse e-mail est déjà utilisée.';

  @override
  String get passwordTooWeak =>
      'Le mot de passe est trop faible. Utilisez au moins 6 caractères.';

  @override
  String registerErrorWith(Object error) {
    return 'Erreur d\'inscription : $error';
  }

  @override
  String get userNotCreated => 'Impossible de créer l\'utilisateur.';

  @override
  String get roleRequestsTitle => 'Demandes de rôle';

  @override
  String get noPendingRequests => 'Aucune demande en attente';

  @override
  String get noPendingRequestsBody =>
      'Les demandes de rôle des nouvelles inscriptions apparaissent ici.';

  @override
  String get approveTitle => 'Approuver la demande';

  @override
  String approveConfirm(String name, String role) {
    return '$name sera promu(e) au rôle $role. Approuvez-vous ?';
  }

  @override
  String get approveAction => 'Approuver';

  @override
  String approvedSnack(String name, String role) {
    return '$name est maintenant $role.';
  }

  @override
  String get rejectTitle => 'Refuser la demande';

  @override
  String rejectConfirm(String name) {
    return 'La demande de $name sera refusée et le compte supprimé. Cette action est irréversible. Continuer ?';
  }

  @override
  String get rejectAction => 'Refuser';

  @override
  String rejectedSnack(String name) {
    return 'La demande de $name a été refusée.';
  }

  @override
  String requestLabel(String role) {
    return 'Demande : $role';
  }

  @override
  String get genericOperationError =>
      'Une erreur s\'est produite lors de l\'opération.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileUserFallback => 'Utilisateur';

  @override
  String get roleDescAdmin =>
      'Peut ajouter, modifier et supprimer tous les enregistrements.';

  @override
  String get roleDescCoach =>
      'Peut gérer les enregistrements de présence et les annonces. Peut consulter les autres enregistrements.';

  @override
  String get roleDescParent =>
      'Peut suivre les performances de son enfant et répondre à la participation aux événements.';

  @override
  String get roleDescStudent =>
      'Peut consulter ses propres informations de présence et de performance.';

  @override
  String get roleDescViewer =>
      'Peut consulter les enregistrements, mais ne peut pas les modifier.';

  @override
  String get childrenSectionStudent => 'Mes infos d\'élève';

  @override
  String get childrenSectionParent => 'Mes élèves';

  @override
  String get authorityTitle => 'Autorisations';

  @override
  String get appearanceTitle => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get backgroundEffectTitle => 'Effet d\'arrière-plan';

  @override
  String get backgroundEffectDesc =>
      'Élevé : vagues + particules · Moyen : vagues uniquement · Faible : arrière-plan uni.';

  @override
  String get backgroundHigh => 'Élevé';

  @override
  String get backgroundMedium => 'Moyen';

  @override
  String get backgroundLow => 'Faible';

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get editAccount => 'Modifier le compte';

  @override
  String get contactUs => 'Contactez-nous';

  @override
  String get whatsappSupport => 'Assistance WhatsApp';

  @override
  String get kvkkTitle => 'Avis de protection des données personnelles';

  @override
  String get termsTitle => 'Conditions d\'utilisation';

  @override
  String get privacyTitle => 'Politique de confidentialité';

  @override
  String get appVersionLabel => 'Version de l\'application';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get commonAll => 'Tout';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get viewAction => 'Voir';

  @override
  String get statusPaid => 'Payé';

  @override
  String get statusPending => 'En attente';

  @override
  String get statusOverdue => 'En retard';

  @override
  String get leaveStatusPending => 'En attente';

  @override
  String get leaveStatusApproved => 'Approuvé';

  @override
  String get leaveStatusRejected => 'Refusé';

  @override
  String get drawerMainPanel => 'Panneau principal';

  @override
  String get sectionRecords => 'Enregistrements';

  @override
  String get sectionOperations => 'Opérations';

  @override
  String get sectionClub => 'Club';

  @override
  String get sectionGeneral => 'Général';

  @override
  String get sectionMyChild => 'Mon enfant';

  @override
  String get sectionMe => 'Moi';

  @override
  String get navStudents => 'Élèves';

  @override
  String get navCoaches => 'Entraîneurs';

  @override
  String get navGroups => 'Groupes';

  @override
  String get navParents => 'Parents';

  @override
  String get navStudentAccounts => 'Comptes élèves';

  @override
  String get navAttendance => 'Présence';

  @override
  String get navLeaveRequests => 'Demandes d\'absence';

  @override
  String get navPayments => 'Paiements';

  @override
  String get navPerformance => 'Performance';

  @override
  String get navEvents => 'Événements';

  @override
  String get navEquipment => 'Inventaire';

  @override
  String get navAnnouncements => 'Annonces';

  @override
  String get navClubCash => 'Caisse du club';

  @override
  String get navReports => 'Rapports';

  @override
  String get navSports => 'Sports';

  @override
  String get navUsers => 'Utilisateurs';

  @override
  String get navReportAbsence => 'Signaler une absence';

  @override
  String get navMyPerformance => 'Ma performance';

  @override
  String get navMyAttendance => 'Ma présence';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get notifCategoryAnnouncement => 'Annonce';

  @override
  String get notifCategoryPayment => 'Paiement';

  @override
  String get notifCategoryLeave => 'Absence';

  @override
  String get notifCategoryAbsence => 'Absence';

  @override
  String get leaveWaitingApproval => 'En attente d\'approbation';

  @override
  String notifLeaveTitle(String name) {
    return '$name • absence';
  }

  @override
  String notifAbsenceTitle(String name) {
    return '$name était absent(e)';
  }

  @override
  String errorLoadingData(Object error) {
    return 'Une erreur s\'est produite lors du chargement des données : $error';
  }

  @override
  String get reminderDialogTitle => 'Nouveau rappel';

  @override
  String get reminderDialogHint => 'Ex. : Commander le matériel mardi';

  @override
  String get newAnnouncementPublished => 'Une nouvelle annonce a été publiée.';

  @override
  String newAnnouncementsPublished(int count) {
    return '$count nouvelles annonces ont été publiées.';
  }

  @override
  String get remindersTitle => 'Rappels rapides';

  @override
  String get remindersEmpty => 'Vous n\'avez pas encore ajouté de rappel.';

  @override
  String get aiIntroParent =>
      'Je connais le résumé actuel de votre enfant. Vous pouvez choisir l\'une des options ci-dessous ou écrire votre propre question.';

  @override
  String get aiIntroStudent =>
      'Je connais ta situation actuelle. Tu peux choisir l\'une des options ci-dessous ou écrire ta propre question.';

  @override
  String get aiIntroStaff =>
      'Je connais le résumé actuel de votre club. Vous pouvez choisir l\'une des options ci-dessous ou écrire votre propre question.';

  @override
  String get viewerWelcomeSubtitle => 'Bienvenue à l\'école de sport.';

  @override
  String get requestPendingTitle => 'Votre demande est en cours d\'examen';

  @override
  String requestPendingMessage(String role) {
    return 'Votre demande pour devenir $role est en attente d\'approbation par l\'administrateur. Une fois approuvée, vous pourrez accéder au panneau correspondant.';
  }

  @override
  String get requestApprovedTitle => 'Votre demande a été approuvée';

  @override
  String get requestApprovedMessage =>
      'Il vous suffit de vous déconnecter et de vous reconnecter pour voir votre nouveau rôle.';

  @override
  String get roleNotAssignedTitle => 'Votre rôle n\'a pas encore été attribué';

  @override
  String get roleNotAssignedMessage =>
      'Lorsqu\'un administrateur vous attribuera un rôle, vous accéderez au panneau correspondant.';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String get studentGreetingSubtitle => 'Ta situation actuelle est ci-dessous.';

  @override
  String parentGreetingSubtitleOne(String name) {
    return '$name • résumé actuel';
  }

  @override
  String get parentGreetingSubtitleMany =>
      'Le résumé actuel de vos enfants est ci-dessous.';

  @override
  String get staffGreetingSubtitle =>
      'Le résumé actuel de votre club est ci-dessous.';

  @override
  String highlightOverdueDues(String amount) {
    return 'Cotisations en retard : $amount';
  }

  @override
  String get highlightGreatAttendance =>
      'Ta présence est excellente, continue ! 🎯';

  @override
  String get highlightWatchAttendance => 'Surveillons un peu la présence';

  @override
  String get highlightPlannedEvent =>
      'Un événement est prévu, ne le manque pas';

  @override
  String get highlightAllGood => 'Tout semble aller bien 👍';

  @override
  String highlightPaymentsPending(int count) {
    return '$count paiements en attente de suivi';
  }

  @override
  String highlightLeavePending(int count) {
    return '$count demandes d\'absence en attente d\'approbation';
  }

  @override
  String get highlightNoPending =>
      'Vous n\'avez aucune tâche en attente, super 👍';

  @override
  String get statPerformance => 'Performance';

  @override
  String get statEvent => 'Événement';

  @override
  String get statAnnouncement => 'Annonce';

  @override
  String get statMyChild => 'Mon enfant';

  @override
  String get statStudent => 'Élève';

  @override
  String get statCoach => 'Entraîneur';

  @override
  String get statGroup => 'Groupe';

  @override
  String noteNew(int count) {
    return '$count nouveaux';
  }

  @override
  String noteWaiting(int count) {
    return '$count en attente';
  }

  @override
  String get attendanceSummaryTitle => 'Résumé de présence';

  @override
  String get attendanceEmpty =>
      'Aucun enregistrement de présence pour le moment.';

  @override
  String get metricLessons => 'Cours';

  @override
  String get metricRecords => 'Enregistrements';

  @override
  String get metricPresent => 'Présent';

  @override
  String get metricAbsent => 'Absent';

  @override
  String get metricAttendanceRate => 'Présence';

  @override
  String get absenceNoteOne => '1 nouvel enregistrement d\'absence';

  @override
  String absenceNoteMany(int count) {
    return '$count nouveaux enregistrements d\'absence';
  }

  @override
  String get financeSummaryTitle => 'Résumé financier';

  @override
  String get financeEmpty => 'Aucun enregistrement de paiement pour le moment.';

  @override
  String get metricCollected => 'Encaissé';

  @override
  String get metricPending => 'En attente';

  @override
  String get metricOverdue => 'En retard';

  @override
  String get clubCashTitle => 'Caisse du club';

  @override
  String get ledgerAction => 'Registre';

  @override
  String get clubCashEmpty => 'Aucun mouvement de caisse pour le moment.';

  @override
  String get metricBalance => 'Caisse';

  @override
  String get metricIncome => 'Revenus';

  @override
  String get metricExpense => 'Dépenses';

  @override
  String unpaidDuesTitle(int count) {
    return 'Cotisations impayées ($count)';
  }

  @override
  String moreStudents(int count) {
    return '+$count élèves de plus';
  }

  @override
  String get latestAnnouncementTitle => 'Dernière annonce';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get searchNoResults => 'Aucun résultat trouvé';

  @override
  String get searchNoResultsBody =>
      'Essayez de modifier le texte de recherche.';

  @override
  String get fieldFullName => 'Nom complet';

  @override
  String get fieldAge => 'Âge';

  @override
  String get fieldBranch => 'Discipline';

  @override
  String get fieldParentPhone => 'Téléphone du parent';

  @override
  String get studentsSearchHint => 'Rechercher des élèves';

  @override
  String get studentsEmptyTitle => 'Aucun élève pour le moment';

  @override
  String get studentsEmptyAdmin =>
      'Utilisez le bouton + en bas à droite pour ajouter un nouvel élève.';

  @override
  String get studentsEmptyViewer =>
      'Aucun enregistrement d\'élève pour le moment. Ils apparaîtront ici lorsqu\'un administrateur en ajoutera un.';

  @override
  String studentSubtitle(String branch, int age, String phone) {
    return '$branch • $age ans\nParent : $phone';
  }

  @override
  String get studentDeleteTitle => 'Supprimer l\'élève';

  @override
  String studentDeleteConfirm(String name) {
    return 'Voulez-vous vraiment supprimer $name';
  }

  @override
  String get studentDeleted => 'Élève supprimé.';

  @override
  String get studentDetailTitle => 'Détails de l\'élève';

  @override
  String get editStudent => 'Modifier l\'élève';

  @override
  String get backToStudentList => 'Retour à la liste des élèves';

  @override
  String get addStudent => 'Ajouter un nouvel élève';

  @override
  String get saveStudent => 'Enregistrer l\'élève';

  @override
  String get fullNameEmpty => 'Le nom complet ne peut pas être vide.';

  @override
  String get fullNameMinLength =>
      'Le nom complet doit comporter au moins 3 caractères.';

  @override
  String get ageEmpty => 'L\'âge ne peut pas être vide.';

  @override
  String get ageMustBeNumber => 'L\'âge doit être un nombre.';

  @override
  String get agePositive => 'L\'âge doit être supérieur à 0.';

  @override
  String get ageTooHigh => 'L\'âge semble trop élevé.';

  @override
  String get fieldPhone => 'Téléphone';

  @override
  String get branchEmpty => 'La discipline ne peut pas être vide.';

  @override
  String get coachesSearchHint => 'Rechercher des entraîneurs';

  @override
  String get coachesEmptyTitle => 'Aucun entraîneur pour le moment';

  @override
  String get coachesEmptyAdmin =>
      'Utilisez le bouton + en bas à droite pour ajouter un nouvel entraîneur.';

  @override
  String get coachesEmptyViewer =>
      'Aucun enregistrement d\'entraîneur pour le moment. Ils apparaîtront ici lorsqu\'un administrateur en ajoutera un.';

  @override
  String coachSubtitle(String branch, String phone) {
    return '$branch • $phone';
  }

  @override
  String get coachDeleteTitle => 'Supprimer l\'entraîneur';

  @override
  String coachDeleteConfirm(String name) {
    return 'Voulez-vous vraiment supprimer $name';
  }

  @override
  String get coachDeleted => 'Entraîneur supprimé.';

  @override
  String get coachDetailTitle => 'Détails de l\'entraîneur';

  @override
  String get editCoach => 'Modifier l\'entraîneur';

  @override
  String get backToCoachList => 'Retour à la liste des entraîneurs';

  @override
  String get addCoach => 'Ajouter un nouvel entraîneur';

  @override
  String get saveCoach => 'Enregistrer l\'entraîneur';

  @override
  String get phoneEmpty => 'Le numéro de téléphone ne peut pas être vide.';

  @override
  String get phoneFormat => 'Le téléphone doit être au format 05XXXXXXXXX.';

  @override
  String get timeEmpty => 'L\'heure ne peut pas être vide.';

  @override
  String get timeFormat => 'L\'heure doit être au format 18:00.';

  @override
  String get dateEmpty => 'La date ne peut pas être vide.';

  @override
  String get dateFormat => 'La date doit être au format 24.06.2026.';

  @override
  String get branchRequired => 'Une discipline doit être sélectionnée.';

  @override
  String get dayMonday => 'Lundi';

  @override
  String get dayTuesday => 'Mardi';

  @override
  String get dayWednesday => 'Mercredi';

  @override
  String get dayThursday => 'Jeudi';

  @override
  String get dayFriday => 'Vendredi';

  @override
  String get daySaturday => 'Samedi';

  @override
  String get daySunday => 'Dimanche';

  @override
  String get groupsSearchHint => 'Rechercher des groupes';

  @override
  String get groupsEmptyTitle => 'Aucun groupe pour le moment';

  @override
  String get groupsEmptyAdd =>
      'Utilisez le bouton + en bas à droite pour ajouter un nouveau groupe.';

  @override
  String get groupsEmptyNoCoach =>
      'Ajoutez d\'abord au moins un entraîneur pour créer un groupe.';

  @override
  String get groupsEmptyViewer =>
      'Aucun enregistrement de groupe pour le moment. Ils apparaîtront ici lorsqu\'un administrateur en ajoutera un.';

  @override
  String groupSubtitle(
    String branch,
    String schedule,
    String coach,
    int count,
    int capacity,
  ) {
    return '$branch • $schedule\nEntraîneur : $coach • $count/$capacity élèves';
  }

  @override
  String get groupDeleteTitle => 'Supprimer le groupe';

  @override
  String groupDeleteConfirm(String name) {
    return 'Voulez-vous vraiment supprimer le groupe $name';
  }

  @override
  String get groupDeleted => 'Groupe supprimé.';

  @override
  String get groupDetailTitle => 'Détails du groupe';

  @override
  String get unknownStudent => 'Élève inconnu';

  @override
  String get fieldGroupName => 'Nom du groupe';

  @override
  String get fieldSchedule => 'Horaire';

  @override
  String get fieldCapacity => 'Capacité';

  @override
  String get fieldDay => 'Jour';

  @override
  String get fieldTime => 'Heure';

  @override
  String capacityPeople(int count, int capacity) {
    return '$count/$capacity personnes';
  }

  @override
  String membersTitle(int count) {
    return 'Membres ($count)';
  }

  @override
  String get noMembersAssigned => 'Aucun élève assigné pour le moment.';

  @override
  String get editGroup => 'Modifier le groupe';

  @override
  String get backToGroupList => 'Retour à la liste des groupes';

  @override
  String get addGroup => 'Ajouter un nouveau groupe';

  @override
  String get saveGroup => 'Enregistrer le groupe';

  @override
  String get groupsNeedCoach =>
      'Vous devez d\'abord ajouter au moins un entraîneur pour créer un groupe.';

  @override
  String get groupNameEmpty => 'Le nom du groupe ne peut pas être vide.';

  @override
  String get groupNameMinLength =>
      'Le nom du groupe doit comporter au moins 2 caractères.';

  @override
  String get coachRequired => 'Vous devez sélectionner un entraîneur.';

  @override
  String get dayRequired => 'Vous devez sélectionner un jour.';

  @override
  String get capacityEmpty => 'La capacité ne peut pas être vide.';

  @override
  String get capacityMustBeNumber => 'La capacité doit être un nombre.';

  @override
  String get capacityPositive => 'La capacité doit être supérieure à 0.';

  @override
  String get capacityMax => 'La capacité ne doit pas dépasser 100.';

  @override
  String get membersLabel => 'Membres';

  @override
  String get noStudentSelected => 'Aucun élève sélectionné';

  @override
  String studentsSelected(int count) {
    return '$count élèves sélectionnés';
  }

  @override
  String get membersNeedStudents =>
      'Des enregistrements d\'élèves sont d\'abord nécessaires pour ajouter des membres.';

  @override
  String get selectCoachFirst =>
      'Vous devez d\'abord sélectionner un entraîneur.';

  @override
  String studentsExceedCapacity(int count, int capacity) {
    return 'Le nombre d\'élèves sélectionnés ($count) dépasse la capacité ($capacity).';
  }

  @override
  String get selectMembersTitle => 'Sélectionner des membres';

  @override
  String selectedCount(int count) {
    return '$count sélectionnés';
  }

  @override
  String selectedCountOf(int count, int capacity) {
    return '$count/$capacity sélectionnés';
  }

  @override
  String get capacityExceeded => 'Capacité dépassée';

  @override
  String get noStudentsTitle => 'Aucun élève';

  @override
  String get noStudentsBody => 'Des élèves doivent d\'abord être ajoutés.';

  @override
  String studentBranchAge(String branch, int age) {
    return '$branch • $age ans';
  }

  @override
  String get usersSearchHint => 'Rechercher un e-mail';

  @override
  String get usersEmptyTitle => 'Aucun utilisateur';

  @override
  String get usersEmptyBody => 'Aucun utilisateur enregistré pour le moment.';

  @override
  String get noEmail => '(pas d\'e-mail)';

  @override
  String get youLabel => '(vous)';

  @override
  String get cannotChangeOwnRole =>
      'Vous ne pouvez pas changer votre propre rôle ici.';

  @override
  String get roleUpdateError =>
      'Une erreur s\'est produite lors de la mise à jour du rôle.';

  @override
  String userRoleUpdated(String email, String role) {
    return '$email → mis à jour en $role.';
  }

  @override
  String get changeRoleTitle => 'Changer de rôle';

  @override
  String get parentAssignHint =>
      'L\'attribution des élèves se fait depuis l\'écran « Parents ».';

  @override
  String get studentAssignHint =>
      'L\'association des élèves se fait depuis l\'écran « Comptes élèves ».';
}
