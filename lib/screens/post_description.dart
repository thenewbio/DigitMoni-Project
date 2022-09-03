import '/helper_class.dart';
import 'package:flutter/material.dart';
import 'package:digitmoni_project/models/user.dart' as model;

class PostDescriptionScreen extends StatefulWidget {
  final dynamic snap;
  const PostDescriptionScreen({required this.snap, Key? key}) : super(key: key);

  @override
  State<PostDescriptionScreen> createState() => _PostDescriptionScreenState();
}

class _PostDescriptionScreenState extends State<PostDescriptionScreen> {
  int commentLen = 0;

  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot? snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios)),
            // HEADER SECTION OF THE POST
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      '${widget.snap['profImage']}',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.snap['username']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: Text(
                              DateFormat.yMMMd().format(
                                  widget.snap['datePublished'].toDate()),
                              style: const TextStyle(
                                  // color: secondaryColor,
                                  ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // IMAGE SECTION OF THE POST
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fadeInCurve: Curves.easeIn,
                    fadeInDuration: Duration(seconds: 5),
                    fit: BoxFit.fill,
                    imageUrl: widget.snap['postUrl'],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      color: Colors.blueGrey,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ],
            ),

            // LIKE, COMMENT SECTION OF THE POST
            Row(
              children: <Widget>[
                IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () => FireStoreMethods().likePost(
                    widget.snap['postId'].toString(),
                    user.uid,
                    widget.snap['likes'],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: widget.snap['postId'].toString(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //DESCRIPTION AND NUMBER OF COMMENTS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w800),
                      child: Text(
                        '${widget.snap['likes'].length} likes',
                        // style: Theme.of(context).textTheme.bodyText2,
                      )),
                  InkWell(
                    child: Container(
                      child: Text(
                        'View all $commentLen comments',
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                          postId: widget.snap['postId'].toString(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      ' ${widget.snap['description']}',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
