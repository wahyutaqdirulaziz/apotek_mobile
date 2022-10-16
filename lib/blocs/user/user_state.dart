part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState{

}

class UserLoadedState extends UserState{

}

class UserErrorState extends UserState{

}


// register
class UserRegisterLoadingState extends UserState{

}

class UserRegisterLoadedState extends UserState{

}

class UserRegisterErrorState extends UserState{
  
}





// register
class UserProfileLoadingState extends UserState{

}

class UserProfileLoadedState extends UserState{
  final DataUser data;
  UserProfileLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class UserProfileErrorState extends UserState{
  
}
