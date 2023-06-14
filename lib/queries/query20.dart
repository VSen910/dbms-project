import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query20 extends StatefulWidget {
  Query20({Key? key, required this.conn})
      : super(key: key);
  final MySQLConnection conn;


  Future<List<String>>? tableData;

  @override
  State<Query20> createState() => _Query20State();
}

class _Query20State extends State<Query20> {

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
        title: Text('Client Info'),
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: widget.conn
              .execute("select a.client_no as client_no, a.full_name as name from client a where exists( select *"
              " from property p where a.max_rent<=p.property_rent and a.property_type = p.property_type and "
              "a.client_no NOT IN (select client_no from lease) and p.property_no NOT IN(select property_no from lease)"
              "  and a.registered_at = p.registered_at)"),
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
              late List<String> name=[];
              late List<String> clientNo=[];

              for (int i = 0; i < snapshot.data!.numOfRows; i++) {

                name.add(snapshot.data!.rows.elementAt(i).assoc()['name']!);
                clientNo.add(snapshot.data!.rows.elementAt(i).assoc()['client_no']!);


              }
              _data = MyData(name, clientNo ,snapshot.data!.numOfRows);
              return Container(
                child: PaginatedDataTable(

                  rowsPerPage: 10,
                  columns: [
                    DataColumn(label: Text('Client no'),),
                    DataColumn(label: Text('Name'),),

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
  MyData(this.name,this.clientNo,
      this.dataLength);
  List<String>? name;
  List<String>? clientNo;


  int dataLength;


  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(clientNo![index]),
        ),
        DataCell(
          Text(name![index]),
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
