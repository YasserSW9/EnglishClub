import 'package:bloc/bloc.dart';

import 'package:english_club/features/login/data/models/login_request_body.dart';
import 'package:english_club/features/login/data/repos/login_repo.dart';
import 'package:english_club/features/login/logic/cubit/login_state.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginCubit(this.loginRepo) : super(LoginState.initial());

  void emitloginloaded() async {
    emit(LoginState.loading());
    LoginRequestBody loginRequestBody = LoginRequestBody(
      username: emailController.text,
      password: passwordController.text,
    );
    final response = await loginRepo.login(loginRequestBody);
    response.when(
      success: (LoginResponse) async {
        emit(LoginState.success(LoginResponse));
      },
      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
