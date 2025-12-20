import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';

/// Settings screen for app configuration
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _autoSync = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Appearance section
          _buildSectionHeader('Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              // TODO: Apply theme change
            },
          ),
          const Divider(),

          // Notifications section
          _buildSectionHeader('Notifications'),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive updates about family tree changes'),
            value: _notifications,
            onChanged: (value) {
              setState(() => _notifications = value);
            },
          ),
          const Divider(),

          // Data & Sync section
          _buildSectionHeader('Data & Sync'),
          SwitchListTile(
            title: const Text('Auto Sync'),
            subtitle: const Text('Automatically sync changes'),
            value: _autoSync,
            onChanged: (value) {
              setState(() => _autoSync = value);
            },
          ),
          ListTile(
            title: const Text('Clear Local Cache'),
            subtitle: const Text('Remove locally stored data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showConfirmDialog(
                'Clear Cache',
                'Are you sure you want to clear the local cache?',
                () {
                  // TODO: Clear cache
                },
              );
            },
          ),
          ListTile(
            title: const Text('Export Data'),
            subtitle: const Text('Download your family tree data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Export data
            },
          ),
          const Divider(),

          // Privacy section
          _buildSectionHeader('Privacy'),
          ListTile(
            title: const Text('Privacy Settings'),
            subtitle: const Text('Manage who can see your profile'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to privacy settings
            },
          ),
          ListTile(
            title: const Text('Blocked Users'),
            subtitle: const Text('Manage blocked users'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to blocked users
            },
          ),
          const Divider(),

          // Account section
          _buildSectionHeader('Account'),
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to change password
            },
          ),
          ListTile(
            title: const Text('Delete Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showConfirmDialog(
                'Delete Account',
                'Are you sure you want to delete your account? This action cannot be undone.',
                () {
                  // TODO: Delete account
                },
                isDestructive: true,
              );
            },
          ),
          const Divider(),

          // About section
          _buildSectionHeader('About'),
          ListTile(
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // TODO: Open terms
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
          ListTile(
            title: const Text('Open Source Licenses'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
          const SizedBox(height: AppSizes.spacingXl),

          // Sign out button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingMd),
            child: OutlinedButton(
              onPressed: () {
                _showConfirmDialog(
                  'Sign Out',
                  'Are you sure you want to sign out?',
                  () {
                    // TODO: Sign out
                  },
                );
              },
              child: const Text('Sign Out'),
            ),
          ),
          const SizedBox(height: AppSizes.spacingXl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.spacingMd,
        AppSizes.spacingMd,
        AppSizes.spacingMd,
        AppSizes.spacingSm,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showConfirmDialog(
    String title,
    String message,
    VoidCallback onConfirm, {
    bool isDestructive = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                color: isDestructive ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
