import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

/// Onboarding wizard for new users to set up their family tree
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Form data
  final _selfFormKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  DateTime? _birthDate;

  // Parents data
  String _motherFirstName = '';
  String _motherLastName = '';
  String _fatherFirstName = '';
  String _fatherLastName = '';
  bool _addMother = true;
  bool _addFather = true;

  // Siblings data
  final List<Map<String, String>> _siblings = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    // TODO: Save all data to the database
    // Create family tree, add self, parents, siblings

    if (mounted) {
      context.go(AppRoutes.tree);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Your Family Tree'),
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousPage,
              )
            : null,
        actions: [
          TextButton(
            onPressed: () => context.go(AppRoutes.tree),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentPage + 1) / 4,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),

          // Page content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: [
                _buildSelfPage(),
                _buildParentsPage(),
                _buildSiblingsPage(),
                _buildCompletePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Step 1: Create your profile
  Widget _buildSelfPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingLg),
      child: Form(
        key: _selfFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.person_add,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSizes.spacingMd),
            Text(
              "Let's start with you",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingSm),
            Text(
              "You'll be at the center of your family tree",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingXl),

            // Photo placeholder
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                    child: Text(
                      _firstName.isNotEmpty ? _firstName[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 40,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18),
                        color: Colors.white,
                        onPressed: () {
                          // TODO: Pick photo
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spacingLg),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _firstName = value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: AppSizes.spacingMd),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _lastName = value),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: AppSizes.spacingMd),

            ListTile(
              title: Text(_birthDate == null
                  ? 'Birth Date (Optional)'
                  : 'Born: ${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'),
              trailing: const Icon(Icons.calendar_today),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                side: BorderSide(color: Colors.grey.shade400),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().subtract(
                    const Duration(days: 365 * 25),
                  ),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _birthDate = date);
                }
              },
            ),
            const SizedBox(height: AppSizes.spacingXl),

            FilledButton(
              onPressed: () {
                if (_selfFormKey.currentState!.validate()) {
                  _nextPage();
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  /// Step 2: Add parents
  Widget _buildParentsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.people,
            size: 64,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSizes.spacingMd),
          Text(
            'Who are your parents?',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingSm),
          Text(
            'You can skip this and add them later',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingXl),

          // Mother section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _addMother,
                        onChanged: (value) {
                          setState(() => _addMother = value ?? false);
                        },
                      ),
                      const Text(
                        'Mother',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  if (_addMother) ...[
                    const SizedBox(height: AppSizes.spacingSm),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (value) => _motherFirstName = value,
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (value) => _motherLastName = value,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacingMd),

          // Father section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _addFather,
                        onChanged: (value) {
                          setState(() => _addFather = value ?? false);
                        },
                      ),
                      const Text(
                        'Father',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  if (_addFather) ...[
                    const SizedBox(height: AppSizes.spacingSm),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (value) => _fatherFirstName = value,
                    ),
                    const SizedBox(height: AppSizes.spacingSm),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (value) => _fatherLastName = value,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacingXl),

          FilledButton(
            onPressed: _nextPage,
            child: const Text('Continue'),
          ),
          const SizedBox(height: AppSizes.spacingSm),
          TextButton(
            onPressed: _nextPage,
            child: const Text('Skip for now'),
          ),
        ],
      ),
    );
  }

  /// Step 3: Add siblings
  Widget _buildSiblingsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.group,
            size: 64,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSizes.spacingMd),
          Text(
            'Do you have siblings?',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingXl),

          // Siblings list
          ..._siblings.asMap().entries.map((entry) {
            final index = entry.key;
            final sibling = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: AppSizes.spacingSm),
              child: ListTile(
                title: Text('${sibling['firstName']} ${sibling['lastName']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() => _siblings.removeAt(index));
                  },
                ),
              ),
            );
          }),

          // Add sibling button
          OutlinedButton.icon(
            onPressed: () => _showAddSiblingDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Add Sibling'),
          ),
          const SizedBox(height: AppSizes.spacingXl),

          FilledButton(
            onPressed: _nextPage,
            child: const Text('Continue'),
          ),
          const SizedBox(height: AppSizes.spacingSm),
          TextButton(
            onPressed: _nextPage,
            child: const Text('No siblings / Skip'),
          ),
        ],
      ),
    );
  }

  void _showAddSiblingDialog() {
    String firstName = '';
    String lastName = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Sibling'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'First Name'),
              onChanged: (value) => firstName = value,
            ),
            const SizedBox(height: AppSizes.spacingSm),
            TextField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              onChanged: (value) => lastName = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (firstName.isNotEmpty) {
                setState(() {
                  _siblings.add({
                    'firstName': firstName,
                    'lastName': lastName,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Step 4: Complete
  Widget _buildCompletePage() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            size: 100,
            color: Colors.green,
          ),
          const SizedBox(height: AppSizes.spacingLg),
          Text(
            "You're all set!",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingMd),
          Text(
            'Your family tree is ready. You can add more family members anytime.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.spacingXl),

          // Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.spacingMd),
              child: Column(
                children: [
                  _buildSummaryRow('You', '$_firstName $_lastName'),
                  if (_addMother && _motherFirstName.isNotEmpty)
                    _buildSummaryRow(
                        'Mother', '$_motherFirstName $_motherLastName'),
                  if (_addFather && _fatherFirstName.isNotEmpty)
                    _buildSummaryRow(
                        'Father', '$_fatherFirstName $_fatherLastName'),
                  if (_siblings.isNotEmpty)
                    _buildSummaryRow('Siblings', '${_siblings.length} added'),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacingXl),

          FilledButton(
            onPressed: _completeOnboarding,
            child: const Text('View My Family Tree'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
