import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query7 extends StatefulWidget {
  Query7({Key? key, required this.conn, required this.property_no})
      : super(key: key);
  final MySQLConnection conn;

  final String property_no;
  Future<List<String>>? tableData;

  @override
  State<Query7> createState() => _Query7State();
}

class _Query7State extends State<Query7> {

  late DataTableSource _data;
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for property ' + widget.property_no),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute("select comments from viewing_report where property_no = '${widget.property_no}'"),
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
            } else {
              late List<String> comments = [];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                comments.add(snapshot.data!.rows.elementAt(i).assoc()['comments']!);

              }
              _data = MyData(comments,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Comments'),),

                  ],
                  source: _data,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.comments, this.dataLength);
  List<String>? comments;
   int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(comments![index]),
        ),

      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => dataLength;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
