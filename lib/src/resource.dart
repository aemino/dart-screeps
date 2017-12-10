part of screeps;

@JS('Resource')
abstract class _DroppedResourcePrototype
    implements _RoomObjectPrototype, _ScreepsObject {
  external int get amount;
  external String get resourceType;
}

class DroppedResource<T extends _DroppedResourcePrototype> extends RoomObject<T>
    with ScreepsObject<T> {
  DroppedResource._internal(T _proto) : super._internal(_proto);

  static DroppedResource fromObject(ScreepsObject object) =>
      new DroppedResource._internal(object._proto);

  /// The number of units this dropped resource contains.
  int get amount => _proto.amount;

  /// The type of resource that was dropped.
  Resource get type => _stringToResource[_proto.resourceType];
}
