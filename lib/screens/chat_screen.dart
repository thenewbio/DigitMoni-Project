import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitmoni_project/screens/e2echat_screen.dart';
import 'package:digitmoni_project/screens/onetoonechat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedUser;

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, i) {
                      final users = snapshot.data!.docs;
                      return InkWell(
                        onTap: () {
                          print(users[i].get('uid'));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OneToOneChat(
                                      senderId: users[i].get('uid'))));
                        },
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 10,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 16,
                                ).copyWith(right: 0),
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: NetworkImage(
                                        users[i].get('photoUrl'),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              users[i].get('username'),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              child: Text(users[i].get('bio')),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }))),
    );
  }
}
