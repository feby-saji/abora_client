import 'package:abora_client/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbServices {
  final userNameCollection = FirebaseFirestore.instance.collection('userNames');
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  final uid = FirebaseAuth.instance.currentUser!.uid;
  SharedPreferences? sharedPref;

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
        bio: '',
        bookedSessions: [],
        area: '',
        createdOn: DateTime.now());
    await usersCollection.doc(uid).set(newUser.toMap());
  }
}
