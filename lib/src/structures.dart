part of screeps;

@JS('Structure')
abstract class _StructurePrototype
    implements
        _RoomObjectPrototype,
        _ScreepsObject,
        _Destructible,
        _Transferable {
  external String get structureType;

  external int destroy();
  external bool isActive();
  // ignore: avoid_positional_boolean_parameters
  external int notifyWhenAttacked(bool enabled);
}

@JS('OwnedStructure')
abstract class _OwnedStructurePrototype
    implements _StructurePrototype, _OwnedObject {}

class Structure<T extends _StructurePrototype> extends RoomObject<T>
    with ScreepsObject<T>, Destructible<T>, Transferable<T> {
  Structure._internal(T _proto) : super._internal(_proto);

  static Structure fromObject(ScreepsObject object) =>
      new Structure._internal(object._proto);

  factory Structure._fromObject(dynamic object) {
    final props = new JsObject(object);
    final type = _stringToStructureType[props['structureType']];

    switch (type) {
      case StructureType.container:
        return new StructureContainer._internal(object);
      case StructureType.controller:
        return new StructureController._internal(object);
      case StructureType.extension:
        return new StructureExtension._internal(object);
      case StructureType.extractor:
        return new StructureExtractor._internal(object);
      case StructureType.keeperLair:
        return new StructureKeeperLair._internal(object);
      case StructureType.lab:
        return new StructureLab._internal(object);
      case StructureType.link:
        return new StructureLink._internal(object);
      case StructureType.nuker:
        return new StructureNuker._internal(object);
      case StructureType.observer:
        return new StructureObserver._internal(object);
      case StructureType.portal:
        return new StructurePortal._internal(object);
      case StructureType.powerBank:
        return new StructurePowerBank._internal(object);
      case StructureType.powerSpawn:
        return new StructurePowerSpawn._internal(object);
      case StructureType.rampart:
        return new StructureRampart._internal(object);
      case StructureType.road:
        return new StructureRoad._internal(object);
      case StructureType.spawn:
        return new StructureSpawn._internal(object);
      case StructureType.storage:
        return new StructureStorage._internal(object);
      case StructureType.terminal:
        return new StructureTerminal._internal(object);
      case StructureType.tower:
        return new StructureTower._internal(object);
      case StructureType.wall:
        return new StructureWall._internal(object);
      default:
        throw new UnimplementedError();
    }
  }

  StructureType get type => _stringToStructureType[_proto.structureType];

  /// True if this structure can be used.
  ///
  /// Stuctures cannot be used if your room controller level is insufficient.
  bool get isActive => _proto.isActive();

  /// Destroy this structure.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this structure.
  /// * [BusyException] - Hostile creeps are in the room.
  void destroy() => _catchError(_proto.destroy);

  /// Enable or disable automatic e-mail notifications for when this structure
  /// is under attack.  Enabled by default.
  ///
  /// The notification will be sent to your account's e-mail.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this structure.
  void notifyWhenAttacked({enabled: true}) =>
      _catchError(() => _proto.notifyWhenAttacked(enabled));

  String toString() => _proto.structureType;
}

class OwnedStructure<T extends _OwnedStructurePrototype> extends Structure<T>
    with OwnedObject<T> {
  T _proto;

  OwnedStructure._internal(T _proto) : super._internal(_proto);

  static OwnedStructure fromObject(ScreepsObject object) =>
      new OwnedStructure._internal(object._proto);
}

abstract class _SpawnEnergyProvider {}

abstract class SpawnEnergyProvider<T extends _SpawnEnergyProvider> {
  T _proto;
}

@JS('StructureContainer')
abstract class _StructureContainerPrototype
    implements
        _StructurePrototype,
        _StructureInventory,
        _Decayable,
        _Attackable {}

class StructureContainer<T extends _StructureContainerPrototype>
    extends Structure<T>
    with StructureInventory<T>, Decayable<T>, Attackable<T> {
  StructureContainer._internal(T _proto) : super._internal(_proto);

  static StructureContainer fromObject(ScreepsObject object) =>
      new StructureContainer._internal(object._proto);
}

