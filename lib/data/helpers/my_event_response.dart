import 'package:ae_task_app/data/models/event.dart';

class MyEventResponse {
  final List<MyEvent> myEventsList;

  MyEventResponse({required this.myEventsList});

  factory MyEventResponse.fromJson(Map<String, dynamic> json) {
    List<MyEvent> mList = [];
    json['my_events'].forEach((v) {
      mList.add(MyEvent.fromJson(v));
    });
    return MyEventResponse(myEventsList: mList);
  }
}

class MyEvent {
  final String pid;
  final String eid;
  final String ucode;
  final Event event;
  MyEvent({
    required this.pid,
    required this.eid,
    required this.ucode,
    required this.event,
  });

  factory MyEvent.fromJson(Map<String, dynamic> json) {
    return MyEvent(
        pid: json['pid'],
        eid: json['eid'],
        ucode: json['ucode'],
        event: Event.fromJson(json['event']));
  }
}
