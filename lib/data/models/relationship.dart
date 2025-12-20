import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Types of relationships between family members
enum RelationshipType {
  /// person1 is parent of person2
  parentChild,

  /// Current spouse/partner
  spouse,

  /// Former spouse/partner
  exSpouse,

  /// Full sibling (same parents)
  sibling,

  /// Half-sibling (one shared parent)
  halfSibling,

  /// person1 is step-parent of person2
  stepParent,

  /// person1 is adoptive parent of person2
  adoptiveParent,

  /// person1 is godparent of person2
  godparent,
}

/// Extension to get display properties for relationship types
extension RelationshipTypeExtension on RelationshipType {
  /// Get the color associated with this relationship type
  Color get color {
    switch (this) {
      case RelationshipType.parentChild:
        return AppColors.parentChild;
      case RelationshipType.spouse:
        return AppColors.spouse;
      case RelationshipType.exSpouse:
        return AppColors.exSpouse;
      case RelationshipType.sibling:
        return AppColors.sibling;
      case RelationshipType.halfSibling:
        return AppColors.halfSibling;
      case RelationshipType.stepParent:
        return AppColors.stepFamily;
      case RelationshipType.adoptiveParent:
        return AppColors.adoptive;
      case RelationshipType.godparent:
        return AppColors.godparent;
    }
  }

  /// Get label from person1's perspective
  String get labelFromPerson1 {
    switch (this) {
      case RelationshipType.parentChild:
        return 'Child';
      case RelationshipType.spouse:
        return 'Spouse';
      case RelationshipType.exSpouse:
        return 'Ex-Spouse';
      case RelationshipType.sibling:
        return 'Sibling';
      case RelationshipType.halfSibling:
        return 'Half-Sibling';
      case RelationshipType.stepParent:
        return 'Step-Child';
      case RelationshipType.adoptiveParent:
        return 'Adopted Child';
      case RelationshipType.godparent:
        return 'Godchild';
    }
  }

  /// Get label from person2's perspective
  String get labelFromPerson2 {
    switch (this) {
      case RelationshipType.parentChild:
        return 'Parent';
      case RelationshipType.spouse:
        return 'Spouse';
      case RelationshipType.exSpouse:
        return 'Ex-Spouse';
      case RelationshipType.sibling:
        return 'Sibling';
      case RelationshipType.halfSibling:
        return 'Half-Sibling';
      case RelationshipType.stepParent:
        return 'Step-Parent';
      case RelationshipType.adoptiveParent:
        return 'Adoptive Parent';
      case RelationshipType.godparent:
        return 'Godparent';
    }
  }

  /// Whether this is a symmetric relationship (same label both ways)
  bool get isSymmetric {
    switch (this) {
      case RelationshipType.spouse:
      case RelationshipType.exSpouse:
      case RelationshipType.sibling:
      case RelationshipType.halfSibling:
        return true;
      case RelationshipType.parentChild:
      case RelationshipType.stepParent:
      case RelationshipType.adoptiveParent:
      case RelationshipType.godparent:
        return false;
    }
  }
}

/// Represents a relationship between two people in the family tree
@immutable
class Relationship {
  final String id;
  final String treeId;
  final String person1Id;
  final String person2Id;
  final RelationshipType type;
  final DateTime? startDate; // e.g., marriage date
  final DateTime? endDate; // e.g., divorce date
  final String createdBy;
  final DateTime createdAt;

  const Relationship({
    required this.id,
    required this.treeId,
    required this.person1Id,
    required this.person2Id,
    required this.type,
    this.startDate,
    this.endDate,
    required this.createdBy,
    required this.createdAt,
  });

  /// Get the relationship label from a specific person's perspective
  String getLabelFor(String personId) {
    if (personId == person1Id) {
      return type.labelFromPerson1;
    } else if (personId == person2Id) {
      return type.labelFromPerson2;
    }
    return type.labelFromPerson1; // Default
  }

  /// Get the other person's ID given one person's ID
  String getOtherPersonId(String personId) {
    if (personId == person1Id) {
      return person2Id;
    } else if (personId == person2Id) {
      return person1Id;
    }
    throw ArgumentError('Person $personId is not part of this relationship');
  }

  /// Whether this relationship is currently active (not ended)
  bool get isActive => endDate == null;

  /// Duration of the relationship (for dated relationships like marriage)
  Duration? get duration {
    if (startDate == null) return null;
    final end = endDate ?? DateTime.now();
    return end.difference(startDate!);
  }

  /// Create a copy with updated fields
  Relationship copyWith({
    String? id,
    String? treeId,
    String? person1Id,
    String? person2Id,
    RelationshipType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return Relationship(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      person1Id: person1Id ?? this.person1Id,
      person2Id: person2Id ?? this.person2Id,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Convert to JSON for API/database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tree_id': treeId,
      'person1_id': person1Id,
      'person2_id': person2Id,
      'type': type.name,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Create from JSON (API/database response)
  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
      id: json['id'] as String,
      treeId: json['tree_id'] as String,
      person1Id: json['person1_id'] as String,
      person2Id: json['person2_id'] as String,
      type: RelationshipType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => RelationshipType.parentChild,
      ),
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Relationship &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Relationship(id: $id, type: ${type.name}, $person1Id <-> $person2Id)';
}
