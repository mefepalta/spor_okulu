import 'package:flutter/material.dart';

import '../widgets/wave_background.dart';

/// Başlık + paragraflardan oluşan basit, salt-okunur bilgi ekranı.
///
/// Bize Ulaşın, Kullanım Koşulları ve Gizlilik Politikası için ortak kullanılır.
/// İçerikler şimdilik örnek/doldurulabilir metinlerdir; gerçek metni sonra
/// [InfoPages] içinden güncelleyebilirsin.
class InfoTextScreen extends StatelessWidget {
  final String title;
  final List<String> paragraphs;

  const InfoTextScreen({
    super.key,
    required this.title,
    required this.paragraphs,
  });

  @override
  Widget build(BuildContext context) {
    return WaveScaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final paragraph in paragraphs) ...[
                    Text(
                      paragraph,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bilgi sayfalarının içerikleri. Gerçek metinler hazır olunca burayı güncelle.
class InfoPages {
  InfoPages._();

  static const String contactTitle = 'Bize Ulaşın';
  static const List<String> contact = <String>[
    'Spor okulu yönetimiyle ilgili her türlü soru, öneri ve talebiniz için '
        'bize ulaşabilirsiniz.',
    'E-posta: iletisim@sporokulu.com',
    'Telefon: (555) 000 00 00',
    'Çalışma saatleri: Hafta içi 09:00 - 18:00',
  ];

  static const String termsTitle = 'Kullanım Koşulları';
  static const List<String> terms = <String>[
    'Bu uygulamayı kullanarak aşağıdaki koşulları kabul etmiş sayılırsınız.',
    'Uygulama, spor okulu öğrenci, antrenör ve veli süreçlerinin takibi '
        'amacıyla sunulmaktadır. Hesabınızın güvenliğinden ve giriş '
        'bilgilerinizin gizliliğinden siz sorumlusunuz.',
    'Uygulama içindeki verilerin doğruluğu okul yönetimi tarafından sağlanır. '
        'Yetkiniz dışındaki kayıtlara erişmeye veya bunları değiştirmeye '
        'çalışmak yasaktır.',
    'Bu metin örnek içeriktir; nihai kullanım koşulları okul yönetimi '
        'tarafından güncellenecektir.',
  ];

  static const String kvkkTitle = 'KVKK Aydınlatma Metni';
  static const List<String> kvkk = <String>[
    '6698 sayılı Kişisel Verilerin Korunması Kanunu ("KVKK") kapsamında, spor '
        'okulu olarak veri sorumlusu sıfatıyla kişisel verilerinizi aşağıda '
        'açıklanan çerçevede işliyoruz.',
    'İşlenen veriler: ad-soyad, e-posta, telefon ve profil fotoğrafı ile '
        'öğrenciye ait yoklama, performans ve ödeme kayıtları. Bu veriler '
        'yalnızca eğitim ve idari süreçlerin yürütülmesi amacıyla işlenir.',
    'Kişisel verileriniz, hizmetin gerektirdiği ölçüde güvenli altyapıda '
        'saklanır; yasal zorunluluklar dışında üçüncü kişilerle paylaşılmaz.',
    'KVKK’nın 11. maddesi uyarınca; verilerinize erişme, düzeltilmesini veya '
        'silinmesini isteme ve işlenmesine itiraz etme haklarına sahipsiniz. '
        'Taleplerinizi okul yönetimine iletebilirsiniz.',
    'Bu metin örnek/taslak içeriktir; nihai KVKK aydınlatma metni okul '
        'yönetimi tarafından güncellenecektir.',
  ];

  static const String privacyTitle = 'Gizlilik Politikası';
  static const List<String> privacy = <String>[
    'Kişisel verileriniz yalnızca spor okulu hizmetlerinin sunulması amacıyla '
        'işlenir ve üçüncü taraflarla paylaşılmaz.',
    'Toplanan bilgiler; ad, e-posta, telefon ve profil fotoğrafı gibi hesap '
        'bilgileriyle sınırlıdır. Bu bilgiler güvenli altyapıda saklanır.',
    'Hesabınıza ait bilgileri profil ekranından düzenleyebilir; silinmesini '
        'talep etmek için okul yönetimiyle iletişime geçebilirsiniz.',
    'Bu metin örnek içeriktir; nihai gizlilik politikası okul yönetimi '
        'tarafından güncellenecektir.',
  ];
}
