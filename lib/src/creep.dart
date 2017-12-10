part of screeps;

@JS()
@anonymous
abstract class _CreepBodypartObject {
  /// TODO: create boost enum
  external String get boost;
  external String get type;
  external int get hits;
}

class CreepBodypart {
  final _CreepBodypartObject object;

  CreepBodypart._internal(this.object);

  /// The type of bodypart.
  Bodypart get type => _stringToBodypart[object.type];

  /// The remaining hitpoints of this bodypart.
  int get hits => object.hits;
}

@JS('Creep')
abstract class _CreepPrototype
    implements
        _RoomObjectPrototype,
        _ScreepsObject,
        _Destructible,
        _OwnedObject,
        _CreepInventory,
        _HasMemory,
        _Attackable,
        _Transferable {
  external List<_CreepBodypartObject> get body;
  external int get fatigue;
  external String get name;
  external String get saying;
  external bool get spawning;
  external int get ticksToLive;

  external int attack(_Attackable target);
  external int attackController(_StructureControllerPrototype target);
  external int build(_ConstructionSitePrototype target);
  external int cancelOrder(String methodName);
  external int claimController(_StructureControllerPrototype target);
  external int dismantle(_StructurePrototype target);
  external int drop(String resourceType, [int amount]);
  external int generateSafeMode(_StructureControllerPrototype target);
  external int getActiveBodyparts(String type);
  external int harvest(_Harvestable target);
  external int heal(_CreepPrototype target);
  external int move(int direction);
  external int moveByPath(List<_PathStep> path);
  external int moveTo(_RoomPosition target);
  external int pickup(_DroppedResourcePrototype target);
  external int rangedAttack(_Attackable target);
  external int rangedHeal(_CreepPrototype target);
  external int rangedMassAttack();
  external int repair(_StructurePrototype target);
  external int reserveController(_StructureControllerPrototype target);
  // ignore: avoid_positional_boolean_parameters
  external int say(String message, [bool isPublic]);
  external int signController(
      _StructureControllerPrototype target, String text);
  external int suicide();
  external int transfer(_Transferable target, String resourceType,
      [int amount]);
  external int upgradeController(_StructureControllerPrototype target);
  external int withdraw(_StructurePrototype target, String resourceType,
      [int amount]);
}

