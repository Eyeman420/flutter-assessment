import 'package:flutter/material.dart';
import 'package:dummy_profile_listing/model/user.dart';

class EditUserForm extends StatefulWidget {
  final User user;

  const EditUserForm({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateUser() {
    // Validate returns true if the form is valid, otherwise false.
    if (_formKey.currentState!.validate()) {
      // Create an updated user object
      User updatedUser = User(
        id: widget.user.id,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        avatar: widget.user.avatar, // Assuming the avatar doesn't change
      );

      // Pop the navigation stack and return the updated user to the previous page
      Navigator.of(context).pop(updatedUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              //Image
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.avatar),
                radius: 50,
              ),

              //First Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
              ),

              //Last Name
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
              ),

              //Email
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _updateUser,
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
