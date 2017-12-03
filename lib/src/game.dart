part of screeps;

@JS('Game')
abstract class _Game {
  external static dynamic get constructionSites;
  // TODO: cpu
  external static dynamic get creeps;
  external static dynamic get flags;
  // TODO: gcl
  // TODO: map
  // TODO: market
  external static dynamic get resources;
  external static dynamic get rooms;

  /// TODO: shard
  external static dynamic get spawns;
  external static dynamic get structures;
  external static int get time;

  external static dynamic getObjectById(String id);
  external static void notify(String message, [int groupInterval]);
}

abstract class Game {
  /// A hash map of all of your construction sites, mapped by id.
  static ConstructiveJsObject<String, _ConstructionSitePrototype,
          ConstructionSite>
      get constructionSites => new ConstructiveJsObject(
          _Game.constructionSites, (v) => new ConstructionSite._internal(v));

  /// A hash map of all of your creeps, mapped by name.
  static ConstructiveJsObject<String, _CreepPrototype, Creep> get creeps =>
      new ConstructiveJsObject(_Game.creeps, (v) => new Creep._internal(v));

  /// A hash map of all of your flags, mapped by name.
  static ConstructiveJsObject<String, _FlagPrototype, Flag> get flags =>
      new ConstructiveJsObject(_Game.flags, (v) => new Flag._internal(v));

  static Inventory get resources =>
      new Inventory._internal(new JsObject(_Game.resources), capacity: -1);

  /// A hash map of all visible rooms in the game, mapped by name.
  static ConstructiveJsObject<String, _RoomPrototype, Room> get rooms =>
      new ConstructiveJsObject(_Game.rooms, (v) => new Room._internal(v));

  /// A hash map of all of your spawns in the game, mapped by name.
  static ConstructiveJsObject<String, _StructureSpawnPrototype, StructureSpawn>
      get spawns => new ConstructiveJsObject(
          _Game.spawns, (v) => new StructureSpawn._internal(v));

  /// A hash map of all of your structures in the game, mapped by id.
  static ConstructiveJsObject<String, _OwnedStructurePrototype, OwnedStructure>
      get structures => new ConstructiveJsObject(
          _Game.spawns, (v) => new OwnedStructure._internal(v));

  /// The current game tick.
  static int get tick => _Game.time;

  /// Fetch an object instance by ID.  Returns `null` if the object cannot be
  /// found.
  static RoomObject getObjectByID(String id) {
    final instance = _Game.getObjectById(id);
    return instance != null ? new RoomObject._internal(instance) : null;
  }

  // TODO: improve groupInterval docs
  /// Send a custom message to your profile e-mail.
  ///
  /// Up to 20 notifications can be scheduled per tick.
  static void notify(String message, {int groupInterval}) =>
      _Game.notify(message, groupInterval);
}
