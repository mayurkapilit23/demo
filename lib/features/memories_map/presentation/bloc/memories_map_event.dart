import 'package:equatable/equatable.dart';

abstract class MemoriesMapEvent extends Equatable {
  const MemoriesMapEvent();

  @override
  List<Object> get props => [];
}

class LoadMemoriesMap extends MemoriesMapEvent {}
