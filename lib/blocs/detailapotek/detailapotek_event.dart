part of 'detailapotek_bloc.dart';

@immutable
abstract class DetailapotekEvent {}

class ApotekDetailFetch extends DetailapotekEvent{
    int id;
  ApotekDetailFetch(
      {required this.id});

  @override
  List<Object> get props => [id,];
}