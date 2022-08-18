import 'package:ae_task_app/data/helpers/my_event_response.dart';
import 'package:ae_task_app/data/models/event.dart';
import 'package:ae_task_app/data/repo/event_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'my_event_state.dart';

class MyEventCubit extends Cubit<MyEventState> {
  MyEventCubit() : super(MyEventInitial()){
    getMyEvents();
  }

  void getMyEvents() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jwt = sharedPreferences.getString("jwtToken") ?? "";
      MyEventResponse eventResponse = await EventRepo().getMyEvents(jwt);

      emit(MyEventSuccess(events: eventResponse.myEventsList));
    } catch (e) {
      emit(MyEventFailed(error: e.toString()));
    }
  }
}
