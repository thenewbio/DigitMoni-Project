import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitmoni_project/screens/e2echat_screen.dart';
import 'package:digitmoni_project/screens/post_description.dart';
import 'package:digitmoni_project/utils/colors.dart';
import 'package:digitmoni_project/utils/dimensions.dart';
import 'package:digitmoni_project/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
                centerTitle: true,
                title: Text('Flutter'),
                actions: [
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
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PostDescriptionScreen(
                                snap: snapshot.data!.docs[index].data())));
                  },
                  child: PostCard(snap: snapshot.data!.docs[index].data()),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
