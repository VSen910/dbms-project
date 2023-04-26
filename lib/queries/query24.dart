import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query24 extends StatefulWidget {
  Query24({Key? key, required this.conn, required this.details})
      : super(key: key);
  final MySQLConnection conn;

  final String details;
  Future<List<String>>? tableData;

  @override
  State<Query24> createState() => _Query24State();
}

class _Query24State extends State<Query24> {

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
        title: Text('Business owners Properties ' + widget.details),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute("SELECT property.property_no, property.property_type, property.Property_address, property.property_rent, property_owner.full_name, property_owner.address, property_owner.tel_no FROM property JOIN property_owner ON property.property_owner = property_owner.owner_no JOIN branch ON property.registered_at = branch.branch_no WHERE branch.branch_no = '${widget.details}'"),
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
              late List<String> property_number = [];
              late List<String> property_t = [];
              late List<String> property_add = [];
              late List<String> property_re = [];
              late List<String> property_own_name = [];
              late List<String> property_own_add = [];
              late List<String> property_own_tele = [];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                property_number.add(snapshot.data!.rows.elementAt(i).assoc()['property_no']!);
                property_t.add(snapshot.data!.rows.elementAt(i).assoc()['property_type']!);
                property_own_tele.add(snapshot.data!.rows.elementAt(i).assoc()['tel_no']!);
                property_own_add.add(snapshot.data!.rows.elementAt(i).assoc()['address']!);
                property_own_name.add(snapshot.data!.rows.elementAt(i).assoc()['full_name']!);
                property_add.add(snapshot.data!.rows.elementAt(i).assoc()['Property_address']!);
                property_re.add(snapshot.data!.rows.elementAt(i).assoc()['property_rent']!);

              }
              _data = MyData(property_own_tele,property_own_add,property_own_name,property_re,property_add,property_t,property_number,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Property Number'),),
                    DataColumn(label: Text('Property Type'),),
                    DataColumn(label: Text('Property Rent'),),
                    DataColumn(label: Text('Owner Names'),),
                    DataColumn(label: Text('Owner Telephone'),),
                    DataColumn(label: Text('Owner Address'),),
                    DataColumn(label: Text('Property Address'),),

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
  MyData(this.property_own_tele,this.property_own_add,this.property_own_name,this.property_re,this.property_add,this.property_t,this.property_number, this.dataLength);
  List<String>? property_own_tele;
  List<String>? property_own_add;
  List<String>? property_own_name;
  List<String>? property_re;
  List<String>? property_add;
  List<String>? property_t;
  List<String>? property_number;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(property_own_tele![index]),
        ),
        DataCell(
          Text(property_own_add![index]),
        ),
        DataCell(
          Text(property_own_name![index]),
        ),
        DataCell(
          Text(property_re![index]),
        ),
        DataCell(
          Text(property_add![index]),
        ),
        DataCell(
          Text(property_t![index]),
        ),
        DataCell(
          Text(property_number![index]),
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
