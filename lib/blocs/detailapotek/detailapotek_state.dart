part of 'detailapotek_bloc.dart';

@immutable
abstract class DetailapotekState {}

class DetailapotekInitial extends DetailapotekState {}


class ApotekDetailLoadingState extends DetailapotekState {}

class ApotekDetailLoadedState extends DetailapotekState {
    final List<DataObat?> data;
 ApotekDetailLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ApotekDetailErrorState extends DetailapotekState {}