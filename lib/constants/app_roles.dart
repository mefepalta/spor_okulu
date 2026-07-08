/// Uygulamadaki kullanıcı rolleri.
class AppRoles {
  static const String admin = 'admin';
  static const String coach = 'coach';
  static const String parent = 'veli';
  static const String student = 'ogrenci';
  static const String viewer = 'viewer';

  /// Firestore'da geçerli sayılan roller.
  static const List<String> all = [admin, coach, parent, student, viewer];

  static bool isValid(String role) => all.contains(role);
}

/// Duyuruların hedef kitlesi seçenekleri.
class AnnouncementAudience {
  static const String everyone = 'Herkes';
  static const String students = 'Öğrenciler';
  static const String coaches = 'Antrenörler';
  static const String parents = 'Veliler';

  static const List<String> all = [everyone, students, coaches, parents];

  /// Bir velinin görmesi gereken duyuru mu? (Herkes veya Veliler hedefli.)
  static bool isVisibleToParent(String audience) =>
      audience == everyone || audience == parents;

  /// Bir öğrencinin görmesi gereken duyuru mu? (Herkes veya Öğrenciler hedefli.)
  static bool isVisibleToStudent(String audience) =>
      audience == everyone || audience == students;
}

/// Antrenörlerin girdiği, velilerin karşılaştırma grafiğinde gördüğü
/// önceden tanımlı performans ölçütleri. Değerler 0-100 arası puandır.
class PerformanceMetrics {
  static const List<String> all = [
    'Sıçrama',
    'Sürat',
    'Dayanıklılık',
    'Esneklik',
    'Top Hakimiyeti',
  ];

  static const int minScore = 0;
  static const int maxScore = 100;
}
