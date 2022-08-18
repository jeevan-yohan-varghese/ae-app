import 'package:ae_task_app/data/helpers/general_response.dart';
import 'package:ae_task_app/data/repo/event_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event_state.dart';

class RegisterEventCubit extends Cubit<RegisterEventState> {
  RegisterEventCubit() : super(RegisterEventInitial());

  void registerForEvent(String eventId) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String jwt = sharedPreferences.getString("jwtToken") ?? "";
      GeneralResponse eventResponse =
          await EventRepo().registerForEvent(jwt, eventId);

      emit(RegisterEventSuccess());
    } catch (e) {
      emit(RegisterEventFailed(error: e.toString()));
    }
  }
}