class Creep<T extends _CreepPrototype> extends RoomObject<T>
    with
        ScreepsObject<T>,
        Destructible<T>,
        OwnedObject<T>,
        CreepInventory<T>,
        HasMemory<T>,
        Attackable<T>,
        Transferable<T> {
  Creep._internal(T _proto) : super._internal(_proto);

  static Creep fromObject(ScreepsObject object) =>
      new Creep._internal(object._proto);

  /// The composition of this creep's body.
  List<CreepBodypart> get body =>
      _proto.body.map((p) => new CreepBodypart._internal(p)).toList();

  /// The current fatigue of this creep.
  ///
  /// This value decreases by 1 per tick.  A fatigue unit is generated for every
  /// non-move creep part per tick while this creep is moving.
  /// The swamp terrain type generates fatigue more fervently at 5x the rate of
  /// plains.  Creeps' movement is impaired while this value is greater than 0.
  int get fatigue => _proto.fatigue;

  /// The name of this creep.  The name is unique, immutable, and chosen upon
  /// creep creation.
  ///
  /// Creeps can be fetched from the [Game.creeps] map using this name.
  String get name => _proto.name;

  /// Contains a message if this creep was speaking during the previous tick.
  String get saying => _proto.saying;

  /// True if this creep is currently being spawned.
  bool get isSpawning => _proto.spawning;

  /// The remaining number of ticks until this creep dies.
  int get ticksToLive => _proto.ticksToLive;

  /// Attack an adjacent creep or structure.
  ///
  /// Requires the [Bodypart.attack] bodypart.
  /// If the target is a creep that resides within a rampart, the rampart will
  /// be attacked instead.
  /// If the target is a creep that does not reside within a rampart and has an
  /// [Bodypart.attack] bodypart, the target creep will strike back automatically.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InvalidTargetException] - The target is not attackable.
  /// * [NotInRangeException] - This creep is not adjacent to the target.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.attack]
  /// bodypart.
  void attack(Attackable target) =>
      _catchError(() => _proto.attack(target._proto));

  /// Attack an adjacent controller.
  ///
  /// Requires the [Bodypart.claim] bodypart.
  /// Decreases the target controller's reservation timer by 300 ticks for each
  /// [Bodypart.claim] bodypart.
  /// After a controller is attacked, it cannot be attacked or upgraded again
  /// for the next 1,000 ticks.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InvalidTargetException] - The target is not an owned or reserved
  /// controller.
  /// * [NotInRangeException] - This creep is not adjacent to the target.
  /// * [TiredException] - The target was already attacked in the last 1,000
  /// ticks.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.claim]
  /// bodypart.
  void attackController(StructureController target) =>
      _catchError(() => _proto.attackController(target._proto));

  /// Build a construction site.
  ///
  /// Requires the [Bodypart.work] and [Bodypart.carry] bodyparts.
  /// Builds a structure at the target construction site using carried energy.
  /// The target must be within 3 squares range of the creep.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InvalidTargetException] - There is a creep at the target construction
  /// site, which is preventing construction.
  /// * [InsufficientResourcesException] - The creep is not carrying any energy.
  /// * [NotInRangeException] - The creep is not in range of the target.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.work]
  /// and [Bodypart.carry] bodypart.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to build the target structure.
  void build(ConstructionSite target) =>
      _catchError(() => _proto.build(target._proto));

  /// Claim a neutral controller.
  ///
  /// Requires the [Bodypart.claim] bodypart.
  /// Claims a neutral controller under your control. The target must be
  /// at an adjacent square to the creep. You must also have corresponding
  /// Global Control Level in order to claim a new room.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InvalidTargetException] - The target controller is not neutral.
  /// * [FullException] - You cannot claim more than 3 rooms in the Novice Area.
  /// * [NotInRangeException] - The target is too far away.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.claim]
  /// bodypart.
  /// * [InsufficientGclException] - Your global control level is below the
  /// level required to claim this controller.
  void claimController(StructureController target) =>
      _catchError(() => _proto.claimController(target._proto));

  /// Dismantle an adjacent structure.
  ///
  /// Requires the [Bodypart.work] bodypart.
  /// Dismantles any structure, returning 50% of the energy used to construct
  /// it.  The resulting energy will be added to the creep's inventory if it has
  /// available capacity.  Otherwise, the energy is dropped onto the ground.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InvalidTargetException] - The target cannot be dismantled.
  /// * [NotInRangeException] - The target structure is not adjacent to this
  /// creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.work]
  /// bodypart.
  void dismantle(Structure target) =>
      _catchError(() => _proto.dismantle(target._proto));

  /// Drop a resource onto the ground.  Omit [amount] to drop all resources of
  /// the given type.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InsufficientResourcesException] - This creep does not have the
  /// specified amount of the given resource.
  void drop(Resource resource, {int amount}) =>
      _catchError(() => _proto.drop(resource.toString(), amount));

  /// Produce a safe mode activation for an adjacent controller using 1,000
  /// ghodium.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InsufficientResourcesException] - This creep does not have enough
  /// ghodium.
  /// * [NotInRangeException] - The target controller is not adjacent to this
  /// creep.
  void generateSafeMode(StructureController target) =>
      _catchError(() => _proto.generateSafeMode(target._proto));

  /// Harvest resources from an adjacent source or mineral.
  ///
  /// Requires the [Bodypart.work] bodypart.
  /// The resulting resources will be added to the creep's inventory if it has
  /// available capacity.  Otherwise, the resources are dropped onto the ground.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotFoundException] - The target mineral must have an extractor in order
  /// to be harvestable.
  /// * [InsufficientResourcesException] - The target source doesn't contain
  /// any harvestable energy.
  /// * [NotInRangeException] - The target must be adjacent to this creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.work]
  /// bodypart.
  void harvest(Harvestable target) =>
      _catchError(() => _proto.harvest(target._proto));

  /// Heal this creep or an adjacent one.
  ///
  /// Requires the [Bodypart.heal] bodypart.
  /// Heals self or heals an adjacent creep.  This will restore the creep's
  /// damaged body parts function and increase the hits counter.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotInRangeException] - The target creep is not adjacent to this creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.heal] bodypart.
  void heal([Creep target]) =>
      _catchError(() => _proto.heal((target ?? this)._proto));

  /// Move one tile in the given direction.
  ///
  /// Requires the [Bodypart.move] bodypart.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [TiredException] - This creep is unable to move; it is currently
  /// fatigued.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.move]
  /// bodypart.
  void move(Direction direction) =>
      _catchError(() => _proto.move(direction.toInteger()));

  /// Move along a given path.
  ///
  /// Requires the [Bodypart.move] bodypart.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotFoundException] - The given path doesn't match this creep's
  /// location.
  /// * [InvalidArgumentException] - The given path is invalid.
  /// * [TiredException] - This creep is unable to move; it is currently
  /// fatigued.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.move]
  /// bodypart.
  void moveAlongPath(List<PathStep> path) =>
      _catchError(() => _proto.moveByPath(path.map((s) => s._object).toList()));

  /// Move towards a given position along a generated optimal path.
  ///
  /// Requires the [Bodypart.move] bodypart.
  /// If the target position is in another room, then the corresponding exit
  /// will be used as the target.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [NoPathException] - A path to the given target could not be found.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotFoundException] - The specified path doesn't match this creep's
  /// location.
  /// * [InvalidTargetException] - The given position is invalid.
  /// * [TiredException] - This creep is unable to move; it is currently
  /// fatigued.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.move] bodypart.
  void moveTo(RoomPosition target) =>
      _catchError(() => _proto.moveTo(target._proto));

  /// Pick up an adjacent dropped resource.
  ///
  /// Requires the [Bodypart.carry] bodypart.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [FullException] - The creep cannot receive any more energy.
  /// * [NotInRangeException] - The target resource is not adjacent to this
  /// creep.
  void pickup(DroppedResource target) =>
      _catchError(() => _proto.pickup(target._proto));

  /// Attack a creep or structure from a range.
  ///
  /// Requires the [Bodypart.rangedAttack] bodypart.
  /// If the target is within a rampart, the rampart is attacked instead.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotInRangeException] - The target is not in range of this creep.
  /// * [NoBodypartException] - This action requires at least 1
  /// [Bodypart.rangedAttack] bodypart.
  void rangedAttack(Attackable target) =>
      _catchError(() => _proto.rangedAttack(target._proto));

  /// Heal another creep from a range.
  ///
  /// Requires the [Bodypart.heal] bodypart.
  /// Has the same effect as [heal], albeit at a reduced effectiveness.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotInRangeException] - The target is not in range of this creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.heal]
  /// bodypart.
  void rangedHeal(Creep target) =>
      _catchError(() => _proto.rangedHeal(target._proto));

  /// Attack all creeps or structures in a radius.
  ///
  /// Requires the [Bodypart.rangedAttack] bodypart.
  /// See [Bodypart.rangedAttack] for more information.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NoBodypartException] - This action requires at least 1
  /// [Bodypart.rangedAttack] bodypart.
  void rangedMassAttack() => _catchError(_proto.rangedMassAttack);

  /// Repair a damaged structure.
  ///
  /// Requires the [Bodypart.work] and [Bodypart.carry] bodyparts.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InsufficientResourcesException] - This creep does not have enough
  /// energy.
  /// * [NotInRangeException] - The target is not in range of this creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.claim]
  /// bodypart.
  void repair(Structure target) =>
      _catchError(() => _proto.repair(target._proto));

  /// Reserve an adjacent controller so that other players cannot claim it.
  ///
  /// Requires the [Bodypart.claim] bodypart.
  /// See [Bodypart.claim] for more information.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [NotInRangeException] - The target controller is not adjacent to this
  /// creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.claim]
  /// bodypart.
  void reserverController(StructureController target) =>
      _catchError(() => _proto.reserveController(target._proto));

  /// Display a visual speech balloon above this creep.
  ///
  /// The message will be visible for a single tick.  A creep's last message can
  /// be read using the [saying] property. Any valid Unicode characters are
  /// allowed, including emoji.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  void say(String message, {bool isPublic}) =>
      _catchError(() => _proto.say(message, isPublic));

  /// Sign an adjacent controller with arbitrary text visible to all players.
  ///
  /// The sign text will appear in the room UI, in the world map, and can be
  /// accessed via the API.  You can sign unowned and hostile controllers.
  /// Pass an empty string to remove the sign.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InvalidTargetException] - The target is not a valid controller object.
  /// * [NotInRangeException] - The target is too far away.
  void signController(StructureController target, String text) =>
      _catchError(() => _proto.signController(target._proto, text));

  /// Kill this creep immediately.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  void suicide() => _catchError(_proto.suicide);

  /// Transfer resources from this creep to an adjacent object.  Omit [amount]
  /// to transfer all of the given resource.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InsufficientResourcesException] - The creep does not have the given
  /// amount of resources.
  /// * [InvalidTargetException] - The target cannot store the specified
  /// resource.
  /// * [FullException] - The target's inventory is full.
  /// * [NotInRangeException] - The target is not adjacent to this creep.
  /// * [InvalidArgumentException] - The given resource amount is invalid.
  void transfer(Transferable target, Resource resource, {int amount}) =>
      _catchError(
          () => _proto.transfer(target._proto, resource.toString(), amount));

  /// Upgrade your controller from a range using energy.  Upgrading controllers
  /// increases your global control level.
  ///
  /// Requires the [Bodypart.work] and [Bodypart.carry] bodyparts.
  /// A fully upgraded level 8 controller cannot be upgraded over
  /// 15 energy units per tick regardless of creep abilities. The cumulative
  /// effect of all the creeps performing [upgradeController] in the current
  /// tick is taken into account.
  /// This limit can be increased using the ghodium mineral boost.
  ///
  /// Upgrading a controller raises its [StructureController.ticksToDowngrade]
  /// timer by 100.  The timer must be full in order for the controller to be
  /// leveled up.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InsufficientResourcesException] - This creep does not have any energy
  /// in its inventory.
  /// * [InvalidTargetException] - The target controller is not yours or cannot
  /// be upgraded right now (due to being attacked).
  /// * [NotInRangeException] - The target controller is not in range of this creep.
  /// * [NoBodypartException] - This action requires at least 1 [Bodypart.work] bodypart.
  void upgradeController(StructureController target) =>
      _catchError(() => _proto.upgradeController(target._proto));

  /// Withdraw resources from an adjacent structure.
  ///
  /// Your creeps can withdraw resources from hostile structures, as long as
  /// no hostile rampart is on top of it.
  ///
  /// May throw:
  /// * [NotOwnerException] - You are not the owner of this creep.
  /// * [BusyException] - This creep is being spawned.
  /// * [InsufficientResourcesException] - The target structure does not have
  /// the given amount of resources.
  /// * [InvalidTargetException] - The target structure does not contain the
  /// given resource.
  /// * [FullException] - The creep's inventory is full.
  /// * [NotInRangeException] - The target is not adjacent to this creep.
  /// * [InvalidArgumentException] - The given resource amount is invalid.
  void withdraw(Structure target, Resource resource, {int amount}) =>
      _catchError(
          () => _proto.withdraw(target._proto, resource.toString(), amount));
}
