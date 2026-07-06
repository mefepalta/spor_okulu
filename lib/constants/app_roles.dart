/// Uygulamadaki kullanıcı rolleri.
class AppRoles {
  static const String admin = 'admin';
  static const String coach = 'coach';
  static const String parent = 'veli';
  static const String viewer = 'viewer';

  /// Firestore'da geçerli sayılan roller.
  static const List<String> all = [admin, coach, parent, viewer];

  static bool isValid(String role) => all.contains(role);
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
