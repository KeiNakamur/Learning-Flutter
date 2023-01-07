import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/utils/authentification.dart';

import '../../model/account.dart';

class UserFirestore{
  //下記でfirebaseのfirestore内のusersを取得できる
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection('users');

  //userの情報をfirestoreに保存するメソッド
  static Future<dynamic> setUser(Account newAccount) async{
    try{
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction':newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        //FirebaseではDate型が扱えず、代わりにTimeStamp()を使用
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print("新規ユーザー作成");
      return true;
    }on FirebaseException catch(e){
      print("新規ユーザー作成エラー");
      return false;
    }
  }

//  ユーザーログイン時にfirebaseからユーザー情報を取得する
//  どのユーザー情報を取得するのかを判別するためにgetUserに引数にString型のuid(user id)を指定
  static Future<dynamic> getUser(String uid) async {
    try{
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        id: uid,
        name: data['name'],
        userId: data['user_id'],
        imagePath: data['image_path'],
        createdTime: data['created_time'],
        updatedTime: data['updated_time'],
      );
      Authentification.myAccount = myAccount;
      print("ユーザ情報取得完了");
      return true;
    }on FirebaseException catch(e){
      print("ユーザー情報取得エラー");
      return false;
    }
  }
}
