import 'package:rxdart/rxdart.dart';
import 'package:teste_gb/bloc/bloc_provider.dart';
import 'package:teste_gb/model/message.dart';
import 'package:teste_gb/model/post.dart';
import 'package:teste_gb/model/post_response.dart';
import 'package:teste_gb/model/user.dart';
import 'package:teste_gb/util/constants.dart';
import 'package:timeago/timeago.dart' as timeago;



class FeedBloc implements BlocBase {

  List<Post> feedPostList = [];

  final _feedDataController = BehaviorSubject<PostResponse>();
  final _textInputController = BehaviorSubject<String>();

  Function(PostResponse) get updateFeedData =>
          (data) {
        _feedDataController.sink.add(data);
        feedPostList = data.feedPosts;
      };

  Function(String) get updateTextInputData => _textInputController.sink.add;

  Stream<PostResponse> get feedDataStream => _feedDataController.stream;

  Stream<String> get textInputDataStream => _textInputController.stream;

  Future<void> generatePosts() async {
    if (feedPostList.isEmpty) {
      feedPostList = [
        Post(User(1,Constants.NAME_ONE, Constants.PLACEHOLDER), Message(Constants.MESSAGE_ONE, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_TWO, Constants.PLACEHOLDER), Message(Constants.MESSAGE_TWO, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_THREE, Constants.PLACEHOLDER), Message(Constants.MESSAGE_THREE, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_FIVE, Constants.PLACEHOLDER), Message(Constants.MESSAGE_FOUR, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_FOUR, Constants.PLACEHOLDER), Message(Constants.MESSAGE_FIVE, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_SIX, Constants.PLACEHOLDER), Message(Constants.MESSAGE_SIX, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_SEVEN, Constants.PLACEHOLDER), Message(Constants.MESSAGE_SEVEN, "2020-02-22T11:00:33Z")),
        Post(User(1,Constants.NAME_EIGHT, Constants.PLACEHOLDER), Message(Constants.MESSAGE_EIGHT, "2020-02-22T11:00:33Z")),
      ];
      return Future.delayed(Duration(seconds: 2), () => updateFeedData(PostResponse(feedPostList)));
    } else {
      return;
    }
  }

  void createsPost(){
    Post newPost = Post(User(2, Constants.MY_NAME, Constants.PLACEHOLDER), Message(_textInputController.value, "${DateTime.now()}"));
    feedPostList.insert(0, newPost);
    updateFeedData(PostResponse(feedPostList));
    clearValidator();
  }

  void editPost(int index) {
    feedPostList[index].message.content = _textInputController.value;
    updateFeedData(PostResponse(feedPostList));
    clearValidator();
  }

  void deletePost(int index){
    feedPostList.removeAt(index);
    updateFeedData(PostResponse(feedPostList));
  }

  void clearValidator(){
    updateTextInputData(null);
  }


  @override
  void dispose() {
    _feedDataController.close();
    _textInputController.close();
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }


}