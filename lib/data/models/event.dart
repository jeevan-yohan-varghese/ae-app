class Event {
  final String name;
  final int seats;
  final String? startDate;
  final String? endDate;
  final String? venue;
  final String eid;

  Event({
    required this.name,
    required this.seats,
    required this.startDate,
    required this.endDate,
    required this.venue,
    required this.eid,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        name: json['name'],
        seats: json['seats'],
        startDate: json['startdate'],
        endDate: json['enddate'],
        eid: json['eid'],
        venue: json['vid']);
  }
}

class GetEventResponse {
  final List<Event> eventsList;

  GetEventResponse({required this.eventsList});

  factory GetEventResponse.fromJson(Map<String, dynamic> json) {
    List<Event> mEventsList = [];
    json['events'].forEach((v) {
      mEventsList.add(Event.fromJson(v));
    });
    return GetEventResponse(eventsList: mEventsList);
  }
}
