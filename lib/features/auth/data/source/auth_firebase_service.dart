import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/signin_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCredentialRequestModel userModel);
  Future<Either> getAges();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either> signup(UserCredentialRequestModel userModel) async {
    try {
      var data = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(
            data.user!.uid,
          )
          .set({
        'email': userModel.email,
        'firstName': userModel.firstName,
        'lastName': userModel.lastName,
        'password': userModel.password,
        'gender': userModel.gender,
        'age': userModel.age,
      });
      return const Right('Singup was successful');
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Ages').get();
      return Right(data.docs);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
