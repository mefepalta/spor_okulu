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

/// Bilgi sayfalarının içerikleri (Türkçe / varsayılan). Hukuk danışmanı
/// gözden geçirmesinden geçmiş metinler.
///
/// Veri sorumlusu: MefeSpor Okulu İZMİR/Torbalı (KVKK aydınlatma metninde geçer).
/// Değişirse burada ve data/info_pages_l10n.dart'taki 5 dilde güncellenmeli.
class InfoPages {
  InfoPages._();

  static const List<String> contact = <String>[
    'Spor okulu yönetimiyle ilgili her türlü soru, öneri ve talebiniz için '
        '— kişisel verilerinize ilişkin başvurular dahil — bize '
        'ulaşabilirsiniz.',
    'E-posta: mefepalta@gmail.com',
    'Telefon: (543) 484 78 30',
    'Çalışma saatleri: Hafta içi 09:00 - 18:00',
  ];

  static const List<String> terms = <String>[
    'Bu uygulamayı kullanarak aşağıdaki kullanım koşullarını kabul etmiş '
        'sayılırsınız.',
    'Uygulama, spor okulunun öğrenci, antrenör ve veli süreçlerinin takibi '
        'için sunulmaktadır. Hesabınızın güvenliğinden ve giriş '
        'bilgilerinizin gizliliğinden siz sorumlusunuz; hesabınızın yetkisiz '
        'kullanımını fark etmeniz hâlinde durumu gecikmeksizin okul '
        'yönetimine bildirmelisiniz.',
    'Yetkiniz dışındaki kayıtlara erişmeye, bunları değiştirmeye veya '
        'silmeye çalışmak yasaktır. İhlal hâlinde okul yönetimi ilgili '
        'hesabı askıya alabilir veya kapatabilir.',
    'Uygulama "olduğu gibi" sunulmaktadır. Kast veya ağır kusur hâlleri '
        'hariç olmak üzere; kesinti, hata veya veri kayıplarından '
        'doğabilecek dolaylı zararlardan okul sorumluluk kabul etmez. Bu '
        'koşullar zaman zaman güncellenebilir; geçerli sürüm uygulama '
        'içinde yayımlanan metindir.',
  ];

  static const List<String> kvkk = <String>[
    'İşbu aydınlatma metni, 6698 sayılı Kişisel Verilerin Korunması Kanunu '
        '("KVKK") m.10 uyarınca, veri sorumlusu sıfatıyla MefeSpor Okulu '
        'İZMİR/Torbalı tarafından hazırlanmıştır.',
    'İşlenen veriler: kimlik verisi (ad-soyad), iletişim verisi (e-posta, '
        'telefon), görsel veri (profil fotoğrafı) ile öğrencinin devam, '
        'performans ve ödeme kayıtlarıdır. Öğrencinin 18 yaşından küçük '
        'olması hâlinde verileri, velisinin veya yasal temsilcisinin onayı '
        've gözetimi çerçevesinde işlenir.',
    'İşleme amaçları: kayıt ve eğitim süreçlerinin yürütülmesi, veli ve '
        'antrenörlerle iletişim, devam ve ödeme takibi ile yasal '
        'yükümlülüklerin yerine getirilmesidir.',
    'Hukuki sebepler: verileriniz KVKK m.5/2-c (sözleşmenin kurulması veya '
        'ifası için gerekli olması), m.5/2-ç (hukuki yükümlülüğün yerine '
        'getirilmesi) ve m.5/2-f (veri sorumlusunun meşru menfaati) '
        'kapsamında işlenir; bu kapsam dışında kalan hâllerde açık rızanız '
        'alınır.',
    'Toplama yöntemi: verileriniz mobil uygulama üzerinden elektronik '
        'ortamda, otomatik yollarla toplanır.',
    'Aktarım: verileriniz yalnızca hizmetin gerektirdiği ölçüde, veri '
        'işleyen sıfatıyla bulut ve bildirim altyapısı sağlayıcılarına '
        '(ör. Google Firebase) ve kanunen zorunlu hâllerde yetkili kamu '
        'kurumlarına aktarılır. Bu sağlayıcıların sunucularının yurt '
        'dışında bulunabilmesi nedeniyle söz konusu aktarım KVKK m.9\'a '
        'uygun olarak gerçekleştirilir.',
    'Saklama: verileriniz, işleme amaçlarının gerektirdiği süre ve '
        'mevzuattaki zamanaşımı süreleri boyunca saklanır; sonrasında '
        'silinir, yok edilir veya anonim hâle getirilir.',
    'KVKK m.11 uyarınca; verilerinizin işlenip işlenmediğini öğrenme, '
        'bilgi talep etme, işleme amacını ve amacına uygun kullanılıp '
        'kullanılmadığını öğrenme, aktarıldığı üçüncü kişileri bilme, '
        'düzeltilmesini, silinmesini veya yok edilmesini isteme, otomatik '
        'analiz sonucu aleyhinize çıkan sonuçlara itiraz etme ve zararın '
        'giderilmesini talep etme haklarına sahipsiniz. Başvurular KVKK '
        'm.13 uyarınca en geç 30 gün içinde ücretsiz olarak sonuçlandırılır.',
  ];

  static const List<String> privacy = <String>[
    'Kişisel verileriniz yalnızca spor okulu hizmetlerinin sunulması '
        'amacıyla işlenir. Hizmetin işletilmesinde kullanılan bulut ve '
        'bildirim altyapısı sağlayıcıları dışında, yasal zorunluluklar '
        'hariç, üçüncü kişilerle paylaşılmaz.',
    'Toplanan bilgiler; ad, e-posta, telefon ve profil fotoğrafı gibi '
        'hesap bilgileri ile öğrencinin devam, performans ve ödeme '
        'kayıtlarıyla sınırlıdır. Bu bilgiler güvenli altyapıda saklanır ve '
        'erişim, rol bazlı yetkilendirme esasına göre kısıtlanır.',
    'Hesap bilgilerinizi profil ekranından düzenleyebilirsiniz; '
        'silinmesini talep etmek için iletişim kanalları üzerinden okul '
        'yönetimine başvurabilirsiniz. Talepler en geç 30 gün içinde '
        'sonuçlandırılır.',
  ];
}
