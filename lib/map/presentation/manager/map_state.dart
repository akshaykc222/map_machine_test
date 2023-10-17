part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();
}

class MapInitial extends MapState {
  @override
  List<Object> get props => [];
}

class MapLoading extends MapState {
  @override
  List<Object?> get props => [];
}

class MapRefresh extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoaded extends MapState {
  @override
  List<Object?> get props => [];
}
