part of 'apotek_bloc.dart';

@immutable
abstract class ApotekEvent {}


class ApotekFetch extends ApotekEvent{
    String keyword;
    int page;
  ApotekFetch(
      {required this.keyword,required this.page});

  @override
  List<Object> get props => [keyword,page];
}

