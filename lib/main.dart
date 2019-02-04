import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: '🍕 Tracker',
     home: MyHomePage(),
     theme: new ThemeData(
       primarySwatch: Colors.amber,
     ),
   );
 }
}

class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() {
   return _MyHomePageState();
 }
}

class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('🍕 Tracker')),
     body: _buildBody(context),
     floatingActionButton: FloatingActionButton(
         child: Icon(Icons.local_pizza),
         onPressed: (){
          _settingModalBottomSheet(context);
        },
     ),
   );
 }

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
   final record = Record.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.name),
         trailing: Text(record.quantity.toString()),
         onTap: () => print(record),
       ),
     ),
   );
 }
}

class Record {
 final String name;
 final double quantity;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, { this.reference })
     : assert(map['name'] != null),
       assert(map['quantity'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble();

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name:$quantity>";
}

void _settingModalBottomSheet(context){
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc){
      return Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.music_note),
              title: new Text('Music'),
              onTap: () => {}
            ),
            new ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () => {},
            ),
          ],
        ),
      );
    }
  );
}
