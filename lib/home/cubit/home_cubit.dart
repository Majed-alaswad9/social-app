import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:social_app/home/chats/chat_screen.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/home/feeds/feeds_screen.dart';
import 'package:social_app/home/new_posts/new_post_screen.dart';
import 'package:social_app/home/settings/setting_screen.dart';
import 'package:social_app/home/users/users_screen.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/end_point.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  MessageModel? msgModel;
  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<UserModel> allUsers = [];
  List<MessageModel> messages = [];

  List<String> title = ['Home', 'Chat', '', 'Users', 'Settings'];
  List<Widget> bottomNavItem = [
    const FeedsScreen(),
    const ChatScreen(),
    NewPostScreen(),
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

  Future<void> getUserData() async {
    emit(GetDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data()!);
      print(model!.profileImage);
      emit(GetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorState(error.toString()));
    });
  }

  //get All users
  void getAllUsers() {
    allUsers = [];
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != uId) {
          allUsers.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
    });
  }

  //get messages
  void getMessages(String? receiveId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiveId)
        .collection('message')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[];
          for (var element in event.docs) { messages.add(MessageModel.fromJson(element.data()));}
          emit(GetMessageSuccessState());
    });
  }

  //get posts
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('like').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(GetPostsSuccessState());
        }).catchError((error) {});
      }
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  // File? profileImage;
  // final ImagePicker _imagePicker = ImagePicker();
  //
  // Future getProfileImage(ImageSource source) async {
  //   final image = await _imagePicker.pickImage(source: source);
  //   if (image != null) {
  //     profileImage = File(image.path);
  //     print(basename(profileImage!.path));
  //     emit(GetProfileImageSuccessState());
  //   } else {
  //     emit(GetProfileImageErrorState());
  //   }
  // }
  //
  // File? coverImage;
  //
  // Future getCoverImage(ImageSource source) async {
  //   final image = await _imagePicker.pickImage(source: source);
  //   if (image != null) {
  //     coverImage = File(image.path);
  //     emit(GetCoverImageSuccessState());
  //   } else {
  //     emit(GetCoverImageErrorState());
  //   }
  // }

  //update profile image user

  // String profileImageUrl = '';

  // void updateProfileImage() {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('usersImages/${Uri.file(profileImage!.path).pathSegments.last}')
  //       .putFile(profileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       profileImageUrl = value;
  //       print(value);
  //       emit(UploadProfileImageSuccessState());
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(UploadProfileImageErrorState());
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(UploadProfileImageErrorState());
  //   });
  // }

  // //update cover image user
  // String coverImageUrl = '';
  //
  // void updateCoverImage() {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
  //       .putFile(coverImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       coverImageUrl = value;
  //       emit(UploadProfileImageSuccessState());
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(UploadCoverImageErrorState());
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(UploadCoverImageErrorState());
  //   });
  // }

  //update data user
  void updateData(
      {required String email,
      required String name,
      required String phone,
      required String bio}) {
    emit(UpdateUserLoadingState());
    UserModel updateUser = UserModel(
        email: email,
        name: name,
        phone: phone,
        bio: bio,
        uId: uId,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(updateUser.toMap())
        .then((value) {
      getUserData();
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserErrorState());
    });
  }

  createPost({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    PostModel post = PostModel(
      name: model!.name,
      text: text,
      image: model!.profileImage,
      dateTime: dateTime,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(post.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  void likePosts(String? idPost) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost!)
        .collection('like')
        .doc(uId)
        .set({'like': true}).then((value) {
      emit(LikePostsSuccessState());
    }).catchError((error) {
      emit(LikePostsErrorState(error.toString()));
    });
  }

  void commentsPost(String? idPost) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost!)
        .collection('comments')
        .doc(uId)
        .set({
      'comment': true,
    }).then((value) {
      emit(CommentPostsSuccessState());
    }).catchError((error) {
      emit(CommentPostsErrorState(error.toString()));
    });
  }

  void sendMessage(
      {required String receiveId, required String date, required String text}) {
    MessageModel model = MessageModel(
        sendId: uId, receiveId: receiveId, dateTime: date, text: text);
    //send message
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiveId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    //receive message
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveId)
        .collection('chats')
        .doc(uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }
}
