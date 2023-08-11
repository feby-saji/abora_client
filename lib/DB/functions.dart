import 'package:abora_client/constants/vars.dart';
import 'package:abora_client/models/user.dart';
import 'package:abora_client/pages/view_trainer_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

DocumentSnapshot? docSnap;
QuerySnapshot? trainersDocSnap;

class DbServices {
  final userNameCollection = FirebaseFirestore.instance.collection('userNames');
  final trainersCollection = FirebaseFirestore.instance.collection('Trainers');
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  final pendingBookings =
      FirebaseFirestore.instance.collection('pendingBookings');
  final uid = FirebaseAuth.instance.currentUser!.uid;
  SharedPreferences? sharedPref;
  SharedPrefVal sharedPrefV = SharedPrefVal();

// functions to do in FUTURE
// NOTE get Trainers near user from CLOUD FUNCTIONS

  Future fillDocSnap() async {
    print('getting docSnap inside Dbservices');
    docSnap = await usersCollection.doc(uid).get();
  }

// frequent functions
  Future<String> getUserName() async {
    if (docSnap == null) {
      await fillDocSnap();
    }
    sharedPref ??= await SharedPreferences.getInstance();
    if (sharedPref!.getString(sharedPrefV.userName) != null) {
      return sharedPref!.getString(sharedPrefV.userName)!;
    } else {
      sharedPref!.setString(sharedPrefV.userName, docSnap!['name']);
      return docSnap!['name'];
    }
  }

  Future<String> getUserGoal() async {
    if (docSnap == null) {
      await fillDocSnap();
    }
    sharedPref ??= await SharedPreferences.getInstance();
    if (sharedPref!.getString(sharedPrefV.userGoal) != null) {
      return sharedPref!.getString(sharedPrefV.userGoal)!;
    } else {
      await sharedPref!.setString(sharedPrefV.userGoal, docSnap!['goal']);
      return docSnap!['goal'];
    }
  }

  Future<String> getimgUrl() async {
    if (docSnap == null) {
      await fillDocSnap();
    }
    sharedPref ??= await SharedPreferences.getInstance();
    if (sharedPref!.getString(sharedPrefV.profilePic) != null) {
      return sharedPref!.getString(sharedPrefV.profilePic)!;
    } else {
      sharedPref!.setString(sharedPrefV.profilePic, docSnap!['profilePic']);
      return docSnap!['profilePic'];
    }
  }

// GET FUNCS
  Future<QuerySnapshot> getNearTrainers() async {
    var req = await trainersCollection.limit(3).get();
    return req;
  }

  Future<QuerySnapshot> getSearchTrainers() async {
    var req = await trainersCollection
        .limit(5)
        .where('name', isEqualTo: 'testtrainer')
        .get();
    return req;
  }

  Future<QuerySnapshot> getPendingReqs() async {
    var reqs = await usersCollection
        .doc(uid)
        .collection('pendingBookings')
        .limit(3)
        .get();
    return reqs;
  }

  Future getSessionsAvailable(dates) async {
    List.from(dates).forEach((dbDate) {
      DateTime date =
          DateTime.fromMicrosecondsSinceEpoch(dbDate.microsecondsSinceEpoch);
      specialDatesD.add(date);
    });
  }

  Future getSessionsBooked(dates) async {
    List.from(dates).forEach((dbDate) {
      DateTime date =
          DateTime.fromMicrosecondsSinceEpoch(dbDate.microsecondsSinceEpoch);
      blackOutDatesD.add(date);
    });
  }

// set funcs
  Future setGoal(goal) async {
    sharedPref ??= await SharedPreferences.getInstance();
    await usersCollection.doc(uid).update({
      'goal': goal,
    });
    await sharedPref!.setString(sharedPrefV.userGoal, goal);
  }

// new user functions
  Future<bool> checkuserNameExists(userName) async {
    QuerySnapshot userNameDocs =
        await userNameCollection.where('userName', isEqualTo: userName).get();
    if (userNameDocs.docs.isNotEmpty) {
      print('user name detected  userNameDocs.docs.length');
      return true;
    } else {
      userNameCollection.add({'userName': userName});
      print('no user name detected continue');
      return false;
    }
  }

  addNewUser(name) async {
    final newUser = NewUser(
      name: name,
      profilePic: '',
      goal: '',
      bookedSessions: [],
      area: '',
      createdOn: DateTime.now(),
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
    await usersCollection.doc(uid).set(newUser.toMap());
  }
}
