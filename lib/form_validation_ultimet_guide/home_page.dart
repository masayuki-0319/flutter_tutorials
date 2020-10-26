import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, String> _loginObject = Map<String, String>();
  String _pass1;
  bool _agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登録画面')),
      body: Form(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                _buildEmailField,
                _buildPasswordField,
                _buildPasswordConfirmationField,
                _buildAgreeToTermsField,
              ],)),),
      floatingActionButton: FloatingActionButton(
          onPressed: _doRegister,
          child: Icon(Icons.save)),
    );
  }

  Widget get _buildEmailField {
    return TextField(
      decoration: InputDecoration(labelText: 'Email'),
    );
  }

  Widget get _buildPasswordField {
    return TextField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      onChanged: (String val) => setState(() => _pass1 = val),
    );
  }

  Widget get _buildPasswordConfirmationField {
    return TextField(
      decoration: InputDecoration(labelText: 'Password (again)'),
      obscureText: true,
    );
  }

  Widget get _buildAgreeToTermsField {
    return Column(
      children: <Widget>[
        Checkbox(
          value: _agree,
          onChanged: (bool val) => setState(() => _agree = val)),
        const Text('規約に同意します'),
      ],
    );
  }

  void _doRegister() {
    print("""
    Registerd new user
      email: '${_loginObject['email']}', password: '${_loginObject['password']}'
    """);
  }
}
