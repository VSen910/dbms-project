import 'package:dbms_project/components/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/exception.dart';
import 'package:mysql_client/mysql_client.dart';

class ClientRegistration extends StatefulWidget {
  ClientRegistration({Key? key, required this.conn, required this.branch_no})
      : super(key: key);
  final MySQLConnection conn;
  final String branch_no;
  final List<String> list = ['House', 'Apartment', 'Condo'];

  @override
  State<ClientRegistration> createState() => _ClientRegistrationState();
}

class _ClientRegistrationState extends State<ClientRegistration> {
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;
  String? clientNo;
  String? fullName;
  String? propertyType;
  String? maxRent;
  String? registeredAt;
  String? registeredBy;
  String? dateRegistered;
  String? telephoneNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DreamHome'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Client registration '
                                'form for branch ' +
                            widget.branch_no.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      CustomTextFormField(
                        header: 'Client No',
                        onSaved: (val) {
                          setState(() {
                            clientNo = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Client No';
                          }
                        },
                      ),
                      CustomTextFormField(
                        header: 'Full Name',
                        onSaved: (val) {
                          setState(() {
                            fullName = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Full Name';
                          }
                        },
                      ),
                      CustomTextFormField(
                        header: 'Max Rent',
                        onSaved: (val) {
                          setState(() {
                            maxRent = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Max Rent';
                          }
                        },
                      ),
                      CustomTextFormField(
                        header: 'Registered at',
                        onSaved: (val) {
                          setState(() {
                            registeredAt = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Max Rent';
                          }
                        },
                      ),
                      CustomTextFormField(
                        header: 'Registered by',
                        onSaved: (val) {
                          setState(() {
                            registeredBy = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Max Rent';
                          }
                        },
                      ),
                      CustomTextFormField(
                        header: 'Date Registerd (YYYY-MM-DD)',
                        onSaved: (val) {
                          setState(() {
                            dateRegistered = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter the DOB';
                          }
                          DateTime? date;
                          final format = DateFormat('yyyy-MM-dd');
                          try {
                            date = format.parseStrict(val);
                          } catch (e) {
                            date = null;
                          }
                          if (date == null) {
                            return 'Please enter the valid format';
                          }
                        },
                      ),
                      CustomTextFormField(
                        header: 'Telephone Number',
                        onSaved: (val) {
                          setState(() {
                            telephoneNumber = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Telephone No';
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Property type:'),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DropdownButton(
                              value: dropdownValue,
                              items: widget.list.map(
                                (e) {
                                  return DropdownMenuItem<String>(
                                    child: Text(e.toString()),
                                    value: e.toString(),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    dropdownValue = value;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                try {
                                  await widget.conn.execute(
                                      "Insert into client () values('$clientNo','$fullName', '$dropdownValue', '$maxRent', '$registeredAt', '$registeredBy', '$dateRegistered','$telephoneNumber')");
                                } on MySQLServerException catch (e) {
                                  Fluttertoast.showToast(msg: 'Error');
                                }
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
