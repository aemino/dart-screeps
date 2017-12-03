part of screeps;

typedef void CostPredicate(String roomName, dynamic costMatrix);
typedef bool FilterPredicate(RoomObject object);

class PathFinderOptions {
  /// True if creeps should be treated as traversable.
  final bool ignoreCreeps;

  /// True if destructible structures should treated as traversable.
  final bool ignoreDestructibleStructures;

  /// True if roads should be ignored during the search.  Can increase search
  /// performance.
  final bool ignoreRoads;

  /// This function can be used to modify the [CostMatrix] for a room during
  /// the search.  Only works if the new [PathFinder] is enabled.
  final costPredicate;

  /// The maximum number of operations to perform.  Each operation costs
  /// approximately 0.001 CPU.
  final int maxOps;

  /// The weight to apply to the heuristic in the A* algorithm.  Only use this
  /// option if you understand how A* pathfinding algorithm works.
  final num heuristicWeight;

  /// The maximum number of rooms to search.
  /// Does not work if the new [PathFinder] is enabeld.
  final int maxRooms;
}

@JS()
@anonymous
abstract class _PathStep {
  external int get x;
  external int get y;
  external int get dx;
  external int get dy;
  external int get direction;
}

class PathStep<T extends _PathStep> {
  T _object;

  PathStep._internal(this._object);

  /// The x-coordinate of this step.
  int get x => _object.x;

  /// The y-coordinate of this step.
  int get y => _object.y;

  /// The x-coordinate delta from the previous step.
  int get dx => _object.dx;

  /// The y-coordinate delta from the previous step.
  int get dy => _object.dy;

  /// The direction this step is moving in.
  Direction get direction => _intToDirection[_object.direction];
}

@JS('Room')
abstract class _RoomPrototype implements _EnergyContainer, _HasMemory {
  @JS('energyAvailable')
  external int get energy;

  @JS('energyCapacity')
  external int get energyCapacity;

  external String get name;
  external _StructureControllerPrototype get controller;
  external _StructureStoragePrototype get storage;
  external _StructureTerminalPrototype get terminal;
  external _RoomVisualPrototype get visual;

  external static String serializePath(List<_PathStep> path);
  external static List<_PathStep> deserializePath(String path);
  external List<dynamic> find(int type, js.JsObject opts);
  external int findExitTo(String roomName);
  external _RoomPosition getPositionAt(int x, int y);
  external List<dynamic> lookForAtArea(
      String type, int top, int left, int bottom, int right,
      [bool asArray = true]); // ignore: avoid_positional_boolean_parameters
}

class Room<T extends _RoomPrototype> extends EnergyContainer<T>
    with HasMemory<T> {
  final T _proto;

  Room._internal(this._proto);

  StructureController get controller =>
      new StructureController._internal(_proto.controller);

  StructureStorage get storage =>
      new StructureStorage._internal(_proto.storage);

  StructureTerminal get terminal =>
      new StructureTerminal._internal(_proto.terminal);

  RoomVisual get visual => new RoomVisual._internal(_proto.visual);

  /// Serialize a list of [PathStep]s into a string, which is more suitable for
  /// storing in memory.
  static String serializePath(List<PathStep> path) =>
      _RoomPrototype.serializePath(path.map((s) => s._object).toList());

  /// Deserialize a serialized list of [PathStep]s.
  static List<PathStep> deserializePath(String path) => _RoomPrototype
      .deserializePath(path)
      .map((s) => new PathStep._internal(s))
      .toList();

  /// Find all of the objects of the given type in this room.
  List<T> find<T>(Find<T> type, {FilterPredicate filter}) {
    final objects = _proto.find(
        type.toInteger(),
        new js.JsObject.jsify(
            {'filter': filter != null ? allowInterop(filter) : null}));
    return objects.map((o) {
      if (type is Find<RoomObject>)
        return new RoomObject<_RoomObjectPrototype>._internal(o);
      if (type is Find<RoomPosition>)
        return new RoomPosition<_RoomPosition>._internal(o);
      return o;
    }).toList();
  }

  /// Determine the exit direction from this room to another.
  ///
  /// May throw:
  /// * [NoPathException] - An exit to the given room cannot be found.
  /// * [InvalidArgumentException] - The given room is invalid.
  Find findExitTo(String roomName) =>
      _intToFind[_catchError(() => _proto.findExitTo(roomName))];

  /// Instantiate a [RoomPosition] in this room for the given coordinates.
  RoomPosition pos(int x, int y) =>
      new RoomPosition._internal(_proto.getPositionAt(x, y));

  List<T> lookForInArea<T>(Look<T> type,
      {int top, int right, int bottom, int left}) {
    final objects =
        _proto.lookForAtArea(type.toString(), top, left, bottom, right);
    return objects.map((o) {
      final obj = new JsObject<String, dynamic>(o);
      final object = obj[type.toString()];
      if (T is RoomObject)
        return new RoomObject<_RoomObjectPrototype>._internal(object);
      return object;
    }).toList();
  }
}

