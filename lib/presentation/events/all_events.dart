import 'package:ae_task_app/cubit/auth/auth_cubit.dart';
import 'package:ae_task_app/cubit/event/get_event/get_event_cubit.dart';
import 'package:ae_task_app/cubit/event/register_event/register_event_cubit.dart';
import 'package:ae_task_app/data/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AllEventsPage extends StatefulWidget {
  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  late List<Event>? events;
  late List<Event>? filteredEvents;
  late Function? refreshState;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetEventCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterEventCubit(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  scrollPadding: EdgeInsets.zero,
                  //cursorColor: darkPink,
                  onChanged: (val) {
                    refreshState!(() {
                      filteredEvents = events!
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Search for an event',
                    contentPadding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                    fillColor: Color(0xfff3f3f4),
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      //color: darkPink,
                      size: 20,
                    ),
                    suffixIconConstraints: BoxConstraints(),
                  ),
                ),
                BlocConsumer<GetEventCubit, GetEventState>(
                  listener: (context, state) {
                    if (state is GetEventSuccess) {
                      events = state.events;
                      filteredEvents = state.events;
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<GetEventCubit, GetEventState>(
                      builder: (context, state) {
                        if (state is GetEventSuccess) {
                          return StatefulBuilder(builder: (context, setState) {
                            refreshState = setState;
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: filteredEvents!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            '/eventDetails',
                                            arguments: filteredEvents![index]);
                                      },
                                      child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/event_sample.jpg',
                                                  width: 100,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      filteredEvents![index]
                                                          .name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                        "Seats : ${filteredEvents![index].seats.toString()}"),
                                                    Text(getLocalDate(
                                                        filteredEvents![index]
                                                                .endDate ??
                                                            '2022-08-20T14:10:17Z'))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    );
                                  }),
                            );
                          });
                        }

                        if (state is GetEventFailed) {
                          return Column(
                            children: [
                              Text("some error occured. //${state.error}"),
                              TextButton(
                                  onPressed: () {
                                    BlocProvider.of<GetEventCubit>(context)
                                        .getAllEvents();
                                  },
                                  child: Text("Try again"))
                            ],
                          );
                        }
                        return LinearProgressIndicator();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.map),
            onPressed: () {
            Navigator.of(context).pushNamed('/map');
          }),
        ),
      ),
    );
  }

  String getLocalTime(String utcStr) {
    var timeFormat = DateFormat("hh:mm aaa");
    //var dateFormat = DateFormat("dd MMM yyyy");
    var strToDateTime = DateTime.parse(utcStr);
    final convertLocal = strToDateTime.toLocal();
    String updatedTime = timeFormat.format(convertLocal);
    return updatedTime;
  }

  String getLocalDate(String utcStr) {
    var dateFormat = DateFormat("dd MMM yyyy");
    var strToDateTime = DateTime.parse(utcStr);
    final convertLocal = strToDateTime.toLocal();
    String updatedDate = dateFormat.format(convertLocal);
    return updatedDate;
  }
}