@JS()
@anonymous
abstract class _Reservation {
  external String get username;
  external int get ticksToEnd;
}

class Reservation {
  final _Reservation _object;

  Reservation._internal(this._object);

  /// The player that created this reservation
  Owner get owner => new _OwnerImpl(username: _object.username);

  /// The number of ticks before the reservation ends.
  int get ticksToEnd => _object.ticksToEnd;
}

@JS()
@anonymous
abstract class _ControllerSign {
  external String get username;
  external String get text;
  external int get time;
  external DateTime get datetime;
}

class ControllerSign {
  final _ControllerSign _object;

  ControllerSign._internal(this._object);

  /// The player that created this sign;
  Owner get owner => new _OwnerImpl(username: _object.username);

  /// The text on this sign.
  String get text => _object.text;

  /// The tick at which this sign was created.
  int get creationTick => _object.time;

  /// The date and time at which this sign was created.
  DateTime get creationTime => _object.datetime;
}

@JS('StructureController')
abstract class _StructureControllerPrototype
    implements
        _OwnedStructurePrototype,
        _Progressing,
        _Reservation,
        _ControllerSign {
  external int get level;
  external _Reservation get reservation;
  external int get safeMode;
  external int get safeModeAvailable;
  external int get safeModeCooldown;
  external _ControllerSign get sign;
  external int get ticksToDowngrade;
  external int get upgradeBlocked;

  external int activateSafeMode();
  external int unclaim();
}

class SafeMode {
  /// The number of ticks until safe mode ends.
  final int ticksToEnd;

  /// The number of available safe mode activations.
  final int availableActivations;

  /// The number of ticks before safe mode can be activated again.
  final int ticksCooldown;

  SafeMode._internal(
      {this.ticksToEnd, this.availableActivations, this.ticksCooldown});
}

class StructureController<T extends _StructureControllerPrototype>
    extends OwnedStructure<T> with Progressing<T> {
  StructureController._internal(T _proto) : super._internal(_proto);

  static StructureController fromObject(ScreepsObject object) =>
      new StructureController._internal(object._proto);

  /// The level of this controller, from 0 to 8.
  int get level => _proto.level;

  /// True if this controller is reserved.
  bool get isReserved => reservation != null;

  /// The reservation information for this controller.
  ///
  /// Will only be present if this controller is reserved.
  Reservation get reservation =>
      isReserved ? new Reservation._internal(_proto.reservation) : null;

  /// The safe mode information for this controller.
  SafeMode get safeMode => new SafeMode._internal(
      ticksToEnd: _proto.safeMode,
      availableActivations: _proto.safeModeAvailable,
      ticksCooldown: _proto.safeModeCooldown);

  /// The sign attached to this controller.
  ///
  /// Will only be present if a sign has been set.
  ControllerSign get sign =>
      _proto.sign == null ? null : new ControllerSign._internal(_proto.sign);

  /// The number of ticks until this controller will downgrade by 1 level.
  int get ticksToDowngrade => _proto.ticksToDowngrade;

  /// The number of ticks left until this controller can be attacked or
  /// upgraded.
  ///
  /// Occurs when this controller is attacked.
  ///
  /// Safe mode will be unavailable during this period.
  int get ticksUpgradeBlocked => _proto.upgradeBlocked;

  /// Activate safe mode if available.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this controller.
  /// * [BusyException] - There is already another room in safe mode.
  /// * [InsufficientResourcesException] - You do not have a safe mode activation
  /// available.
  /// * [TiredException] - Safe mode is not available for activation right now.
  void activateSafeMode() => _catchError(_proto.activateSafeMode);

  /// Unclaim this controller and make it neutral.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this controller.
  void unclaim() => _catchError(_proto.unclaim);
}

@JS('StructureExtension')
abstract class _StructureExtensionPrototype
    implements
        _OwnedStructurePrototype,
        _SpawnEnergyProvider,
        _EnergyContainer,
        _Attackable {}

