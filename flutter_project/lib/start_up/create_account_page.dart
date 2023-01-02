import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/authentification.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //+ボタンをクリックした際のファイル選択
  File? image;
  ImagePicker picker = ImagePicker();

  //Futureは「非同期処理の返り値を表すクラス」
  Future<void> getImageFromGallery() async{
    //写真フォルダから選択
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      //setStateは更新を伝えるメソッド
      setState((){
        image = File(pickedFile.path);
      });
    }
  }
  //画像をfirebase Storageにアップロードする
  Future<void> uploadImage(String uid) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();
    await ref.child(uid).putFile(image!);
    //getDownloadUrl()で先ほどアップロードした写真のurlが取得できる
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("新規登録", style:TextStyle(color:Colors.black),),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30),
              //GestureDetectorで押せないWidgetを押せるようにしてくれる
              GestureDetector(
                onTap: (){
                  //プラスアイコンが押された際にユーザーの写真フォルダにアクセスする
                  getImageFromGallery();
                },
                child: CircleAvatar(
                  foregroundImage: image == null ? null : FileImage(image!),
                  radius: 40,
                  child: Icon(Icons.add),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: ("Username"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: ("Email"),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: ("userId"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: ("Introduction"),
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: ("password"),
                  ),
                ),
              ),
              SizedBox(height:40),
              ElevatedButton(
                  onPressed: () async {
                    if(nameController.text.isNotEmpty &&
                    userIdController.text.isNotEmpty &&
                    selfIntroductionController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty){
                      //すべての項目に入力された際にsignUp()を行う
                      var result = await Authentification.signUp(email: emailController.text, password: passwordController.text);
                      //AuthenticationでのsingUp()でUserCredential型でユーザーを作成したので、
                      //resultの型がUserCredentialであれば、といった条件分岐
                      if(result is UserCredential){
                        await uploadImage(result.user!.uid);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text("アカウント作成"))
            ],
          ),
        ),
      )
    );
  }
}
