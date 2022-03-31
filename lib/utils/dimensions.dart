import 'package:digitmoni_project/screens/addpost_screen.dart';
import 'package:digitmoni_project/screens/posts_screen.dart';
import 'package:digitmoni_project/screens/profile_screen.dart';
import 'package:digitmoni_project/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
