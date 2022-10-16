part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserLogin extends UserEvent {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class UserRegistrasi extends UserEvent {
  String name;
  String email;
  String nomor;
  String password;

  UserRegistrasi(
      {required this.name,
      required this.email,
      required this.nomor,
      required this.password});

  @override
  List<Object> get props => [name, email, nomor, password];
}



class GetProfile extends UserEvent {
}
