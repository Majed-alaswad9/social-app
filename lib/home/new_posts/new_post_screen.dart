import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          TextButton(onPressed: (){}, child:const Text('POST',style: TextStyle(fontSize: 17),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: const [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://student.valuxapps.com/storage/assets/defaults/user.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Majed Alaswad',
                    style: TextStyle(
                        height: 1.3, fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?', border: InputBorder.none),
            )),
            Row(
              children: [
                Expanded(
                    child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: const Text(
                    'Add Photo',
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
    );
  }
}
