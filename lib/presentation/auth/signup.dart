import 'package:ae_task_app/cubit/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
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
            }
          },
          builder: (context, state) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    TextField(
                      controller: regNoController,
                      decoration: InputDecoration(hintText: "Reg No"),
                    ),
                    TextField(
                      controller: pwdController,
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).signUp(
                              emailController.text,
                              pwdController.text,
                              nameController.text,
                              regNoController.text);
                        },
                        child: const Text("Register")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text("Already registerd? Login"))
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
