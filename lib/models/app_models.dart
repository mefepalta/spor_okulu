class Student {
  final String id;
  final String name;
  final int age;
  final String branch;
  final String parentPhone;

  const Student({
    this.id = '',
    required this.name,
    required this.age,
    required this.branch,
    required this.parentPhone,
  });

  Student copyWith({
    String? id,
    String? name,
    int? age,
    String? branch,
    String? parentPhone,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      branch: branch ?? this.branch,
      parentPhone: parentPhone ?? this.parentPhone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'branch': branch,
      'parentPhone': parentPhone,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'],
      age: (json['age'] as num).toInt(),
      branch: json['branch'],
      parentPhone: json['parentPhone'],
    );
  }
}

class Coach {
  final String id;
  final String name;
  final String branch;
  final String phone;

  const Coach({
    this.id = '',
    required this.name,
    required this.branch,
    required this.phone,
  });

  Coach copyWith({String? id, String? name, String? branch, String? phone}) {
    return Coach(
      id: id ?? this.id,
      name: name ?? this.name,
      branch: branch ?? this.branch,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'branch': branch, 'phone': phone};
  }

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'] ?? '',
      name: json['name'],
      branch: json['branch'],
      phone: json['phone'],
    );
  }
}

class TrainingGroup {
  final String id;
  final String name;
  final String branch;

  /// Antrenör referansı: [coachId] kalıcı bağ, [coachName] görüntü içindir.
  /// Eski kayıtlarda [coachId] boş olabilir; o durumda ada göre çalışılır.
  final String coachId;
  final String coachName;
  final String schedule;
  final int capacity;

  /// Gruba atanmış öğrenci kimlikleri (kadro).
  final List<String> studentIds;

  const TrainingGroup({
    this.id = '',
    required this.name,
    required this.branch,
    this.coachId = '',
    required this.coachName,
    required this.schedule,
    required this.capacity,
    this.studentIds = const [],
  });

  TrainingGroup copyWith({
    String? id,
    String? name,
    String? branch,
    String? coachId,
    String? coachName,
    String? schedule,
    int? capacity,
    List<String>? studentIds,
  }) {
    return TrainingGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      branch: branch ?? this.branch,
      coachId: coachId ?? this.coachId,
      coachName: coachName ?? this.coachName,
      schedule: schedule ?? this.schedule,
      capacity: capacity ?? this.capacity,
      studentIds: studentIds ?? this.studentIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'branch': branch,
      'coachId': coachId,
      'coachName': coachName,
      'schedule': schedule,
      'dayTime': schedule,
      'capacity': capacity,
      'studentIds': studentIds,
    };
  }

  factory TrainingGroup.fromJson(Map<String, dynamic> json) {
    return TrainingGroup(
      id: json['id'] ?? '',
      name: json['name'],
      branch: json['branch'],
      coachId: json['coachId'] ?? '',
      coachName: json['coachName'],
      schedule: json['schedule'] ?? json['dayTime'],
      capacity: (json['capacity'] as num).toInt(),
      studentIds: List<String>.from(json['studentIds'] ?? const []),
    );
  }
}

class AttendanceRecord {
  final String id;
  final String groupId;
  final String groupName;
  final String dateText;
  final List<String> presentStudentNames;
  final List<String> absentStudentNames;

  /// ID bazlı katılım listeleri (kalıcı bağ). İsim listeleri görüntü içindir.
  final List<String> presentStudentIds;
  final List<String> absentStudentIds;

  /// Kayda dahil tüm öğrenci kimlikleri (gelen + gelmeyen). Velinin "çocuğumu
  /// içeren kayıtlar" sorgusunu (array-contains) yapabilmesi için tutulur.
  final List<String> studentIds;

  const AttendanceRecord({
    this.id = '',
    this.groupId = '',
    required this.groupName,
    required this.dateText,
    required this.presentStudentNames,
    required this.absentStudentNames,
    this.presentStudentIds = const [],
    this.absentStudentIds = const [],
    this.studentIds = const [],
  });

