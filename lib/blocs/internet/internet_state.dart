part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitialState extends InternetState {}

class ConnectionInternetState extends InternetState {
  final String message;
  ConnectionInternetState({required this.message});
}

class NotConnectionInternetState extends InternetState {
  final String message;
  NotConnectionInternetState({required this.message});
}
