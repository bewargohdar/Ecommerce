import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryFirebaseService {
  Future<Either> getCategories();
}

class CategoryFirebaseServiceImpl implements CategoryFirebaseService {
  final _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<Either> getCategories() async {
    var categories = await _firebaseFirestore.collection('categories').get();

    try {
      return Right(categories.docs);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
