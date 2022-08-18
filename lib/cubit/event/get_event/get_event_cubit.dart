import 'package:ae_task_app/data/models/event.dart';
import 'package:ae_task_app/data/repo/event_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_event_state.dart';

class GetEventCubit extends Cubit<GetEventState> {
  GetEventCubit() : super(GetEventInitial()){
    getAllEvents();
  }
  void getAllEvents() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jwt = sharedPreferences.getString("jwtToken") ?? "";
      GetEventResponse eventResponse = await EventRepo().getAllEvents();

      emit(GetEventSuccess(events: eventResponse.eventsList));
    } catch (e) {
      emit(GetEventFailed(error: e.toString()));
    }
  }
}
