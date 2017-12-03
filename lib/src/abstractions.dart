part of screeps;

class ScreepsException implements Exception {
  factory ScreepsException(int errCode) {
    if (errCode == _errNotOwner) return new NotOwnerException();
    if (errCode == _errNoPath) return new NoPathException();
    if (errCode == _errNameExists) return new DuplicateNameException();
    if (errCode == _errBusy) return new BusyException();
    if (errCode == _errNotFound) return new NotFoundException();
    if (errCode == _errNotEnoughEnergy || errCode == _errNotEnoughResources)
      return new InsufficientResourcesException();
    if (errCode == _errInvalidTarget) return new InvalidTargetException();
    if (errCode == _errFull) return new FullException();
    if (errCode == _errNotInRange) return new NotInRangeException();
    if (errCode == _errInvalidArgs) return new InvalidArgumentException();
    if (errCode == _errTired) return new TiredException();
    if (errCode == _errNoBodypart) return new NoBodypartException();
    if (errCode == _errNotEnoughExtensions)
      return new InsufficientExtensionsException();
    if (errCode == _errRclNotEnough) return new InsufficientRclException();
    if (errCode == _errGclNotEnough) return new InsufficientGclException();

    throw new UnimplementedError();
  }
}

class NotOwnerException implements ScreepsException {}

class NoPathException implements ScreepsException {}

class DuplicateNameException implements ScreepsException {}

class BusyException implements ScreepsException {}

class NotFoundException implements ScreepsException {}

class InsufficientResourcesException implements ScreepsException {}

class InvalidTargetException implements ScreepsException {}

class FullException implements ScreepsException {}

class NotInRangeException implements ScreepsException {}

class InvalidArgumentException implements ScreepsException {}

class TiredException implements ScreepsException {}

class NoBodypartException implements ScreepsException {}

class InsufficientExtensionsException implements ScreepsException {}

class InsufficientRclException implements ScreepsException {}

class InsufficientGclException implements ScreepsException {}

abstract class Find<T> {
  int get _index;

  static final Find<RoomPosition> exitsTop = new _FindImpl(_findExitsTop);
  static final Find<RoomPosition> exitsRight = new _FindImpl(_findExitsRight);
  static final Find<RoomPosition> exitsBottom = new _FindImpl(_findExitsBottom);
  static final Find<RoomPosition> exitsLeft = new _FindImpl(_findExitsLeft);
  static final Find<RoomPosition> exits = new _FindImpl(_findExits);
  static final Find<Creep> creeps = new _FindImpl(_findCreeps);
  static final Find<Creep> myCreeps = new _FindImpl(_findMyCreeps);
  static final Find<Creep> hostileCreeps = new _FindImpl(_findHostileCreeps);
  static final Find<Source> sourcesActive = new _FindImpl(_findSourcesActive);
  static final Find<Source> sources = new _FindImpl(_findSources);
  static final Find<DroppedResource> droppedResources =
      new _FindImpl(_findDroppedResources);
  static final Find<Structure> structures = new _FindImpl(_findStructures);
  static final Find<OwnedStructure> myStructures =
      new _FindImpl(_findMyStructures);
  static final Find<OwnedStructure> hostileStructures =
      new _FindImpl(_findHostileStructures);
  static final Find<Flag> flags = new _FindImpl(_findFlags);
  static final Find<ConstructionSite> constructionSites =
      new _FindImpl(_findConstructionSites);
  static final Find<StructureSpawn> mySpawns = new _FindImpl(_findMySpawns);
  static final Find<StructureSpawn> hostileSpawns =
      new _FindImpl(_findHostileSpawns);
  static final Find<ConstructionSite> myConstructionSites =
      new _FindImpl(_findMyConstructionSites);
  static final Find<ConstructionSite> hostileConstructionSites =
      new _FindImpl(_findHostileConstructionSites);
  static final Find<Mineral> minerals = new _FindImpl(_findMinerals);
  static final Find<Nuke> nukes = new _FindImpl(_findNukes);

  int toInteger() => _index;
}

class _FindImpl<T> extends Find<T> {
  final int _index;

  _FindImpl(this._index);
}

abstract class Direction {
  int get _index;

  /// The x-coordinate delta of this direction.
  int get dx;

  /// The y-coordinate delta of this direction.
  int get dy;

  static final Direction top = new _DirectionImpl(_directionTop, 0, 1);
  static final Direction topRight =
      new _DirectionImpl(_directionTopRight, 1, 1);
  static final Direction right = new _DirectionImpl(_directionRight, 1, 0);
  static final Direction bottomRight =
      new _DirectionImpl(_directionBottomRight, 1, -1);
  static final Direction bottom = new _DirectionImpl(_directionBottom, 0, -1);
  static final Direction bottomLeft =
      new _DirectionImpl(_directionBottomLeft, -1, -1);
  static final Direction left = new _DirectionImpl(_directionLeft, -1, 0);
  static final Direction topLeft = new _DirectionImpl(_directionTopLeft, -1, 1);

  int toInteger() => _index;
}

