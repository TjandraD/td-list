import 'package:flutter/material.dart';
import 'package:td_list/pages/add_page.dart';
import 'package:td_list/services/db_helper.dart';
import '../constants.dart';
import '../services/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  Future<List> listViewData;

  @override
  void initState() {
    super.initState();
    listViewData = dbHelper.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: appBarColor,
      ),
      body: FutureBuilder(
        future: listViewData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget mainWidget;
          if (snapshot.hasData) {
            List items = [];
            for (Map data in snapshot.data) {
              items.add(data['title']);
            }

            mainWidget = ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final String item = items[index];

                return Dismissible(
                  key: UniqueKey(),
                  child: ListTile(
                    title: Text(item),
                  ),
                  background: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.black54,
                    ),
                    tileColor: Colors.red,
                  ),
                  onDismissed: (direction) async {
                    setState(() {
                      dbHelper.deleteData(item);
                      listViewData = dbHelper.getData();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$item finished")));
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            mainWidget = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Error: ${snapshot.error}'),
              ],
            );
          } else {
            mainWidget = Center(
              child: CircularProgressIndicator(),
            );
          }

          return mainWidget;
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
      ),
    );
  }
}