  AttendanceRecord copyWith({
    String? id,
    String? groupId,
    String? groupName,
    String? dateText,
    List<String>? presentStudentNames,
    List<String>? absentStudentNames,
    List<String>? presentStudentIds,
    List<String>? absentStudentIds,
    List<String>? studentIds,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      dateText: dateText ?? this.dateText,
      presentStudentNames: presentStudentNames ?? this.presentStudentNames,
      absentStudentNames: absentStudentNames ?? this.absentStudentNames,
      presentStudentIds: presentStudentIds ?? this.presentStudentIds,
      absentStudentIds: absentStudentIds ?? this.absentStudentIds,
      studentIds: studentIds ?? this.studentIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupId': groupId,
      'groupName': groupName,
      'dateText': dateText,
      'date': dateText,
      'presentStudentNames': presentStudentNames,
      'absentStudentNames': absentStudentNames,
      'presentStudentIds': presentStudentIds,
      'absentStudentIds': absentStudentIds,
      'studentIds': studentIds,
    };
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'] ?? '',
      groupId: json['groupId'] ?? '',
      groupName: json['groupName'],
      dateText: json['dateText'] ?? json['date'],
      presentStudentNames: List<String>.from(json['presentStudentNames'] ?? []),
      absentStudentNames: List<String>.from(json['absentStudentNames'] ?? []),
      presentStudentIds: List<String>.from(json['presentStudentIds'] ?? []),
      absentStudentIds: List<String>.from(json['absentStudentIds'] ?? []),
      studentIds: List<String>.from(json['studentIds'] ?? []),
    );
  }
}

class PaymentRecord {
  final String id;

  /// Öğrenci referansı: [studentId] kalıcı bağ, [studentName] görüntü içindir.
  /// Eski kayıtlarda [studentId] boş olabilir.
  final String studentId;
  final String studentName;
  final String period;
  final int amount;
  final String status;
  final String dateText;
  final String note;

  const PaymentRecord({
    this.id = '',
    this.studentId = '',
    required this.studentName,
    required this.period,
    required this.amount,
    required this.status,
    required this.dateText,
    required this.note,
  });

  PaymentRecord copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? period,
    int? amount,
    String? status,
    String? dateText,
    String? note,
  }) {
    return PaymentRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      period: period ?? this.period,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      dateText: dateText ?? this.dateText,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'period': period,
      'month': period,
      'amount': amount,
      'status': status,
      'dateText': dateText,
      'date': dateText,
      'note': note,
    };
  }

  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      studentName: json['studentName'],
      period: json['period'] ?? json['month'],
      amount: (json['amount'] as num).toInt(),
      status: json['status'],
      dateText: json['dateText'] ?? json['date'],
      note: json['note'] ?? '',
    );
  }
}

/// Bir veli kullanıcı hesabı ve ona atanmış öğrenci kimlikleri.
class ParentAccount {
  final String uid;
  final String email;
  final List<String> studentIds;

  const ParentAccount({
    required this.uid,
    required this.email,
    this.studentIds = const [],
  });

  ParentAccount copyWith({
    String? uid,
    String? email,
    List<String>? studentIds,
  }) {
    return ParentAccount(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      studentIds: studentIds ?? this.studentIds,
    );
  }

  factory ParentAccount.fromJson(String uid, Map<String, dynamic> json) {
    return ParentAccount(
      uid: uid,
      email: json['email'] ?? '',
      studentIds: List<String>.from(json['studentIds'] ?? const []),
    );
  }
}

/// Uygulamaya kayıtlı herhangi bir kullanıcı hesabı (rolünden bağımsız).
///
/// Admin'in "Kullanıcılar" ekranında rol atadığı kayıttır. [role] ham haliyle
/// tutulur; geçerli değerler [AppRoles] içinde tanımlıdır.
class UserAccount {
  final String uid;
  final String email;
  final String role;
  final List<String> studentIds;

  /// Kayıt sırasında girilen ad soyad (varsa). Gösterim amaçlı.
  final String displayName;

  /// Kullanıcının kayıtta talep ettiği rol ('veli' | 'ogrenci' | '').
  final String requestedRole;

  /// Rol başvurusunun durumu: 'pending' | 'approved' | 'rejected' | ''.
  final String requestStatus;

  const UserAccount({
    required this.uid,
    required this.email,
    required this.role,
    this.studentIds = const [],
    this.displayName = '',
    this.requestedRole = '',
    this.requestStatus = '',
  });

  /// Yönetici onayı bekleyen bir rol başvurusu mu?
  bool get isPendingRequest => requestStatus == 'pending';

