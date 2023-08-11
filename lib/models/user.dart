class NewUser {
  final String name;
  String profilePic;
  String goal;
  String area;
  String uid;
  List bookedSessions;
  DateTime createdOn;

  NewUser({
    required this.name,
    required this.profilePic,
    required this.goal,
    required this.bookedSessions,
    required this.area,
    required this.createdOn,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "profilePic": profilePic,
      "goal": goal,
      "sessionsBooked": bookedSessions,
      "area": area,
      "createdOn": createdOn,
      "uid": uid,
    };
  }
}
