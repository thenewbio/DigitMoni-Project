import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitmoni_project/providers/user_provider.dart';
import 'package:digitmoni_project/responsive/mobile_layout.dart';
import 'package:digitmoni_project/responsive/responsive_layout.dart';
import 'package:digitmoni_project/responsive/web_layout.dart';
import 'package:digitmoni_project/screens/login_screen.dart';
import 'package:digitmoni_project/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCiawbGsZjm03nLPwmvX0YFtO_41D_p7iU",
            authDomain: "phonic-monolith-333903.firebaseapp.com",
            appId: "1:663960199514:web:a8517738914edc6a421363",
            messagingSenderId: "663960199514",
            projectId: "phonic-monolith-333903",
            storageBucket: "phonic-monolith-333903.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ModelTheme()),
      ],
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter',
              theme: themeNotifier.isDark
                  ? ThemeData(
                      brightness: Brightness.dark,
                    )
                  : ThemeData(
                      brightness: Brightness.light,
                      // primaryColor: Colors.black,
                    ),
              home: const AnimatedSplashScreen());
        },
      ),
    );
  }
}
