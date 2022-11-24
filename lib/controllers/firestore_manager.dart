import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  final CollectionReference basicsList = FirebaseFirestore.instance.collection('standardPosts');
  
  Future getBasicPostsList() async {
    List items = [];
    
    try {
      await basicsList.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          items.add(element.data());
        }
      });
      return items;
    } catch (e) {
      print(e.toString());
      return null; 
    }
  }
}