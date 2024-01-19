import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dummy_profile_listing/model/user.dart';
import 'edit_user_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> _users = [];

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _users =
            (data['data'] as List).map((user) => User.fromJson(user)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _navigateAndEditUser(User user, int index) async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserForm(user: user),
      ),
    ) as User?;

    if (updatedUser != null) {
      setState(() {
        _users[index] = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: fetchData,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Contacts',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ChoiceChip(label: Text('ALL'), selected: true),
              ChoiceChip(label: Text('Favourite'), selected: false),
            ],
          ),
          Expanded(
            child: _users.isEmpty
                ? const Center(
                    child: Text('No Contacts Available'),
                  )
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return Slidable(
                        key: ValueKey(user.id),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            // Edit part
                            SlidableAction(
                              onPressed: (BuildContext context) =>
                                  _navigateAndEditUser(user, index),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),

                            // Delete part
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    // Popup alert when User want to delete it
                                    return AlertDialog(
                                      title: const Text('Delete Contact'),
                                      content: const Text(
                                          'Are you sure you want to delete this contact?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(dialogContext).pop(),
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _users.removeAt(index);
                                            });
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text(user.email),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add user form or perform another action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
