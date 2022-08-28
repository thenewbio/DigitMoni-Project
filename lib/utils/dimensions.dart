import 'package:digitmoni_project/screens/addpost_screen.dart';
import 'package:digitmoni_project/screens/chat_screen.dart';
import 'package:digitmoni_project/screens/e2echat_screen.dart';
import 'package:digitmoni_project/screens/onetoonechat.dart';
import 'package:digitmoni_project/screens/posts_screen.dart';
import 'package:digitmoni_project/screens/profile_screen.dart';
import 'package:digitmoni_project/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;
final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Chat(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
