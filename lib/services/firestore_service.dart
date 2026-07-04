import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_models.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _studentsCollection = 'students';
  static const String _coachesCollection = 'coaches';
  static const String _groupsCollection = 'groups';
  static const String _attendanceCollection = 'attendanceRecords';
  static const String _paymentsCollection = 'payments';
  static const String _announcementsCollection = 'announcements';

  CollectionReference<Map<String, dynamic>> get _students {
    return _firestore.collection(_studentsCollection);
  }

  CollectionReference<Map<String, dynamic>> get _coaches {
    return _firestore.collection(_coachesCollection);
  }

  CollectionReference<Map<String, dynamic>> get _groups {
    return _firestore.collection(_groupsCollection);
  }

  CollectionReference<Map<String, dynamic>> get _attendanceRecords {
    return _firestore.collection(_attendanceCollection);
  }

  CollectionReference<Map<String, dynamic>> get _payments {
    return _firestore.collection(_paymentsCollection);
  }

  CollectionReference<Map<String, dynamic>> get _announcements {
    return _firestore.collection(_announcementsCollection);
  }

  Future<List<T>> _loadCollection<T>({
    required CollectionReference<Map<String, dynamic>> collection,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    final snapshot = await collection.get();

    return snapshot.docs.map((doc) {
      return fromJson({...doc.data(), 'id': doc.id});
    }).toList();
  }

  Future<T> _addDocument<T>({
    required CollectionReference<Map<String, dynamic>> collection,
    required T Function(String id) withId,
    required Map<String, dynamic> Function(T item) toJson,
  }) async {
    final doc = collection.doc();
    final itemWithId = withId(doc.id);

    await doc.set({
      ...toJson(itemWithId),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return itemWithId;
  }

  Future<void> _updateDocument({
    required CollectionReference<Map<String, dynamic>> collection,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    if (id.isEmpty) {
      throw StateError('Firestore kayıt id bilgisi eksik.');
    }

    await collection.doc(id).set({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> _deleteDocument({
    required CollectionReference<Map<String, dynamic>> collection,
    required String id,
  }) async {
    if (id.isEmpty) {
      throw StateError('Firestore kayıt id bilgisi eksik.');
    }

    await collection.doc(id).delete();
  }

  Future<List<Student>> loadStudents() {
    return _loadCollection<Student>(
      collection: _students,
      fromJson: Student.fromJson,
    );
  }

  Future<Student> addStudent(Student student) {
    return _addDocument<Student>(
      collection: _students,
      withId: (id) => student.copyWith(id: id),
      toJson: (student) => student.toJson(),
    );
  }

  Future<void> updateStudent(Student student) {
    return _updateDocument(
      collection: _students,
      id: student.id,
      data: student.toJson(),
    );
  }

  Future<void> deleteStudent(String id) {
    return _deleteDocument(collection: _students, id: id);
  }

  Future<List<Coach>> loadCoaches() {
    return _loadCollection<Coach>(
      collection: _coaches,
      fromJson: Coach.fromJson,
    );
  }

  Future<Coach> addCoach(Coach coach) {
    return _addDocument<Coach>(
      collection: _coaches,
      withId: (id) => coach.copyWith(id: id),
      toJson: (coach) => coach.toJson(),
    );
  }

  Future<void> updateCoach(Coach coach) {
    return _updateDocument(
      collection: _coaches,
      id: coach.id,
      data: coach.toJson(),
    );
  }

  Future<void> deleteCoach(String id) {
    return _deleteDocument(collection: _coaches, id: id);
  }

  Future<List<TrainingGroup>> loadGroups() {
    return _loadCollection<TrainingGroup>(
      collection: _groups,
      fromJson: TrainingGroup.fromJson,
    );
  }

  Future<TrainingGroup> addGroup(TrainingGroup group) {
    return _addDocument<TrainingGroup>(
      collection: _groups,
      withId: (id) => group.copyWith(id: id),
      toJson: (group) => group.toJson(),
    );
  }

  Future<void> updateGroup(TrainingGroup group) {
    return _updateDocument(
      collection: _groups,
      id: group.id,
      data: group.toJson(),
    );
  }

  Future<void> deleteGroup(String id) {
    return _deleteDocument(collection: _groups, id: id);
  }

  Future<List<AttendanceRecord>> loadAttendanceRecords() {
    return _loadCollection<AttendanceRecord>(
      collection: _attendanceRecords,
      fromJson: AttendanceRecord.fromJson,
    );
  }

  Future<AttendanceRecord> addAttendanceRecord(AttendanceRecord record) {
    return _addDocument<AttendanceRecord>(
      collection: _attendanceRecords,
      withId: (id) => record.copyWith(id: id),
      toJson: (record) => record.toJson(),
    );
  }

  Future<void> updateAttendanceRecord(AttendanceRecord record) {
    return _updateDocument(
      collection: _attendanceRecords,
      id: record.id,
      data: record.toJson(),
    );
  }

  Future<void> deleteAttendanceRecord(String id) {
    return _deleteDocument(collection: _attendanceRecords, id: id);
  }

  Future<List<PaymentRecord>> loadPayments() {
    return _loadCollection<PaymentRecord>(
      collection: _payments,
      fromJson: PaymentRecord.fromJson,
    );
  }

  Future<PaymentRecord> addPayment(PaymentRecord payment) {
    return _addDocument<PaymentRecord>(
      collection: _payments,
      withId: (id) => payment.copyWith(id: id),
      toJson: (payment) => payment.toJson(),
    );
  }

  Future<void> updatePayment(PaymentRecord payment) {
    return _updateDocument(
      collection: _payments,
      id: payment.id,
      data: payment.toJson(),
    );
  }

  Future<void> deletePayment(String id) {
    return _deleteDocument(collection: _payments, id: id);
  }

  Future<List<Announcement>> loadAnnouncements() {
    return _loadCollection<Announcement>(
      collection: _announcements,
      fromJson: Announcement.fromJson,
    );
  }

  Future<Announcement> addAnnouncement(Announcement announcement) {
    return _addDocument<Announcement>(
      collection: _announcements,
      withId: (id) => announcement.copyWith(id: id),
      toJson: (announcement) => announcement.toJson(),
    );
  }

  Future<void> updateAnnouncement(Announcement announcement) {
    return _updateDocument(
      collection: _announcements,
      id: announcement.id,
      data: announcement.toJson(),
    );
  }

  Future<void> deleteAnnouncement(String id) {
    return _deleteDocument(collection: _announcements, id: id);
  }
}
