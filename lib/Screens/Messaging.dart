import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handelerFun(RemoteMessage msg)async{
  print(msg.data);
}
class MessagingClass{

  FirebaseMessaging fbmessag = FirebaseMessaging.instance;


  Future<void> init() async{
    fbmessag.requestPermission();
    String? token = await fbmessag.getToken();
    FirebaseMessaging.onBackgroundMessage(handelerFun);
    print("----------$token------------------");
  }
}