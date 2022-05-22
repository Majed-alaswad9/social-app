import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/home/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context,state){},
        builder: (context,state){
          var model=HomeCubit.get(context).model;
          return ConditionalBuilder(
              condition: model!=null,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 260,
                    //   child: Stack(
                    //     alignment: AlignmentDirectional.bottomCenter,
                    //     children: [
                    //       Align(
                    //         child: Container(
                    //           width: double.infinity,
                    //           height: 200,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               image:  DecorationImage(
                    //                 fit: BoxFit.cover,
                    //                 image: NetworkImage(
                    //                     'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1647433213~exp=1647433813~hmac=334747c3be9988fa4d9ac995fd5d04d36cebd1c4a9d458aeb96781c3c2320987&w=826'),
                    //               )),
                    //         ),
                    //         alignment: AlignmentDirectional.topCenter,
                    //       ),
                    //       CircleAvatar(
                    //         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    //         radius: 65,
                    //         child: CircleAvatar(
                    //           radius: 60,
                    //           backgroundImage: NetworkImage(
                    //               'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1647433213~exp=1647433813~hmac=334747c3be9988fa4d9ac995fd5d04d36cebd1c4a9d458aeb96781c3c2320987&w=826'),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Text(
                      '${model!.name}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      '${model.bio}',
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const [
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'post',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const [
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'friends',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const [
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Column(
                                children: const [
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Followings',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(onPressed: (){},
                            child: const Text('Add photo',style: TextStyle(fontSize: 20),),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        OutlinedButton(onPressed: (){
                          navigatorTo(context: context, widget: EditProfileScreen(model));
                        },
                            child: const Icon(Icons.edit))

                      ],
                    )
                  ],
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
