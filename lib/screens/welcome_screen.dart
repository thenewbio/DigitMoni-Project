import 'package:firebase_auth/firebase_auth.dart' as user;
import 'package:flutter/material.dart';
import '/helper_class.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<user.User?>(
      stream: user.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // Checking if the snapshot has any data or not
          if (snapshot.hasData) {
            // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
            return const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }

        // means connection to future hasnt been made yet
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const LoginScreen();
      },
    );
  }
}
