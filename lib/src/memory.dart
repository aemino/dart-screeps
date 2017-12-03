part of screeps;

@JS('Memory')
abstract class _Memory {
  external static dynamic get creeps;
  external static dynamic get flags;
  external static dynamic get rooms;
  external static dynamic get spawns;
}

abstract class Memory {
  static JsObject<String, dynamic> get creeps => new JsObject(_Memory.creeps);
  static JsObject<String, dynamic> get flags => new JsObject(_Memory.flags);
  static JsObject<String, dynamic> get rooms => new JsObject(_Memory.rooms);
  static JsObject<String, dynamic> get spawns => new JsObject(_Memory.spawns);
}
