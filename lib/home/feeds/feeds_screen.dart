import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/home/comments/comments_screen.dart';
import 'package:social_app/home/cubit/home_cubit.dart';
import 'package:social_app/home/cubit/home_state.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getPosts(),
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context,state){},
        builder: (context,state){
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  margin: EdgeInsetsDirectional.all(10),
                  child: Image(
                    image: NetworkImage('https://img.freepik.com/free-photo/woman-using-smartphone-social-media-conecpt_53876-40967.jpg?t=st=1647704509~exp=1647705109~hmac=f1ae56f2218ca7938f19ae0fbd675b8c6b2e21d3d25548429a500e43f89ce211&w=740'),
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
                ConditionalBuilder(condition:  HomeCubit.get(context).posts.isNotEmpty,
                    builder: (context)=> ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildPost(context,HomeCubit.get(context).posts[index],index),
                        separatorBuilder:(context,index)=> const SizedBox(height: 10,),
                        itemCount: HomeCubit.get(context).posts.length),
                    fallback:(context)=> Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.menu,size: 50,),
                        Text('No Posts Yet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),))

              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPost(context,PostModel post,index)=>Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${post.image}'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        '${post.name}',
                        style: const TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text('${post.dateTime}',
                          style: const TextStyle(
                              height: 1.3, color: Colors.grey))
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz))
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
              '${post.text}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Container(
            //
            //           padding: const EdgeInsetsDirectional.only(end: 10),
            //           height: 25,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //             height: 25,
            //             child: Text(
            //               '#flutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutterflutter',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .caption!
            //                   .copyWith(
            //                   color: Colors.blue, fontSize: 18),
            //             ),
            //           ),
            //         ),
            //         Container(
            //           padding: const EdgeInsetsDirectional.only(end: 10),
            //           height: 25,
            //           child: MaterialButton(
            //             onPressed: () {},
            //             padding: EdgeInsets.zero,
            //             minWidth: 1,
            //             height: 25,
            //             child: Text(
            //               '#flutterflutter',
            //
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .caption!
            //                   .copyWith(
            //                   color: Colors.blue, fontSize: 18),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   height: 200,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       image: const DecorationImage(
            //         fit: BoxFit.cover,
            //         image: NetworkImage(
            //             'https://student.valuxapps.com/storage/assets/defaults/user.jpg'),
            //       )),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.thumb_up,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${HomeCubit.get(context).likes[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.chat_rounded,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'comment',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: Colors.grey, fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey,
              ),
            ),
            Row(
              children:  [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1647433213~exp=1647433813~hmac=334747c3be9988fa4d9ac995fd5d04d36cebd1c4a9d458aeb96781c3c2320987&w=826'),
                        ),
                        SizedBox(width: 10,),
                        Text('Write Comment...',style: TextStyle(fontSize: 15,color: Colors.grey),),
                      ],
                    ),
                    onTap: (){
                      navigatorTo(context: context, widget: CommentsScreen(post));
                    },
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.thumb_up,size: 20,color: Colors.grey,),
                      SizedBox(width: 5,),
                      Text('like',style: TextStyle(fontSize: 15,color: Colors.grey))
                    ],
                  ),
                  onTap: (){
                    HomeCubit.get(context).likePosts(HomeCubit.get(context).postId[index]);
                  },
                )
              ],
            )
          ],
        ),
      ));
}
