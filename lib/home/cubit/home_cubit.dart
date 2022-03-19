import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/home/chats/chat_screen.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/home/feeds/feeds_screen.dart';
import 'package:social_app/home/new_posts/new_post_screen.dart';
import 'package:social_app/home/settings/setting_screen.dart';
import 'package:social_app/home/users/users_screen.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/end_point.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserCreate? model;

  List<String> title = ['Home', 'Chat', '', 'Users', 'Settings'];
  List<Widget> bottomNavItem = [
    const FeedsScreen(),
    const ChatScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  int indexBottom = 0;

  void changeBottom(index) {
    if (index == 2) {
      emit(NewPostState());
    } else {
      indexBottom = index;
      emit(ChangeBottomState());
    }
  }

  void getUserData() {
    emit(GetDataLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      model = UserCreate.fromJson(value.data()!);
      emit(GetDataSuccessState());
    }).catchError((error) {
      emit(GetDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future getProfileImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image != null) {
      profileImage = File(image.path);
      emit(GetProfileImageSuccessState());
    } else {
      emit(GetProfileImageErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image != null) {
      coverImage = File(image.path);
      emit(GetCoverImageSuccessState());
    } else {
      emit(GetCoverImageErrorState());
    }
  }

  void updateProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }
}
