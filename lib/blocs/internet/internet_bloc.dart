import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InternetEvent>((event, emit) {
      if (event is ConnectInternetEvent) {
        emit(ConnectionInternetState(message: 'Connection Internet'));
      } else if (event is NotConnectInternetEvent) {
        emit(NotConnectionInternetState(message: 'Not Connection Internet'));
      }
    });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        add(ConnectInternetEvent());
      } else if (result == ConnectivityResult.mobile) {
        add(ConnectInternetEvent());
      } else if (result == ConnectivityResult.none) {
        add(NotConnectInternetEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
