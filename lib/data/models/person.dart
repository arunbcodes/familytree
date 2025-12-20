import 'package:flutter/foundation.dart';

/// Visibility levels for a person's profile
enum PersonVisibility {
  /// Only the person themselves can see
  private,

  /// All members of the family tree can see
  treeMembers,

  /// Anyone can see (public profile)
  public,
}

/// Represents a person in the family tree
@immutable
class Person {
  final String id;
  final String treeId;
  final String createdBy;

  // Basic info
  final String firstName;
  final String lastName;
  final String? nickname;
  final String? photoUrl;
  final List<String> additionalPhotos;

  // Dates
  final DateTime? birthDate;
  final DateTime? deathDate;
  final bool isDeceased;

  // Extended info
  final String? bio;
  final String? location;
  final String? contactEmail;
  final String? contactPhone;

  // Claim & Proxy
  final String? claimedBy;
  final DateTime? claimedAt;
  final bool isClaimable;
  final List<String> proxyManagers;
  final String? proxyReason;
  final bool isElderlyAssisted;

  // Privacy
  final PersonVisibility visibility;

  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;

  const Person({
    required this.id,
    required this.treeId,
    required this.createdBy,
    required this.firstName,
    required this.lastName,
    this.nickname,
    this.photoUrl,
    this.additionalPhotos = const [],
    this.birthDate,
    this.deathDate,
    this.isDeceased = false,
    this.bio,
    this.location,
    this.contactEmail,
    this.contactPhone,
    this.claimedBy,
    this.claimedAt,
    this.isClaimable = true,
    this.proxyManagers = const [],
    this.proxyReason,
    this.isElderlyAssisted = false,
    this.visibility = PersonVisibility.treeMembers,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Full name combining first and last name
  String get fullName => '$firstName $lastName';

  /// Display name (nickname if available, otherwise first name)
  String get displayName => nickname ?? firstName;

  /// Initials for avatar placeholder
  String get initials {
    final first = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final last = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$first$last';
  }

  /// Age calculation (if birth date available)
  int? get age {
    if (birthDate == null) return null;
    final endDate = deathDate ?? DateTime.now();
    int years = endDate.year - birthDate!.year;
    if (endDate.month < birthDate!.month ||
        (endDate.month == birthDate!.month && endDate.day < birthDate!.day)) {
      years--;
    }
    return years;
  }

  /// Whether this person has been claimed by a user
  bool get isClaimed => claimedBy != null;

  /// Whether this person is managed by a proxy
  bool get hasProxy => proxyManagers.isNotEmpty;

  /// Create a copy with updated fields
  Person copyWith({
    String? id,
    String? treeId,
    String? createdBy,
    String? firstName,
    String? lastName,
    String? nickname,
    String? photoUrl,
    List<String>? additionalPhotos,
    DateTime? birthDate,
    DateTime? deathDate,
    bool? isDeceased,
    String? bio,
    String? location,
    String? contactEmail,
    String? contactPhone,
    String? claimedBy,
    DateTime? claimedAt,
    bool? isClaimable,
    List<String>? proxyManagers,
    String? proxyReason,
    bool? isElderlyAssisted,
    PersonVisibility? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Person(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      createdBy: createdBy ?? this.createdBy,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickname: nickname ?? this.nickname,
      photoUrl: photoUrl ?? this.photoUrl,
      additionalPhotos: additionalPhotos ?? this.additionalPhotos,
      birthDate: birthDate ?? this.birthDate,
      deathDate: deathDate ?? this.deathDate,
      isDeceased: isDeceased ?? this.isDeceased,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      claimedBy: claimedBy ?? this.claimedBy,
      claimedAt: claimedAt ?? this.claimedAt,
      isClaimable: isClaimable ?? this.isClaimable,
      proxyManagers: proxyManagers ?? this.proxyManagers,
      proxyReason: proxyReason ?? this.proxyReason,
      isElderlyAssisted: isElderlyAssisted ?? this.isElderlyAssisted,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert to JSON for API/database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tree_id': treeId,
      'created_by': createdBy,
      'first_name': firstName,
      'last_name': lastName,
      'nickname': nickname,
      'photo_url': photoUrl,
      'additional_photos': additionalPhotos,
      'birth_date': birthDate?.toIso8601String(),
      'death_date': deathDate?.toIso8601String(),
      'is_deceased': isDeceased,
      'bio': bio,
      'location': location,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'claimed_by': claimedBy,
      'claimed_at': claimedAt?.toIso8601String(),
      'is_claimable': isClaimable,
      'proxy_managers': proxyManagers,
      'proxy_reason': proxyReason,
      'is_elderly_assisted': isElderlyAssisted,
      'visibility': visibility.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create from JSON (API/database response)
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as String,
      treeId: json['tree_id'] as String,
      createdBy: json['created_by'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      nickname: json['nickname'] as String?,
      photoUrl: json['photo_url'] as String?,
      additionalPhotos: List<String>.from(json['additional_photos'] ?? []),
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'] as String)
          : null,
      deathDate: json['death_date'] != null
          ? DateTime.parse(json['death_date'] as String)
          : null,
      isDeceased: json['is_deceased'] as bool? ?? false,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      contactEmail: json['contact_email'] as String?,
      contactPhone: json['contact_phone'] as String?,
      claimedBy: json['claimed_by'] as String?,
      claimedAt: json['claimed_at'] != null
          ? DateTime.parse(json['claimed_at'] as String)
          : null,
      isClaimable: json['is_claimable'] as bool? ?? true,
      proxyManagers: List<String>.from(json['proxy_managers'] ?? []),
      proxyReason: json['proxy_reason'] as String?,
      isElderlyAssisted: json['is_elderly_assisted'] as bool? ?? false,
      visibility: PersonVisibility.values.firstWhere(
        (v) => v.name == json['visibility'],
        orElse: () => PersonVisibility.treeMembers,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Person(id: $id, name: $fullName)';
}
