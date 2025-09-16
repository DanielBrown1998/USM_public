// import "package:app/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:app/domain/models/monitoria.dart";

class MonitoriasService {
  static Future<void> saveMonitoria(
      {required FirebaseFirestore firestore,
      required Monitoria monitoria}) async {
    await firestore
        .collection("monitorias")
        .doc(monitoria.id)
        .set(monitoria.toMap());
  }

  static Future<List<Monitoria>> getAllMonitorias(
      FirebaseFirestore firestore) async {
    List<Monitoria> monitorias = [];
    var snapshot = await firestore.collection("monitorias").get();
    for (var item in snapshot.docs) {
      monitorias.add(Monitoria.fromMap(item.data()));
    }
    return monitorias;
  }
}
