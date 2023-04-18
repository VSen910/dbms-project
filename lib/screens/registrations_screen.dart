import 'package:dbms_project/screens/property_register_screen.dart';
import 'package:dbms_project/screens/staff_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key, required this.conn}) : super(key: key);

  final MySQLConnection conn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DreamHome'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaffRegisterScreen(conn: conn),
                    ),
                  );
                },
                child: Text('Register staff'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyRegisterScreen(conn: conn),
                    ),
                  );
                },
                child: Text('Register property'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Register client'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Register property owner'),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