class StructureExtension<T extends _StructureExtensionPrototype>
    extends OwnedStructure<T>
    with SpawnEnergyProvider<T>, EnergyContainer<T>, Attackable<T> {
  StructureExtension._internal(T _proto) : super._internal(_proto);

  static StructureExtension fromObject(ScreepsObject object) =>
      new StructureExtension._internal(object._proto);
}

@JS('StructureExtractor')
abstract class _StructureExtractorPrototype
    implements _OwnedStructurePrototype, _CooldownObject, _Attackable {}

class StructureExtractor<T extends _StructureExtractorPrototype>
    extends OwnedStructure<T> with CooldownObject<T>, Attackable<T> {
  StructureExtractor._internal(T _proto) : super._internal(_proto);

  static StructureExtractor fromObject(ScreepsObject object) =>
      new StructureExtractor._internal(object._proto);
}

@JS('StructureKeeperLair')
abstract class _StructureKeeperLairPrototype
    implements _OwnedStructurePrototype {
  external int get ticksToSpawn;
}

class StructureKeeperLair<T extends _StructureKeeperLairPrototype>
    extends OwnedStructure<T> {
  StructureKeeperLair._internal(T _proto) : super._internal(_proto);

  static StructureKeeperLair fromObject(ScreepsObject object) =>
      new StructureKeeperLair._internal(object._proto);

  /// The number of ticks until this lair spawns a new Source Keeper.
  int get ticksToSpawn => _proto.ticksToSpawn;
}

@JS('StructureLab')
abstract class _StructureLabPrototype
    implements
        _OwnedStructurePrototype,
        _EnergyContainer,
        _MineralContainer,
        _CooldownObject {
  external int boostCreep(_CreepPrototype creep, [int bodyPartsCount]);
  external int runReaction(
      _StructureLabPrototype lab1, _StructureLabPrototype lab2);
}

class StructureLab<T extends _StructureLabPrototype> extends OwnedStructure<T>
    with EnergyContainer<T>, MineralContainer<T>, CooldownObject<T> {
  StructureLab._internal(T _proto) : super._internal(_proto);

  static StructureLab fromObject(ScreepsObject object) =>
      new StructureLab._internal(object._proto);

  /// Boost an adjacent creep's body parts using the current mineral compund
  /// present in this lab.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this lab.
  /// * [NotFoundException] - The current mineral present in this lab cannot
  /// boost any of the target creep's body parts.
  /// * [InsufficientResourcesException] - This lab does not have enough energy
  /// or minerals to boost the target creep.
  /// * [InvalidTargetException] - The target creep is invalid.
  /// * [NotInRangeException] - The target creep is not adjacent.
  void boostCreep(Creep target, [int numBodyParts]) =>
      _catchError(() => _proto.boostCreep(target._proto, numBodyParts));

  /// Combine the mineral compounds from two other labs and add the resulting
  /// mineral compound to this lab.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this lab.
  /// * [InsufficientResourcesException] - One or more of the specified source
  /// labs have insufficient resources to perform a reaction.
  /// * [InvalidTargetException] - The target labs are invalid.
  /// * [FullException] - This lab does not have space for additional minerals
  /// or a new type of mineral.
  /// * [NotInRangeException] - One or more of the target labs are not in range.
  /// * [InvalidArgumentException] - The two source labs do not produce a valid
  /// reaction.
  /// * [TiredException] - This lab is still cooling down.
  void runReaction(StructureLab lab1, StructureLab lab2) =>
      _catchError(() => _proto.runReaction(lab1._proto, lab2._proto));
}

@JS('StructureLink')
abstract class _StructureLinkPrototype
    implements
        _OwnedStructurePrototype,
        _EnergyContainer,
        _CooldownObject,
        _Attackable {
  external int transferEnergy(_StructureLinkPrototype target, int amount);
}

