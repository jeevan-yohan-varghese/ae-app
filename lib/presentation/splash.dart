import 'package:ae_task_app/cubit/splash/splash_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              if(state is SplashLoggedInState){
                Navigator.of(context).pushReplacementNamed('/home');
              }else if (state is SplashNotLoggedInState){
                Navigator.of(context).pushReplacementNamed('/login');
              }


            },
            child: Column(children: [Text("Hello")]),
          ),
        ),
      ),
    );
  }
}
