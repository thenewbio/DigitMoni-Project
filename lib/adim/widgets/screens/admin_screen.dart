// import 'package:digitmoni_project/utils/colors.dart';
// import 'package:digitmoni_project/utils/dimensions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class AdminScreen extends StatefulWidget {
//   const AdminScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminScreen> createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   int _page = 0;
//   late PageController pageController; // for tabs animation

//   @override
//   void initState() {
//     super.initState();
//     pageController = PageController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     pageController.dispose();
//   }

//   void onPageChanged(int page) {
//     setState(() {
//       _page = page;
//     });
//   }

//   void navigationTapped(int page) {
//     //Animating Page
//     pageController.jumpToPage(page);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         physics: const NeverScrollableScrollPhysics(),
//         children: adminScreen,
//         controller: pageController,
//         onPageChanged: onPageChanged,
//       ),
//       bottomNavigationBar: CupertinoTabBar(
//         backgroundColor: mobileBackgroundColor,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               color: (_page == 0) ? primaryColor : secondaryColor,
//             ),
//             label: 'Home',
//             backgroundColor: primaryColor,
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.add_circle,
//                 color: (_page == 1) ? primaryColor : secondaryColor,
//               ),
//               label: 'Add Post',
//               backgroundColor: primaryColor),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.person,
//               color: (_page == 2) ? primaryColor : secondaryColor,
//             ),
//             label: 'Profile',
//             backgroundColor: primaryColor,
//           ),
//         ],
//         onTap: navigationTapped,
//         currentIndex: _page,
//       ),
//     );
//   }
// }
