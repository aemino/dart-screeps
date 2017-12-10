part of screeps;

@JS('Nuke')
abstract class _NukePrototype implements _RoomObjectPrototype {
  external String get launchRoomName;
  external int get timeToLand;
}

class Nuke<T extends _NukePrototype> extends RoomObject<T> {
  Nuke._internal(T _proto) : super._internal(_proto);

  /// The name of the room where this nuke was launched from.
  String get launchRoomName => _proto.launchRoomName;

  /// The room where this nuke was launched from.
  ///
  /// May be null if you don't have vision of the room.
  Room get launchRoom => Game.rooms[launchRoomName];

  /// The number of ticks before this nuke lands.
  int get timeToLand => _proto.timeToLand;
}
