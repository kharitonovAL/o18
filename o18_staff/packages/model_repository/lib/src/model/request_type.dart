class RequestType {
  /// Авария
  static const failure = 'Авария';
  
  /// Платная
  static const paid = 'Платная';
  
  /// Текущий ремонт
  static const maintenance = 'Текущий ремонт';

  /// Плановая
  static const scheduled = 'Плановая';

  static List<String> get all => [
        failure,
        paid,
        maintenance,
        scheduled,
      ];
}
