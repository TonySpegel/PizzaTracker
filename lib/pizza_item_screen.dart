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

void getEntries(mode) async {
  DateTime today = todayUtc();

  switch(mode) {
    case 'week': {
      DateTime _firstDayOfTheweek = startOfDay(today.subtract(new Duration(days: today.weekday)));
      DateTime _lastDayOfTheweek = endOfDay(_firstDayOfTheweek.add(new Duration(days: 7)));

      print(_firstDayOfTheweek);
      print(_lastDayOfTheweek);

      QuerySnapshot _myDoc = await
        Firestore
          .instance
          .collection('pizza-list')
          .where('date', isGreaterThanOrEqualTo: _firstDayOfTheweek)
          .where('date', isLessThanOrEqualTo: _lastDayOfTheweek)
          .getDocuments();

      List<DocumentSnapshot> _myDocCount = _myDoc.documents;
      print(_myDocCount.length);
    }
    break;
  }

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

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  getEntries('week');

  Padding infoCard = Padding(
    padding: EdgeInsets.all(8),
    child: Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text('Week: '),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(40))
                ),
                child: Center(
                  child: Text(
                    '20',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center
                  ),
                )
              )
          ],
        ),
      ),
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
