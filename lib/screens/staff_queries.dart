import 'package:dbms_project/queries/query1.dart';
import 'package:dbms_project/queries/query20.dart';
import 'package:dbms_project/queries/query3.dart';
import 'package:dbms_project/queries/query4.dart';
import 'package:dbms_project/queries/query5.dart';
import 'package:dbms_project/queries/query6.dart';
import 'package:dbms_project/queries/query7.dart';
import 'package:dbms_project/queries/query9.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import '../queries/query10.dart';
import '../queries/query2.dart';
import '../queries/query8.dart';

class StaffQueries extends StatefulWidget {
  const StaffQueries({Key? key, required this.conn, required this.branch_no})
      : super(key: key);
  final MySQLConnection conn;
  final String branch_no;

  @override
  State<StaffQueries> createState() => _StaffQueriesState();
}

class _StaffQueriesState extends State<StaffQueries> {
  final _formKey = GlobalKey<FormState>();

  List<String> queries = [
    "List details of staff supervised by a named Supervisor at the branch",
    "List details of all Assistants alphabetically by name at the branch",
    "List the details of properties managed by a named member of staff at the branch",
    "List the clients registering at the branch and the names of the members of staff who registered the clients",
    "Identify properties located in Glasgow with rents no higher than £450",
    "Identify the name and telephone number of an owner of a given property",
    "List the details of comments made by clients viewing a given property",
    "Display the names and phone numbers of clients who have viewed a given property but not supplied comments",
    "Display the details of a lease between a named client and a given property"
  ];
  String? var1;
  String? var2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Queries'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("List details of staff supervised by "
                          "a named Supervisor at the branch"),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Supervisor Name'
                        ),
                        onChanged: (text) {
                          var1 = text;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query1(
                                conn: widget.conn,
                                branch: widget.branch_no,
                                fullName: var1,
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "List details of all Assistants alphabetically by name at the branch"),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query2(
                                  conn: widget.conn,
                                  branch: widget.branch_no),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "List the details of properties managed by a named member of staff at the branch"),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Branch Staff Name'
                        ),
                        onChanged: (text) {
                          var1 = text;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query3(
                                conn: widget.conn,
                                branch: widget.branch_no,
                                staffName: var1,
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "List the clients registering at the branch and the "
                              "names of the members of staff who registered the clients"),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query4(
                                conn: widget.conn,
                                branch: widget.branch_no,
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "Identify properties located in Glasgow with rents no higher than £450"),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query5(
                                conn: widget.conn,
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Identify the name and telephone number of an owner of a given property",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Property No'
                        ),
                        onChanged: (text) {
                          var1 = text;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query6(
                                conn: widget.conn, property_no: var1,
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),


                      Text(
                        "List the details of comments made by clients viewing a given property",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Property No'
                        ),
                        onChanged: (text) {
                          var1 = text;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query7(
                                conn: widget.conn, property_no: var1.toString(),
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Display the names and phone numbers of clients who have viewed a"
                            " given property but not supplied comments",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query8(
                                conn: widget.conn,
                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "Display the details of a lease between a named client and a given property"),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Client Name'
                        ),
                        onChanged: (text) {
                          var1 = text;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Property No'
                        ),
                        onChanged: (text) {
                          var2 = text;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query9(
                                conn: widget.conn, fullName: var1,propertyNo: var2,

                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "Identify the leases due to expire next month at the branch."),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query10(
                                conn: widget.conn,

                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                          "Produce a list of clients whose preferences match a particular property"),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Query20(
                                conn: widget.conn,

                              ),
                            ),
                          );
                        },
                        child: Text("Show result"),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
