import 'package:dbms_project/screens/property_register_screen.dart';
import 'package:dbms_project/screens/staff_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:dbms_project/screens/client_register_screen.dart';
import 'package:dbms_project/screens/property_owner_register_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen(
      {Key? key, required this.conn, required this.branch_no})
      : super(key: key);

  final MySQLConnection conn;
  final String branch_no;

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
                      builder: (context) => PropertyRegisterScreen(conn: conn, branchNo: branch_no,),
                    ),
                  );
                },
                child: Text('Register property'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientRegistration(
                        conn: conn,
                        branch_no: branch_no,
                      ),
                    ),
                  );
                },
                child: Text('Register client'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyOwnerRegistration(
                        conn: conn,
                      ),
                    ),
                  );
                },
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
