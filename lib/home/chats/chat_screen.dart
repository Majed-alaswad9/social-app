import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/chat_details/chat_details_screen.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeCubit()..getAllUsers(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! GetAllUsersLoadingState,
              builder: (context)=>ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildChat(HomeCubit.get(context).allUsers[index],context),
                  separatorBuilder:(context,index)=> Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  itemCount: HomeCubit.get(context).allUsers.length),
              fallback: (context)=> Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.menu,size: 50,),
                  Text('No Users Yet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),));
        },
      ),);
  }
  Widget buildChat(UserModel model,context)=>InkWell(
    onTap: (){
      navigatorTo(context: context, widget: ChatDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children:  [
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                'https://student.valuxapps.com/storage/assets/defaults/user.jpg'),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
                height: 1.3,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ],
      ),
    ),
  );
}
