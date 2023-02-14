import 'package:fb_copy/blocs/friends/friends_bloc.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/screens/error_connect.dart';
import 'package:fb_copy/screens/friend/components/friend_recomment.dart';
import 'package:fb_copy/screens/friend/components/friend_request.dart';
import 'package:fb_copy/untils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class FriendsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendsTabState();
  }
}

class _FriendsTabState extends State<FriendsTab> {
  late FriendsBloc _friendsBloc;
  @override
  void initState() {
    _friendsBloc = BlocProvider.of<FriendsBloc>(context)
      // ..add(LoadGetListFriendRequest())
      ..add(LoadGetListFriendRecommend());
    _friendsBloc.add(LoadGetListFriendRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _friendsBloc.add(ReFreshGetListFriendTab());
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Bạn bè', style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15.0),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30.0)),
                    child: const Text('Gợi ý', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30.0)),
                    child: const Text('Bạn bè', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<FriendsBloc, FriendsState>(
                buildWhen: (previous, current) {
                  if (current is FriendsLoaded && previous is FriendsLoading) {
                    return true;
                  }
                  if (current is FriendsError || current is FriendsLoading) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is FriendsInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FriendsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FriendsLoaded) {
                    return Column(
                      children: [
                        if (listFriendRequests.length != 0) ListFriendRequestsWidget(),
                        ContainterListSuggestFriend(),
                      ],
                    );
                  } else if (state is FriendsError) {
                    return ErrorConnect(
                      onTap: () {
                        _friendsBloc.add(LoadGetListFriendRequest());
                        _friendsBloc.add(LoadGetListFriendRecommend());
                      },
                    );
                  } else {
                    return ErrorConnect(
                      onTap: () {
                        _friendsBloc.add(LoadGetListFriendRequest());
                        _friendsBloc.add(LoadGetListFriendRecommend());
                      },
                    );
                  }
                },
              ),
              // const Divider(height: 30.0, thickness: 1.2),
            ],
          ),
        ),
      ),
    );
  }
}

class ListFriendRequestsWidget extends StatelessWidget {
  const ListFriendRequestsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 30.0, thickness: 1.2),
        Row(
          children: <Widget>[
            InkWell(
              child: const Text('Lời mời kết bạn', style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
              onTap: () {
                // updateStateFriendRequestContainer();
                // print("tap");
              },
            ),
            const SizedBox(width: 10.0),
            Text(numFriendRequests == 0 ? '0' : listFriendRequests.length.toString(),
                style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.red)),
          ],
        ),
        const SizedBox(height: 10),
        // BlocBuilder<FriendsBloc, FriendsState>(
        //   builder: (context, state) {
        //     if (state is FriendsLoading || state is FriendsInitial) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (state is FriendsLoaded) {
        //       return ListBody(
        //         children: listFriendRequests.map((user) => FriendRequest(user: user)).toList(),
        //       );
        //     } else if (state is FriendsError) {
        //       return ErrorConnect();
        //     }
        //     return Container();
        //   },
        // ),
        ListBody(
          children: listFriendRequests.map((user) => FriendRequest(user: user)).toList(),
        ),
      ],
    );
  }
}

class ContainterListSuggestFriend extends StatelessWidget {
  const ContainterListSuggestFriend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Divider(height: 30.0),
          Row(
            children: <Widget>[
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('Những người bạn có thể biết',
                      style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  // updateStateFriendRequestContainer();
                  // print("tap");
                },
              ),
              const SizedBox(width: 10.0),
              Text(numFriendSuggests,
                  style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.red)),
              // Text(friendRequest == 0 ? '0' : listFriendRequests.length.toString(),
              //     style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: Colors.red)),
            ],
          ),
          const SizedBox(width: 20.0),
          ListBody(
            children: listFriendSuggests.map((user) => FriendRecommend(user: user)).toList(),
          ),
          // Container(
          //   child: BlocBuilder<FriendsBloc, FriendsState>(
          //     builder: (context, state) {
          //       if (state is FriendsInitial) {
          //         return const Center(
          //           child: Text('Initial'),
          //         );
          //       } else if (state is FriendsLoading) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       } else if (state is FriendsLoaded) {
          //         return ListBody(
          //           children: listFriendSuggests.map((user) => FriendRecommend(user: user)).toList(),
          //         );
          //       } else if (state is FriendsError) {
          //         return ErrorConnect();
          //       }
          //       return Container();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
