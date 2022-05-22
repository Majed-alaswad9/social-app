import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/end_point.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  var msgController = TextEditingController();

  ChatDetailsScreen(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        HomeCubit.get(context).getMessages(model.uId);
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 7,
                title: Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          'https://student.valuxapps.com/storage/assets/defaults/user.jpg'),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Text(
                      '${model.name}',
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var msg = HomeCubit.get(context).messages[index];
                                if (uId == msg.sendId) {
                                  return buildMyMessage(msg);
                                } else {
                                  return buildReceiveMessage(msg);
                                }
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                              itemCount: HomeCubit.get(context).messages.length),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: TextFormField(
                                  controller: msgController,
                                  decoration: const InputDecoration(
                                      hintText: 'message...',
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                var date = DateTime.now();
                                HomeCubit.get(context).sendMessage(
                                    receiveId: model.uId!,
                                    date: date.toString(),
                                    text: msgController.text);
                                msgController.clear();
                              },
                              minWidth: 2,
                              child: const Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

            );
          },
        );
      }),
    );
  }

  Widget buildMyMessage(MessageModel msg) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    bottomStart: Radius.circular(10),
                    topStart: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '${msg.text}',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      );

  Widget buildReceiveMessage(MessageModel msg) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10))),
            child:  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '${msg.text}',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      );
}
