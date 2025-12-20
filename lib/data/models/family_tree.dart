import 'package:flutter/foundation.dart';

/// Visibility levels for a family tree
enum TreeVisibility {
  /// Only the owner can see
  private,

  /// Only invited members can see
  inviteOnly,

  /// Anyone can view (but not edit)
  public,
}

/// Roles a user can have within a family tree
enum TreeRole {
  /// Full control over the tree
  owner,

  /// Can add/edit people and relationships
  editor,

  /// Can only view the tree
  viewer,
}

/// Extension for TreeRole permissions
extension TreeRoleExtension on TreeRole {
  bool get canEdit =>
      this == TreeRole.owner || this == TreeRole.editor;

  bool get canInvite => this == TreeRole.owner || this == TreeRole.editor;

  bool get canDelete => this == TreeRole.owner;

  bool get canChangeSettings => this == TreeRole.owner;

  bool get canPromoteToOwner => this == TreeRole.owner;
}

/// Represents a family tree
@immutable
class FamilyTree {
  final String id;
  final String name;
  final String? description;
  final String ownerId;
  final TreeVisibility visibility;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Statistics (can be computed or cached)
  final int? memberCount;
  final int? relationshipCount;

  const FamilyTree({
    required this.id,
    required this.name,
    this.description,
    required this.ownerId,
    this.visibility = TreeVisibility.private,
    required this.createdAt,
    required this.updatedAt,
    this.memberCount,
    this.relationshipCount,
  });

  /// Create a copy with updated fields
  FamilyTree copyWith({
    String? id,
    String? name,
    String? description,
    String? ownerId,
    TreeVisibility? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? memberCount,
    int? relationshipCount,
  }) {
    return FamilyTree(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      memberCount: memberCount ?? this.memberCount,
      relationshipCount: relationshipCount ?? this.relationshipCount,
    );
  }

  /// Convert to JSON for API/database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'owner_id': ownerId,
      'visibility': visibility.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create from JSON (API/database response)
  factory FamilyTree.fromJson(Map<String, dynamic> json) {
    return FamilyTree(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      ownerId: json['owner_id'] as String,
      visibility: TreeVisibility.values.firstWhere(
        (v) => v.name == json['visibility'],
        orElse: () => TreeVisibility.private,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      memberCount: json['member_count'] as int?,
      relationshipCount: json['relationship_count'] as int?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyTree && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'FamilyTree(id: $id, name: $name)';
}

/// Represents a user's membership in a family tree
@immutable
class TreeMember {
  final String treeId;
  final String userId;
  final String? personId; // Which Person in the tree they are (if any)
  final TreeRole role;
  final DateTime joinedAt;

  const TreeMember({
    required this.treeId,
    required this.userId,
    this.personId,
    required this.role,
    required this.joinedAt,
  });

  /// Convert to JSON for API/database
  Map<String, dynamic> toJson() {
    return {
      'tree_id': treeId,
      'user_id': userId,
      'person_id': personId,
      'role': role.name,
      'joined_at': joinedAt.toIso8601String(),
    };
  }

  /// Create from JSON (API/database response)
  factory TreeMember.fromJson(Map<String, dynamic> json) {
    return TreeMember(
      treeId: json['tree_id'] as String,
      userId: json['user_id'] as String,
      personId: json['person_id'] as String?,
      role: TreeRole.values.firstWhere(
        (r) => r.name == json['role'],
        orElse: () => TreeRole.viewer,
      ),
      joinedAt: DateTime.parse(json['joined_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreeMember &&
          runtimeType == other.runtimeType &&
          treeId == other.treeId &&
          userId == other.userId;

  @override
  int get hashCode => Object.hash(treeId, userId);
}
