part of screeps;

@JS('Memory')
abstract class _MemoryStatics {
  external static dynamic get creeps;
  external static dynamic get flags;
  external static dynamic get rooms;
  external static dynamic get spawns;
}

@JS('Memory')
external dynamic get _Memory; // ignore: non_constant_identifier_names

class MemoryObject extends JsObject<String, dynamic> {
  MemoryObject(object) : super(object);

  JsObject<String, dynamic> creeps = new JsObject(_MemoryStatics.creeps);
  JsObject<String, dynamic> flags = new JsObject(_MemoryStatics.flags);
  JsObject<String, dynamic> rooms = new JsObject(_MemoryStatics.rooms);
  JsObject<String, dynamic> spawns = new JsObject(_MemoryStatics.spawns);
}

// ignore: non_constant_identifier_names
final Memory = new MemoryObject(_Memory);
