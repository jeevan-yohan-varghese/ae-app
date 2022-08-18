import 'package:ae_task_app/cubit/admin/create_event/create_event_cubit.dart';
import 'package:ae_task_app/cubit/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventPage extends StatefulWidget {
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController capacityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEventCubit(),
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is CreateEventSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Event created")));
              }

              if (state is CreateEventError) {
                debugPrint('Success');
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Error")));
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
                        decoration: InputDecoration(hintText: "Event Name"),
                      ),
                      TextField(
                        controller: capacityController,
                        decoration:
                            InputDecoration(hintText: "Max participants"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CreateEventCubit>(context).newEvent(
                                nameController.text,
                                "3c948824-bee4-4168-a428-795268ab20b0",
                                DateTime.now().toIso8601String(),
                                DateTime.now().toIso8601String(),
                                int.parse(capacityController.text));
                          },
                          child: const Text("Create Event")),
                      
                    ]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
