part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class ConnectInternetEvent extends InternetEvent {}

class NotConnectInternetEvent extends InternetEvent {}
