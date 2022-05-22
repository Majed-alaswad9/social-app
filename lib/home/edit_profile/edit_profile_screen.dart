import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/home/feeds/feeds_screen.dart';
import 'package:social_app/home/settings/setting_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/const.dart';

class EditProfileScreen extends StatelessWidget {
  late final model;

  EditProfileScreen(this.model, {Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      HomeCubit()
        ..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is UpdateUserSuccessState){
            showMsg(msg: 'تم التحديث بنجاح', color: colorMsg.success);

          }
        },
        builder: (context, state) {
          // var profileImage = HomeCubit
          //     .get(context)
          //     .profileImage;
          // var coverImage = HomeCubit
          //     .get(context)
          //     .coverImage;
          var usermodel = HomeCubit
              .get(context)
              .model;
          emailController.text = model!.email!;
          nameController.text = model.name!;
          bioController.text = model.bio!;
          phoneController.text = model.phone!;
          return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Profile'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: (const Icon(Icons.arrow_back_ios)),
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        // SizedBox(
                        //   height: 260,
                        //   child: Stack(
                        //     alignment: AlignmentDirectional.bottomCenter,
                        //     children: [
                        //       Stack(
                        //         alignment: AlignmentDirectional.topEnd,
                        //         children: [
                        //           Align(
                        //             child: Container(
                        //               width: double.infinity,
                        //               height: 200,
                        //               decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(
                        //                       5),
                        //                   image: DecorationImage(
                        //                     image: coverImage == null
                        //                         ? NetworkImage('${HomeCubit
                        //                         .get(context)
                        //                         .model!
                        //                         .cover}')
                        //                         : Image(
                        //                         image:
                        //                         FileImage(coverImage)).image,
                        //                   )),
                        //             ),
                        //             alignment: AlignmentDirectional.topCenter,
                        //           ),
                        //           CircleAvatar(
                        //             radius: 20,
                        //             child: IconButton(
                        //                 onPressed: () {
                        //                   HomeCubit.get(context)
                        //                       .getCoverImage(
                        //                       ImageSource.gallery);
                        //                 },
                        //                 icon: const Icon(
                        //                     Icons.camera_alt_outlined)),
                        //           )
                        //         ],
                        //       ),
                        //       Stack(
                        //         alignment: AlignmentDirectional.bottomEnd,
                        //         children: [
                        //           CircleAvatar(
                        //             backgroundColor:
                        //             Theme
                        //                 .of(context)
                        //                 .scaffoldBackgroundColor,
                        //             radius: 65,
                        //             child: CircleAvatar(
                        //               radius: 60,
                        //               backgroundImage: profileImage == null
                        //                   ? NetworkImage('${HomeCubit
                        //                   .get(context)
                        //                   .model!
                        //                   .profileImage}')
                        //                   : Image(
                        //                   image: FileImage(profileImage))
                        //                   .image,
                        //             ),
                        //           ),
                        //           CircleAvatar(
                        //             radius: 18,
                        //             child: IconButton(
                        //                 onPressed: () {
                        //                   HomeCubit.get(context)
                        //                       .getProfileImage(
                        //                       ImageSource.gallery);
                        //                 },
                        //                 icon: const Icon(
                        //                     Icons.camera_alt_outlined)),
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: bioController,
                            keyboardType: TextInputType.text,
                            validator: validateBio,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              // border: InputBorder.none
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          validator: validateEmail,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: validateName,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: validateMobile,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0)),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          minWidth: double.infinity,
                          onPressed: () {
                            HomeCubit.get(context).updateData(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text);
                          },
                          child: const Text('Update'),
                        ),
                        if (state is UpdateUserLoadingState)
                          const LinearProgressIndicator()
                      ]),
                    )),
              ));
        },
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value != null) {
      if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
        return null;
      }
      return 'Enter a Valid Email Address';
    }
  }

  String? validateName(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 charter';
    }
    return null;
  }

  String? validateBio(String? value) {
    if (value!.length < 3) {
      return 'Bio must be more than 2 charter';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value!.length != 10) {
      return 'Mobile Number must be of 10 digit';
    }
    return null;
  }
}
