import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste_gb/bloc/bloc_provider.dart';
import 'package:teste_gb/bloc/feed_bloc.dart';
import 'package:teste_gb/components/dialog_popup.dart';
import 'package:teste_gb/components/text_editor_popup.dart';
import 'package:teste_gb/elements/loader_element.dart';
import 'package:teste_gb/model/post.dart';
import 'package:teste_gb/model/post_response.dart';
import 'package:teste_gb/util/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:teste_gb/style/theme.dart' as Style;

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
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildPostItem(BuildContext context, Post postData, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        color: Colors.grey[100],
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
                postData.user.id,
                postData.user.name,
                postData.message.createdAt,
                postData.message.content,
                index,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String userName, String profilePictureUrl) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              userName,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(100.0)),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Icon(EvaIcons.person, color: Colors.grey,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(String content) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                AutoSizeText(
                  content,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  maxFontSize: 13,
                  minFontSize: 12,
                  style: GoogleFonts.roboto(color: Colors.grey),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(int userId, String createdAt, String userName,
      String content, int index) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      userId == 2
          ? Expanded(
              child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TextEditorPopup(
                            cancelButtonCallback: () => Navigator.pop(context),
                            onDispose: () => feedBloc.clearValidator(),
                            onTextChange: feedBloc.updateTextInputData,
                            validatedTextStream: feedBloc.textInputDataStream,
                            confirmButtonCallback: () =>
                                feedBloc.editPost(index),
                            oldText: content,
                          );
                        }),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Icon(
                            EvaIcons.edit,
                            size: 16,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
                Positioned(
                  right: 120,
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => feedBloc.deletePost(index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(
                                    color: Colors.grey[100], width: 0.8),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Icon(
                              EvaIcons.trash2,
                              size: 16,
                              color: Colors.grey,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          : Container(),
      Container(
        margin: EdgeInsets.only(top: 8, left: 8),
        alignment: Alignment.center,
        child: Text(
          timeUntil(DateTime.now()),
          style: GoogleFonts.roboto(fontSize: 10, color: Colors.grey),
        ),
      ),
    ]);
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }

  Widget _buildButton() {
    return Container(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(backgroundColor: Style.MyColors.greenColor,
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
