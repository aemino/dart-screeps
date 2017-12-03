part of screeps;

int _catchError(int method()) {
  final code = method();
  if (code < 0) throw new ScreepsException(code);
  return code;
}

Map<V, K> _reverseMap<K, V>(Map<K, V> map) =>
    new Map.fromIterables(map.values, map.keys);

@JS('Object.keys')
external List<dynamic> _getKeys(o);

@JS('Object.values')
external List<dynamic> _getValues(o);

class JsObject<K, V> {
  final dynamic _object;

  const JsObject(this._object);

  List<K> get keys => _getKeys(_object);
  List<V> get values => _getValues(_object);

  V operator [](K key) {
    var value = getProperty(_object, key);
    if (value == dynamic) value = new JsObject(value);

    return value;
  }

  void operator []=(K key, V value) {
    final jsifiedValue =
        (V is Iterable || V is Map) ? new js.JsObject.jsify(value) : value;
    setProperty(_object, key, jsifiedValue);
  }
}

typedef Constructor<V, T> = T Function(V value);

class ConstructiveJsObject<K, V, T> implements JsObject<K, T> {
  JsObject<K, V> _object;
  final Constructor<V, T> _construct;

  ConstructiveJsObject(dynamic object, this._construct) {
    _object = new JsObject(object);
  }

  List<K> get keys => _object.keys;
  List<T> get values => _object.values.map(_construct);

  T operator [](K key) => _construct(_object[key]);
  void operator []=(K key, dynamic value) => _object[key] = value;
}
