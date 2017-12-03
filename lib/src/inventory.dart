part of screeps;

class Inventory {
  final JsObject<String, int> _object;
  final int capacity;

  const Inventory._internal(this._object, {@required this.capacity});

  int operator [](Resource key) => _object[key._type] ?? 0;

  /// The current amount of the given resource being stored, represented as a
  /// percentage from 0 to 1.  Omit [resource] to compute this for all
  /// resources.
  num resourcePercent([Resource resource]) =>
      resource == null ? sum : this[resource] / capacity;

  /// The sum of all resources being contained in this inventory.
  int get sum => _object.values.fold(0, (total, amount) => total + amount);
}
