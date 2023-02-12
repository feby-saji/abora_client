class NewUser {
  final String name;
  String profilePic;
  String bio;
  String area;
  List bookedSessions;
  DateTime createdOn;

  NewUser({
    required this.name,
    required this.profilePic,
    required this.bio,
    required this.bookedSessions,
    required this.area,
    required this.createdOn,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "profilePic": profilePic,
      "bio": bio,
      "sessionsBooked": bookedSessions,
      "area": area,
      "createdOn": createdOn,
    };
  }
}
