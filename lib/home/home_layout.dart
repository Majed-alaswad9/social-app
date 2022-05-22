
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/home/new_posts/new_post_screen.dart';
import 'package:social_app/shared/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>HomeCubit()..getUserData()..getPosts(),
    child: BlocConsumer<HomeCubit,HomeState>(
      listener: (context,state){
        if(state is NewPostState){
          navigatorTo(context: context, widget: NewPostScreen());
        }
      },
      builder: (context,state){
        var cubit=HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: Text(cubit.title[cubit.indexBottom]),actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.notification_important)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            const SizedBox(width: 10,)

          ],),
          body: cubit.bottomNavItem[cubit.indexBottom],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.indexBottom,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add_sharp), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'setting'),
            ],
          ));
      },
    ),
    );
  }
}
