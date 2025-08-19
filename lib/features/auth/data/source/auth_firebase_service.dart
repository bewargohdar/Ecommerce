import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/features/auth/data/models/signin_user_req.dart';
import 'package:ecomerce/features/auth/data/models/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<DataState> signup(UserCredentialRequestModel userModel);
  Future<DataState> signin(SigninUserReq userModel);
  Future<DataState> getAges();
  Future<DataState> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<DataState> getUser();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<DataState> signup(UserCredentialRequestModel userModel) async {
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
      return const DataSuccess('Singup was successful');
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return DataError(Exception(message));
    }
  }

  @override
  Future<DataState> getAges() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Ages').get();
      return DataSuccess(data.docs);
    } catch (e) {
      return DataError(Exception(e.toString()));
    }
  }

  @override
  Future<DataState> signin(SigninUserReq userModel) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password!,
      );
      return const DataSuccess("Signin was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      return DataError(Exception(message));
    }
  }

  @override
  Future<DataState> sendPasswordResetEmail(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
      return const DataSuccess("Email sent successfully");
    } catch (e) {
      return DataError(Exception(e.toString()));
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
  Future<DataState> getUser() async {
    var currentUser = _firebaseAuth.currentUser;
    var userData = await _firebaseFirestore
        .collection('Users')
        .doc(
          currentUser?.uid,
        )
        .get()
        .then((value) => value.data());

    try {
      return DataSuccess(userData);
    } catch (e) {
      return DataError(Exception('Please try again'));
    }
  }
}