@JS('RoomPosition')
abstract class _RoomPosition {
  external factory _RoomPosition(int x, int y, String roomName);

  external int get x;
  external int get y;
  external String get roomName;

  external int createConstructionSite(String structureType);
  external int createFlag([String name, int color, int secondaryColor]);
  external T findClosestByPath<T>(List<T> objects, [js.JsObject opts]);
  external T findClosestByRange<T>(List<T> objects, [js.JsObject opts]);
  external List<_PathStep> findPathTo(_RoomPosition pos, [js.JsObject opts]);
  external int getDirectionTo(_RoomPosition pos);
  external int getRangeTo(_RoomPosition pos);
  external bool inRangeTo(_RoomPosition pos, int range);
  external bool isEqualTo(_RoomPosition pos);
  external bool isNearTo(_RoomPosition pos);
  external List<dynamic> lookFor(String type);
}

class RoomPosition<T extends _RoomPosition> {
  T _proto;

  factory RoomPosition(int x, int y, String roomName) =>
      new RoomPosition._internal(new _RoomPosition(x, y, roomName));

  RoomPosition._internal(this._proto);

  /// The x-position in the room.
  int get x => _proto.x;

  /// The y-position in the room.
  int get y => _proto.y;

  /// The name of the room this position represents.
  String get roomName => _proto.roomName;

  /// The room this position represents.
  ///
  /// May be null if you don't have vision of the room.
  Room get room => Game.rooms[roomName];

  /// Create a [ConstructionSite] at this position.
  ///
  /// May throw:
  /// * [InvalidTargetException] - The given structure cannot be placed at this
  /// position.
  /// * [FullException] - You have too many construction sites (100).
  /// * [InvalidArgumentException] - This position is invalid.
  /// * [InsufficientRclException] - Your room controller level is below the
  /// level required to place a construction site.
  void createConstructionSite(StructureType structure) => _catchError(
      () => _proto.createConstructionSite(_structureTypeToString[structure]));

  /// Create a [Flag] at this position.
  ///
  /// The default primary color is white.  The default secondary color is the
  /// primary color.
  ///
  /// May throw:
  /// * [DuplicateNameException] - You already have a flag of the same name.
  /// * [InvalidArgumentException] - This position is invalid.
  void createFlag([String name, Color primaryColor, Color secondaryColor]) =>
      _catchError(() => _proto.createFlag(
          name, primaryColor.toInteger(), secondaryColor.toInteger()));

  /// Find the closest position to this position out of the given positions.
  RoomPosition findClosestPosition(List<RoomPosition> positions,
      {FilterPredicate filter, bool byPath = false}) {
    final protos = positions.map((o) => o._proto).toList();
    final opts = new js.JsObject.jsify(
        {'filter': filter != null ? allowInterop(filter) : null});
    final object = byPath
        ? _proto.findClosestByPath
        : _proto.findClosestByRange(protos, opts);

    return new RoomPosition._internal(object);
  }

  /// Find the closest object to this object out of the given object.
  T findClosestObject<T extends RoomObject<_RoomObjectPrototype>>(
      List<T> objects,
      {FilterPredicate filter,
      bool byPath = false}) {
    final protos = objects.map((o) => o._proto).toList();
    final opts = new js.JsObject.jsify(
        {'filter': filter != null ? allowInterop(filter) : null});
    final object = byPath
        ? _proto.findClosestByPath
        : _proto.findClosestByRange(protos, opts);

    return new RoomObject<_RoomObjectPrototype>._internal(object) as T;
  }

