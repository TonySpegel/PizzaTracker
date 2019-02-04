// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';
// Material Theme
import 'package:flutter/material.dart';
// Internationalization
import 'package:intl/intl.dart';
// Widgets
import 'pizza_item_screen.dart';

void main() => runApp(PizzaTracker());

class PizzaTracker extends StatelessWidget {
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
         title: Text(
             new DateFormat('yyyy-MM-dd').format(record.date).toString()
         ),
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
 final DateTime date;

 Record.fromMap(Map<String, dynamic> map, { this.reference })
     : assert(map['name'] != null),
       assert(map['quantity'] != null),
       assert(map['date'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble(),
        date = map['date'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name:$quantity:$date>";
}

///
/// Modal Bottom Sheet
///
void _settingModalBottomSheet(context){
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc){
      return Container(
        child: MyCustomForm(),
      );
    }
  );
}


class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

///
/// Pizza Form
///
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}