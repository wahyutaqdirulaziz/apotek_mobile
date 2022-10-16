import 'package:apotek_ku/models/apotek_detail_model.dart';
import 'package:apotek_ku/service/apotek_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detailapotek_event.dart';
part 'detailapotek_state.dart';

class DetailapotekBloc extends Bloc<DetailapotekEvent, DetailapotekState> {
    ApotekService _apotekService = ApotekService();
  DetailapotekBloc() : super(DetailapotekInitial()) {
     on<ApotekDetailFetch>((event, emit) async {
      emit(ApotekDetailLoadingState());

      try {
        Detail_apotik_model data = await _apotekService.getDetailApotek(id: event.id);
        print(data);
        emit(ApotekDetailLoadedState(data: data.dataObat!));
      } catch (error) {
        emit(ApotekDetailErrorState());
      }
    });
  }
}
