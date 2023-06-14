import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query11 extends StatefulWidget {
  Query11({Key? key, required this.conn, required this.city})
      : super(key: key);
  final MySQLConnection conn;
  final String? city;
  Future<List<String>>? tableData;

  @override
  State<Query11> createState() => _Query11State();
}

class _Query11State extends State<Query11> {

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
        title: Text('Branches in city ' + widget.city.toString()),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn
                .execute("SELECT branch_no , branch_address , tel_no FROM branch "
                "WHERE branch_city = '${widget.city}'"),
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
                late List<String> branch_no = [];
                late  List<String> branch_address = [];
                late List<String> telephone = [];



                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  branch_no.add(snapshot.data!.rows.elementAt(i).assoc()['branch_no']!);
                  branch_address.add(snapshot.data!.rows.elementAt(i).assoc()['branch_address']!);
                  telephone.add(snapshot.data!.rows.elementAt(i).assoc()['tel_no']!);



                }

                _data = MyData(branch_no, branch_address, telephone,snapshot.data!.numOfRows);
                return PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Branch No')),
                    DataColumn(label: Text('Branch Adrdess')),
                    DataColumn(label: Text('Telephone Not')),

                  ],
                  source: _data,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.branch_no, this.address, this.tele, this.dataLength);
  List<String> branch_no;
  List<String>? address;
  List<String> tele ;

  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(branch_no![index]),
        ),
        DataCell(Text(
            address![index]
        ),),
        DataCell(Text(
            tele![index]
        ),),


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
