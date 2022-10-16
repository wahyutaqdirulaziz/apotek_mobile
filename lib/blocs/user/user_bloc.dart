import 'package:apotek_ku/models/user_profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';
import '../../service/auth_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  AuthService _authService = AuthService();
  UserBloc() : super(UserInitial()) {
    on<UserLogin>((event, emit) async {
      emit(UserLoadingState());

      try {
        UserModel data = await _authService.login(
            email: event.email, password: event.password);
        print(data);
        emit(UserLoadedState());
      } catch (error) {
        emit(UserErrorState());
      }
    });

    on<UserRegistrasi>((event, emit) async {
      emit(UserRegisterLoadingState());

      try {
        await _authService.register(
            name: event.name,
            email: event.email,
            number: event.nomor,
            password: event.password);

        emit(UserRegisterLoadedState());
      } catch (error) {
        emit(UserRegisterErrorState());
      }
    });

    on<GetProfile>((event, emit) async {
      emit(UserProfileLoadingState());

      try {
      UserProfileModel data =  await _authService.getProfile();

        emit(UserProfileLoadedState(data: data.data!));
      } catch (error) {
        emit(UserProfileErrorState());
      }
    });
  }
}
