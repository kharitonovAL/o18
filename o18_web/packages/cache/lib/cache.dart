library cache;

/// An in-memory cache client.
class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({
    required String key,
    required T value,
  }) {
    _cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({
    required String key,
  }) {
    final value = _cache[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Removes all entries from the CacheClient.
  ///
  /// After this, the CacheClient is empty.
  void clearCache() => _cache.clear();
}
