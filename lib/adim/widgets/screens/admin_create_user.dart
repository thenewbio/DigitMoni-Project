// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:digitmoni_project/resources/auth_method.dart';
// import 'package:digitmoni_project/responsive/responsive_layout.dart';
// import 'package:digitmoni_project/screens/login_screen.dart';
// import 'package:digitmoni_project/utils/colors.dart';
// import 'package:digitmoni_project/utils/pick_utils.dart';
// import 'package:digitmoni_project/widgets/text_input_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateUser extends StatefulWidget {
//   const CreateUser({Key? key}) : super(key: key);

//   @override
//   _CreateUserState createState() => _CreateUserState();
// }

// class _CreateUserState extends State<CreateUser> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//   Uint8List? _image;

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _usernameController.dispose();
//   }

//   void signUpUser() async {
//     // set loading to true
//     setState(() {
//       _isLoading = true;
//     });

//     // signup user using our authmethodds
//     String res = await AuthMethods().signUpUser(
//         email: _emailController.text,
//         password: _passwordController.text,
//         username: _usernameController.text,
//         file: _image!,
//         role: 'admin');
//     // if string returned is sucess, user has been created
//     if (res == "success") {
//       print('success');
//       Navigator.of(context).pop();
//       setState(() {
//         _isLoading = false;
//       });
//       // navigate to the home screen

//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       // Navigator.of(context)
//       //     .push(MaterialPageRoute(builder: (_) => const AdminPage()));
//       // show the error
//       showSnackBar(context, res);
//     }
//   }

//   selectImage() async {
//     Uint8List im = await pickImage(ImageSource.gallery);
//     // set state because we need to display the image we selected on the circle avatar
//     setState(() {
//       _image = im;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create User'),
//         centerTitle: true,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//               // image: DecorationImage(
//               //     fit: BoxFit.fill, image: AssetImage('assets/digit.jpg'))
//               ),
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Container(),
//                 flex: 1,
//               ),
//               Stack(
//                 children: [
//                   _image != null
//                       ? CircleAvatar(
//                           radius: 64,
//                           backgroundImage: MemoryImage(_image!),
//                           backgroundColor: Colors.red,
//                         )
//                       : const CircleAvatar(
//                           radius: 64,
//                           backgroundImage: NetworkImage(
//                               'https://i.stack.imgur.com/l60Hf.png'),
//                           backgroundColor: Colors.red,
//                         ),
//                   Positioned(
//                     bottom: -10,
//                     left: 80,
//                     child: IconButton(
//                       onPressed: selectImage,
//                       icon: const Icon(
//                         Icons.add_a_photo,
//                         color: Colors.black38,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your username',
//                 textInputType: TextInputType.text,
//                 textEditingController: _usernameController,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your email',
//                 textInputType: TextInputType.emailAddress,
//                 textEditingController: _emailController,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your password',
//                 textInputType: TextInputType.text,
//                 textEditingController: _passwordController,
//                 isPass: true,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               InkWell(
//                 child: Container(
//                   child: !_isLoading
//                       ? const Text(
//                           'Create',
//                         )
//                       : const CircularProgressIndicator(
//                           color: primaryColor,
//                         ),
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: const ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                     ),
//                     color: mobileBackgroundColor,
//                   ),
//                 ),
//                 onTap: signUpUser,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
