/// s/o https://github.com/PoojaB26/LayoutsFlutter/blob/master/lib/chat_item.dart
import 'package:flutter/material.dart';
import 'pizza_item.dart';
import 'pizza_form.dart';
import 'package:flutter/foundation.dart';
import 'date_utils.dart';

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
  Pizza pizza = Pizza.fromSnapshot(data);

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
    // Wait for Future of getEntries to resolve
    future: getEntries(mode),
    // Use its Result to build a Widget
    builder: (context, futureResult) {
      return buildInfoCircle(mode, futureResult.data);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  Padding infoCard = Padding(
    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Card(
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)),
      color: Colors.amber[100],
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
    children: [
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
    }
  );
}
