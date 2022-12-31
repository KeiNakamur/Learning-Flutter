import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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
                  onPressed: (){
                    if(nameController.text.isNotEmpty &&
                    userIdController.text.isNotEmpty &&
                    selfIntroductionController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty){
                      Navigator.pop(context);
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
