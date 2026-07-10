import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_models.dart';

/// Haftalık ders programı servisi. Oturumlar `scheduleEntries` koleksiyonunda
/// tutulur; gerçek zamanlı dinlenir (antrenör değişiklikleri herkeste anında
/// görünür). Gün/saat sıralaması istemci tarafında yapılır (gün adı Türkçe
/// olduğundan kronolojik sıralamaya uymaz).
class ScheduleService {
  ScheduleService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _collection = 'scheduleEntries';

  CollectionReference<Map<String, dynamic>> get _entries {
    return _firestore.collection(_collection);
  }

  Stream<List<ScheduleEntry>> watchEntries() {
    return _entries.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ScheduleEntry.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  Future<void> addEntry(ScheduleEntry entry) async {
    await _entries.add(entry.toJson());
  }

  Future<void> updateEntry(ScheduleEntry entry) async {
    if (entry.id.isEmpty) {
      return;
    }
    await _entries.doc(entry.id).update(entry.toJson());
  }

  Future<void> deleteEntry(String id) async {
    if (id.isEmpty) {
      return;
    }
    await _entries.doc(id).delete();
  }
}
