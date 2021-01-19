import 'package:flutter/material.dart';
import '../constants.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isLoading = false;
  String item = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(
                fontSize: 18.0,
              ),
              decoration: InputDecoration(hintText: 'To-Do'),
              onChanged: (value) {
                item = value;
              },
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.resolveWith(
                  (states) => Size(100, 58),
                ),
                padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.all(8.0),
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => buttonColor,
                ),
              ),
              onPressed: () {
                if (!isLoading) {
                  setState(() {
                    isLoading = !isLoading;
                  });
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
