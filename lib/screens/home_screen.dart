import 'package:dbms_project/screens/registrations_screen.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:dbms_project/screens/branch_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.conn}) : super(key: key);

  final MySQLConnection conn;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  Future<List<String>> getBranchData() async {
    final results = await widget.conn.execute('select branch_no from branch');
    print('data fetched');
    List<String> data = [];
    for (var row in results) {
      data.add(row.first.toString());
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DreamHome'),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn.execute('select branch_no from branch'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.numOfRows,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BranchScreen(
                            conn: widget.conn,
                            branch_no: snapshot.data!.rows
                                .elementAt(index)
                                .assoc()['branch_no']!,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      snapshot.data!.rows
                          .elementAt(index)
                          .assoc()['branch_no']!,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(16.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => RegistrationScreen(conn: widget.conn),
// ),
// );
// },
// child: Text('Registerations'),
// ),
// ElevatedButton(
// onPressed: () {},
// child: Text('Listings'),
// ),
// ],
// ),
// );
