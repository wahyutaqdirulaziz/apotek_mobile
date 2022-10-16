import 'package:apotek_ku/models/obat_model.dart';
import 'package:apotek_ku/service/obat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'obat_event.dart';
part 'obat_state.dart';

class ObatBloc extends Bloc<ObatEvent, ObatState> {
   ObatService _obatService = ObatService();
  ObatBloc() : super(ObatInitial()) {
    on<ObatFetch>((event, emit) async{
     emit(ObatLoadingState());
      try {
        ObatModel data = await _obatService.getObat();
        print(data);
        emit(ObatLoadedState(data: data.data!));
      } catch (error) {
        emit(ObatErrorState());
      }
    });
  }
}
