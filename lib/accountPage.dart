import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _twoFactorAuthEnabled = false;
  bool _showProfileSettings = false;

  String _name = 'John Doe';
  String _username = 'johndoe';
  String _email = 'johndoe@example.com';

  String _currentPassword = '';
  String _newPassword = '';
  String _confirmNewPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Edit Profile'),
                leading: Icon(Icons.person),
                onTap: () {
                  setState(() {
                    _showProfileSettings = !_showProfileSettings;
                  });
                },
              ),
              if (_showProfileSettings) ...[
                Divider(),
                // Profile settings widgets
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _username,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
              ],
              Divider(),
              Text(
                'Security',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Change Password'),
                leading: Icon(Icons.lock),
                onTap: () {
                  _showChangePasswordDialog(context);
                },
              ),
              SwitchListTile(
                title: Text('Two-Factor Authentication'),
                value: _twoFactorAuthEnabled,
                onChanged: (value) {
                  setState(() {
                    _twoFactorAuthEnabled = value;
                    // Handle two-factor authentication toggle
                  });
                },
              ),
              Divider(),
              Text(
                'Notifications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SwitchListTile(
                title: Text('Push Notifications'),
                value: _pushNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _pushNotificationsEnabled = value;
                    // Handle push notifications toggle
                  });
                },
              ),
              SwitchListTile(
                title: Text('Email Notifications'),
                value: _emailNotificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _emailNotificationsEnabled = value;
                    // Handle email notifications toggle
                  });
                },
              ),
              Divider(),
              Text(
                'Privacy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Privacy Settings'),
                leading: Icon(Icons.privacy_tip),
                onTap: () {
                  // Handle privacy settings action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                onChanged: (value) => _currentPassword = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value) => _newPassword = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
                onChanged: (value) => _confirmNewPassword = value,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle password change
                if (_newPassword == _confirmNewPassword) {
                  // Passwords match, proceed with change
                  _currentPassword = '';
                  _newPassword = '';
                  _confirmNewPassword = '';
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password changed successfully')),
                  );
                } else {
                  // Passwords don't match, show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: Text('Change Password'),
            ),
          ],
        );
      },
    );
  }
}