class _DirectionImpl extends Direction {
  final int _index;
  final int dx;
  final int dy;

  _DirectionImpl(this._index, this.dx, this.dy);
}

abstract class Color {
  int get _index;

  static final Color red = new _ColorImpl(_colorRed);
  static final Color purple = new _ColorImpl(_colorPurple);
  static final Color blue = new _ColorImpl(_colorBlue);
  static final Color cyan = new _ColorImpl(_colorCyan);
  static final Color green = new _ColorImpl(_colorGreen);
  static final Color yellow = new _ColorImpl(_colorYellow);
  static final Color orange = new _ColorImpl(_colorOrange);
  static final Color brown = new _ColorImpl(_colorBrown);
  static final Color grey = new _ColorImpl(_colorGrey);
  static final Color white = new _ColorImpl(_colorWhite);

  int toInteger() => _index;
}

class _ColorImpl extends Color {
  final int _index;

  _ColorImpl(this._index);
}

abstract class Look<T> {
  String get _type;

  static final Look<Creep> creeps = new _LookImpl(_lookCreeps);
  static final Look<DroppedResource> droppedEnergy =
      new _LookImpl(_lookDroppedEnergy);
  static final Look<DroppedResource> droppedResources =
      new _LookImpl(_lookDroppedResources);
  static final Look<Source> sources = new _LookImpl(_lookSources);
  static final Look<Mineral> minerals = new _LookImpl(_lookMinerals);
  static final Look<Structure> structures = new _LookImpl(_lookStructures);
  static final Look<Flag> flags = new _LookImpl(_lookFlags);
  static final Look<ConstructionSite> constructionSites =
      new _LookImpl(_lookConstructionSites);
  static final Look<Nuke> nukes = new _LookImpl(_lookNukes);
  static final Look<String> terrain = new _LookImpl(_lookTerrain);

  String toString() => _type;
}

class _LookImpl<T> extends Look<T> {
  final String _type;

  _LookImpl(this._type);
}

abstract class Bodypart {
  String get _type;
  int get cost;

  /// Each instance of this part reduces a creep's fatigue by 2 points per tick.
  static final Bodypart move = new _BodypartImpl(_bodypartMove);

  /// This part allows a creep to do various kinds of work.
  ///
  /// Specifically, each instance of this part will allow a creep to:
  /// * harvest 2 energy units from a source per tick
  /// * harvest 1 mineral unit from a deposit per tick
  /// * build a structure for 5 energy units per tick
  /// * repair a structure by 100 hitpoints for 1 energy per tick
  /// * dismantle a structure by 50 hitpoints to gain 0.25 energy units per tick
  /// * upgrade a controller for 1 energy unit per tick
  static final Bodypart work = new _BodypartImpl(_bodypartWork);

  /// Each instance of this part allows a creep to carry 50 resource units.
  static final Bodypart carry = new _BodypartImpl(_bodypartCarry);

  /// This part allows a creep to attack an adjacent creep or structure.
  ///
  /// Each instance of this part allows a creep to damage an adjacent creep or
  /// structure by 30 hitpoints per tick.
  static final Bodypart attack = new _BodypartImpl(_bodypartAttack);

  /// This part allows a creep to attack a creep or structure from a range.
  ///
  /// Each instance of this part allows a creep to damage a creep or structure in
  /// a range with a radius of 3 squares.  This single target attack removes 10
  /// hitpoints per tick.  This part also allows a creep to perform a ranged
  /// area-of-effect attack.
  /// The amount of hitpoints removed by the AoE attack varies by distance:
  /// * 1 square away: 10 hitpoints
  /// * 2 squares away: 4 hitpoints
  /// * 3 squares away: 1 hitpoint
  static final Bodypart rangedAttack = new _BodypartImpl(_bodypartRangedAttack);

  /// This part has no special effect.  It is simply a buffer for incoming
  /// damage.  Ensure that this part is at the beginning of a creep's body, as
  /// bodyparts are damaged in sequential order.
  static final Bodypart tough = new _BodypartImpl(_bodypartTough);

  /// This part allows a creep to heal itself or another creep.
  ///
  /// Each instance of this part will heal 12 hitpoints per tick to adjacent
  /// creeps, or 4 hitpoints per tick to creeps at a distance.
  static final Bodypart heal = new _BodypartImpl(_bodypartHeal);

  /// This part allows a creep to claim, reserve, and attack adjacent
  /// controllers.
  ///
  /// Each instance of this part allows a creep to reserve a neutral room
  /// controller for 1 tick (for a maximum of 5,000 ticks.)
  ///
  /// Each instance of this part also allows a creep to downgrade or decrease
  /// the reservation timer of an enemy controller or by 300 ticks.  Note
  /// that attacking enemy controllers requires at least 5 instances of this
  /// part.  After an enemy controller is attacked, it cannot be upgraded
  /// or attacked again for the next 1,000 ticks.
  static final Bodypart claim = new _BodypartImpl(_bodypartClaim);

  String toString() => _type;
}

