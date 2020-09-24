import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_gb/bloc/bloc_provider.dart';
import 'package:teste_gb/bloc/feed_bloc.dart';
import 'package:teste_gb/components/dialog_popup.dart';
import 'package:teste_gb/components/text_editor_popup.dart';
import 'package:teste_gb/model/post.dart';
import 'package:teste_gb/model/post_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FeedBloc feedBloc;
  Size deviceSize;
  PostResponse feedData;

  @override
  void initState() {
    feedBloc = BlocProvider.of<FeedBloc>(context);

    feedBloc.generatePosts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (deviceSize == null) deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: _buildButton(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildPostList(),
        ],
      ),
    );
  }

  Widget _buildPostList() {
    return StreamBuilder<PostResponse>(
      stream: feedBloc.feedDataStream,
      builder: (BuildContext context, AsyncSnapshot<PostResponse> snapshot) {
        if (snapshot.hasData) {
          List<Post> postList = snapshot.data.feedPosts;

          return Expanded(
            child: ListView.builder(
              itemCount: postList.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildPostItem(context, postList[index], index),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          );
        }
      },
    );
  }

  Widget _buildPostItem(BuildContext context, Post postData, int index) {
    return Container(
      color: Colors.grey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        width: deviceSize.width,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo(
                  postData.user.name,
                  postData.user.profilePicture,
                ),
                _buildContentSection(postData.message.content)
              ],
            ),
            _buildBottomSection(
              postData.user.name,
              postData.message.createdAt,
              postData.message.content,
              index,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String userName, String profilePictureUrl) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.8),
                  borderRadius: BorderRadius.circular(5.0)),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  profilePictureUrl,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            userName,
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(String content) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              AutoSizeText(
                content,
                textAlign: TextAlign.justify,
                softWrap: true,
                maxFontSize: 12,
                minFontSize: 10,
                style: GoogleFonts.montserrat(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(
      String createdAt, String userName, String content, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        index == 0  ?
    Expanded(
                child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return TextEditorPopup(
                              cancelButtonCallback: () =>
                                  Navigator.pop(context),
                              onDispose: () => feedBloc.clearValidator(),
                              onTextChange: feedBloc.updateTextInputData,
                              validatedTextStream: feedBloc.textInputDataStream,
                              confirmButtonCallback: () =>
                                  feedBloc.editPost(index),
                              oldText: content,
                            );
                          }),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 0.8),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => feedBloc.deletePost(index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 0.8),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Icon(
                              Icons.delete,
                              size: 16,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ))
            : Container(),
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 12),
          alignment: Alignment.bottomRight,
          child: Text(
            timeUntil(DateTime.parse("2020-02-22T11:00:33Z")),
            style: GoogleFonts.montserrat(fontSize: 9, color: Colors.blueGrey),
          ),
        )
    ]);

  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }

  Widget _buildButton() {
    return Container(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogPopup(
                      cancelButtonCallback: () {
                        Navigator.of(context).pop(null);
                      },
                      onTextChange: feedBloc.updateTextInputData,
                      confirmButtonCallback: feedBloc.createsPost,
                      onDispose: () {
                        feedBloc.clearValidator();
                      },
                      validatedTextStream: feedBloc.textInputDataStream);
                })));
  }
}
