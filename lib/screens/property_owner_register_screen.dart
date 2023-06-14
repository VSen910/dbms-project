import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_client/exception.dart';
import 'package:mysql_client/mysql_client.dart';

import '../components/custom_textformfield.dart';

class PropertyOwnerRegistration extends StatefulWidget {
  PropertyOwnerRegistration({Key? key, required this.conn}) : super(key: key);
  List<String> list = ['false', 'true'];
  final MySQLConnection conn;
  @override
  State<PropertyOwnerRegistration> createState() =>
      _PropertyOwnerRegistrationState();
}

class _PropertyOwnerRegistrationState extends State<PropertyOwnerRegistration> {
  final _formKey = GlobalKey<FormState>();

  String? ownerNo;
  String? fullName;
  String? address;
  String? telNo;
  String? typeofBusiness;
  String? contactName;
  String? isBusiness;
  String? dropdownValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.list.first;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DreamHome'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      header: 'Owner Number',
                      onSaved: (val) {
                        setState(
                          () {
                            ownerNo = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the owner no.';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Full Name',
                      onSaved: (val) {
                        setState(
                          () {
                            fullName = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter full name.';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Address',
                      onSaved: (val) {
                        setState(
                          () {
                            address = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please fill the address';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Telephone Number',
                      onSaved: (val) {
                        setState(
                          () {
                            telNo = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the telephone number';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Type Of Business',
                      onSaved: (val) {
                        setState(
                          () {
                            if(val.isEmpty){
                              typeofBusiness = null;
                            }
                            else{
                              typeofBusiness = val;

                            }
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return null;
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Contact Name',
                      onSaved: (val) {
                        setState(
                          () {
                            contactName = val;
                          },
                        );
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the Contact No.';
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Is Business?:'),
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
                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                if (typeofBusiness == null) {
                                  await widget.conn.execute(
                                      "insert into property_owner values('$ownerNo', '$fullName', '$address', '$telNo', null, '$contactName', '$dropdownValue')");
                                } else {
                                  await widget.conn.execute(
                                      "insert into property_owner values('$ownerNo', '$fullName', '$address', '$telNo', '$typeofBusiness' ,'$contactName', '$dropdownValue')");
                                }
                              }on MySQLServerException catch (e) {
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
    );
  }
}
