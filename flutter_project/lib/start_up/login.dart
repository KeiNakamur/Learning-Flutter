import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screen.dart';
import 'package:flutter_project/start_up/create_account_page.dart';
import 'package:flutter_project/utils/authentification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextFieldに入力された文字列を取得(Email用)
  TextEditingController emailController = TextEditingController();
  //パスワード用
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 50),
              Text("Flutter SNS", style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              //Email用
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 400,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                    ),
                  ),
                ),
              ),
              //Password用
              Container(
                width: 400,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style:TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: "アカウントを作成していない方は"),
                    TextSpan(text:"こちら",
                    style: TextStyle(color: Colors.blue),
                    //TapGestureRecognizerでこちらをtapできる状態に
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => CreateAccountPage())
                      );
                    }),
                  ]
                )
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () async {
                    //Authenticationで作成したemailSignIn()でログイン処理
                    var result = await Authentification.emailSignIn(email: emailController.text, password: passwordController.text)
                    if(result){
                      //ログインページを破棄した状態で画面遷移するので、pushReplacementを使用
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Screen()));
                      }
                    },
                  child: Text("Emailでログイン")),
            ],
          ),
        ),
      ),
    );
  }
}
