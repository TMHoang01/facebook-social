part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  FriendsLoaded();
}

class FriendsError extends FriendsState {
  final String message;

  FriendsError(this.message);
}
