import 'package:dbms_project/screens/staff_queries.dart';
import 'package:dbms_project/screens/registrations_screen.dart';
import 'package:dbms_project/screens/viewing_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:dbms_project/screens/lease_screen.dart';
import 'package:dbms_project/screens/show_staff_screen.dart';
import 'package:dbms_project/screens/show_listing_screen.dart';
import 'package:dbms_project/screens/show_rented_screen.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({Key? key, required this.conn, required this.branch_no})
      : super(key: key);
  final MySQLConnection conn;
  final String branch_no;

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DreamHome'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.branch_no,
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(
                        conn: widget.conn,
                        branch_no: widget.branch_no,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Registration',
                ),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StaffListScreen(
                          conn: widget.conn, branch: widget.branch_no
                      ),
                    ),
                  );
                },
                child: Text(
                  'Branch Information',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaseScreen(conn: widget.conn),
                    ),
                  );
                },
                child: Text(
                  'Lease',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewReportForm(conn: widget.conn),
                    ),
                  );
                },
                child: Text(
                  'Viewing Report Form',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListingScreen(conn: widget.conn, branch: widget.branch_no,),
                    ),
                  );
                },
                child: Text(
                  'Property Listing',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentedScreen(conn: widget.conn, branch: widget.branch_no,),
                    ),
                  );
                },
                child: Text(
                  'Property rented',
                ),
              ),
            ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BranchQueries(conn: widget.conn, branch_no: widget.branch_no,),
              ),
            );
          },
          child: Text(
            'Branch Queries',
          ),
        ),
        )],
        ),
      ),
    );
  }
}
