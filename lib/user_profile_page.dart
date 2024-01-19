import 'package:dummy_profile_listing/edit_user_form.dart';
import 'package:flutter/material.dart';
import 'package:dummy_profile_listing/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  final User user;

  const UserProfilePage({Key? key, required this.user}) : super(key: key);

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: user.email,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Could not launch email client');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserForm(user: user),
                  ),
                );
              },
              child: const Text("Edit"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatar),
            ),
            const SizedBox(height: 10),

            // User name
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.email,
              size: 60.0,
            ),
            //Email
            Text(
              user.email,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendEmail,
              child: const Text('Send Email'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
