// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/domain/models/disciplinas.dart';

class User {
  String firstName;
  String lastName;
  String userName;
  String email;
  String uid;
  String phone;
  bool isStaff;
  bool isActive;
  bool isSuperUser;
  DateTime? lastLogin;
  DateTime? dateJoined;
  List<Disciplina> disciplinas;
  String campus;

  User(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.phone,
      required this.uid,
      required this.isStaff,
      required this.isActive,
      required this.isSuperUser,
      required this.lastLogin,
      required this.dateJoined,
      required this.disciplinas,
      required this.campus});

  User.fromMap(Map<String, dynamic> map)
      : firstName = map["firstName"],
        lastName = map["lastName"],
        userName = map["userName"],
        email = map["email"],
        uid = map["uid"],
        phone = map["phone"],
        isStaff = map["isStaff"],
        isActive = map["isActive"],
        isSuperUser = map["isSuperUser"],
        lastLogin = map["lastLogin"].toDate(),
        dateJoined = map["dateJoined"].toDate(),
        disciplinas = List.generate(map["disciplinas"].length,
            (index) => Disciplina.fromMap(map["disciplinas"][index])),
        campus = map["campus"];

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "uid": uid,
      "phone": phone,
      "isStaff": isStaff,
      "isActive": isActive,
      "isSuperUser": isSuperUser,
      "lastLogin": lastLogin,
      "dateJoined": dateJoined,
      "disciplinas": disciplinas.map(
        (Disciplina value) => value.toMap(),
      ).toList(),
      "campus": campus,
    };
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, uid: $uid, phone: $phone, isStaff: $isStaff, isActive: $isActive, isSuperUser: $isSuperUser, lastLogin: $lastLogin, dateJoined: $dateJoined, disciplinas: $disciplinas, campus: $campus)';
  }
}
