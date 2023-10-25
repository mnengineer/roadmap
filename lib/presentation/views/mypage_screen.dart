import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _customListTile(context, 'Try for free', Icons.perm_identity),
              _groupedListTiles(
                context,
                [
                  ['Notifications', Icons.notifications],
                  ['General', Icons.settings],
                ],
              ),
              _customListTile(
                context,
                'Sign in with web account',
                Icons.person,
              ),
              _customListTile(context, 'Siri Shortcuts', Icons.shortcut),
              _customListTile(context, 'Help', Icons.help),
              _customListTile(context, 'Send Feedback', Icons.feedback),
              _customListTile(context, 'Share', Icons.share),
              _customListTile(context, 'Rate on the App Store', Icons.star),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customListTile(BuildContext context, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
        onTap: () {
          // Define actions for each list item here
        },
      ),
    );
  }

  Widget _groupedListTiles(BuildContext context, List<List<dynamic>> items) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: items.map<Widget>((item) {
          return Column(
            children: [
              _customListTile(context, item[0] as String, item[1] as IconData),
              if (item != items.last) const Divider(color: Colors.grey),
            ],
          );
        }).toList(),
      ),
    );
  }
}
