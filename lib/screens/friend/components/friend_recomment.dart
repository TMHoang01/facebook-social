import 'package:fb_copy/blocs/friends/friends_bloc.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/untils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fb_copy/widgets/profile_avatar.dart';

class FriendRecommend extends StatefulWidget {
  final UserModel user;

  const FriendRecommend({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendRecommendState(user);
  }
}

class _FriendRecommendState extends State<FriendRecommend> {
  int? isRequest;
  final UserModel user;

  _FriendRecommendState(this.user);

  late FriendsBloc _friendsBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isRequest = 0;
    _friendsBloc = BlocProvider.of<FriendsBloc>(context);
  }

  void _request() {
    setState(() {
      isRequest = 1;
      print('decrement: $isRequest');
    });
  }

  void _undo() {
    setState(() {
      isRequest = 0;
      print('decrement: $isRequest');
    });
  }

  void _delete() {
    setState(() {
      isRequest = 2;
      numFriendSuggests = (int.parse(numFriendSuggests) - 1).toString();
      print('increment: $isRequest');
    });
  }

  @override
  Widget build(BuildContext context) {
    var avt =
        'https://firebasestorage.googleapis.com/v0/b/savvy-celerity-368016.appspot.com/o/avatar_default.png?alt=media';
    return isRequest != 2
        ? InkWell(
            child: Row(
              children: <Widget>[
                // CircleAvatar(
                //   backgroundImage: CachedNetworkImageProvider(avt),
                //   radius: 30.0,
                // ),
                ProfileAvatar(
                  avatar: user.avatar,
                  // isActive: true,
                  // hasBorder: true,
                  radius: 36.0,
                ),
                const SizedBox(width: 14.0),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(user.username ?? "Người dùng FaceBook",
                          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3.0),
                      user.sameFriends != '0'
                          ? Text('${user.sameFriends} bạn chung',
                              style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal))
                          : const SizedBox(),
                      const SizedBox(height: 3.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          isRequest == 0
                              ? InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    decoration:
                                        BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
                                    child: const Text('Thêm bạn bè',
                                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                                  ),
                                  onTap: () {
                                    // _friendsBloc.SendFriendRequest(user.id);
                                    _friendsBloc.add(SendFriendRequest(user.id!));
                                    _request();
                                  },
                                )
                              : InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    decoration:
                                        BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
                                    child: const Text('Hủy lời mời',
                                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                                  ),
                                  onTap: () {
                                    // _friend_bloc.undoFriendRequest(user.id);
                                    _friendsBloc.add(UndoFriendRequest(user.id!));
                                    _undo();
                                  },
                                ),
                          const SizedBox(width: 10.0),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                              decoration:
                                  BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5.0)),
                              child: const Text('Gỡ', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                            ),
                            onTap: () {
                              _delete();
                            },
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
                // SizedBox(height: 20.0),
              ],
            ),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return ProfileUser(
              //     id: user.id,
              //     username: user.username,
              //   );
              // }));
            },
          )
        : SizedBox();
  }
}
