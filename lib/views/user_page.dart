import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/response.dart';
import '../providers/provider_users.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRequest>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Registro de usuario')),
      body: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Registro o Login",
                    style: Theme.of(context).textTheme.headline6),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Si no tiene una cuenta se creara una, si ya tiene una cuenta, escribe los mismos datos y se logueara',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    FormBuilderTextField(
                        keyboardType: TextInputType.text,
                        name: 'username',
                        autofocus: true,
                        maxLength: 20,
                        decoration: const InputDecoration(
                            labelText: "Nombre Usuario",
                            hintText: 'Ejemplo... pedro1',
                            icon: Icon(Icons.person)),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Nombre de usuario requerido'),
                        ])),
                    FormBuilderTextField(
                      keyboardType: TextInputType.emailAddress,
                      name: 'email',
                      decoration: const InputDecoration(
                          labelText: "Correo electrónico",
                          hintText: 'Ejemplo... pedro@gmail.com',
                          icon: Icon(Icons.email)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Correo requerido'),
                        FormBuilderValidators.email(
                            errorText: 'Ingrese un correo valido'),
                      ]),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final Future<Response?> response = user.register(
                        _formKey.currentState!.value['username'].toString(),
                        _formKey.currentState!.value['email'].toString());
                    response.then((_) => {
                          if (user.errorPost.isEmpty)
                            {Navigator.of(context).pushNamed('/homepage')}
                          else
                            {_showToast(user.errorPost, "error")}
                        });
                  }
                },
                child: const Text('Aceptar'),
              ),
            ],
          )),
    );
  }

  _showToast(String msg, String tipo) {
    Color color;
    IconData icono;
    if (tipo == "error") {
      color = Color.fromARGB(125, 231, 20, 20);
      icono = Icons.error;
    } else if (tipo == "success") {
      color = Colors.greenAccent;
      icono = Icons.check;
    } else {
      color = Color.fromARGB(178, 226, 241, 14);
      icono = Icons.warning;
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(style: const TextStyle(color: Colors.black), msg),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
