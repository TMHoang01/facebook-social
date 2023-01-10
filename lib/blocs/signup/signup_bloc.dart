import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository _authRepository = AuthRepository();
  SignupBloc() : super(SignupInitialState()) {
    on<SignupUserEvent>((event, emit) {
      // TODO: implement event handler
      emit(SignupLoadingState());
    });
  }
}
