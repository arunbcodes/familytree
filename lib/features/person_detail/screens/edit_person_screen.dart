import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/person.dart';
import '../../tree_view/providers/tree_provider.dart';
import '../../tree_view/widgets/hexagon_avatar.dart';

/// Screen for editing an existing person's details
class EditPersonScreen extends ConsumerStatefulWidget {
  final String personId;

  const EditPersonScreen({
    super.key,
    required this.personId,
  });

  @override
  ConsumerState<EditPersonScreen> createState() => _EditPersonScreenState();
}

class _EditPersonScreenState extends ConsumerState<EditPersonScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _nicknameController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // State
  DateTime? _birthDate;
  DateTime? _deathDate;
  bool _isDeceased = false;
  PersonVisibility _visibility = PersonVisibility.treeMembers;
  String? _photoUrl;
  bool _isLoading = false;
  bool _hasChanges = false;
  Person? _originalPerson;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _nicknameController = TextEditingController();
    _bioController = TextEditingController();
    _locationController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    // Add listeners to track changes
    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
    _nicknameController.addListener(_onFieldChanged);
    _bioController.addListener(_onFieldChanged);
    _locationController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
  }

  void _populateFields(Person person) {
    if (_originalPerson != null) return; // Already populated

    _originalPerson = person;
    _firstNameController.text = person.firstName;
    _lastNameController.text = person.lastName;
    _nicknameController.text = person.nickname ?? '';
    _bioController.text = person.bio ?? '';
    _locationController.text = person.location ?? '';
    _emailController.text = person.contactEmail ?? '';
    _phoneController.text = person.contactPhone ?? '';
    _birthDate = person.birthDate;
    _deathDate = person.deathDate;
    _isDeceased = person.isDeceased;
    _visibility = person.visibility;
    _photoUrl = person.photoUrl;

    // Reset hasChanges after populating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _hasChanges = false);
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      final uploadedUrl = await _uploadPhoto(image.path);
      setState(() {
        _photoUrl = uploadedUrl;
        _hasChanges = true;
      });
    }
  }

  /// Upload photo to storage and return the URL
  /// 
  /// Currently stores local path. When Supabase storage is configured,
  /// this will upload to remote storage and return the public URL.
  Future<String> _uploadPhoto(String localPath) async {
    // TODO: Implement Supabase storage upload when configured
    // Example implementation:
    // 
    // if (SupabaseService.isAvailable) {
    //   final fileName = '${_originalPerson!.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    //   final file = File(localPath);
    //   final bytes = await file.readAsBytes();
    //   
    //   await SupabaseService.client!.storage
    //       .from('avatars')
    //       .uploadBinary(fileName, bytes);
    //   
    //   return SupabaseService.client!.storage
    //       .from('avatars')
    //       .getPublicUrl(fileName);
    // }
    
    // For now, return local path
    return localPath;
  }

  Future<void> _selectDate({required bool isBirthDate}) async {
    final initialDate = isBirthDate
        ? (_birthDate ?? DateTime.now().subtract(const Duration(days: 365 * 30)))
        : (_deathDate ?? DateTime.now());

    final firstDate = isBirthDate ? DateTime(1800) : (_birthDate ?? DateTime(1800));
    final lastDate = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(lastDate) ? initialDate : lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: isBirthDate ? 'Select birth date' : 'Select death date',
    );

    if (date != null) {
      setState(() {
        if (isBirthDate) {
          _birthDate = date;
        } else {
          _deathDate = date;
          _isDeceased = true;
        }
        _hasChanges = true;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;
    if (_originalPerson == null) return;

    setState(() => _isLoading = true);

    try {
      final updatedPerson = _originalPerson!.copyWith(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        nickname: _nicknameController.text.trim().isEmpty
            ? null
            : _nicknameController.text.trim(),
        bio: _bioController.text.trim().isEmpty
            ? null
            : _bioController.text.trim(),
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
        contactEmail: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        contactPhone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        birthDate: _birthDate,
        deathDate: _deathDate,
        isDeceased: _isDeceased,
        visibility: _visibility,
        photoUrl: _photoUrl,
        updatedAt: DateTime.now(),
      );

      // Get the tree notifier and update
      final treeId = _originalPerson!.treeId;
      final notifier = ref.read(treeNotifierProvider(treeId).notifier);
      await notifier.updatePerson(updatedPerson);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Changes saved successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving changes: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text(
          'You have unsaved changes. Are you sure you want to discard them?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Editing'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final personAsync = ref.watch(personStreamProvider(widget.personId));

    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          context.pop();
        }
      },
      child: personAsync.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('Edit Person')),
          body: Center(child: Text('Error: $error')),
        ),
        data: (person) {
          if (person == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Person not found')),
            );
          }

          // Populate fields on first load
          _populateFields(person);

          return Scaffold(
            appBar: AppBar(
              title: Text('Edit ${person.firstName}'),
              actions: [
                if (_hasChanges)
                  TextButton(
                    onPressed: _isLoading ? null : _saveChanges,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
              ],
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSizes.spacingMd),
                children: [
                  // Photo section
                  _buildPhotoSection(),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Basic info section
                  _buildSectionHeader('Basic Information'),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildNameFields(),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Dates section
                  _buildSectionHeader('Dates'),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildDateFields(),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Contact section
                  _buildSectionHeader('Contact Information'),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildContactFields(),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Bio section
                  _buildSectionHeader('Bio'),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildBioField(),
                  const SizedBox(height: AppSizes.spacingLg),

                  // Privacy section
                  _buildSectionHeader('Privacy'),
                  const SizedBox(height: AppSizes.spacingSm),
                  _buildPrivacySection(),
                  const SizedBox(height: AppSizes.spacingXl),

                  // Save button
                  FilledButton(
                    onPressed: _hasChanges && !_isLoading ? _saveChanges : null,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save Changes'),
                  ),
                  const SizedBox(height: AppSizes.spacingXl),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
    );
  }

  Widget _buildPhotoSection() {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: HexagonAvatar(
              imageUrl: _photoUrl,
              initials: _getInitials(),
              size: 120,
              isDeceased: _isDeceased,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, size: 20),
                color: Colors.white,
                onPressed: _pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials() {
    final first = _firstNameController.text.isNotEmpty
        ? _firstNameController.text[0].toUpperCase()
        : '';
    final last = _lastNameController.text.isNotEmpty
        ? _lastNameController.text[0].toUpperCase()
        : '';
    return '$first$last';
  }

  Widget _buildNameFields() {
    return Column(
      children: [
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name *',
            prefixIcon: Icon(Icons.person_outline),
          ),
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'First name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSizes.spacingMd),
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name *',
            prefixIcon: Icon(Icons.person_outline),
          ),
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Last name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSizes.spacingMd),
        TextFormField(
          controller: _nicknameController,
          decoration: const InputDecoration(
            labelText: 'Nickname (optional)',
            prefixIcon: Icon(Icons.tag),
            hintText: 'e.g., "Bobby", "Nana"',
          ),
          textCapitalization: TextCapitalization.words,
        ),
      ],
    );
  }

  Widget _buildDateFields() {
    final dateFormat = DateFormat('MMMM d, yyyy');

    return Column(
      children: [
        // Birth date
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.cake_outlined),
          title: const Text('Birth Date'),
          subtitle: Text(
            _birthDate != null
                ? dateFormat.format(_birthDate!)
                : 'Not set',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_birthDate != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _birthDate = null;
                      _hasChanges = true;
                    });
                  },
                ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(isBirthDate: true),
              ),
            ],
          ),
        ),
        const Divider(),

        // Deceased toggle
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: Icon(
            _isDeceased ? Icons.church : Icons.favorite,
            color: _isDeceased ? Colors.grey : Colors.red,
          ),
          title: const Text('Deceased'),
          value: _isDeceased,
          onChanged: (value) {
            setState(() {
              _isDeceased = value;
              if (!value) {
                _deathDate = null;
              }
              _hasChanges = true;
            });
          },
        ),

        // Death date (only if deceased)
        if (_isDeceased) ...[
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_outlined),
            title: const Text('Death Date'),
            subtitle: Text(
              _deathDate != null
                  ? dateFormat.format(_deathDate!)
                  : 'Not set',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_deathDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _deathDate = null;
                        _hasChanges = true;
                      });
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(isBirthDate: false),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        TextFormField(
          controller: _locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            prefixIcon: Icon(Icons.location_on_outlined),
            hintText: 'e.g., San Francisco, CA',
          ),
        ),
        const SizedBox(height: AppSizes.spacingMd),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && value.isNotEmpty && !value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSizes.spacingMd),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildBioField() {
    return TextFormField(
      controller: _bioController,
      decoration: const InputDecoration(
        labelText: 'Biography',
        alignLabelWithHint: true,
        hintText: 'Write a short bio about this person...',
      ),
      maxLines: 4,
      maxLength: 500,
    );
  }

  Widget _buildPrivacySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Who can see this profile?',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: AppSizes.spacingSm),
        SegmentedButton<PersonVisibility>(
          segments: const [
            ButtonSegment(
              value: PersonVisibility.private,
              label: Text('Private'),
              icon: Icon(Icons.lock_outline),
            ),
            ButtonSegment(
              value: PersonVisibility.treeMembers,
              label: Text('Family'),
              icon: Icon(Icons.family_restroom),
            ),
            ButtonSegment(
              value: PersonVisibility.public,
              label: Text('Public'),
              icon: Icon(Icons.public),
            ),
          ],
          selected: {_visibility},
          onSelectionChanged: (selection) {
            setState(() {
              _visibility = selection.first;
              _hasChanges = true;
            });
          },
        ),
      ],
    );
  }
}