class _BodypartImpl extends Bodypart {
  final String _type;
  final int cost;

  _BodypartImpl(this._type) : cost = _bodypartCost[_type];
}

abstract class Resource {
  String get _type;

  static final Resource energy = new _ResourceImpl(_resourceEnergy);
  static final Resource power = new _ResourceImpl(_resourcePower);

  static final Resource hydrogen = new _ResourceImpl(_resourceHydrogen);
  static final Resource oxygen = new _ResourceImpl(_resourceOxygen);
  static final Resource utrium = new _ResourceImpl(_resourceUtrium);
  static final Resource keanium = new _ResourceImpl(_resourceKeanium);
  static final Resource lemergium = new _ResourceImpl(_resourceLemergium);
  static final Resource zynthium = new _ResourceImpl(_resourceZynthium);
  static final Resource catalyst = new _ResourceImpl(_resourceCatalyst);
  static final Resource ghodium = new _ResourceImpl(_resourceGhodium);

  static final Resource hydroxide = new _ResourceImpl(_resourceHydroxide);
  static final Resource zynthiumKeanite =
      new _ResourceImpl(_resourceZynthiumKeanite);
  static final Resource utriumLemergite =
      new _ResourceImpl(_resourceUtriumLemergite);

  static final Resource utriumHydride =
      new _ResourceImpl(_resourceUtriumHydride);
  static final Resource utriumOxide = new _ResourceImpl(_resourceUtriumOxide);
  static final Resource keaniumHydride =
      new _ResourceImpl(_resourceKeaniumHydride);
  static final Resource keaniumOxide = new _ResourceImpl(_resourceKeaniumOxide);
  static final Resource lemergiumHydride =
      new _ResourceImpl(_resourceLemergiumHydride);
  static final Resource lemergiumOxide =
      new _ResourceImpl(_resourceLemergiumOxide);
  static final Resource zynthiumHydride =
      new _ResourceImpl(_resourceZynthiumHydride);
  static final Resource zynthiumOxide =
      new _ResourceImpl(_resourceZynthiumOxide);
  static final Resource ghodiumHydride =
      new _ResourceImpl(_resourceGhodiumHydride);
  static final Resource ghodiumOxide = new _ResourceImpl(_resourceGhodiumOxide);

  static final Resource utriumAcid = new _ResourceImpl(_resourceUtriumAcid);
  static final Resource utriumAlkalide =
      new _ResourceImpl(_resourceUtriumAlkalide);
  static final Resource keaniumAcid = new _ResourceImpl(_resourceKeaniumAcid);
  static final Resource keaniumAlkalide =
      new _ResourceImpl(_resourceKeaniumAlkalide);
  static final Resource lemergiumAcid =
      new _ResourceImpl(_resourceLemergiumAcid);
  static final Resource lemergiumAlkalide =
      new _ResourceImpl(_resourceLemergiumAlkalide);
  static final Resource zynthiumAcid = new _ResourceImpl(_resourceZynthiumAcid);
  static final Resource zynthiumAlkalide =
      new _ResourceImpl(_resourceZynthiumAlkalide);
  static final Resource ghodiumAcid = new _ResourceImpl(_resourceGhodiumAcid);
  static final Resource ghodiumAlkalide =
      new _ResourceImpl(_resourceGhodiumAlkalide);

  static final Resource catalyzedUtriumAcid =
      new _ResourceImpl(_resourceCatalyzedUtriumAcid);
  static final Resource catalyzedUtriumAlkalide =
      new _ResourceImpl(_resourceCatalyzedUtriumAlkalide);
  static final Resource catalyzedKeaniumAcid =
      new _ResourceImpl(_resourceCatalyzedKeaniumAcid);
  static final Resource catalyzedKeaniumAlkalide =
      new _ResourceImpl(_resourceCatalyzedKeaniumAlkalide);
  static final Resource catalyzedLemergiumAcid =
      new _ResourceImpl(_resourceCatalyzedLemergiumAcid);
  static final Resource catalyzedLemergiumAlkalide =
      new _ResourceImpl(_resourceCatalyzedLemergiumAlkalide);
  static final Resource catalyzedZynthiumAcid =
      new _ResourceImpl(_resourceCatalyzedZynthiumAcid);
  static final Resource catalyzedZynthiumAlkalide =
      new _ResourceImpl(_resourceCatalyzedZynthiumAlkalide);
  static final Resource catalyzedGhodiumAcid =
      new _ResourceImpl(_resourceCatalyzedGhodiumAcid);
  static final Resource catalyzedGhodiumAlkalide =
      new _ResourceImpl(_resourceCatalyzedGhodiumAlkalide);

  String toString() => _type;
}

class _ResourceImpl extends Resource {
  final String _type;

  _ResourceImpl(this._type);
}

enum StructureType {
  container,
  controller,
  extension,
  extractor,
  keeperLair,
  lab,
  link,
  nuker,
  observer,
  portal,
  powerBank,
  powerSpawn,
  rampart,
  road,
  spawn,
  storage,
  terminal,
  tower,
  wall
}
