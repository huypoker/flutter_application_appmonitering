
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_appmonitering/Models/AlertNotification.dart';
import 'package:flutter_application_appmonitering/Models/user.dart';



class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String uid;
  final String password;
  FirestoreService ({this.uid, this.password});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('ManagerInforUser');
  final CollectionReference faqCollection = FirebaseFirestore.instance.collection('Faq');
  final CollectionReference alertNotificationCollection = FirebaseFirestore.instance.collection('AlertNotification');
  
  
  Future<void> updateUserData(String name) async {
    return await userCollection.doc(uid).set({
      'displayName': name,
    });
  }
  // ignore: non_constant_identifier_names
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
  List<AlertNotification> _alertNotificationListFromSnapshot(QuerySnapshot snapshot) =>
    snapshot.docs.map((doc) => AlertNotification(
      title: doc['title'],
      subtitle: doc['subtitle']
    )).toList();

  Stream<List<AlertNotification>> get alertNotifications => 
    alertNotificationCollection.snapshots().map(_alertNotificationListFromSnapshot);

  Future<List<AlertNotification>> getNotifications() async {
    QuerySnapshot querySnapshot = await alertNotificationCollection.get();
    return querySnapshot.docs.map<AlertNotification>((snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return AlertNotification(
        title: data['title'],
        subtitle: data['subtitle']
      );
    }).toList();
  }

  Future addNewNotification(AlertNotification notification) async => await alertNotificationCollection.doc().set({
    'title': notification.title,
    'subtitle': notification.subtitle
  });
}
