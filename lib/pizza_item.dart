import 'package:flutter/material.dart';
// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

//
// Pizza Record
//
class Pizza {
 final DateTime date;
 final DocumentReference reference;
 final String name;
 final double quantity;

 Pizza.fromMap(Map<String, dynamic> map, { this.reference })
     : assert(map['name'] != null),
       assert(map['quantity'] != null),
       assert(map['date'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble(),
        date = map['date'];

 Pizza.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Pizza<$name:$quantity:$date>";
}

class PizzaItem extends StatelessWidget {
  //
  // Define Layout Elements
  //
  final leftSection = new Container(
    child: new CircleAvatar(
      backgroundImage:
      new NetworkImage("https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg"),
      backgroundColor: Colors.lightGreen,
      radius: 24.0,
    ),
  );

  final middleSection = new Expanded(
    child: new Container(
      padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text("Name",
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),),
          new Text("Hi whatsp?", style:
          new TextStyle(color: Colors.grey),),
        ],
      ),
    ),
  );

  final rightSection = new Container(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text("9:50",
          style: new TextStyle(
              color: Colors.lightGreen,
              fontSize: 12.0),),
        new CircleAvatar(
          backgroundColor: Colors.lightGreen,
          radius: 10.0,
          child: new Text("1",
            style: new TextStyle(color: Colors.white,
                fontSize: 12.0),),
        )
      ],
    ),
  );

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('pizza-list').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map(
       (data) => _buildListItem(context, data)
     ).toList(),
   );
 }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return new Container(
      padding: new EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 8.0
      ),
      height: 70.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          leftSection,
          middleSection,
          rightSection
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8.0
      ),
      height: 70.0,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          leftSection,
          middleSection,
          rightSection
        ],
      ),
    );
  }

}
