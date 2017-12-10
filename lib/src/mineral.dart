part of screeps;

@JS('Mineral')
abstract class _MineralPrototype
    implements _RoomObjectPrototype, _MineralContainer, _Harvestable {
  external int get density;
}

class Mineral<T extends _MineralPrototype> extends RoomObject<T>
    with MineralContainer<T>, Harvestable<T> {
  Mineral._internal(T _proto) : super._internal(_proto);
}
