import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query28 extends StatefulWidget {
  Query28({Key? key, required this.conn, required this.details})
      : super(key: key);
  final MySQLConnection conn;

  final String details;
  Future<List<String>>? tableData;

  @override
  State<Query28> createState() => _Query28State();
}

class _Query28State extends State<Query28> {

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
        title: Text('Details Of Clients ' + widget.details),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute(" SELECT client_no, full_name, tel_no, property_type, max_rent FROM client WHERE registered_at ='${widget.details}'"),
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
              late List<String> client_number = [];
              late List<String> property_t = [];

              late List<String> max_rent = [];
              late List<String> client_name = [];

              late List<String> tele_no = [];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {

                property_t.add(snapshot.data!.rows.elementAt(i).assoc()['property_type']!);
                tele_no.add(snapshot.data!.rows.elementAt(i).assoc()['tel_no']!);

                client_name.add(snapshot.data!.rows.elementAt(i).assoc()['full_name']!);
                client_number.add(snapshot.data!.rows.elementAt(i).assoc()['client_no']!);
                max_rent.add(snapshot.data!.rows.elementAt(i).assoc()['max_rent']!);

              }
              _data = MyData(tele_no,client_name,max_rent,property_t,client_number,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Client Number'),),
                    DataColumn(label: Text('Full Name'),),
                    DataColumn(label: Text('Telephone'),),
                    DataColumn(label: Text('Property Type'),),
                    DataColumn(label: Text('Max Rent'),),


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
  MyData(this.client_tele,this.client_name,this.max_re,this.property_t,this.client_number, this.dataLength);
  List<String>? client_tele;
  List<String>? client_name;
  List<String>? max_re;
  List<String>? property_t;
  List<String>? client_number;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(client_number![index]),
        ),
        DataCell(
          Text(client_name![index]),
        ),
        DataCell(
          Text(client_tele![index]),
        ),
        DataCell(
          Text(property_t![index]),
        ),
        DataCell(
          Text(max_re![index]),
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
