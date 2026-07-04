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
