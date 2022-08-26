import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitmoni_project/screens/chat_screen.dart';
import 'package:digitmoni_project/utils/colors.dart';
import 'package:digitmoni_project/utils/dimensions.dart';
import 'package:digitmoni_project/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        // backgroundColor:
        //     width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
        appBar: width > webScreenSize
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                // backgroundColor: mobileBackgroundColor,
                centerTitle: false,
                title: Image.asset(
                  'assets/digit.jpg',
                  height: 32,
                ),
                actions: [
                    // IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                    IconButton(
                        icon: Icon(themeNotifier.isDark
                            ? Icons.nightlight_round
                            : Icons.wb_sunny),
                        onPressed: () {
                          themeNotifier.isDark
                              ? themeNotifier.isDark = false
                              : themeNotifier.isDark = true;
                        }),
                    SizedBox(width: 20),
                  ]),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width > webScreenSize ? width * 0.3 : 0,
                  vertical: width > webScreenSize ? 15 : 0,
                ),
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

// class BadgeNotification extends StatelessWidget {
//   const BadgeNotification({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//           builder: (context, snapshot) {
//             return InkWell(
//               onTap: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (_) => Chat()));
//               },
//               child: Stack(
//                 children: <Widget>[
//                   const Icon(
//                     Icons.message,
//                     size: 38,
//                   ),
//                   Positioned(
//                     top: 3,
//                     right: 3,
//                     child: Container(
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 12,
//                         minHeight: 12,
//                       ),
//                       child: Text(
//                         '${snapshot.data!.docs.length.toInt()}',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 9,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
// }