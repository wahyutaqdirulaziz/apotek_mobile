import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/apotek_model.dart';
import '../../service/apotek_service.dart';

part 'apotek_event.dart';
part 'apotek_state.dart';

class ApotekBloc extends Bloc<ApotekEvent, ApotekState> {
  ApotekService _apotekService = ApotekService();
  ApotekBloc() : super(ApotekInitial()) {
    on<ApotekFetch>((event, emit) async {
      emit(ApotekLoadingState());

      try {
        ApotekModel data = await _apotekService.getApotek();
        print(data);
        emit(ApotekLoadedState(data: data.data!));
      } catch (error) {
        emit(ApotekErrorState());
      }
    });
  }
}
