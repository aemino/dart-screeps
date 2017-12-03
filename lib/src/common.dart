part of screeps;

@JS()
@anonymous
abstract class Owner {
  /// The username of this owner.
  external String get username;
}

class _OwnerImpl implements Owner {
  final String username;

  _OwnerImpl({this.username});
}

@JS()
@anonymous
abstract class _ScreepsObject {
  external String get id;
}

abstract class ScreepsObject<T extends _ScreepsObject> {
  T _proto;

  static ScreepsObject fromObject(ScreepsObject object) => object;

  /// A unique object identifier.
  ///
  /// You can use [Game.getObjectByID] to retrieve an object instance by its id.
  String get id => _proto.id;
}

@JS()
@anonymous
abstract class _Destructible {
  external int get hits;
  external int get hitsMax;
}

abstract class Destructible<T extends _Destructible> {
  T _proto;

  /// The remaining hitpoints of this object.
  int get hits => _proto.hits;

  /// The maximum number of hitpoints this object can have.
  int get hitsMax => _proto.hitsMax;

  /// The hitpoints of this object expressed as a percentage from 0 to 1.
  num get hitsPercent => hits / hitsMax;
}

@JS()
@anonymous
abstract class _OwnedObject {
  external Owner get owner;
  external bool get my;
}

abstract class OwnedObject<T extends _OwnedObject> {
  T _proto;

  /// The owner of this object.
  Owner get owner => _proto.owner;

  /// True if you own this object.
  bool get isMine => _proto.my;
}

@JS()
@anonymous
abstract class _Decayable {
  external int get ticksToDecay;
}

abstract class Decayable<T extends _Decayable> {
  T _proto;

  /// The number of game ticks until this object will lose hitpoints.
  int get ticksToDecay => _proto.ticksToDecay;
}

@JS()
@anonymous
abstract class _Progressing {
  external int get progress;
  external int get progressTotal;
}

abstract class Progressing<T extends _Progressing> {
  T _proto;

  /// The current progress.
  int get progress => _proto.progress;

  /// The total amount of progress needed for completion.
  int get progressTotal => _proto.progressTotal;

  /// The current progress represented as a percentage from 0 to 1.
  num get progressPercent => progress / progressTotal;
}

@JS()
@anonymous
abstract class _EnergyContainer {
  external int get energy;
  external int get energyCapacity;
}

class EnergyContainer<T extends _EnergyContainer> {
  T _proto;

  /// The amount of energy contained by this object.
  int get energy => _proto.energy;

  /// The total energy capacity of this object.
  int get energyCapacity => _proto.energy;

  /// The current amount of energy being contained represented as a percentage
  /// from 0 to 1.
  num get energyPercent => energy / energyCapacity;
}

@JS()
@anonymous
abstract class _MineralContainer {
  external int get mineralAmount;
  external String get mineralType;
  external int get mineralCapacity;
}

class MineralData {
  /// The amount of minerals being stored.
  final int amount;

  /// The total mineral storage capacity.
  final int capacity;

  /// The type of mineral being stored.
  final Resource type;

  const MineralData._internal({this.amount, this.capacity, this.type});
}

class MineralContainer<T extends _MineralContainer> {
  T _proto;

  /// True if this object contains a mineral.
  bool get hasMineral => _proto.mineralAmount > 0;

  /// The mineral information for this object.
  MineralData get mineral => new MineralData._internal(
      amount: _proto.mineralAmount,
      capacity: _proto.mineralCapacity,
      type: _stringToResource[_proto.mineralType]);
}

@JS()
@anonymous
abstract class _CooldownObject {
  external int get cooldown;
}

class CooldownObject<T extends _CooldownObject> {
  T _proto;

  /// The amount of ticks before this object can be used again.
  int get ticksToCooldown => _proto.cooldown;
}

@JS()
@anonymous
abstract class _Harvestable {
  external int get ticksToRegeneration;
}

class Harvestable<T extends _Harvestable> {
  T _proto;

  /// The number of ticks before this deposit will be refilled.
  int get ticksToRegeneration => _proto.ticksToRegeneration;
}

abstract class _RoomObjectInventory {
  dynamic get inventory;
  int get inventoryCapacity;
}

@JS()
@anonymous
abstract class _CreepInventory implements _RoomObjectInventory {
  external dynamic get carry;
  external int get carryCapacity;
}

@JS()
@anonymous
abstract class _StructureInventory implements _RoomObjectInventory {
  external dynamic get store;
  external int get storeCapacity;
}

abstract class RoomObjectInventory<T extends _RoomObjectInventory> {
  T _proto;

  /// The inventory of this object.
  Inventory get inventory;
}

abstract class CreepInventory<T extends _CreepInventory>
    implements RoomObjectInventory<T> {
  T _proto;

  Inventory get inventory => new Inventory._internal(new JsObject(_proto.carry),
      capacity: _proto.carryCapacity);
}

abstract class StructureInventory<T extends _StructureInventory>
    implements RoomObjectInventory<T> {
  T _proto;

  Inventory get inventory => new Inventory._internal(new JsObject(_proto.store),
      capacity: _proto.storeCapacity);
}

@JS()
@anonymous
abstract class _HasMemory {
  external dynamic get memory;
}

abstract class HasMemory<T extends _HasMemory> {
  T _proto;

  /// A shorthand getter to the [Memory] data for this object.
  JsObject<String, dynamic> get memory => new JsObject(_proto.memory);
}

abstract class _Attackable {}

abstract class Attackable<T extends _Attackable> {
  T _proto;
}

abstract class _Transferable {}

abstract class Transferable<T extends _Transferable> {
  T _proto;
}
