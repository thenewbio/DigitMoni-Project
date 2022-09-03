import 'package:flutter/material.dart';
import 'package:digitmoni_project/helper_class.dart';

class BadgeNotification extends StatelessWidget {
  const BadgeNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Chat()));
              },
              child: Stack(
                children: <Widget>[
                  const Icon(
                    Icons.message,
                    size: 38,
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${snapshot.data!.docs.length.toInt()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
