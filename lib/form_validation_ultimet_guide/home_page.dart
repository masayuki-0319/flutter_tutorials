import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  Map<String, String> _loginObject = Map<String, String>();
  String _pass1;
  bool _agree = false;
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  FocusNode _emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登録画面')),
      body: Form(
        autovalidateMode: _autovalidate,
        key: _key,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailField,
                _buildPasswordField,
                _buildPasswordConfirmationField,
                _buildAgreeToTermsField,
                _buildSubmitButton,
              ],
            )),
      ),
    );
  }

  Widget get _buildSubmitButton {
    return SafeArea(
      child: RaisedButton(
        onPressed: _doRegister,
        child: Text('登録する'),));
  }

  Widget get _buildEmailField {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      onSaved: (String val) => _loginObject['email'] = val,
      validator: _validateEmail,
      autofocus: true,
      focusNode: _emailFocusNode,
    );
  }

  Widget get _buildPasswordField {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      onChanged: (String val) => setState(() => _pass1 = val),
      onSaved: (String val) => _loginObject['password'] = val,
      validator: _validatePassword,
    );
  }

  Widget get _buildPasswordConfirmationField {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password (again)'),
      obscureText: true,
      validator: _validatePasswordConfirmation,
    );
  }

  Widget get _buildAgreeToTermsField {
    return FormField<bool>(
      initialValue: _agree,
      builder: (FormFieldState<bool> state) {
        return Column(
          children: <Widget>[
            Row(children: [
              Checkbox(
                  value: _agree,
                  onChanged: (bool val) => setState(() => _agree = val)),
              const Text('規約に同意します'),
            ]),
            state.errorText == null
                ? Text('')
                : Text(state.errorText, style: TextStyle(color: Colors.red)),
          ],
        );
      },
      validator: (val) => _validateTerms(_agree),
    );
  }

  String _validateTerms(bool agree) {
    return agree == true ? null : '登録には、規約の同意が必要になります';
  }

  String _validateEmail(String email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');

    if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();

    if (email.isEmpty) {
      return 'メールアドレスを入力してください';
    }
    if (!regex.hasMatch(email)) {
      return '許可された形式ではありません';
    }
    return null;
  }

  String _validatePassword(String pass1) {
    RegExp hasCount = RegExp(r'.{8,}');
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasPunct = RegExp(r'[!@#&*~-]');

    if (!hasCount.hasMatch(pass1)) {
      return 'パスワードは、８文字以上入力してください';
    }
    if (!hasUpper.hasMatch(pass1)) {
      return 'パスワードは、大文字を含めて入力してください';
    }
    if (!hasLower.hasMatch(pass1)) {
      return 'パスワードは、小文字を入力してください';
    }
    if (!hasDigit.hasMatch(pass1)) {
      return 'パスワードは、数字を含めて入力してください';
    }
    if (!hasPunct.hasMatch(pass1)) {
      return 'パスワードは、記号も含めて入力してください';
    }
    return null;
  }

  String _validatePasswordConfirmation(String pass2) {
    return pass2 == _pass1 ? null : '[Password]のフィールドと値が異なります';
  }

  void _doRegister() {
    setState(() => _autovalidate = AutovalidateMode.onUserInteraction);

    if (_key.currentState.validate()) {
      _key.currentState.save();
      print("""
      Registerd new user
      email: '${_loginObject['email']}', password: '${_loginObject['password']}'
      """);
    }
  }
}
