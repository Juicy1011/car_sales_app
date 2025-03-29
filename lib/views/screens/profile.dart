import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/configs/mycolors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample user data - replace with actual user data later
    final Map<String, dynamic> userData = {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '+1 234 567 8900',
      'joinDate': 'March 2024',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: mainColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userData['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    userData['email'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Account Information'),
                  _buildProfileCard(
                    [
                      _buildProfileItem('Phone', userData['phone']),
                      _buildProfileItem('Member Since', userData['joinDate']),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Settings'),
                  _buildProfileCard(
                    [
                      _buildSettingsItem(
                        'Change Password',
                        Icons.lock_outline,
                        () {
                          // Handle change password
                        },
                      ),
                      _buildSettingsItem(
                        'Notification Settings',
                        Icons.notifications_outlined,
                        () {
                          // Handle notification settings
                        },
                      ),
                      _buildSettingsItem(
                        'Privacy Settings',
                        Icons.privacy_tip_outlined,
                        () {
                          // Handle privacy settings
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Account Actions'),
                  _buildProfileCard(
                    [
                      _buildSettingsItem(
                        'Logout',
                        Icons.logout,
                        () {
                          // Handle logout
                          Get.offAllNamed('/login');
                        },
                        textColor: Colors.red,
                        iconColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileCard(List<Widget> children) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? textColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? mainColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor ?? Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
