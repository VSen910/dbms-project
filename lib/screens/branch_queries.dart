import 'package:dbms_project/queries/query11.dart';
import 'package:dbms_project/queries/query12.dart';
import 'package:dbms_project/queries/query15.dart';
import 'package:dbms_project/queries/query16.dart';
import 'package:dbms_project/queries/query17.dart';
import 'package:dbms_project/queries/query18.dart';
import 'package:dbms_project/queries/query19.dart';
import 'package:dbms_project/queries/query24.dart';
import 'package:dbms_project/queries/query25.dart';
import 'package:dbms_project/queries/query28.dart';
import 'package:dbms_project/queries/query8.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../queries/query13.dart';
import '../queries/query14.dart';

class BranchQueries extends StatefulWidget {
  const BranchQueries({Key? key, required this.conn, required this.branch_no})
      : super(key: key);
  final MySQLConnection conn;
  final String branch_no;

  @override
  State<BranchQueries> createState() => _BranchQueriesState();
}

class _BranchQueriesState extends State<BranchQueries> {
  final _formKey = GlobalKey<FormState>();
  String? var1;
  String? var2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Quries'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "List the details of branches in a given city.",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'City'),
                      onChanged: (text) {
                        var1 = text;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query11(
                              conn: widget.conn,
                              city: var1,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Identify the total number of branches in each city.",
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query12(
                              conn: widget.conn,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Identify the total number of staff and the sum of their salaries",
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query13(
                              conn: widget.conn,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Identify the total number of staff in each position at branches in Glasgow",
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query14(
                              conn: widget.conn,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "List the name of each Manager at each branch, ordered by branch address",
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query15(
                              conn: widget.conn,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "List the property number, address, type, and rent of all properties"
                      " in Glasgow, ordered by rental amount",
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query16(
                              conn: widget.conn,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Identify the total number of properties assigned to each member of staff at a given branch",
                      style: TextStyle(fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query17(
                              conn: widget.conn,
                              branch: widget.branch_no,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),

                    Text(
                      "List the names of staff supervised by a named Supervisor.",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Supervisor Name'),
                      onChanged: (text) {
                        var1 = text;
                      },
                    ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Branch No'),
                  onChanged: (text) {
                    var2 = text;
                  },),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query18(
                              conn: widget.conn,
                              fullName: var1,
                              branch: var2.toString(),
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),

                    Text(
                      "List the details of properties for rent managed by a named member of staff.",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Staff Name'),
                      onChanged: (text) {
                        var1 = text;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Branch No'),
                      onChanged: (text) {
                        var2 = text;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query19(
                              conn: widget.conn,
                              branch: var2,
                              staffName: var1,
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "List the details of properties provided by business owners at a given branch.",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Branch No'),
                      onChanged: (text) {
                        var1 = text;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query24(
                              conn: widget.conn,
                              details: var1.toString(),
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    SizedBox(height: 50,),
                    Text(
                      "Identify the total number of properties of each type at all branches",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 8,
                      ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query25(
                              conn: widget.conn, properties: '',
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),
                    Text(
                      "List the number, name, and telephone number of clients and their property preferences at a given branch.",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Branch No'),
                      onChanged: (text) {
                        var1 = text;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Query28(
                              conn: widget.conn,
                              details: var1.toString(),
                            ),
                          ),
                        );
                      },
                      child: Text("Show result"),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
