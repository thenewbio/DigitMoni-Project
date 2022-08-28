import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digitmoni_project/models/user.dart' as model;
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../utils/pick_utils.dart';
import 'e2echat_screen.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedUser;

class OneToOneChat extends StatefulWidget {
  final String senderId;
  const OneToOneChat({required this.senderId, Key? key}) : super(key: key);

  @override
  State<OneToOneChat> createState() => _OneToOneChatState();
}

class _OneToOneChatState extends State<OneToOneChat> {
  final _auth = FirebaseAuth.instance;
  final _textController = TextEditingController();

  late String text;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat Me'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('Me')
                    .doc(loggedUser!.uid)
                    .collection(widget.senderId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final messages = snapshot.data!.docs.reversed;
                  List<ChatBubble> messagesWidget = [];
                  for (var message in messages) {
                    final chatText = message.get('message');
                    final chatSender = message.get('username');
                    final chatEmail = message.get('sender');
                    final user = FirebaseAuth.instance.currentUser!.email;
                    if (user != chatEmail) {}
                    final chatWidget =
                        ChatBubble(chatText, chatSender, user != chatEmail);
                    messagesWidget.add(chatWidget);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      children: messagesWidget,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore
                          .collection('Me')
                          .doc(loggedUser!.uid)
                          .collection(widget.senderId)
                          .add({
                        'message': text,
                        'sender': _auth.currentUser!.email,
                        'username': user.username,
                      });
                      // _firestore.collection('chats').add({
                      //   'message': text,
                      //   'sender': _auth.currentUser!.email,
                      //   'username': user.username,
                      // });
                      _textController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
