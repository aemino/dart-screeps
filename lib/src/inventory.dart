part of screeps;

class Inventory {
  final JsObject<String, int> _objectt;
  final int capacity;

  const Inventory._internal(this._objectt, {@required this.capacity});

  int operator [](Resource key) => _objectt[key._type] ?? 0;

  /// The current amount of the given resource being stored, represented as a
  /// percentage from 0 to 1.  Omit [resource] to compute this for all
  /// resources.
  num resourcePercent([Resource resource]) =>
      resource == null ? sum : this[resource] / capacity;

  /// The sum of all resources being contained in this inventory.
  int get sum => _objectt.values.fold(0, (total, amount) => total + amount);
}
