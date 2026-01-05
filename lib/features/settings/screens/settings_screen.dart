import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/database_provider.dart';
import '../providers/settings_provider.dart';

/// Settings screen for app configuration
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notifications = true;
  bool _autoSync = true;
  bool _isClearing = false;
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final isSupabaseAvailable = ref.watch(isSupabaseAvailableProvider);
    final userEmail = ref.watch(userEmailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // User info (if logged in)
          if (userEmail != null) ...[
            ListTile(
              leading: CircleAvatar(
                child: Text(userEmail[0].toUpperCase()),
              ),
              title: Text(userEmail),
              subtitle: const Text('Signed in'),
            ),
            const Divider(),
          ] else if (!isSupabaseAvailable) ...[
            Container(
              margin: const EdgeInsets.all(AppSizes.spacingMd),
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: AppSizes.spacingSm),
                  Expanded(
                    child: Text(
                      'Running in demo mode. Configure Supabase for full features.',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Appearance section
          _buildSectionHeader('Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: isDarkMode,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state =
                  value ? ThemeMode.dark : ThemeMode.light;
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
              _showSnackBar('Notification settings saved');
            },
          ),
          const Divider(),

          // Data & Sync section
          _buildSectionHeader('Data & Sync'),
          SwitchListTile(
            title: const Text('Auto Sync'),
            subtitle: const Text('Automatically sync changes'),
            value: _autoSync,
            onChanged: isSupabaseAvailable
                ? (value) {
                    setState(() => _autoSync = value);
                    _showSnackBar('Sync settings saved');
                  }
                : null,
          ),
          ListTile(
            title: const Text('Clear Local Cache'),
            subtitle: const Text('Remove locally stored data'),
            trailing: _isClearing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.chevron_right),
            onTap: _isClearing
                ? null
                : () {
                    _showConfirmDialog(
                      'Clear Cache',
                      'Are you sure you want to clear the local cache? You will need to re-sync your data.',
                      _clearCache,
                    );
                  },
          ),
          ListTile(
            title: const Text('Export Data'),
            subtitle: const Text('Download your family tree data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showSnackBar('Export feature coming soon');
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
              _showSnackBar('Privacy settings coming soon');
            },
          ),
          ListTile(
            title: const Text('Blocked Users'),
            subtitle: const Text('Manage blocked users'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showSnackBar('Blocked users feature coming soon');
            },
          ),
          const Divider(),

          // Account section
          if (isSupabaseAvailable) ...[
            _buildSectionHeader('Account'),
            ListTile(
              title: const Text('Change Password'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _showChangePasswordDialog();
              },
            ),
            ListTile(
              title: const Text('Delete Account'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                _showConfirmDialog(
                  'Delete Account',
                  'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
                  _deleteAccount,
                  isDestructive: true,
                );
              },
            ),
            const Divider(),
          ],

          // About section
          _buildSectionHeader('About'),
          const ListTile(
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchUrl('https://example.com/terms'),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () => _launchUrl('https://example.com/privacy'),
          ),
          ListTile(
            title: const Text('Open Source Licenses'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: 'Family Tree',
                applicationVersion: '1.0.0',
              );
            },
          ),
          const SizedBox(height: AppSizes.spacingXl),

          // Sign out button
          if (isSupabaseAvailable && userEmail != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingMd),
              child: OutlinedButton(
                onPressed: _isSigningOut
                    ? null
                    : () {
                        _showConfirmDialog(
                          'Sign Out',
                          'Are you sure you want to sign out?',
                          _signOut,
                        );
                      },
                child: _isSigningOut
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Sign Out'),
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

  void _showChangePasswordDialog() {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter your email address and we will send you a link to reset your password.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (emailController.text.isNotEmpty) {
                try {
                  await ref
                      .read(authNotifierProvider.notifier)
                      .sendPasswordReset(emailController.text);
                  if (mounted) {
                    _showSnackBar('Password reset email sent');
                  }
                } catch (e) {
                  if (mounted) {
                    _showSnackBar('Error: $e', isError: true);
                  }
                }
              }
            },
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }

  Future<void> _clearCache() async {
    setState(() => _isClearing = true);
    try {
      final db = ref.read(databaseProvider);
      // Clear all local data
      await db.personDao.deleteAll();
      await db.relationshipDao.deleteAll();
      await db.familyTreeDao.deleteAll();

      if (mounted) {
        _showSnackBar('Cache cleared successfully');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error clearing cache: $e', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isClearing = false);
      }
    }
  }

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    try {
      await ref.read(authNotifierProvider.notifier).signOut();
      if (mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error signing out: $e', isError: true);
        setState(() => _isSigningOut = false);
      }
    }
  }

  Future<void> _deleteAccount() async {
    _showSnackBar('Account deletion requires contacting support');
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        _showSnackBar('Could not open link', isError: true);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
