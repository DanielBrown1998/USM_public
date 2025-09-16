class Status {
  static const String marcada = "MARCADA";
  static const String ausente = "AUSENTE";
  static const String presente = "PRESENTE";

  static List<String> get allStatus => [marcada, ausente, presente];
}

class Campus {
  static const String zonaOeste = "Zona Oeste";
  static const String maracana = "Maracana";
  static const String teresopolis = "Teresopolis";
  static const String resende = "Resende";
  static const String petropolis = "Petropolis";
  static const String saoGoncalo = "Sao Goncalo";
  static const String novaFriburgo = "Nova Friburgo";
  static const String duqueDeCaxias = "Duque de Caxias";

  static List<String> get allCampus => [
        zonaOeste,
        maracana,
        teresopolis,
        resende,
        petropolis,
        saoGoncalo,
        novaFriburgo,
        duqueDeCaxias
      ];
}
