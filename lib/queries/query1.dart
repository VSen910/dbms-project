import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Query1 extends StatefulWidget {
  Query1({Key? key, required this.conn, required this.branch,  required this.fullName})
      : super(key: key);
  final String? fullName;
  final MySQLConnection conn;
  final String branch;
  Future<List<String>>? tableData;

  @override
  State<Query1> createState() => _Query1State();
}

class _Query1State extends State<Query1> {

  late DataTableSource _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String? fullName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List at branch ' + widget.branch),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          
          child: Column(
            children: [


              FutureBuilder(
                future: widget.conn
                    .execute("select * from staff where supervisor_name= '${widget.fullName}' and staff_branch='${widget.branch}'"),
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
                    late List<String> staffNo = [];
                    late  List<String> fullName = [];
                    late List<String> sex = [];
                    late List<String> dob = [];
                    late List<String> position = [];
                    late List<String> salary = [];
                    late List<String> branch = [];
                    late List<String> supervisor = [];
                    late List<String> managerStartDate = [];
                    late List<String> managerBonus = [];


                    for (int i = 0; i < snapshot.data!.numOfRows; i++) {
                      staffNo.add(snapshot.data!.rows.elementAt(i).assoc()['staff_no']!);
                      fullName.add(snapshot.data!.rows.elementAt(i).assoc()['full_name']!);
                      sex.add(snapshot.data!.rows.elementAt(i).assoc()['sex']!);
                      dob.add(snapshot.data!.rows.elementAt(i).assoc()['DOB']!);

                      position.add(snapshot.data!.rows.elementAt(i).assoc()['position']!);

                      salary.add(snapshot.data!.rows.elementAt(i).assoc()['salary']!);

                      branch.add(snapshot.data!.rows.elementAt(i).assoc()['staff_branch']!);

                      if(snapshot.data!.rows.elementAt(i).assoc()['supervisor_name'] == null){
                        supervisor.add('');
                      } else {
                        supervisor.add(snapshot.data!.rows.elementAt(i)
                            .assoc()['supervisor_name']!);
                      }
                      if(snapshot.data!.rows.elementAt(i).assoc()['manager_start_date'] == null){
                        managerStartDate.add('');
                      } else {
                        managerStartDate.add(snapshot.
                        data!.rows.elementAt(i).assoc()['manager_start_date']!);

                      }

                      if(snapshot.data!.rows.elementAt(i).assoc()['manager_bonus'] == null){
                        managerBonus.add('');
                      } else {
                        managerBonus.add(snapshot.data!.rows.elementAt(i).assoc()['manager_bonus']!);

                      }

                    }



                    _data = MyData(staffNo, fullName, sex, dob, position, salary, branch,supervisor,managerStartDate, managerBonus ,snapshot.data!.numOfRows);
                    return PaginatedDataTable(
                      rowsPerPage: 10,
                      columns: [
                        DataColumn(label: Text('Staff No')),
                        DataColumn(label: Text('Full Name')),
                        DataColumn(label: Text('Sex')),
                        DataColumn(label: Text('DOB')),
                        DataColumn(label: Text('Position')),
                        DataColumn(label: Text('Salary')),
                        DataColumn(label: Text('Staff Branch')),
                        DataColumn(label: Text('Supervisor Name')),
                        DataColumn(label: Text('Manager Start Date')),
                        DataColumn(label: Text('Manager Bonus')),
                      ],
                      source: _data,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(this.staffNo, this.fullName, this.sex,
      this.dob, this.position, this.salary,this.branch,
      this.supervisor, this.managerStartDate, this.managerBonus, this.dataLength);
  List<String> staffNo;
  List<String>? fullName;
  List<String> sex ;
  List<String> dob ;
  List<String> position ;
  List<String> salary;
  List<String> branch ;
  List<String> supervisor ;
  List<String> managerStartDate ;
  List<String> managerBonus;
  int dataLength;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(staffNo![index]),
        ),
        DataCell(Text(
            fullName![index]
        ),),
        DataCell(Text(
            sex![index]
        ),),
        DataCell(Text(
            dob![index]
        ),),
        DataCell(Text(
            position![index]
        ),),
        DataCell(Text(
            salary![index]
        ),),
        DataCell(Text(
            branch![index]
        ),),
        DataCell(Text(
            supervisor![index]
        ),),
        DataCell(Text(
            managerStartDate![index]
        ),),
        DataCell(Text(
            managerBonus![index]
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
