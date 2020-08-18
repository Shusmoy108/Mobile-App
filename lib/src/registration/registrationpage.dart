import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
class RegisterForm extends StatefulWidget {
  String mobile,pass;
  RegisterForm(this.mobile,this.pass);

  @override
  _RegisterFormState createState() => _RegisterFormState(mobile,pass);
}

class _RegisterFormState extends State<RegisterForm> {
  String mobile,pass;
  String _nid_fileName = '...';
  String _institutiional_id_fileName = '...';
  String _nid_path = '...';
  String _institutiional_id_path = '...';
  String _extension;
  bool _hasValidMime = false;
  FileType _nid_pickingType=FileType.any;
  FileType _institutiional_id_pickingType=FileType.any;
  _RegisterFormState(this.mobile,this.pass);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  bool role= true;
  bool teacher=false;
  void _openNID() async {
    if (_nid_pickingType == FileType.any || _hasValidMime) {
      try {
        _nid_path = await FilePicker.getFilePath(type: _nid_pickingType);
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }

      if (!mounted) return;

      setState(() {
        _nid_fileName = _nid_path != null ? _nid_path.split('/').last : '...';

      });
    }

  }
  void _openInstitutionalID() async {
    if (_institutiional_id_pickingType == FileType.any || _hasValidMime) {
      try {
        _institutiional_id_path = await FilePicker.getFilePath(type: _institutiional_id_pickingType);
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }

      if (!mounted) return;

      setState(() {
        _institutiional_id_fileName = _institutiional_id_path != null ? _institutiional_id_path.split('/').last : '...';

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Quiz Master")),
        body:Padding(
            padding: EdgeInsets.all(10),
            child:Form(

      key: _formKey,
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Mobile',
            )
            ,
            enabled: false,
            initialValue: mobile,

            //enabled: false,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Nickname is required';
              }
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full name',
            ),
            validator: (String value) {
              if (value.trim().isEmpty) {
                return 'Full name is required';
              }
            },

          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            initialValue: pass,
            enabled: false,

          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Text("Role"),
              Checkbox(
                value: role,
                onChanged: _setRole,
              ),
              GestureDetector(
                onTap: () => _setRole(!role),
                child: const Text(
                  'Student',
                ),
              ),
              Checkbox(
                value: teacher,
                onChanged: _setTeacher,
              ),
              GestureDetector(
                onTap: () => _setTeacher(!teacher),
                child: const Text(
                  'Teacher',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Visibility(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text("You have to upload the image of your NID/BirthCertificate"),
                  Center(child:
                  new RaisedButton(

                    onPressed: () => _openNID(),
                    child: new Text("Choose NID/Birth Certificate"),
                  ),),

                  new Text(
                    'URI PATH ',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    _nid_path ?? '...',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    textScaleFactor: 0.85,
                  ),
                  const SizedBox(height: 16.0),
                  Text("You have to upload the image of your Institutional ID Card"),
                  Center(child:
                  new RaisedButton(
                    onPressed: () => _openInstitutionalID(),
                    child: new Text("Choose Institutional ID"),
                  ),),

                  new Text(
                    'URI PATH ',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    _institutiional_id_path ?? '...',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    textScaleFactor: 0.85,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            visible: teacher,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              OutlineButton(
                highlightedBorderColor: Colors.black,
                onPressed: _submittable() ? _submit : null,
                child: const Text('Create Account'),
              ),
            ],
          ),
        ],
      ),
    )));
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    print('Form submitted');
  }
  void _setRole(bool newValue) {
    setState(() {
      role = newValue;
      teacher= !newValue;
    });
  }
  void _setTeacher(bool newValue) {
    setState(() {
      role = !newValue;
      teacher= newValue;
    });
  }
  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}