import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../components/custom_textformfield.dart';

class PropertyRegisterScreen extends StatefulWidget {
  const PropertyRegisterScreen({Key? key, required this.conn}) : super(key: key);

  final MySQLConnection conn;

  @override
  State<PropertyRegisterScreen> createState() => _PropertyRegisterScreenState();
}

class _PropertyRegisterScreenState extends State<PropertyRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? propertyNo;
  String? propertyType;
  String? rooms;
  String? rent;
  String? address;
  String? owner;
  String? managedBy;
  String? staffName;
  String? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register staff'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      header: 'Property no.',
                      onSaved: (val) {
                        setState(() {
                          propertyNo = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the property no.';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Property type',
                      onSaved: (val) {
                        setState(() {
                          propertyType = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the type of the property';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Rent',
                      onSaved: (val) {
                        setState(() {
                          rent = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the rent';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Address',
                      onSaved: (val) {
                        setState(() {
                          address = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the address';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Owner no.',
                      onSaved: (val) {
                        setState(() {
                          owner = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the owner no.';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Staff reg. no.',
                      onSaved: (val) {
                        setState(() {
                          managedBy = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the reg. no. of the staff';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'Staff name',
                      onSaved: (val) {
                        setState(() {
                          staffName = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the staff\'s name';
                        }
                      },
                    ),
                    CustomTextFormField(
                      header: 'City',
                      onSaved: (val) {
                        setState(() {
                          city = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter the city';
                        }
                      },
                    ),
                    // CustomTextFormField(
                    //   header: 'Manager start date (if applicable)',
                    //   onSaved: (val) {
                    //     setState(() {
                    //       managerStartDate = val;
                    //     });
                    //   },
                    //   validator: (val) {
                    //     if(val.isEmpty) {
                    //       return null;
                    //     }
                    //     DateTime? date;
                    //     final format = DateFormat('yyyy-MM-dd');
                    //     try {
                    //       date = format.parseStrict(val);
                    //     } catch (e) {
                    //       date = null;
                    //     }
                    //     if (date == null) {
                    //       return 'Please enter the valid format';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // CustomTextFormField(
                    //   header: 'Date of Birth (YYYY-MM-DD)',
                    //   onSaved: (val) {
                    //     setState(() {
                    //       dob = val;
                    //     });
                    //   },
                    //   validator: (val) {
                    //     if (val.isEmpty) {
                    //       return 'Please enter the DOB';
                    //     }
                    //     DateTime? date;
                    //     final format = DateFormat('yyyy-MM-dd');
                    //     try {
                    //       date = format.parseStrict(val);
                    //     } catch (e) {
                    //       date = null;
                    //     }
                    //     if (date == null) {
                    //       return 'Please enter the valid format';
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(city);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
