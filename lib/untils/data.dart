import 'package:fb_copy/models/comment_model.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/models/user_model.dart';

PostModel? choosePost;
List<PostModel> posts = [];
List<PostModel> userPosts = [];
List<UserModel> listFriends = [];
List<UserModel> listFriendRequests = [];
String numFriendRequests = '0';
List<UserModel> listFriendSuggests = [];
String numFriendSuggests = '0';
List<PostModel> localPosts = [];
UserModel? userProfile = null;
List<String> historySearch = [];
List<PostModel> searchResult = [];
List<CommentModel> commentOfPost = [];
int indexState = 0;
String stringSearch = '';
List<UserModel> searchUser = [];
List<PostModel> videoData = [];
// List<UserNotification> notifications = [];
// Map<String,Conversation> listConversation = {};

UserModel user1 = UserModel(
  id: '1',
  username: 'Nguyễn Văn A',
  isFriend: '1',
  address: 'Hà Nội',
);
UserModel user2 = UserModel(
  id: '2',
  username: 'Nguyễn Văn B',
  isFriend: '0',
  address: 'Hà Nội',
);
