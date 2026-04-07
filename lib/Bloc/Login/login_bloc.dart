import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cab_zing/Data/local_storage.dart';
import 'package:cab_zing/core/constants.dart';
import 'package:cab_zing/core/repo/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(login);
  }
  final storage = LocalStorage();
  Future<void> login(LoginRequested event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final result = await LoginRepo().login(event.username, event.password);

      if (result.isSuccess) {
        await storage.write(accessToken, result.access!);
        await storage.write(refreshToken, result.refresh!);
        await storage.write(userName, result.data!.username!);
        await storage.write(userEmail, result.data!.email!);
        await storage.write(userId, result.data!.userId!.toString());

        emit(LoginSuccess());
      } else {
        emit(LoginError(result.error ?? "Login failed"));
      }
    } catch (e) {
      print('Error occured: $e');
      emit(LoginError(e.toString()));
    }
  }
}
