import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitmoni_project/providers/user_provider.dart';
import 'package:digitmoni_project/responsive/mobile_layout.dart';
import 'package:digitmoni_project/responsive/responsive_layout.dart';
import 'package:digitmoni_project/responsive/web_layout.dart';
import 'package:digitmoni_project/screens/login_screen.dart';
import 'package:digitmoni_project/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'adim/widgets/screens/admin_dashboard.dart';
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
  late final DocumentSnapshot snapshot;
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
                    primaryColor: Colors.amber,
                    primarySwatch: Colors.purple),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
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
            ),
          );
        },
      ),
    );
  }

  // Widget checkRole() {
  //   if (snapshot.get('role') == "admin") {
  //     return const AdminPage();
  //   } else {
  //     return const ResponsiveLayout(
  //       mobileScreenLayout: MobileScreenLayout(),
  //       webScreenLayout: WebScreenLayout(),
  //     );
  //   }
  // }
}
