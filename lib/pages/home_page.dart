import 'package:flutter/material.dart';
import 'package:td_list/pages/add_page.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listviewItems = [
    'Working on personal project',
    'Cleaning the house',
    'Meditate'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: appBarColor,
      ),
      body: ListView.builder(
        itemCount: listviewItems.length,
        itemBuilder: (context, index) {
          String item = listviewItems[index];

          return Dismissible(
            key: Key(item),
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
            onDismissed: (direction) {
              setState(() {
                listviewItems.removeAt(index);
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
      ),
    );
  }
}
