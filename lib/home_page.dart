// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<void> fetchData() async {
//     final response =
//         await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

//     if (response.statusCode == 200) {
//       // If the server returns a 200 OK response, parse the JSON.
//       print('Response data: ${response.body}');
//     } else {
//       // If the server did not return a 200 OK response,
//       // throw an exception.
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Contacts'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.sync),
//             onPressed: () {
//               fetchData;
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Search HomePage',
//                 suffixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               ChoiceChip(label: Text('ALL'), selected: true),
//               ChoiceChip(label: Text('Favourite'), selected: false),
//             ],
//           ),
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Icon(Icons.contact_phone, size: 100, color: Colors.grey),
//                   Text(
//                     'No HomePages Available',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 22,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add HomePage action
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

//Working but non editable
// import 'package:dummy_profile_listing/add_user_form.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:dummy_profile_listing/model/user.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<User> _users = [];

//   Future<void> fetchData() async {
//     final response =
//         await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       setState(() {
//         _users =
//             (data['data'] as List).map((user) => User.fromJson(user)).toList();
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Contacts'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.sync),
//             onPressed: fetchData,
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Search Contacts',
//                 suffixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               ChoiceChip(label: Text('ALL'), selected: true),
//               ChoiceChip(label: Text('Favourite'), selected: false),
//             ],
//           ),
//           Expanded(
//             //If contact it empty
//             child: _users.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Icon(Icons.contact_phone,
//                             size: 100, color: Colors.grey),
//                         Text(
//                           'No Contacts Available',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 22,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )

//                 // When able to fetch from postman
//                 : ListView.builder(
//                     itemCount: _users.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(_users[index].avatar),
//                         ),
//                         title: Text(
//                             '${_users[index].firstName} ${_users[index].lastName}'),
//                         subtitle: Text(_users[index].email),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AddUserForm(),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:dummy_profile_listing/add_user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dummy_profile_listing/model/user.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
        centerTitle: true,
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
            //If contact it empty
            child: _users.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.contact_phone,
                            size: 100, color: Colors.grey),
                        Text(
                          'No Contacts Available',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  )

                // When able to fetch from postman
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return Slidable(
                        key: ValueKey(user.id),
                        // startActionPane: ActionPane(
                        //   motion: const DrawerMotion(),
                        //   children: [
                        //     SlidableAction(
                        //       onPressed: (BuildContext context) {
                        //         // TODO: Implement your edit action
                        //       },
                        //       backgroundColor: Colors.blue,
                        //       foregroundColor: Colors.white,
                        //       icon: Icons.edit,
                        //       label: 'Edit',
                        //     ),
                        //   ],
                        // ),

                        // Make it slidable
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                // TODO: Implement your edit action
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                setState(() {
                                  _users.removeAt(index);
                                  // TODO: Implement your delete action, such as making an API call to delete the user from the server
                                });
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUserForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:dummy_profile_listing/add_user_form.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:dummy_profile_listing/model/user.dart';

// class HomePage extends StatelessWidget {
//   // Replace with your actual data source
//   final List<Contact> contacts = [
//     // Your contact data here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Contacts'),
//       ),
//       body: ListView.builder(
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           final contact = contacts[index];
//           return Dismissible(
//             key: Key(contact.id.toString()),
//             background: Container(
//               color: Colors.red,
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Icon(Icons.delete, color: Colors.white),
//                     Text('Delete', style: TextStyle(color: Colors.white)),
//                     SizedBox(width: 20),
//                   ],
//                 ),
//               ),
//             ),
//             secondaryBackground: Container(
//               color: Colors.blue,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(width: 20),
//                     Icon(Icons.edit, color: Colors.white),
//                     Text('Edit', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//             ),
//             onDismissed: (direction) {
//               if (direction == DismissDirection.endToStart) {
//                 // TODO: Implement your delete logic
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Deleted ${contact.name}'),
//                   ),
//                 );
//               } else {
//                 // TODO: Implement your edit logic
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Edit ${contact.name}'),
//                   ),
//                 );
//               }
//             },
//             confirmDismiss: (direction) async {
//               if (direction == DismissDirection.endToStart) {
//                 // Confirm deletion with the user, for example using a dialog
//                 final bool confirmDelete = await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('Delete Contact'),
//                       content: Text(
//                           'Are you sure you want to delete ${contact.name}?'),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () => Navigator.of(context).pop(true),
//                           child: Text('Delete'),
//                         ),
//                         TextButton(
//                           onPressed: () => Navigator.of(context).pop(false),
//                           child: Text('Cancel'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//                 return confirmDelete;
//               } else {
//                 // Handle edit logic here if you need to confirm before editing
//                 return true;
//               }
//             },
//             child: ListTile(
//               title: Text(contact.name),
//               subtitle: Text(contact.email),
//               // Add any other ListTile properties you need
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Replace with your actual contact model
// class Contact {
//   final int id;
//   final String name;
//   final String email;

//   Contact({required this.id, required this.name, required this.email});
// }
