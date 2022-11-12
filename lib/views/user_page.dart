import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Usuario')),
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Text("Registro", style: Theme.of(context).textTheme.headline2),
          ),
          TextFormField(
            autofocus: true,
            maxLength: 20,
            decoration: const InputDecoration(
                labelText: "Nombre Usuario", icon: Icon(Icons.person)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese un nombre de usuario';
              }
              return null;
            },
          ),
          TextFormField(
            maxLength: 20,
            decoration: const InputDecoration(
                labelText: "Correo electrónico", icon: Icon(Icons.email)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su correo electroico';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      )),
    );
  }
}
