import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/models/post_model.dart';

class CommentsScreen extends StatelessWidget {
  PostModel? post;

  CommentsScreen(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),

            body: Column(
              children: [
                Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage('${post!.image}'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${post!.name}',
                                        style: const TextStyle(
                                            height: 1.3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      Text('${post!.dateTime}',
                                          style: const TextStyle(
                                              height: 1.3, color: Colors.grey))
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_horiz)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${post!.text}',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ])),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'comments...',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Card(
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: const BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(10),
                                  bottomStart: Radius.circular(10),
                                  topStart: Radius.circular(10))),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              '${post!.text}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
