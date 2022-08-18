import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()){
    checkSignIn();
  }

  void checkSignIn() async {
    debugPrint('checking sign in ');
    SharedPreferences sh = await SharedPreferences.getInstance();
    if (sh.getBool("isLoggedIn") ?? false) {
      debugPrint(sh.getString('jwtToken')??"");
      emit(SplashLoggedInState());
    } else {
      emit(SplashNotLoggedInState());
    }
  }
}
