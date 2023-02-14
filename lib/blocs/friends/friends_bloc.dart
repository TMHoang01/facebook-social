import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/friendrespository.dart';
import 'package:fb_copy/untils/data.dart';
import 'package:logger/logger.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsRespository friendsRespository;
  static const count = 10;
  FriendsBloc(this.friendsRespository) : super(FriendsInitial()) {
    on<FriendsEvent>((event, emit) {});
    on<LoadGetListFriend>(_loadGetListFriend);
    on<LoadGetListFriendRequest>(_loadGetListFriendRequest);
    on<LoadGetListFriendRecommend>(_loadGetListFriendRecommend);
    on<SetAcceptFriendRequest>(_setAcceptFriendRequest);
    on<SendFriendRequest>(_setRequestFriend);
    // on<ConfirmFriendRequest>(_confirmFriendRequest);
  }

  FutureOr<void> _loadGetListFriend(LoadGetListFriend event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      emit(FriendsLoaded());
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  FutureOr<void> _loadGetListFriendRequest(LoadGetListFriendRequest event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      final ApiResponse response =
          await friendsRespository.getRequestedFriends(listFriendRequests.length.toString(), count.toString());

      Logger().d('_loadGetListFriendRequest ' + response.data.toString());
      if (response.code == '1000') {
        final Map<String, dynamic> data = response.data ?? <String, dynamic>{};
        List? newListData = data['request'] as List<dynamic>?;
        // Logger().d(newListData);
        numFriendRequests = data['total'];
        listFriendRequests = List.from(listFriendRequests)
          ..addAll(newListData!.map((e) => UserModel.fromJson(e as Map<String, dynamic>)));
        emit(FriendsLoaded());
      } else if (response.code == '9994') {
        // not list friend request
        emit(FriendsLoaded());
        // emit(FriendsError(response.message.toString()));
      } else {
        emit(FriendsError(response.message.toString()));
      }
    } catch (e) {
      print(e);
      emit(FriendsError(e.toString()));
    }
  }

  FutureOr<void> _loadGetListFriendRecommend(LoadGetListFriendRecommend event, Emitter<FriendsState> emit) async {
    emit(FriendsLoading());
    try {
      final ApiResponse response =
          await friendsRespository.getListSuggestedFriends(listFriendSuggests.length.toString(), count.toString());
      // Logger().d(response.data);
      if (response.code == '1000') {
        final Map<String, dynamic> data = response.data ?? <String, dynamic>{};
        List? newListData = data['list_users'] as List<dynamic>?;
        // Logger().d(newListData);
        numFriendSuggests = data['total'];
        listFriendSuggests = List.from(listFriendSuggests)
          ..addAll(newListData!.map((e) => UserModel.fromJson(e as Map<String, dynamic>)));
        emit(FriendsLoaded());
      } else {
        emit(FriendsError(response.message.toString()));
      }
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  FutureOr<void> _setRequestFriend(SendFriendRequest event, Emitter<FriendsState> emit) async {
    final id = event.id;
    print('_setRequestFriend  id: $id');
    try {
      // emit(FriendsLoading());
      final ApiResponse response = await friendsRespository.setRequestFriend(id);
      Logger().d(response);
      if (response.code == '1000') {
        // emit(FriendsLoaded());
      } else if (response.code == '1005') {
        // emit(FriendsError(response.message.toString()));
        // remove id
        listFriendSuggests.removeWhere((element) => element.id == id);
      } else {}
      // emit(FriendsLoaded());
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }

  // FutureOr<void> _confirmFriendRequest(ConfirmFriendRequest event, Emitter<FriendsState> emit) {}

  FutureOr<void> _setAcceptFriendRequest(SetAcceptFriendRequest event, Emitter<FriendsState> emit) async {
    final id = event.id;
    final isAccept = event.isAccept;
    print('_setAcceptFriendRequest  id: $id isAccept: $isAccept');
    try {
      // emit(FriendsLoading());
      final ApiResponse response = await friendsRespository.setAcceptFriend(id, isAccept);
      Logger().d(response);
      if (response.code == '1000') {
        // emit(FriendsLoaded());
      } else if (response.code == '1005') {
        // emit(FriendsError(response.message.toString()));
        // listFriendRequests.removeWhere((element) => element.id == id);
      } else {}
      // emit(FriendsLoaded());
    } catch (e) {
      emit(FriendsError(e.toString()));
    }
  }
}
