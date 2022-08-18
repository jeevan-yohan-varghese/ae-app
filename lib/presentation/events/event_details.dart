import 'package:ae_task_app/cubit/event/register_event/register_event_cubit.dart';
import 'package:ae_task_app/data/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;
  EventDetailsScreen({required this.event});
  @override
  State<EventDetailsScreen> createState() =>
      _EventDetailsScreenState(event: event);
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final Event event;
  _EventDetailsScreenState({required this.event});
  @override
  Widget build(BuildContext context) {
    //final event = ModalRoute.of(context)!.settings.arguments as Event;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<RegisterEventCubit, RegisterEventState>(
          listener: (context, state) {
            if (state is RegisterEventSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Registered for event")));
            }

            if (state is RegisterEventFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Could not register. ${state.error}")));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/event_sample.jpg',width: double.infinity,),
              const SizedBox(height: 20,),
              Text(
                event.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12,),
              Row(
                children: [Icon(Icons.location_on), Text(event.venue ?? 'Silver Jubilee Tower')],
              ),
              const SizedBox(height: 16,),
              const Text(
                //textAlign: TextAlign.justify,
                
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ultrices scelerisque est in imperdiet. EtiamNunc dui libero, porta, lorem quam feugiat neque, aliquam sollicitudin lectus diam a elit. Maecenas laoreet sollicitudin est, sed elementum nunc tincidunt ac. In sagittis neque turpis, et mollis dui cursus a."),
              
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    
                      onPressed: () {
                        BlocProvider.of<RegisterEventCubit>(context)
                            .registerForEvent(event.eid);
                      },
                      child: const Text("Register")),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
