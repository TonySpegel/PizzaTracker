/// s/o https://github.com/PoojaB26/LayoutsFlutter/blob/master/lib/chat_item.dart
import 'package:flutter/material.dart';
import 'pizza_item.dart';
import 'pizza_form.dart';
import 'package:flutter/foundation.dart';

// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

class PizzaItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🍕 Tracker'),
        backgroundColor: Colors.amber,
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.local_pizza),
        onPressed: () {
          _settingModalBottomSheet(context);
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
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.documents);
    },
  );
}

DateTime todayUtc(){
  DateTime now = new DateTime.now();
  return startOfDay(new DateTime.utc(now.year, now.month, now.day));
}

DateTime startOfDay(DateTime date){
  if (date == null) return null;
  if (date.isUtc) {
    return new DateTime.utc(date.year, date.month, date.day, 0, 0, 0);
  } else {
    return new DateTime(date.year, date.month, date.day, 0, 0, 0);
  }
}

DateTime endOfDay(DateTime date){
  if (date == null) return null;
  if (date.isUtc) {
    return new DateTime.utc(date.year, date.month, date.day, 23, 59, 59);
  } else {
    return new DateTime(date.year, date.month, date.day, 23, 59, 59);
  }
}

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

      // print('tag: ' + today.weekday.toString());
      // print('heute: ' + today.toString());
      // print('start: ' + _firstDayOfTheweek.toString());
      // print('ende: ' + _lastDayOfTheweek.toString());

      numberOfEntries = await numberOfSnapshotEntries(_firstDayOfTheweek, _lastDayOfTheweek);

      break;

    case 'month':
      DateTime _firstDayOfMonth = DateTime(today.year, today.month);

      // Find the last day of the month.
      DateTime _lastDayOfMonth = (today.month < 12) ?
        new DateTime(today.year, today.month + 1, 0, 23, 59, 59) :
        new DateTime(today.year + 1, 1, 0, 23, 59, 59);

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

Widget buildInfoCircle(String labelText, int numberOfPizza) {
  String displayName = labelText[0].toUpperCase() + labelText.substring(1);

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(displayName),
      Material(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
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

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final pizza = Pizza.fromSnapshot(data);

  return Padding(
    key: ValueKey(pizza.name),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Container(
      child: PizzaItem(pizza: pizza),
    ),
  );
}

buildCircle(mode) {
  return FutureBuilder(
    future: getEntries(mode),
    builder: (context, futureResult) {
      return buildInfoCircle(mode, futureResult.data);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  // DateTime today = todayUtc();

  // print(DateTime(today.year));

  Padding infoCard = Padding(
    padding: EdgeInsets.all(8),
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCircle('week'),
              buildCircle('month'),
              buildCircle('year'),
              buildCircle('all'),
            ],
          ),
        ),
      )
    )
  );

  ListView elements = ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );

  Column wrapper = Column(
    children: <Widget>[
      infoCard,
      Expanded(
        child: Container(
          child: elements,
        ),
      )
    ],
  );

  return wrapper;
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: MyCustomForm(),
        );
      });
}
