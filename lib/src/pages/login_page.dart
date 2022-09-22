import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  // LoginPage({Key key}) : super(key: key);
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? usuario = "";
  String? clave = "";
  String _error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Material app bar'),
        // ),
        body: Form(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.lightBlue.shade300,
                  Colors.blue.shade800,
                ],
              ),
            ),
            height: 300,
            child: Image.asset("assets/images/logo.png"),
          ),
          Transform.translate(
            offset: Offset(0, -40),
            child: Center(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 260, bottom: 20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: "Usuario:"),
                          onChanged: (value) => usuario = value,
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Contrasena:"),
                          obscureText: true,
                          onChanged: (value) => clave = value,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              _login(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text("INICIAR SESION"),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: const CircularProgressIndicator(),
                                  )
                              ],
                            ),
                          ),
                        ),
                        if (_error.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
      if (usuario == 'admin' || clave == 'admin') {
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        setState(() {
          _error = "Usuario o contrasena incorrecta";
          _loading = false;
        });
      }
    }
  }
}
