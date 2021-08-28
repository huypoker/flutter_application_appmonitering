
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_appmonitering/Models/user.dart';



class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String uid;
  final String password;
  FirestoreService ({this.uid, this.password});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('ManagerInforUser');

  Future<void> updateUserData(String name) async {
    return await userCollection.doc(uid).set({
      'displayName': name,

    });
  }
  Stream<QuerySnapshot> get ManagerInforUser {
      return userCollection.snapshots();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      password: password,
      displayName: snapshot['displayName'],
    );
  }

  Stream<UserData> get userData{
    return userCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}
