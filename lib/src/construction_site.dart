part of screeps;

@JS('ConstructionSite')
abstract class _ConstructionSitePrototype
    implements
        _RoomObjectPrototype,
        _ScreepsObject,
        _OwnedObject,
        _Progressing {
  external int get progress;
  external int get progressTotal;
  external String get structureType;

  external int remove();
}

class ConstructionSite<T extends _ConstructionSitePrototype>
    extends RoomObject<T>
    with ScreepsObject<T>, OwnedObject<T>, Progressing<T> {
  ConstructionSite._internal(T _proto) : super._internal(_proto);

  static ConstructionSite fromObject(ScreepsObject object) =>
      new ConstructionSite._internal(object._proto);

  /// A unique object identifier.
  ///
  /// You can use [Game.getObjectByID] to retrieve an object instance by its id.
  external String get id;

  /// The structure type that this construction site is building.
  StructureType get type => _stringToStructureType[_proto.structureType];

  /// Remove this construction site.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this construction site.
  void remove() => _catchError(_proto.remove);
}
