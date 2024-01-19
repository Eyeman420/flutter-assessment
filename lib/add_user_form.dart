import 'package:dummy_profile_listing/services/add_user_service.dart';
import 'package:flutter/material.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

  String _firstName = '';
  String _lastName = '';
  String _email = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _userService
          .addUser(firstName: _firstName, lastName: _lastName, email: _email)
          .then((response) {
        if (response.statusCode == 201) {
          // Handle successful response
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User added successfully')));
        } else {
          // Handle error response
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to add user')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              onSaved: (value) => _firstName = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a first name' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              onSaved: (value) => _lastName = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a last name' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter an email' : null,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
