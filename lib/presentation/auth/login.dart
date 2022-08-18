import 'package:ae_task_app/cubit/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              debugPrint('Error : ${state.error}');
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }

            if (state is AuthSuccess) {
              debugPrint('Success');
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Authenticated")));
              if (state.participant.email == 'jjj@mail.com') {
                //Navigator.of(context).pushReplacementNamed('/newEvent');
              }
              Navigator.of(context).pushReplacementNamed('/home');

            }
          },
          builder: (context, state) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    TextField(
                      controller: pwdController,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).signInAsync(
                              emailController.text, pwdController.text);
                        },
                        child: const Text("Login")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signUp');
                        },
                        child: const Text("Register Now."))
                  ]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
