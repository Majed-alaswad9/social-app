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
      required String phone,
      BuildContext? context}) {
    emit(SignUpLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user!.uid);
      userCreate(email: email, name: name, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState(error.toString()));
    });
  }

  void userCreate(
      {required String email,
      required String name,
      required String phone,
      required String uId}) {
    emit(CreateLoadState());
    UserCreate users = UserCreate(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        bio: 'write you bio...',
        cover: 'https://student.valuxapps.com/storage/assets/defaults/user.jpg',
        image:
            'https://student.valuxapps.com/storage/assets/defaults/user.jpg');
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(users.toMap())
        .then((value) {
      emit(CreateSuccessState(users));
    }).catchError((error) {
      emit(CreateErrorState(error.toString()));
    });
  }
}
