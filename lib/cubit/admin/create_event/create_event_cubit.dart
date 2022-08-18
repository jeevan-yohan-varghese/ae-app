import 'package:ae_task_app/data/helpers/general_response.dart';
import 'package:ae_task_app/data/repo/event_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventInitial());

  void newEvent(String eventName, String venueId, String startDate,
      String endDate, int seats) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jwt = sharedPreferences.getString("jwtToken") ?? "";
      GeneralResponse loginResponse = await EventRepo()
          .createEventAsync(jwt, eventName, startDate, endDate, venueId, seats);

      emit(CreateEventSuccess());
    } catch (e) {
      emit(CreateEventError(error: e.toString()));
    }
  }
}
