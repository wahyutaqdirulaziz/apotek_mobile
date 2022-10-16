part of 'apotek_bloc.dart';

@immutable
abstract class ApotekState {}

class ApotekInitial extends ApotekState {}

class ApotekLoadingState extends ApotekState {}

class ApotekLoadedState extends ApotekState {
    final List<Data> data;
  ApotekLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ApotekErrorState extends ApotekState {}
