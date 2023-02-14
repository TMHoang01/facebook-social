// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/blocs/friends/friends_bloc.dart';
import 'package:fb_copy/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendRequest extends StatefulWidget {
  final UserModel user;

  const FriendRequest({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FriendRequestState(user);
  }
}

class _FriendRequestState extends State<FriendRequest> {
  int? isAccept;
  final UserModel user;

  _FriendRequestState(this.user);
  late FriendsBloc _friendsBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _friendsBloc = BlocProvider.of<FriendsBloc>(context);
    isAccept = 0;
  }

  void _accept() {
    setState(() {
      isAccept = 1;
      print('decrement: $isAccept');
    });
  }

  void _delete() {
    setState(() {
      isAccept = 2;
      print('increment: $isAccept');
    });
  }

  @override
  Widget build(BuildContext context) {
    var avt =
        'https://firebasestorage.googleapis.com/v0/b/savvy-celerity-368016.appspot.com/o/avatar_default.png?alt=media';
    return InkWell(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(avt),
            radius: 30.0,
          ),
          const SizedBox(width: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.username ?? "Người dùng FaceBook",
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              isAccept == 0
                  ? Row(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
                            child: const Text('Xác nhận', style: TextStyle(color: Colors.white, fontSize: 15.0)),
                          ),
                          onTap: () {
                            _friendsBloc.add(SetAcceptFriendRequest(id: user.id.toString(), isAccept: "1"));
                            _accept();
                          },
                        ),
                        const SizedBox(width: 10.0),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            decoration:
                                BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5.0)),
                            child: const Text('Xóa lời mời', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                          ),
                          onTap: () {
                            _friendsBloc.add(SetAcceptFriendRequest(id: user.id.toString(), isAccept: "0"));

                            _delete();
                          },
                        ),
                      ],
                    )
                  : isAccept == 2
                      ? Row(
                          children: const <Widget>[
                            Text('Đã xóa lời mời', style: TextStyle(fontSize: 16, color: AppColor.kColorButton))
                          ],
                        )
                      : Row(
                          children: const <Widget>[
                            Text('Đã chấp nhận lời mời', style: TextStyle(fontSize: 16, color: AppColor.kColorButton))
                          ],
                        ),
              const SizedBox(height: 15.0),
            ],
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
    );
  }
}
