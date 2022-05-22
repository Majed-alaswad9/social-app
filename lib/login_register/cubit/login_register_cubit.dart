import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'login_register_state.dart';

class LoginSignUpCubit extends Cubit<LogInSIgnUpState> {
  LoginSignUpCubit() : super(InitialLogInState());

  static LoginSignUpCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LogInLoadState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          if(value.user!=null){
            AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);
            FirebaseAuth.instance.currentUser!
                .reauthenticateWithCredential(credential);
          }
      emit(LogInSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LogInErrorState(error.toString()));
    });
  }

  void userSignUp(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    try {
      emit(SignUpLoadState());
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            if(value.user!=null){
              userCreate(
                  email: email, name: name, phone: phone, uId: value.user!.uid);
              AuthCredential credential =
              EmailAuthProvider.credential(email: email, password: password);
              FirebaseAuth.instance.currentUser!
                  .reauthenticateWithCredential(credential);
            }
      }).catchError((error) {
        print(error.toString());
        emit(SignUpErrorState(error.toString()));
      });
    } catch (e) {}
  }

  void userCreate(
      {required String email,
      required String name,
      required String phone,
      required String uId}) {
    try {
      emit(CreateLoadState());
      UserModel model = UserModel(
          email: email,
          name: name,
          phone: phone,
          uId: uId,
          isEmailVerified: false,
          bio: 'write you bio...',
          cover:
              'https://student.valuxapps.com/storage/assets/defaults/user.jpg',
          profileImage:
              'https://student.valuxapps.com/storage/assets/defaults/user.jpg');
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap())
          .then((value) {
        emit(CreateSuccessState(model));
      }).catchError((error) {
        emit(CreateErrorState(error.toString()));
      });
    } catch (e) {}
  }
}
