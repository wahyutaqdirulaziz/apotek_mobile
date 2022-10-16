part of 'obat_bloc.dart';

@immutable
abstract class ObatState {}

class ObatInitial extends ObatState {}

class ObatLoadingState extends ObatState {}

class ObatLoadedState extends ObatState {
    final List<Data> data;
  ObatLoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ObatErrorState extends ObatState {}