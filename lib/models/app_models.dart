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
  final String coachName;
  final String schedule;
  final int capacity;

  const TrainingGroup({
    this.id = '',
    required this.name,
    required this.branch,
    required this.coachName,
    required this.schedule,
    required this.capacity,
  });

  TrainingGroup copyWith({
    String? id,
    String? name,
    String? branch,
    String? coachName,
    String? schedule,
    int? capacity,
  }) {
    return TrainingGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      branch: branch ?? this.branch,
      coachName: coachName ?? this.coachName,
      schedule: schedule ?? this.schedule,
      capacity: capacity ?? this.capacity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'branch': branch,
      'coachName': coachName,
      'schedule': schedule,
      'dayTime': schedule,
      'capacity': capacity,
    };
  }

  factory TrainingGroup.fromJson(Map<String, dynamic> json) {
    return TrainingGroup(
      id: json['id'] ?? '',
      name: json['name'],
      branch: json['branch'],
      coachName: json['coachName'],
      schedule: json['schedule'] ?? json['dayTime'],
      capacity: (json['capacity'] as num).toInt(),
    );
  }
}

class AttendanceRecord {
  final String id;
  final String groupName;
  final String dateText;
  final List<String> presentStudentNames;
  final List<String> absentStudentNames;

  const AttendanceRecord({
    this.id = '',
    required this.groupName,
    required this.dateText,
    required this.presentStudentNames,
    required this.absentStudentNames,
  });

  AttendanceRecord copyWith({
    String? id,
    String? groupName,
    String? dateText,
    List<String>? presentStudentNames,
    List<String>? absentStudentNames,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      dateText: dateText ?? this.dateText,
      presentStudentNames: presentStudentNames ?? this.presentStudentNames,
      absentStudentNames: absentStudentNames ?? this.absentStudentNames,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'dateText': dateText,
      'date': dateText,
      'presentStudentNames': presentStudentNames,
      'absentStudentNames': absentStudentNames,
    };
  }

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'] ?? '',
      groupName: json['groupName'],
      dateText: json['dateText'] ?? json['date'],
      presentStudentNames: List<String>.from(json['presentStudentNames'] ?? []),
      absentStudentNames: List<String>.from(json['absentStudentNames'] ?? []),
    );
  }
}

class PaymentRecord {
  final String id;
  final String studentName;
  final String period;
  final int amount;
  final String status;
  final String dateText;
  final String note;

  const PaymentRecord({
    this.id = '',
    required this.studentName,
    required this.period,
    required this.amount,
    required this.status,
    required this.dateText,
    required this.note,
  });

  PaymentRecord copyWith({
    String? id,
    String? studentName,
    String? period,
    int? amount,
    String? status,
    String? dateText,
    String? note,
  }) {
    return PaymentRecord(
      id: id ?? this.id,
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
