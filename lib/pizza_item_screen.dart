//
// Main Interface
//
// Copyright 2019 Tony Spegel
//


/// s/o https://github.com/PoojaB26/LayoutsFlutter/blob/master/lib/chat_item.dart
import 'package:flutter/material.dart';
import 'pizza_item/pizza_item.dart';
import 'pizza_form/pizza_form.dart';
import 'package:flutter/foundation.dart';
import 'date_utils.dart';

import 'pizza.dart';

// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rounded_modal/rounded_modal.dart';

class PizzaItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🍕 Tracker'),
      ),
      body: _buildBody(context),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.local_pizza),
        onPressed: () {
          showRoundedModalBottomSheet(
            context: context,
            radius: 20,
            color: Colors.white,
            builder: (context) {
              return PizzaForm();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Material(
          child: SizedBox(
            width: double.infinity,
            height: 40.0,
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
      .collection('pizza-list')
      .orderBy('date', descending: true)
      .snapshots(),
    builder: (context, snapshot) {
      // Show Linear Progress as long as there is no data
      if (!snapshot.hasData) return LinearProgressIndicator(
        backgroundColor: Colors.amber,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent[100]),
      );

      return _buildList(context, snapshot.data.documents);
    },
  );
}

// Receives the Number of Snapshot-Entries using a Start- and Enddate
Future<int> numberOfSnapshotEntries(DateTime startDate, DateTime endDate) async {
  QuerySnapshot fireStoreSnapshot = await
    Firestore
      .instance
      .collection('pizza-list')
      .where('date', isGreaterThanOrEqualTo: startDate)
      .where('date', isLessThanOrEqualTo: endDate)
      .getDocuments();

  List<DocumentSnapshot> documentCount = fireStoreSnapshot.documents;

  return documentCount.length;
}

// Receives the actual Entries by calculating the different
// Beginnings and Endings for a Week, Month, Year..
Future<int> getEntries(mode) async {
  DateTime today = todayUtc();
  int numberOfEntries;

  switch(mode) {
    case 'week':
      DateTime _firstDayOfTheweek;
      DateTime _lastDayOfTheweek;

      if (today.weekday == 1) {
        _firstDayOfTheweek = startOfDay(today);
        _lastDayOfTheweek = endOfDay(_firstDayOfTheweek.add(new Duration(days: 6)));
      } else {
        _firstDayOfTheweek = today.subtract(new Duration(days: today.weekday - 1));
        _lastDayOfTheweek = endOfDay(_firstDayOfTheweek.add(new Duration(days: 6)));
      }

      numberOfEntries = await numberOfSnapshotEntries(_firstDayOfTheweek, _lastDayOfTheweek);
      break;

    case 'month':
      DateTime _firstDayOfMonth = firstDayOfMonth(today);
      DateTime _lastDayOfMonth = lastDayOfMonth(today);

      numberOfEntries = await numberOfSnapshotEntries(_firstDayOfMonth, _lastDayOfMonth);
      break;

    case 'year':
      DateTime _firstDayOfYear = DateTime(today.year);
      DateTime _lastDayOfYear = endOfDay(DateTime(today.year, 12, 31));

      numberOfEntries = await numberOfSnapshotEntries(_firstDayOfYear, _lastDayOfYear);
      break;

    case 'all':
      DateTime _longTimeAgo = DateTime.utc(2016, 01, 01);
      DateTime _lastDayOfYear = endOfDay(DateTime(today.year, 12, 31));

      numberOfEntries = await numberOfSnapshotEntries(_longTimeAgo, _lastDayOfYear);
      break;

    default:
      numberOfEntries = 0;
      break;
  }

  return numberOfEntries;
}

// An Info-Circle displays the Number of Pizzas eaten in a Week, Month, Year...
Widget buildInfoCircle(String labelText, int numberOfPizza) {
  String displayName = labelText[0].toUpperCase() + labelText.substring(1);

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(displayName),
      Material(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(40))
          ),
          child: Center(
            child: Text(
              numberOfPizza.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              textAlign: TextAlign.center
            ),
          )
        ),
      )
    ],
  );
}

// Deletes a Document (a Pizza) given by its documentId
deletePizza(String documentId) {
  Firestore
    .instance
    .collection('pizza-list')
    .document(documentId)
    .delete()
    .catchError((errorMessage) {
      print(errorMessage);
    });
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  Pizza pizza = Pizza.fromSnapshot(data);

  return Padding(
    key: ValueKey(pizza.name),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Dismissible(
      background: Card(
        color: Colors.red[400],
        elevation: 2,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)),
      ),
      child: PizzaItem(pizza: pizza),
      key: Key(pizza.hashCode.toString()),
      // Swipe → to delete a Pizza
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        deletePizza(data.documentID);

        Scaffold
          .of(context)
          .showSnackBar(SnackBar(
            backgroundColor: Colors.red[400],
            content: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: pizza.name,
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  TextSpan(text: ' deleted')
                ]
              ),
              textAlign: TextAlign.center,
            ),
          )
        );
      }
    ),
  );
}

buildCircle(mode) {
  return FutureBuilder(
    // Wait for Future of getEntries to resolve
    future: getEntries(mode),
    // Use its Result to build a Widget
    builder: (context, futureResult) {
      return buildInfoCircle(mode, futureResult.data);
    },
  );
}

// Sometimes it can be a good Idea to extract
// Code into separated Widgets.
// This ↓  might be not too useful ¯\_(ツ)_/¯
class RoundedContainer extends StatelessWidget {
  RoundedContainer(this.child);

  final Widget child;

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: this.child,
    );
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  // This Panel (a 'Card') is at the top of the App
  // and floats above a ListView showing recorded Pizzas.
  // It displays the Number of eaten Pizzas for the
  // past Week, Month, Year and all Time.
  Padding infoCard = Padding(
    padding: EdgeInsets.only(top: 8, left: 4, right: 4),
    child: Card(
      color: Colors.amber[100],
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCircle('week'),
              buildCircle('month'),
              buildCircle('year'),
              buildCircle('all'),
            ],
          ),
          height: 60,
        )
      ),
    )
  );

  // Used as a hidden first Item to provide some kind of Margin
  // to show the Rest of the Listview's Items below the "infoPanel"
  const topContainer = SizedBox(
    height: 105,
  );

  // Same as topContainer but used for bottomNavigationBar
  // to provide a Margin.
  const bottomContainer = SizedBox(
    height: 50,
  );

  // In order to have the 'infoCard' floating above the ListView
  // it is necessary to use the Stack-Widget. It is similiar to
  // the CSS-Porperty 'z-index'. The order of the 'children'-Property
  // indicates which element at the lowest level
  // appears first - in this Case ListView and then infoCard above that.
  return Stack(
    children: [
      ListView(
        children: [
          topContainer,
          ...snapshot.map((data) => _buildListItem(context, data)).toList(),
          bottomContainer
        ],
      ),
      infoCard,
    ],
  );
}
