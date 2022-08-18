import 'package:ae_task_app/data/helpers/login_response.dart';
import 'package:ae_task_app/data/models/participant.dart';
import 'package:ae_task_app/data/repo/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signInAsync(String email, String pwd) async {
    debugPrint('Sign in called');
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      try {
        String idToken =
            await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
        LoginResponse loginResponse = await LoginRepo().loginAsync(idToken);
        sharedPreferences.setBool("isLoggedIn", true);
        sharedPreferences.setString("idToken", idToken);
        sharedPreferences.setString("jwtToken", loginResponse.jwt);
        emit(AuthSuccess(
            jwt: loginResponse.jwt, participant: loginResponse.participant));
      } catch (e) {
        debugPrint(e.toString());
        sharedPreferences.setBool("isLoggedIn", false);
        //sharedPreferences.setString("idToken", "");
        sharedPreferences.setString("jwtToken", "");
        if (e.toString() == "Exception: Not registered") {
          emit(AuthError(error: e.toString()));
          FirebaseAuth.instance.signOut();
        } else {
          emit(AuthError(error: e.toString()));
          FirebaseAuth.instance.signOut();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(AuthError(error: "Account not found"));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(AuthError(error: e.message ?? ""));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthError(error: e.toString()));
    }
  }

  void signUp(String email, String pwd, String name, String regNo) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String idToken =
          await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";

      LoginResponse loginResponse =
          await LoginRepo().signUpAsync(idToken, name, email, regNo);
      sharedPreferences.setBool("isLoggedIn", true);
      sharedPreferences.setString("idToken", idToken);
      sharedPreferences.setString("jwtToken", loginResponse.jwt);
      emit(AuthSuccess(
          jwt: loginResponse.jwt, participant: loginResponse.participant));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(AuthError(error: 'Choose a strong password'));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(AuthError(error: "Account already exists"));
      }
    } catch (e) {
      print(e);
    }
  }
}
