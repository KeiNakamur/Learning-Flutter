import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/time_line/post_page.dart';
import 'package:intl/intl.dart';

import '../model/account.dart';
import '../model/post.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: "1",
    name: "Flutterホゲホゲ",
    userId:"1",
    imagePath: "https://virment.com/images/2019/05/logo_lockup_flutter_horizontal.png",
    selfIntroduction: "ホゲホゲ",
    createdTime: Timestamp.now(),
    updatedTime: Timestamp.now(),
  );

  List<Post> postList =[
    Post(
      id: "1",
      content: "始めまして",
      postAccountId: "1",
      createdTime: DateTime.now(),
    ),
    Post(
      id: "2",
      content: "初めまして2",
      postAccountId: "1",
      createdTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("タイムライン",style: TextStyle(color:Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index){
          return Container(
            decoration: BoxDecoration(
              //一番目の要素の際はtopとbottomにborderをつける
              border: index == 0 ? Border(
                top: BorderSide(color: Colors.grey, width: 0),
                bottom: BorderSide(color: Colors.grey, width: 0),
              ):
              //    一番目以外はbottomのborderをつける
              Border(bottom:BorderSide(color: Colors.grey, width: 0),),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage(myAccount.imagePath),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(myAccount.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('@${myAccount.userId}', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            //Pubspec.yamlでDateTime型をString型に変更する必要があるので、pubspec.yamlでintl:anyを追記する必要がある
                            //format(postList[index].createdTime)はnullの可能性があるので、nullを許容しない!を末尾に
                            Text(DateFormat("M/d/yy").format(postList[index].createdTime!))
                          ],
                        ),
                        Text(postList[index].content)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
