part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LoadMapEvent extends MapEvent {
  final BuildContext context;

  const LoadMapEvent(this.context);

  @override
  List<Object?> get props => [context];
}

class ShowCarDetails extends MapEvent {
  final BuildContext context;

  const ShowCarDetails(this.context);

  @override
  List<Object?> get props => [context];
}
