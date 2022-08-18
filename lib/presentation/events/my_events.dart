import 'package:ae_task_app/cubit/auth/auth_cubit.dart';
import 'package:ae_task_app/cubit/event/get_event/get_event_cubit.dart';
import 'package:ae_task_app/cubit/event/my_event/my_event_cubit.dart';
import 'package:ae_task_app/cubit/event/register_event/register_event_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyEventsPage extends StatefulWidget {
  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyEventCubit(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("My Events",style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<MyEventCubit, MyEventState>(
                builder: (context, state) {
                  if (state is MyEventSuccess) {
                    return ListView.builder(
                        itemCount: state.events.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  state.events[index].event.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                    state.events[index].event.seats.toString()),
                                Text("CODE : ${state.events[index].ucode}"),
                                QrImage(data: "${state.events[index].ucode}",size: 120,)
                              ],
                            ),
                          ));
                        });
                  }

                  if (state is MyEventFailed) {
                    return Column(
                      children: [
                        Text("some error occured. //${state.error}"),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<MyEventCubit>(context)
                                  .getMyEvents();
                            },
                            child: Text("Try again"))
                      ],
                    );
                  }
                  return LinearProgressIndicator();
                },
              ),
            )),
      ),
    );
  }
}