class StructureLink<T extends _StructureLinkPrototype> extends OwnedStructure<T>
    with EnergyContainer<T>, CooldownObject<T>, Attackable<T> {
  StructureLink._internal(T _proto) : super._internal(_proto);

  static StructureLink fromObject(ScreepsObject object) =>
      new StructureLink._internal(object._proto);

  /// Transfer energy to another link anywhere in the same room as this link.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this link.
  /// * [InsufficientResourcesException] - This link does not have the given
  /// amount of energy to transfer.
  /// * [FullException] - The target has insufficient capacity to store the
  /// given amount of energy.
  /// * [InvalidArgumentException] - An invalid amount of energy was provided.
  /// * [TiredException] - This link is still cooling down.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this link.
  void transferEnergy(StructureLink target, {int amount}) =>
      _catchError(() => _proto.transferEnergy(target._proto, amount));
}

@JS('StructureNuker')
abstract class _StructureNukerPrototype
    implements
        _OwnedStructurePrototype,
        _EnergyContainer,
        _CooldownObject,
        _Attackable {
  external int get ghodium;
  external int get ghodiumCapacity;

  external int launchNuke(_RoomPosition pos);
}

class StructureNuker<T extends _StructureNukerPrototype>
    extends OwnedStructure<T>
    with EnergyContainer<T>, CooldownObject<T>, Attackable<T> {
  StructureNuker._internal(T _proto) : super._internal(_proto);

  static StructureNuker fromObject(ScreepsObject object) =>
      new StructureNuker._internal(object._proto);

  /// The amount of ghodium contained by this object.
  int get ghodium => _proto.ghodium;

  /// The total ghodium capacity of this object.
  int get ghodiumCapacity => _proto.ghodiumCapacity;

  /// The current amount of ghodium being contained represented as a percentage
  /// from 0 to 1.
  num get ghodiumPercent => ghodium / ghodiumCapacity;

  /// Launch a nuke targetted at the specified position.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this nuker.
  /// * [InsufficientResourcesException] - This nuker does not have enough energy
  /// or ghodium.
  /// * [InvalidTargetException] - The target position is invalid.
  /// * [NotInRangeException] - The target position is not in range.
  /// * [TiredException] - This nuker is still cooling down.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this nuker.
  void launchNuke(RoomPosition pos) =>
      _catchError(() => _proto.launchNuke(pos._proto));
}

@JS('StructureObserver')
abstract class _StructureObserverPrototype implements _OwnedStructurePrototype {
  external int observeRoom(String roomName);
}

class StructureObserver<T extends _StructureObserverPrototype>
    extends OwnedStructure<T> {
  StructureObserver._internal(T _proto) : super._internal(_proto);

  static StructureObserver fromObject(ScreepsObject object) =>
      new StructureObserver._internal(object._proto);

  /// Provide visibility into a distant room.
  ///
  /// The target room will be available on the next tick.
  ///
  /// May throw:
  /// * [NotInRangeException] - The target room is not in range of this observer.
  /// * [InvalidArgumentException] - The specified room does not exist.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this observer.
  void observeRoom(String roomName) =>
      _catchError(() => _proto.observeRoom(roomName));
}

@JS('StructurePowerBank')
abstract class _StructurePowerBankPrototype
    implements _StructurePrototype, _Decayable, _Attackable {
  external int get power;
}

class StructurePowerBank<T extends _StructurePowerBankPrototype>
    extends Structure<T> with Decayable<T>, Attackable<T> {
  StructurePowerBank._internal(T _proto) : super._internal(_proto);

  static StructurePowerBank fromObject(ScreepsObject object) =>
      new StructurePowerBank._internal(object._proto);

  /// The amount of power contained by this object.
  int get power => _proto.power;
}

@JS('StructurePowerSpawn')
abstract class _StructurePowerSpawnPrototype
    implements _OwnedStructurePrototype, _EnergyContainer, _Attackable {
  external int get power;
  external int get powerCapacity;

  external int processPower();
}

