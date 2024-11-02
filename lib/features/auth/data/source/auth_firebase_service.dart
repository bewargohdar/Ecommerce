import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';
import 'package:ecomerce/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCredentialRequestModel userModel);
  Future<Either> signin(SigninUserReq userModel);
  Future<Either> getAges();
  Future<Either> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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

  @override
  Future<Either> signin(SigninUserReq userModel) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password!,
      );
      return const Right("Signin was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right("Email sent successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (_firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> getUser() async {
    var currentUser = _firebaseAuth.currentUser;
    var userData = await _firebaseFirestore
        .collection('Users')
        .doc(
          currentUser?.uid,
        )
        .get()
        .then((value) => value.data());
    UserModel user = UserModel.fromMap(userData ?? {});
    try {
      return Right(user);
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