  /// Find a path from this position to [pos].
  List<PathStep> findPathTo(RoomPosition pos) => _proto
      .findPathTo(pos._proto)
      .map((s) => new PathStep._internal(s))
      .toList();

  /// Compute the direction towards the given position.
  Direction getDirectionTo(RoomPosition pos) =>
      _intToDirection[_proto.getDirectionTo(pos._proto)];

  /// Compute the range at which the given position is from this one.
  ///
  /// Note that ranges in the game are regarded as squares.  The range from one
  /// position to another is whichever is greater between the delta x and delta
  /// y.
  int getRangeTo(RoomPosition pos) => _proto.getRangeTo(pos._proto);

  List<T> lookFor<T>(Look<T> type) {
    final objects = _proto.lookFor(type.toString());
    return objects.map((o) {
      if (T is RoomObject)
        return new RoomObject<_RoomObjectPrototype>._internal(o);
      return o;
    }).toList();
  }

  /// Compute the squared distance between this position and the given position.
  double squaredDistanceTo(RoomPosition pos) {
    if (roomName != pos.roomName) return double.INFINITY;
    return pow(pos.x - x, 2) + pow(pos.y - y, 2);
  }

  /// Compute the distance between this position and the given position.
  ///
  /// Note that this method is more computationally expensive than
  /// [squaredDistanceTo].
  double distanceTo(RoomPosition pos) {
    if (roomName != pos.roomName) return double.INFINITY;
    return sqrt(pow(pos.x - x, 2) + pow(pos.y - y, 2));
  }

  int get hashCode => roomName.hashCode * x * y;

  /// Returns true if other is a RoomPosition with the same room name,
  /// x-coordinate, and y-coordinate.
  bool operator ==(dynamic other) {
    if (other is! RoomPosition) return false;
    return (other.roomName == roomName && other.x == x && other.y == y);
  }

  /// Addition operator.  Both positions must be in the same room.
  RoomPosition operator +(RoomPosition other) {
    if (other.roomName != roomName)
      throw new ArgumentError(
          'Cannot add two RoomPositions with different rooms.');
    return new RoomPosition(x + other.x, y + other.y, roomName);
  }

  /// Subtraction operator.  Both positions must be in the same room.
  RoomPosition operator -(RoomPosition other) {
    if (other.roomName != roomName)
      throw new ArgumentError(
          'Cannot subtract two RoomPositions with different rooms.');
    return new RoomPosition(x - other.x, y - other.y, roomName);
  }

  /// Multiplication operator.  Both positions must be in the same room.
  RoomPosition operator *(RoomPosition other) {
    if (other.roomName != roomName)
      throw new ArgumentError(
          'Cannot multiply two RoomPositions with different rooms.');
    return new RoomPosition(x * other.x, y * other.y, roomName);
  }

  /// Division operator.  Both positions must be in the same room.
  /// The resulting coordinates are rounded down.
  RoomPosition operator /(RoomPosition other) {
    if (other.roomName != roomName)
      throw new ArgumentError(
          'Cannot divide two RoomPositions with different rooms.');
    return new RoomPosition(
        (x / other.x).floor(), (y / other.y).floor(), roomName);
  }
}

@JS('RoomObject')
abstract class _RoomObjectPrototype {
  external _RoomPosition get pos;
  external _RoomPrototype get room;
}

class RoomObject<T extends _RoomObjectPrototype> {
  T _proto;

  RoomObject._internal(this._proto);

  /// The position of this room object.
  RoomPosition get pos => new RoomPosition._internal(_proto.pos);

  /// The room this object resides in.
  ///
  /// May be null if this object is a flag or construction site.
  /// Also may be null if this object is in a room that is not visible to you.
  Room get room => new Room._internal(_proto.room);
}

@JS('RoomVisual')
abstract class _RoomVisualPrototype {}

class RoomVisual<T extends _RoomVisualPrototype> {
  T _proto;

  RoomVisual._internal(this._proto);
}