class StructurePowerSpawn<T extends _StructurePowerSpawnPrototype>
    extends OwnedStructure<T> with EnergyContainer<T>, Attackable<T> {
  StructurePowerSpawn._internal(T _proto) : super._internal(_proto);

  static StructurePowerSpawn fromObject(ScreepsObject object) =>
      new StructurePowerSpawn._internal(object._proto);

  /// The amount of power contained by this object.
  int get power => _proto.power;

  /// The total power capacity of this object.
  int get powerCapacity => _proto.powerCapacity;

  /// The current amount of power being contained represented as a percentage
  /// from 0 to 1.
  num get powerPercent => power / powerCapacity;

  /// Add power units to your account.  Power units allow you to develop power
  /// creep skills.
  ///
  /// May throw:
  /// * [InsufficientResourcesException] - This power spawn does not have enough
  /// energy or power units.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this power spawn.
  void processPower() => _catchError(_proto.processPower);
}

@JS('StructurePortal')
abstract class _StructurePortalPrototype
    implements _StructurePrototype, _Decayable {
  external dynamic get destination;
}

/// The destination of a [StructurePortal].
///
/// If this destination is a [PortalInterRoomDestination], it will have a [pos]
/// property present.
///
/// Otherwise, if this destination is a [PortalInterShardDestination], it will
/// have its [shard] and [roomName] properties present.  If the room is visible,
/// the [room] property will also be present.
abstract class PortalDestination {
  /// The target position.  Will be present if this is a
  /// [PortalInterRoomDestination].
  RoomPosition get pos => null;

  /// The target shard.  Will be present if this is a
  /// [PortalInterShardDestination].
  String get shard => null;

  /// The target room name in the target shard.  Will be present if this is a
  /// [PortalInterShardDestination].
  String get roomName => null;

  /// The target room in the target shard.  Will be present if this is a
  /// [PortalInterShardDestination] and the room is visible.
  Room get room => null;
}

class PortalInterRoomDestination extends PortalDestination {
  final RoomPosition pos;

  PortalInterRoomDestination._internal({this.pos});
}

class PortalInterShardDestination extends PortalDestination {
  final String shard;
  final String roomName;
  Room get room => Game.rooms[roomName];

  PortalInterShardDestination._internal({this.shard, this.roomName});
}

class StructurePortal<T extends _StructurePortalPrototype> extends Structure<T>
    with Decayable<T> {
  StructurePortal._internal(T _proto) : super._internal(_proto);

  static StructurePortal fromObject(ScreepsObject object) =>
      new StructurePortal._internal(object._proto);

  /// The destination of this portal.
  PortalDestination get destination {
    final destination = new JsObject(_proto.destination);

    if (destination['shard'] != null) {
      return new PortalInterShardDestination._internal(
          shard: destination['shard'], roomName: destination['room']);
    } else {
      return new PortalInterRoomDestination._internal(pos: _proto.destination);
    }
  }
}

@JS('StructureRampart')
abstract class _StructureRampartPrototype
    implements _OwnedStructurePrototype, _Decayable, _Attackable {
  external bool get isPublic;

  // ignore: avoid_positional_boolean_parameters
  external int setPublic(bool isPublic);
}

class StructureRampart<T extends _StructureRampartPrototype>
    extends OwnedStructure<T> with Decayable<T>, Attackable<T> {
  StructureRampart._internal(T _proto) : super._internal(_proto);

  static StructureRampart fromObject(ScreepsObject object) =>
      new StructureRampart._internal(object._proto);

  /// True if all creeps (including enemy creeps) are allowed to traverse this
  /// rampart.  Defaults to `false`.
  bool get isPublic => _proto.isPublic;

  /// Enable or disable the public setting for this rampart.
  void setPublic({public: true}) => _catchError(() => _proto.setPublic(public));
}

@JS('StructureRoad')
abstract class _StructureRoadPrototype
    implements _StructurePrototype, _Decayable {}

