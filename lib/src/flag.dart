part of screeps;

@JS('Flag')
abstract class _FlagPrototype implements _RoomObjectPrototype, _HasMemory {
  external int get color;
  external String get name;
  external int get secondaryColor;

  external int remove();
  external int setColor(int color, [int secondaryColor]);
  external int setPosition(_RoomPosition pos);
}

class Flag<T extends _FlagPrototype> extends RoomObject<T> with HasMemory<T> {
  final T _proto;

  Flag._internal(this._proto) : super._internal(_proto);

  /// The name of this flag.  The name is unique, immutable, and chosen upon
  /// flag creation.
  ///
  /// Flags can be fetched from the [Game.flags] map using this name.
  String get name => _proto.name;

  /// The primary color of this flag.
  Color get primaryColor => _intToColor[_proto.color];

  /// The secondary color of this flag.
  Color get secondaryColor => _intToColor[_proto.secondaryColor];

  /// Remove this flag.
  void remove() => _catchError(_proto.remove);

  /// Set new color(s) for this flag.
  void setColor({@required Color primary, Color secondary}) => _catchError(
      () => _proto.setColor(primary.toInteger(), secondary.toInteger()));

  /// Set a new position for this flag.
  ///
  /// May throw:
  /// * [InvalidTargetException] - The provided position is invalid.
  void setPosition(RoomPosition pos) =>
      _catchError(() => _proto.setPosition(pos._proto));
}
