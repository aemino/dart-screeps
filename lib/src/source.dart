part of screeps;

@JS('Source')
abstract class _SourcePrototype
    implements _RoomObjectPrototype, _EnergyContainer, _Harvestable {
  external int get density;
}

class Source<T extends _SourcePrototype> extends RoomObject<T>
    with EnergyContainer<T>, Harvestable<T> {
  final T _proto;

  Source._internal(this._proto) : super._internal(_proto);
}