class StructureRoad<T extends _StructureRoadPrototype> extends Structure<T>
    with Decayable<T> {
  StructureRoad._internal(T _proto) : super._internal(_proto);

  static StructureRoad fromObject(ScreepsObject object) =>
      new StructureRoad._internal(object._proto);
}

@JS()
@anonymous
abstract class _SpawningData {
  external String get name;
  external int get needTime;
  external int get remainingTime;
}

class SpawningData {
  final _SpawningData _object;

  const SpawningData._internal(this._object);

  /// The name of the creep being spawned.
  String get name => _object.name;

  /// The total number of ticks the current creep needs to spawn.
  int get totalTicks => _object.needTime;

  /// The number of ticks remaining before the current creep is spawned.
  int get remainingTicks => _object.remainingTime;

  /// The number of ticks the current creep has been spawning for.
  int get ticks => totalTicks - remainingTicks;

  /// The spawning progress represented as a percentage from 0 to 1.
  num get percent => ticks / totalTicks;
}

@JS('StructureSpawn')
abstract class _StructureSpawnPrototype
    implements
        _OwnedStructurePrototype,
        _SpawnEnergyProvider,
        _EnergyContainer,
        _HasMemory,
        _Attackable {
  external String get name;
  external _SpawningData get spawning;

  external int spawnCreep(List<String> body, String name, js.JsObject opts);
  external int recycleCreep(_CreepPrototype target);
  external int renewCreep(_CreepPrototype target);
}

class StructureSpawn<T extends _StructureSpawnPrototype>
    extends OwnedStructure<T>
    with
        SpawnEnergyProvider<T>,
        EnergyContainer<T>,
        HasMemory<T>,
        Attackable<T> {
  StructureSpawn._internal(T _proto) : super._internal(_proto);

  static StructureSpawn fromObject(ScreepsObject object) =>
      new StructureSpawn._internal(object._proto);

  /// The name of this spawn.  The name is unique, immutable, and chosen upon
  /// spawn creation.
  ///
  /// Spawns can be fetched from the [Game.spawns] map using this name.
  String get name => _proto.name;

  /// True if this spawn is currently spawning a creep.
  bool get isSpawning => _proto.spawning != null;

  /// The spawning information for this spawn.
  SpawningData get spawning =>
      isSpawning ? new SpawningData._internal(_proto.spawning) : null;

  /// Request that a creep be spawned, or check if a creep can be spawned if
  /// `dryRun` is true.
  ///
  /// The required energy can be drawn from all spawns and extensions in the
  /// room.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this spawn.
  /// * [DuplicateNameException] - You already have a creep of the same name.
  /// * [BusyException] - This spawn is currently busy spawning another creep.
  /// * [InsufficientResourcesException] - There is not enough energy available
  /// in the room to spawn this creep.
  /// * [InvalidArgumentException] - The body of this creep is invalid.  Ensure
  /// that it has between 1 and 50 non-null [Bodypart]s.  Also ensure the
  /// requested name is valid.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this spawn.
  void spawnCreep(List<Bodypart> body, String name,
      {Map<String, dynamic> memory,
      List<SpawnEnergyProvider> energyProviders,
      bool dryRun}) {
    final Map<String, dynamic> opts = {'memory': memory, 'dryRun': dryRun};

    if (energyProviders != null)
      opts['energyStructures'] = energyProviders.map((p) => p._proto).toList();

    _catchError(() => _proto.spawnCreep(
        body.map((p) => p.toString()).toList(), name, jsify(opts)));
  }

  /// Recycle an adjacent creep, killing it and dropping a portion of the
  /// resources used to spawn it in its place based on remaining lifetime.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [NotInRangeException] - The target creep must be adjacent to this spawn.
  void recycleCreep(Creep target) =>
      _catchError(() => _proto.recycleCreep(target._proto));

  /// Increase the remaining lifetime of an adjacent creep.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This spawn is currently busy spawning another creep.
  /// * [InsufficientResourcesException] - There is not enough energy available
  /// in the room to renew this creep.
  /// * [FullException] - The target creep's lifetime cannot be extended further.
  /// * [NotInRangeException] - The target creep must be adjacent to this spawn.
  void renewCreep(Creep target) =>
      _catchError(() => _proto.renewCreep(target._proto));
}

