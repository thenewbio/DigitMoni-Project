// import 'package:digitmoni_project/adim/widgets/screens/admin_screen.dart';
// import 'package:digitmoni_project/responsive/mobile_layout.dart';
// import 'package:digitmoni_project/responsive/web_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';

// import 'admin_create_user.dart';

// class SamplePage extends StatelessWidget {
//   const SamplePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AdminScaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Admin Home'),
//           centerTitle: true,
//         ),
//         sideBar: SideBar(
//           items: const [
//             AdminMenuItem(
//               title: 'Dashboard',
//               route: '/',
//               icon: Icons.dashboard,
//             ),
//             AdminMenuItem(
//                 title: 'Settings', icon: Icons.settings, route: '/setting'),
//             AdminMenuItem(
//                 icon: Icons.block_flipped,
//                 title: 'Create user',
//                 route: '/user'),
//             AdminMenuItem(
//                 icon: Icons.block_flipped,
//                 title: 'Block user',
//                 route: '/block'),
//             AdminMenuItem(
//               icon: Icons.check_box,
//               title: 'Activate user',
//               route: '/act',
//             ),
//             AdminMenuItem(
//               icon: Icons.logout,
//               title: 'Logout',
//               route: '/logout',
//             ),
//           ],
//           selectedRoute: '/',
//           onSelected: (item) {
//             switch (item.route) {
//               case '/':
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (_) => const AdminScreen()));
//                 break;
//               case '/setting':
//                 return;
//               case '/post':
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (_) => const AdminScreen()));
//                 break;
//               case '/user':
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (_) => const CreateUser()));
//                 break;
//               case '/block':
//                 return;
//               case '/act':
//                 return;
//               case '/logout':
//                 return;
//             }
//           },
//           header: Container(
//             height: 50,
//             width: double.infinity,
//             color: const Color(0xff444444),
//             child: const Center(
//                 child: CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.white,
//             )),
//           ),
//           footer: Container(
//             height: 50,
//             width: double.infinity,
//             color: const Color(0xff444444),
//             child: const Center(
//               child: Text(
//                 'Manager.IO',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: const AdminScreen());
//   }
// }