  UserAccount copyWith({
    String? uid,
    String? email,
    String? role,
    List<String>? studentIds,
    String? displayName,
    String? requestedRole,
    String? requestStatus,
  }) {
    return UserAccount(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
      studentIds: studentIds ?? this.studentIds,
      displayName: displayName ?? this.displayName,
      requestedRole: requestedRole ?? this.requestedRole,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }

  factory UserAccount.fromJson(String uid, Map<String, dynamic> json) {
    final rawRole = json['role'];
    return UserAccount(
      uid: uid,
      email: json['email'] ?? '',
      role: rawRole is String ? rawRole.trim().toLowerCase() : 'viewer',
      studentIds: List<String>.from(json['studentIds'] ?? const []),
      displayName: json['displayName'] as String? ?? '',
      requestedRole: (json['requestedRole'] as String? ?? '')
          .trim()
          .toLowerCase(),
      requestStatus: (json['roleRequestStatus'] as String? ?? '').trim(),
    );
  }
}

/// Giriş yapan kullanıcının kendi düzenleyebildiği profil bilgileri.
///
/// [role] ve [studentIds] burada salt-okunur bilgidir; kullanıcı bunları
/// değiştiremez (güvenlik kuralı da engeller). [photoBase64] küçültülüp
/// sıkıştırılmış avatarın base64 hâlidir (yoksa boş).
class UserProfile {
  final String uid;
  final String email;
  final String role;
  final String displayName;
  final String phone;
  final String photoBase64;

  const UserProfile({
    required this.uid,
    required this.email,
    required this.role,
    this.displayName = '',
    this.phone = '',
    this.photoBase64 = '',
  });

  UserProfile copyWith({
    String? displayName,
    String? phone,
    String? photoBase64,
  }) {
    return UserProfile(
      uid: uid,
      email: email,
      role: role,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      photoBase64: photoBase64 ?? this.photoBase64,
    );
  }

  factory UserProfile.fromJson(String uid, Map<String, dynamic> json) {
    final rawRole = json['role'];
    return UserProfile(
      uid: uid,
      email: json['email'] ?? '',
      role: rawRole is String ? rawRole.trim().toLowerCase() : 'viewer',
      displayName: json['displayName'] ?? '',
      phone: json['phone'] ?? '',
      photoBase64: json['photoBase64'] ?? '',
    );
  }
}

/// Kulüp genel sohbetindeki tek bir mesaj.
///
/// [senderName] gönderildiği andaki ad-soyad (denormalize; her mesajda okuma
/// yapmamak için). Avatar mesajda tutulmaz — `users/{senderId}.photoBase64`'ten
/// gönderen başına bir kez okunup önbelleğe alınır (ücretsiz kotayı korur).
/// [createdAt] sunucu zaman damgası; yeni yazılan mesajda bir an için null olur.
class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime? createdAt;

  const ChatMessage({
    this.id = '',
    required this.senderId,
    required this.senderName,
    required this.text,
    this.createdAt,
  });

  factory ChatMessage.fromJson(String id, Map<String, dynamic> json) {
    return ChatMessage(
      id: id,
      senderId: json['senderId'] as String? ?? '',
      senderName: json['senderName'] as String? ?? '',
      text: json['text'] as String? ?? '',
      // Firestore Timestamp'ı bu saf modelde tip olarak import etmeden çöz:
      // Timestamp.toDate() varsa kullan; yoksa DateTime/int'i de kabul et.
      createdAt: _parseTimestamp(json['createdAt']),
    );
  }

  static DateTime? _parseTimestamp(dynamic raw) {
    if (raw == null) {
      return null;
    }
    if (raw is DateTime) {
      return raw;
    }
    if (raw is int) {
      return DateTime.fromMillisecondsSinceEpoch(raw);
    }
    try {
      return (raw as dynamic).toDate() as DateTime;
    } catch (_) {
      return null;
    }
  }
}

/// Antrenörün bir öğrenci için belirli bir tarihte girdiği performans puanları.
/// [scores] anahtarları [PerformanceMetrics.all] içindeki ölçüt adlarıdır.
class PerformanceRecord {
  final String id;
  final String studentId;
  final String dateText;
  final Map<String, num> scores;

  const PerformanceRecord({
    this.id = '',
    required this.studentId,
    required this.dateText,
    required this.scores,
  });

  PerformanceRecord copyWith({
    String? id,
    String? studentId,
    String? dateText,
    Map<String, num>? scores,
  }) {
    return PerformanceRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      dateText: dateText ?? this.dateText,
      scores: scores ?? this.scores,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'dateText': dateText,
      'scores': scores.map((key, value) => MapEntry(key, value)),
    };
  }

  factory PerformanceRecord.fromJson(Map<String, dynamic> json) {
    final rawScores = (json['scores'] as Map?) ?? const {};

    return PerformanceRecord(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      dateText: json['dateText'] ?? '',
      scores: rawScores.map(
        (key, value) => MapEntry(key.toString(), (value as num?) ?? 0),
      ),
    );
  }
}