@JS('StructureStorage')
abstract class _StructureStoragePrototype
    implements _OwnedStructurePrototype, _StructureInventory, _Attackable {}

class StructureStorage<T extends _StructureStoragePrototype>
    extends OwnedStructure<T> with StructureInventory<T>, Attackable<T> {
  StructureStorage._internal(T _proto) : super._internal(_proto);

  static StructureStorage fromObject(ScreepsObject object) =>
      new StructureStorage._internal(object._proto);
}

@JS('StructureTerminal')
abstract class _StructureTerminalPrototype
    implements
        _OwnedStructurePrototype,
        _StructureInventory,
        _CooldownObject,
        _Attackable {
  external int send(String resourceType, int amount, String destination,
      [String description]);
}

class StructureTerminal<T extends _StructureTerminalPrototype>
    extends OwnedStructure<T>
    with StructureInventory<T>, CooldownObject<T>, Attackable<T> {
  StructureTerminal._internal(T _proto) : super._internal(_proto);

  static StructureTerminal fromObject(ScreepsObject object) =>
      new StructureTerminal._internal(object._proto);

  /// Send a resource to a [StructureTerminal] in another room.
  ///
  /// The `amount` of resources sent must be at least 100.
  /// Visibility is not required for the target room.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this terminal.
  /// * [InsufficientResourcesException] - This terminal does not have the
  /// given amount of resources to transfer.
  /// * [InvalidArgumentException] - The target room is invalid, the amount of
  /// resources is invalid, or the description is too long.
  /// * [TiredException] - This terminal is still cooling down.
  void send(Resource resource, String destinationRoomName,
          {@required int amount, String description}) =>
      _catchError(() => _proto.send(
          resource.toString(), amount, destinationRoomName, description));
}

@JS('StructureTower')
abstract class _StructureTowerPrototype
    implements _OwnedStructurePrototype, _EnergyContainer, _Attackable {
  external int attack(_CreepPrototype target);
  external int heal(_CreepPrototype target);
  external int repair(_StructurePrototype target);
}

class StructureTower<T extends _StructureTowerPrototype>
    extends OwnedStructure<T> with EnergyContainer<T>, Attackable<T> {
  StructureTower._internal(T _proto) : super._internal(_proto);

  static StructureTower fromObject(ScreepsObject object) =>
      new StructureTower._internal(object._proto);

  /// Attack any creep in the same room as this tower.
  ///
  /// May throw:
  /// * [InsufficientResourcesException] - This tower does not have enough
  /// resources to perform this action.
  /// * [InvalidTargetException] - The target is not attackable.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this tower.
  void attack(Creep target) => _catchError(() => _proto.attack(target._proto));

  /// Heal any creep in the same room as this tower.
  ///
  /// May throw:
  /// * [InsufficientResourcesException] - This tower does not have enough
  /// resources to perform this action.
  /// * [InvalidTargetException] - The target is not healable.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this tower.
  void heal(Creep target) => _catchError(() => _proto.heal(target._proto));

  /// Repair any structure in the same room as this tower.
  ///
  /// May throw:
  /// * [InsufficientResourcesException] - This tower does not have enough
  /// resources to perform this action.
  /// * [InvalidTargetException] - The target is not repairable.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to operate this tower.
  void repair(Structure target) =>
      _catchError(() => _proto.repair(target._proto));
}

@JS('StructureWall')
abstract class _StructureWallPrototype
    implements _StructurePrototype, _Attackable {}

class StructureWall<T extends _StructureWallPrototype> extends Structure<T>
    with Attackable<T> {
  StructureWall._internal(T _proto) : super._internal(_proto);

  static StructureWall fromObject(ScreepsObject object) =>
      new StructureWall._internal(object._proto);
}
