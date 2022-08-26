import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitmoni_project/resources/storage_method.dart';
import 'package:digitmoni_project/utils/pick_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:digitmoni_project/models/user.dart' as model;
import '../providers/user_provider.dart';

class EditPost extends StatefulWidget {
  // final String image;
  final String desc;
  const EditPost({
    Key? key,
    // required this.image,
    required this.desc,
  }) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  Uint8List? _file;
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _file == null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: MemoryImage(_file!),
                          backgroundColor: Colors.red,
                        )
                      : CircleAvatar(
                          radius: 70,
                          // backgroundImage: NetworkImage(widget.image),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black38,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: widget.desc,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: editPost, child: const Text('Update Post'))
            ],
          ),
        ),
      ),
    );
  }

  selectImage() {
    Uint8List img = pickImage(ImageSource.gallery);
    setState(() {
      _file = img;
    });
  }

  void editPost() async {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    Map<String, dynamic> snap = {};
    if (_file != null) {
      String url =
          await StorageMethods().uploadImageToStorage('posts', _file!, false);
      snap["postUrl"] = url;
    }
    snap['description'] = _descController.text;
    FirebaseFirestore.instance.collection('posts').doc(user.uid).update(snap);
    Navigator.of(context).pop();
  }
}
