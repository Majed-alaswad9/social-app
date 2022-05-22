import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var postTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit,HomeState>(
          listener: (context,state){
            if(state is CreatePostSuccessState) {
              postTextController.text='';
            }
          },
      builder: (context,state){
            return ConditionalBuilder(condition: HomeCubit.get(context).model!=null,
                builder: (context)=>Form(
                  key: formKey,
                  child: Scaffold(
                    appBar: AppBar(actions: [
                      TextButton(onPressed: (){
                        var date=DateTime.now();
                        if (formKey.currentState!.validate()) {
                          HomeCubit.get(context).createPost(
                              text: postTextController.text, dateTime: date.toString());
                        }

                      },
                          child: const Text(
                            'POST',style: TextStyle(
                              fontSize: 18
                          ),
                          ))
                    ],
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          if(state is CreatePostLoadingState)
                            const LinearProgressIndicator(),
                          if(state is CreatePostLoadingState)
                            const SizedBox(height: 20,),
                          Row(
                            children:  [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://student.valuxapps.com/storage/assets/defaults/user.jpg'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${HomeCubit.get(context).model!.name}',
                                  style: const TextStyle(
                                      height: 1.3,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: TextFormField(
                                controller: postTextController,
                                minLines: 1,
                                maxLines: 100,
                                keyboardType: TextInputType.multiline,
                                validator: validatePost,
                                decoration: const InputDecoration(
                                    hintText: 'What\'s on your mind?',
                                    border: InputBorder.none),
                              )),
                          Row(
                            children: [
                              Expanded(
                                  child: MaterialButton(
                                    color: Colors.blue,
                                    onPressed: () {

                                    },
                                    child: const Text(
                                      'Add post',
                                      style: TextStyle(color: Colors.white, fontSize: 17),
                                    ),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: MaterialButton(
                                    color: Colors.blue,
                                    onPressed: () {},
                                    child: const Text(
                                      '# tags',
                                      style: TextStyle(color: Colors.white, fontSize: 17),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator()));
      },),
    );
  }

  String? validatePost(String? value) {
    if (value!.isEmpty) {
      return 'you must write post';
    }
    return null;
  }
}
