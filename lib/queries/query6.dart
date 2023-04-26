import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query6 extends StatefulWidget {
  Query6({Key? key, required this.conn, required this.property_no})
      : super(key: key);
  final MySQLConnection conn;

  final String? property_no;
  Future<List<String>>? tableData;

  @override
  State<Query6> createState() => _Query6State();
}

class _Query6State extends State<Query6> {

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
        title: Text('Property Owner Details'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: widget.conn
                .execute("select property_owner.full_name as \"Full Name\", property_owner.tel_no as \"Telephone\" from property_owner, "
                "property where property.property_owner = property_owner.owner_no and property.property_no = '${widget.property_no}'"),
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
                late List<String> full_name = [];
                late  List<String> telephone = [];



                for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                  full_name.add(snapshot.data!.rows.elementAt(i).assoc()['Full Name']!);
                  telephone.add(snapshot.data!.rows.elementAt(i).assoc()['Telephone']!);

                }
                _data = MyData(full_name,telephone ,snapshot.data!.numOfRows);
                return PaginatedDataTable(
                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Full Name')),
                    DataColumn(label: Text('Telephone NUmber')),

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
  MyData(this.full_name, this.telephone,  this.dataLength);
  List<String>? full_name;
  List<String> ?telephone;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(full_name![index]),
        ),
        DataCell(Text(
            telephone![index]
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
