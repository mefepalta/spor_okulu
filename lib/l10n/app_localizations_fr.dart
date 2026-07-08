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
}
