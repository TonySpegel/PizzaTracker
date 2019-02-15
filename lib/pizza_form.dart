// Material Theme
import 'package:flutter/material.dart';

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter Data for your new 🍕',
              style: Theme.of(context).textTheme.headline,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: '🍕 Name',
                border: OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1.0),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'bruh enter some text';
                }
              },
            ),
            Center(
              child: RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text('Add new'),
                    new Icon(Icons.local_pizza),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
