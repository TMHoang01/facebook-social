part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class LoadGetListFriend extends FriendsEvent {
  LoadGetListFriend();
}

class LoadGetListFriendRequest extends FriendsEvent {
  LoadGetListFriendRequest();
}

class LoadGetListFriendRecommend extends FriendsEvent {
  LoadGetListFriendRecommend();
}

class LoadGetListFriendSearch extends FriendsEvent {
  final String name;
  LoadGetListFriendSearch(this.name);
}

class ReFreshGetListFriendTab extends FriendsEvent {
  ReFreshGetListFriendTab();
}

class ConfirmFriendRequest extends FriendsEvent {
  final String id;
  ConfirmFriendRequest(this.id);
}

class DeleteFriendRequest extends FriendsEvent {
  final String id;
  DeleteFriendRequest(this.id);
}

class UndoFriendRequest extends FriendsEvent {
  final String id;
  UndoFriendRequest(this.id);
}

class SendFriendRequest extends FriendsEvent {
  final String id;
  SendFriendRequest(this.id);
}

class SetAcceptFriendRequest extends FriendsEvent {
  final String id;
  final String isAccept;
  SetAcceptFriendRequest({required this.id, required this.isAccept});
}
