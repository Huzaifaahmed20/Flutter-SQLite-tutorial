import 'package:flutter/material.dart';
import 'package:sqflite_demo/model/user.dart';

import './services/user_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFLite Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final services = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLite Demo'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Age'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: RaisedButton.icon(
                color: Colors.orange,
                onPressed: () {
                  setState(() {
                    services.saveUser(
                        _nameController.text, int.parse(_ageController.text));
                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add User'),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: services.fetchUsers(),
                builder: (ctx, snap) {
                  List<User> users = snap.data;
                  if (!snap.hasData) {
                    return Center(
                      child: Text('No data found'),
                    );
                  }
                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (ctx, idx) {
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text('${users[idx].name}'),
                            subtitle: Text('${users[idx].age}'),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