/// Antrenörün gelecek için planladığı bir etkinlik/antrenman.
class PlannedEvent {
  final String id;
  final String title;
  final String description;
  final String dateText;

  const PlannedEvent({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateText,
  });

  PlannedEvent copyWith({
    String? id,
    String? title,
    String? description,
    String? dateText,
  }) {
    return PlannedEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateText: dateText ?? this.dateText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateText': dateText,
      'date': dateText,
    };
  }

  factory PlannedEvent.fromJson(Map<String, dynamic> json) {
    return PlannedEvent(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dateText: json['dateText'] ?? json['date'] ?? '',
    );
  }
}

/// Bir velinin, bir öğrenci adına bir etkinliğe verdiği katılım cevabı.
class EventResponse {
  final String id;
  final String eventId;
  final String studentId;
  final String parentUid;
  final bool willAttend;

  const EventResponse({
    this.id = '',
    required this.eventId,
    required this.studentId,
    required this.parentUid,
    required this.willAttend,
  });

  /// Aynı etkinlik + öğrenci için tek cevap tutulur; belge kimliği bu ikiliden.
  static String buildId(String eventId, String studentId) =>
      '${eventId}_$studentId';

  EventResponse copyWith({
    String? id,
    String? eventId,
    String? studentId,
    String? parentUid,
    bool? willAttend,
  }) {
    return EventResponse(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      studentId: studentId ?? this.studentId,
      parentUid: parentUid ?? this.parentUid,
      willAttend: willAttend ?? this.willAttend,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'studentId': studentId,
      'parentUid': parentUid,
      'willAttend': willAttend,
    };
  }

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      id: json['id'] ?? '',
      eventId: json['eventId'] ?? '',
      studentId: json['studentId'] ?? '',
      parentUid: json['parentUid'] ?? '',
      willAttend: json['willAttend'] == true,
    );
  }
}

class Announcement {
  final String id;
  final String title;
  final String content;
  final String targetAudience;
  final String dateText;

  const Announcement({
    this.id = '',
    required this.title,
    required this.content,
    required this.targetAudience,
    required this.dateText,
  });

  Announcement copyWith({
    String? id,
    String? title,
    String? content,
    String? targetAudience,
    String? dateText,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      targetAudience: targetAudience ?? this.targetAudience,
      dateText: dateText ?? this.dateText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'targetAudience': targetAudience,
      'dateText': dateText,
      'date': dateText,
    };
  }

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] ?? '',
      title: json['title'],
      content: json['content'],
      targetAudience: json['targetAudience'],
      dateText: json['dateText'] ?? json['date'],
    );
  }
}

/// Mazeret / izin talebinin durum değerleri.
class LeaveStatus {
  static const String pending = 'Beklemede';
  static const String approved = 'Onaylandı';
  static const String rejected = 'Reddedildi';

  static const List<String> all = [pending, approved, rejected];
}

/// Velinin çocuğu için gönderdiği mazeret/izin talebi.
///
/// Veli oluşturur (kendi UID'si + kendi çocuğu), personel görüntüler ve
/// durumunu (Beklemede/Onaylandı/Reddedildi) günceller. Etkinlik cevaplarıyla
/// aynı güvenlik desenini izler.
class LeaveRequest {
  final String id;

  /// Öğrenci referansı: [studentId] kalıcı bağ, [studentName] görüntü içindir.
  final String studentId;
  final String studentName;
  final String parentUid;

  /// İzin/mazeret tarihi (görüntü metni) ve gerekçe.
  final String dateText;
  final String reason;

  /// [LeaveStatus] değerlerinden biri.
  final String status;

  const LeaveRequest({
    this.id = '',
    required this.studentId,
    required this.studentName,
    required this.parentUid,
    required this.dateText,
    required this.reason,
    this.status = LeaveStatus.pending,
  });

  LeaveRequest copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? parentUid,
    String? dateText,
    String? reason,
    String? status,
  }) {
    return LeaveRequest(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      parentUid: parentUid ?? this.parentUid,
      dateText: dateText ?? this.dateText,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'parentUid': parentUid,
      'dateText': dateText,
      'reason': reason,
      'status': status,
    };
  }

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      studentName: json['studentName'] ?? '',
      parentUid: json['parentUid'] ?? '',
      dateText: json['dateText'] ?? '',
      reason: json['reason'] ?? '',
      status: json['status'] ?? LeaveStatus.pending,
    );
  }
}

