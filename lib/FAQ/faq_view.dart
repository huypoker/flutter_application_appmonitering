import 'package:expansion_card/expansion_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqView extends StatefulWidget {


  @override
  _FaqViewState createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List FAQ"),

    ),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Faq').snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return Text('no value');
        }
        return ListView(
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              child: ExpansionCard(
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Question 1", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 25)
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data.docs[0]['title'], style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ],
                    ),
                  ),                  
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(snapshot.data.docs[0]['sub'],style: TextStyle(color: Colors.black, fontSize: 15)
                    ),
                    )
                  ],
                )
            ),
            SizedBox(height:10),
            Card(
              clipBehavior: Clip.antiAlias,
              child: ExpansionCard(
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Question 2", style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 25)
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data.docs[1]['title'], style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(snapshot.data.docs[1]['sub'],style: TextStyle(color: Colors.black, fontSize: 15)
                    ),
                    )
                  ],
                )
            ),
          ],
        );
      },),
    );
  }
}



