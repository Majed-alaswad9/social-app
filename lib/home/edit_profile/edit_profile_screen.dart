import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/home/settings/setting_screen.dart';
import 'package:social_app/shared/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context,state){},
        builder: (context,state){
          var profileImage=HomeCubit.get(context).profileImage;
          var coverImage=HomeCubit.get(context).coverImage;
          var model=HomeCubit.get(context).model;
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
              body: ConditionalBuilder(
                condition: model!=null,
                builder: (context)=>Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(
                        height: 260,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Align(
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: coverImage==null? NetworkImage('${model!.cover}') :Image(image: FileImage(coverImage)).image,
                                        )),
                                  ),
                                  alignment: AlignmentDirectional.topCenter,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                      onPressed: (){
                                        HomeCubit.get(context).getCoverImage(ImageSource.camera);
                                      },
                                      icon: const Icon(Icons.camera_alt_outlined)),
                                )
                              ],
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  radius: 65,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:profileImage==null? NetworkImage('${model!.image}'):Image(image: FileImage(profileImage)).image,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 18,
                                  child: IconButton(
                                      onPressed: (){
                                        HomeCubit.get(context).getProfileImage(ImageSource.camera);
                                      },
                                      icon: const Icon(Icons.camera_alt_outlined)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: validateName,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.people_alt,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText:'Name',
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: bioController,
                        keyboardType: TextInputType.text,
                        validator: validateBio,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintText:'Bio',
                        ),
                      ),
                    ])),
                fallback: (context)=>const Center(child: CircularProgressIndicator()),
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