/// Kulüp kasası hareketinin türü.
class CashType {
  static const String income = 'Gelir';
  static const String expense = 'Gider';

  static const List<String> all = [income, expense];
}

/// Kasa hareketleri için önerilen kategoriler (form seçimi kolaylaştırır;
/// serbest metin de olabilir).
class CashCategories {
  static const List<String> income = [
    'Aidat',
    'Kayıt Ücreti',
    'Sponsorluk',
    'Bağış',
    'Diğer',
  ];
  static const List<String> expense = [
    'Kira',
    'Maaş',
    'Malzeme',
    'Fatura',
    'Ulaşım',
    'Bakım',
    'Diğer',
  ];

  /// Türüne göre önerilen kategori listesi.
  static List<String> forType(String type) =>
      type == CashType.expense ? expense : income;
}

/// Kulüp kasasındaki tek bir gelir/gider hareketi (defter kaydı).
///
/// Yalnızca admin görür ve yönetir; kulübün nakit defterini oluşturur. Güncel
/// kasa, gelirlerin toplamından giderlerin toplamı çıkarılarak türetilir
/// (ayrı bir bakiye alanı tutulmaz).
class CashTransaction {
  final String id;

  /// [CashType] değerlerinden biri (Gelir / Gider).
  final String type;
  final String title;
  final String category;

  /// ₺ cinsinden pozitif tutar. Kasa etkisi türe göre [signedAmount] ile alınır.
  final int amount;
  final String dateText;
  final String note;

  const CashTransaction({
    this.id = '',
    required this.type,
    required this.title,
    this.category = '',
    required this.amount,
    required this.dateText,
    this.note = '',
  });

  bool get isIncome => type == CashType.income;

  /// Kasaya net etki: gelir pozitif, gider negatif.
  int get signedAmount => isIncome ? amount : -amount;

  CashTransaction copyWith({
    String? id,
    String? type,
    String? title,
    String? category,
    int? amount,
    String? dateText,
    String? note,
  }) {
    return CashTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      dateText: dateText ?? this.dateText,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'category': category,
      'amount': amount,
      'dateText': dateText,
      'date': dateText,
      'note': note,
    };
  }

  factory CashTransaction.fromJson(Map<String, dynamic> json) {
    return CashTransaction(
      id: json['id'] ?? '',
      type: json['type'] ?? CashType.income,
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      dateText: json['dateText'] ?? json['date'] ?? '',
      note: json['note'] ?? '',
    );
  }
}

/// Depodaki bir malzemenin fiziksel durumu.
class EquipmentCondition {
  static const String good = 'Sağlam';
  static const String maintenance = 'Bakımda';
  static const String worn = 'Yıpranmış';

  static const List<String> all = [good, maintenance, worn];
}

/// Depo malzemeleri için önerilen kategoriler.
class EquipmentCategories {
  static const List<String> all = [
    'Top',
    'Forma / Kıyafet',
    'Antrenman Ekipmanı',
    'Sağlık / İlk Yardım',
    'Diğer',
  ];
}

/// Depodaki (envanterdeki) bir malzeme kalemi.
///
/// Personel (admin/antrenör) yönetir; kulübün ekipman envanterini oluşturur.
/// [assignedTo] isteğe bağlı zimmet bilgisidir (malzeme kimde).
class EquipmentItem {
  final String id;
  final String name;
  final String category;
  final int quantity;

  /// [EquipmentCondition] değerlerinden biri.
  final String condition;

  /// Zimmet: malzemenin kimde/nerede olduğu (isteğe bağlı).
  final String assignedTo;
  final String note;

  const EquipmentItem({
    this.id = '',
    required this.name,
    this.category = '',
    required this.quantity,
    this.condition = EquipmentCondition.good,
    this.assignedTo = '',
    this.note = '',
  });

  EquipmentItem copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    String? condition,
    String? assignedTo,
    String? note,
  }) {
    return EquipmentItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      assignedTo: assignedTo ?? this.assignedTo,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'condition': condition,
      'assignedTo': assignedTo,
      'note': note,
    };
  }

  factory EquipmentItem.fromJson(Map<String, dynamic> json) {
    return EquipmentItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      condition: json['condition'] ?? EquipmentCondition.good,
      assignedTo: json['assignedTo'] ?? '',
      note: json['note'] ?? '',
    );
  }
}
