import 'package:flutter/material.dart';

/// Sporlar bölümündeki tek bir bilgi başlığı (Açıklama, Faydaları vb.).
class SportSection {
  final String title;
  final List<String> items;

  const SportSection({required this.title, required this.items});
}

/// Tanıtım videosu + açıklamalarıyla bir spor dalı.
///
/// İçerik uygulama içinde sabittir ("fix sporlar"). [videoUrl] boş bırakılırsa
/// detay ekranı ilgili sporu YouTube'da arayan bir bağlantı açar; kendi
/// videonu eklemek için buraya URL yaz.
class Sport {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  /// Kısa tanıtım cümlesi (liste kartında görünür).
  final String tagline;

  /// Tanıtım videosunun bağlantısı. Boşsa YouTube araması açılır.
  final String videoUrl;

  final List<SportSection> sections;

  const Sport({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.tagline,
    this.videoUrl = '',
    required this.sections,
  });
}

/// Uygulamada gösterilen sabit spor kataloğu. Yeni spor eklemek ya da video
/// bağlantısı/açıklama güncellemek için bu listeyi düzenle.
const List<Sport> sportsCatalog = <Sport>[
  Sport(
    id: 'futbol',
    name: 'Futbol',
    icon: Icons.sports_soccer,
    color: Color(0xFF2E7D32),
    tagline: 'Takım oyunu, koordinasyon ve dayanıklılık',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Futbol, iki takımın topu rakip kaleye göndererek gol atmaya '
              'çalıştığı, ayak becerisine dayalı bir takım sporudur.',
          'Her takım kaleci dahil 11 oyuncudan oluşur ve maç iki yarıdan '
              'ibarettir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Kalp-damar sağlığını ve dayanıklılığı geliştirir.',
          'Takım çalışması, iletişim ve paylaşmayı öğretir.',
          'Denge, koordinasyon ve çeviklik kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Top elle oynanmaz (kaleci ceza sahası içinde hariç).',
          'Amaç, topu rakip kaleye sokarak gol atmaktır.',
          'Adil oyun ve rakibe saygı esastır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'basketbol',
    name: 'Basketbol',
    icon: Icons.sports_basketball,
    color: Color(0xFFE65100),
    tagline: 'Hız, sıçrama ve el-göz koordinasyonu',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Basketbol, topu rakip potaya atarak sayı kazanmaya çalışılan, '
              'beşer kişilik iki takımla oynanan bir spordur.',
          'Top elde sürülerek (dribbling) veya paslaşarak ilerletilir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Sıçrama gücünü ve reflekslerini geliştirir.',
          'El-göz koordinasyonunu artırır.',
          'Hızlı karar verme ve takım oyununu güçlendirir.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Top sürülürken çift el veya yürüme (hata) yapılmaz.',
          'Sayılar atış mesafesine göre 1, 2 veya 3 puandır.',
          'Savunma ve hücum dengesi önemlidir.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'voleybol',
    name: 'Voleybol',
    icon: Icons.sports_volleyball,
    color: Color(0xFF1565C0),
    tagline: 'Takım uyumu, zamanlama ve sıçrama',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Voleybol, file ile ayrılmış iki takımın topu yere düşürmeden '
              'rakip sahaya göndermeye çalıştığı bir spordur.',
          'Her takım en fazla üç dokunuşla topu karşıya geçirir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Refleks ve zamanlama becerisini geliştirir.',
          'Takım içi iletişimi ve uyumu güçlendirir.',
          'Üst vücut ve bacak kaslarını çalıştırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Topa aynı oyuncu üst üste iki kez dokunamaz.',
          'Manşet, pas ve smaç temel tekniklerdir.',
          'Sayılar rakip sahaya top düşürerek kazanılır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'yuzme',
    name: 'Yüzme',
    icon: Icons.pool,
    color: Color(0xFF0097A7),
    tagline: 'Tüm vücudu çalıştıran güvenli spor',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Yüzme, suda çeşitli tekniklerle (serbest, kurbağalama, sırtüstü, '
              'kelebek) ilerlemeye dayalı bireysel bir spordur.',
          'Hem yarışma hem de yaşam becerisi olarak önemlidir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Eklemleri yormadan tüm vücut kaslarını çalıştırır.',
          'Akciğer kapasitesini ve dayanıklılığı geliştirir.',
          'Su güvenliği ve özgüven kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Doğru nefes tekniği yüzmenin temelidir.',
          'Isınma ve gözetim güvenlik için şarttır.',
          'Farklı stiller farklı kas gruplarını çalıştırır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'tenis',
    name: 'Tenis',
    icon: Icons.sports_tennis,
    color: Color(0xFF7B1FA2),
    tagline: 'Odak, çeviklik ve el becerisi',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Tenis, raketle topu file üzerinden rakip sahaya göndermeye dayalı, '
              'tekli veya çiftli oynanan bir spordur.',
          'Amaç, topu rakibin karşılayamayacağı şekilde sahaya düşürmektir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Çeviklik, denge ve el-göz koordinasyonunu geliştirir.',
          'Odaklanma ve strateji kurma becerisini artırır.',
          'Tüm vücudu dengeli biçimde çalıştırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Top bir kez yere değdikten sonra vurulabilir.',
          'Servis, forehand ve backhand temel vuruşlardır.',
          'Sayı sistemi 15-30-40 şeklinde ilerler.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'jimnastik',
    name: 'Jimnastik',
    icon: Icons.sports_gymnastics,
    color: Color(0xFFC2185B),
    tagline: 'Esneklik, denge ve vücut kontrolü',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Jimnastik, esneklik, denge ve güç gerektiren hareketlerin ustalıkla '
              'sergilendiği bir spordur.',
          'Yer, denge aleti ve atlama gibi farklı branşları vardır.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Esneklik ve vücut kontrolünü üst düzeyde geliştirir.',
          'Denge, duruş ve kas gücünü artırır.',
          'Disiplin ve öz güven kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Isınma ve esneme sakatlığı önlemek için kritiktir.',
          'Hareketler kademeli olarak, gözetimle öğrenilir.',
          'Doğru teknik güvenliğin temelidir.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'karate',
    name: 'Karate',
    icon: Icons.sports_martial_arts,
    color: Color(0xFFD84315),
    tagline: 'Disiplin, denge ve öz savunma',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Karate, el ve ayak tekniklerine dayalı bir Uzakdoğu dövüş sanatıdır.',
          'Kata (hareket dizileri) ve kumite (eşli çalışma) olmak üzere iki '
              'ana bölümü vardır.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Disiplin, öz denetim ve saygıyı geliştirir.',
          'Denge, koordinasyon ve refleksleri güçlendirir.',
          'Öz güven ve öz savunma becerisi kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Kuşak sistemi ilerlemeyi gösterir.',
          'Isınma ve doğru teknik sakatlığı önler.',
          'Kontrollü ve saygılı çalışma esastır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'taekwondo',
    name: 'Taekwondo',
    icon: Icons.sports_martial_arts,
    color: Color(0xFF283593),
    tagline: 'Tekme teknikleri, esneklik ve disiplin',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Taekwondo, özellikle tekme tekniklerinin öne çıktığı Kore kökenli '
              'bir dövüş sanatıdır.',
          'Hem spor hem öz savunma olarak yaygındır ve olimpik bir branştır.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Bacak esnekliği ve gücünü artırır.',
          'Denge, çeviklik ve refleksleri geliştirir.',
          'Disiplin ve öz güven kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Kuşak sistemiyle seviye ilerler.',
          'Isınma ve esneme çok önemlidir.',
          'Kontrollü teknik ve saygı esastır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'judo',
    name: 'Judo',
    icon: Icons.sports_kabaddi,
    color: Color(0xFF4E342E),
    tagline: 'Denge, kavrama ve yere indirme',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Judo, rakibi dengeden düşürüp kontrol etmeye dayalı, Japon kökenli '
              'bir dövüş sanatıdır.',
          'Vuruş yerine tutuş, atma ve yer teknikleri kullanılır.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Denge, kavrama gücü ve vücut kontrolünü geliştirir.',
          'Düşme (ukemi) teknikleriyle güvenli düşmeyi öğretir.',
          'Disiplin, saygı ve öz güven kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Minderde çalışılır, güvenli düşüş temeldir.',
          'Kuşak sistemiyle ilerlenir.',
          'Rakibe saygı ve kontrol esastır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'atletizm',
    name: 'Atletizm',
    icon: Icons.directions_run,
    color: Color(0xFF00897B),
    tagline: 'Koşu, atlama ve atmanın temeli',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Atletizm; koşu, atlama ve atma branşlarını kapsayan, "sporların '
              'anası" olarak bilinen bir spordur.',
          'Kısa/uzun mesafe koşuları, uzun atlama ve gülle atma gibi çok '
              'sayıda dalı vardır.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Dayanıklılık, hız ve gücü dengeli geliştirir.',
          'Tüm temel hareket becerilerini güçlendirir.',
          'Bireysel hedef koyma ve disiplin kazandırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Isınma ve teknik koşu sakatlığı önler.',
          'Her dalın kendine özgü tekniği vardır.',
          'Gelişim ölçülebilir hedeflerle takip edilir.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'masa-tenisi',
    name: 'Masa Tenisi',
    icon: Icons.sports_tennis,
    color: Color(0xFFAD1457),
    tagline: 'Refleks, hız ve konsantrasyon',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Masa tenisi, masa üzerinde küçük bir topu raketle karşılıklı '
              'vurmaya dayalı hızlı bir spordur.',
          'Tekli veya çiftli oynanır; çok hızlı reaksiyon gerektirir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'El-göz koordinasyonunu ve refleksleri üst düzeyde geliştirir.',
          'Konsantrasyon ve hızlı karar vermeyi güçlendirir.',
          'Her yaşta oynanabilen, düşük sakatlık riskli bir spordur.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Servis ve vuruş teknikleri temeldir.',
          'Top masaya bir kez değmelidir.',
          'Hızlı ayak hareketi önemlidir.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'satranc',
    name: 'Satranç',
    icon: Icons.castle,
    color: Color(0xFF455A64),
    tagline: 'Strateji, dikkat ve planlama',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Satranç, iki oyuncunun 64 kareli tahtada taşlarla stratejik '
              'mücadele ettiği bir zeka sporudur.',
          'Amaç, rakibin şahını mat etmektir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Analitik düşünme ve planlama becerisini geliştirir.',
          'Dikkat, sabır ve konsantrasyonu artırır.',
          'Problem çözme ve öngörü yeteneğini güçlendirir.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Her taşın kendine özgü bir hareketi vardır.',
          'Oyun açılış, orta oyun ve son oyundan oluşur.',
          'Sabır ve önceden planlama kazandırır.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'hentbol',
    name: 'Hentbol',
    icon: Icons.sports_handball,
    color: Color(0xFFEF6C00),
    tagline: 'Hız, pas ve takım oyunu',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Hentbol, topu elle paslaşarak rakip kaleye gol atmaya dayalı, '
              'yedişer kişilik iki takımla oynanan bir spordur.',
          'Hızlı hücum ve savunma geçişleri içerir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Hız, sıçrama ve fırlatma gücünü geliştirir.',
          'Takım oyunu ve hızlı karar vermeyi güçlendirir.',
          'Tüm vücut koordinasyonunu artırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Top elle oynanır, kaleci alanına girilmez.',
          'Top elde en fazla üç adım taşınabilir.',
          'Pas ve pozisyon alma önemlidir.',
        ],
      ),
    ],
  ),
  Sport(
    id: 'badminton',
    name: 'Badminton',
    icon: Icons.sports_tennis,
    color: Color(0xFF558B2F),
    tagline: 'Çeviklik, refleks ve zamanlama',
    sections: [
      SportSection(
        title: 'Açıklama',
        items: [
          'Badminton, file üzerinden tüy topu raketle rakip sahaya göndermeye '
              'dayalı bir raket sporudur.',
          'Tekli veya çiftli oynanır; hızlı yön değiştirmeler içerir.',
        ],
      ),
      SportSection(
        title: 'Faydaları',
        items: [
          'Çeviklik, refleks ve dayanıklılığı geliştirir.',
          'El-göz koordinasyonunu artırır.',
          'Tüm vücudu dengeli çalıştırır.',
        ],
      ),
      SportSection(
        title: 'Temel Bilgiler',
        items: [
          'Tüy top yere düşmeden vurulur.',
          'Servis ve smaç temel tekniklerdir.',
          'Hızlı ayak hareketi belirleyicidir.',
        ],
      ),
    ],
  ),
];

/// Katalogdaki spor adları — branş seçimi (dropdown) için tek kaynak.
List<String> get sportNames =>
    sportsCatalog.map((sport) => sport.name).toList();
