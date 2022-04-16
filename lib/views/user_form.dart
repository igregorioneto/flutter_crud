import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/user.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id.toString();
    _formData['name'] = user.name.toString();
    _formData['email'] = user.email.toString();
    _formData['avatarUrl'] = user.avatarUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'].toString(),
                    email: _formData['email'].toString(),
                    avatarUrl: _formData['avatarUrl'].toString(),
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                onSaved: (value) => _formData['name'] = value.toString(),
                validator: (value) {
                  if (value == null || value.trim().isNotEmpty) {
                    return 'Nome inválido';
                  }

                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                onSaved: (value) => _formData['email'] = value.toString(),
                validator: (value) {
                  return 'Ocorreu um erro';
                },
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: const InputDecoration(
                  labelText: 'URL do Avatar',
                ),
                onSaved: (value) => _formData['avatarUrl'] = value.toString(),
                validator: (value) {
                  return 'Ocorreu um erro';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
