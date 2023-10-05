class JobType {
  static const landscaping = 'Благоустройство';
  static const anotheJob = 'Иные работы';
  static const generalConstruction = 'Общестроительные';
  static const sanitaryEngineering = 'Сантехника';
  static const electrics = 'Электрика';

  static List<String> get all => [
        landscaping,
        anotheJob,
        generalConstruction,
        sanitaryEngineering,
        electrics,
      ];
}
