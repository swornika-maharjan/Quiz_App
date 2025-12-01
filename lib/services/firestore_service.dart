import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getCategories() async {
    final snapshot = await _db.collection('categories').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getQuizQuestions(String category) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .doc(category)
        .collection('questions')
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> saveQuizResult({
    required String userId,
    required String category,
    required int score,
    required int total,
  }) async {
    await _db.collection('history').add({
      'userId': userId,
      'quizCategory': category,
      'score': score,
      'total': total,
      'date': DateTime.now().toIso8601String(),
    });
  }
}
