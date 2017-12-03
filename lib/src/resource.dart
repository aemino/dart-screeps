part of screeps;

@JS('Resource')
abstract class _DroppedResourcePrototype
    implements _RoomObjectPrototype, _ScreepsObject {
  external int get amount;
  external String get type;
}

class DroppedResource<T extends _DroppedResourcePrototype> extends RoomObject<T>
    with ScreepsObject<T> {
  final T proto;

  DroppedResource._internal(this.proto) : super._internal(proto);

  static DroppedResource fromObject(ScreepsObject object) =>
      new DroppedResource._internal(object._proto);

  /// The number of units this dropped resource contains.
  int get amount => proto.amount;

  /// The type of resource that was dropped.
  Resource get type => _stringToResource[proto.type];
}
