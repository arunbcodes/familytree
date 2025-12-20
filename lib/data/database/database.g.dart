// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PersonsTableTable extends PersonsTable
    with TableInfo<$PersonsTableTable, PersonsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<String> treeId = GeneratedColumn<String>(
    'tree_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _additionalPhotosMeta = const VerificationMeta(
    'additionalPhotos',
  );
  @override
  late final GeneratedColumn<String> additionalPhotos = GeneratedColumn<String>(
    'additional_photos',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deathDateMeta = const VerificationMeta(
    'deathDate',
  );
  @override
  late final GeneratedColumn<DateTime> deathDate = GeneratedColumn<DateTime>(
    'death_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeceasedMeta = const VerificationMeta(
    'isDeceased',
  );
  @override
  late final GeneratedColumn<bool> isDeceased = GeneratedColumn<bool>(
    'is_deceased',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deceased" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactEmailMeta = const VerificationMeta(
    'contactEmail',
  );
  @override
  late final GeneratedColumn<String> contactEmail = GeneratedColumn<String>(
    'contact_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPhoneMeta = const VerificationMeta(
    'contactPhone',
  );
  @override
  late final GeneratedColumn<String> contactPhone = GeneratedColumn<String>(
    'contact_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimedByMeta = const VerificationMeta(
    'claimedBy',
  );
  @override
  late final GeneratedColumn<String> claimedBy = GeneratedColumn<String>(
    'claimed_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimedAtMeta = const VerificationMeta(
    'claimedAt',
  );
  @override
  late final GeneratedColumn<DateTime> claimedAt = GeneratedColumn<DateTime>(
    'claimed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isClaimableMeta = const VerificationMeta(
    'isClaimable',
  );
  @override
  late final GeneratedColumn<bool> isClaimable = GeneratedColumn<bool>(
    'is_claimable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_claimable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _proxyManagersMeta = const VerificationMeta(
    'proxyManagers',
  );
  @override
  late final GeneratedColumn<String> proxyManagers = GeneratedColumn<String>(
    'proxy_managers',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proxyReasonMeta = const VerificationMeta(
    'proxyReason',
  );
  @override
  late final GeneratedColumn<String> proxyReason = GeneratedColumn<String>(
    'proxy_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isElderlyAssistedMeta = const VerificationMeta(
    'isElderlyAssisted',
  );
  @override
  late final GeneratedColumn<bool> isElderlyAssisted = GeneratedColumn<bool>(
    'is_elderly_assisted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_elderly_assisted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('treeMembers'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treeId,
    createdBy,
    firstName,
    lastName,
    nickname,
    photoUrl,
    additionalPhotos,
    birthDate,
    deathDate,
    isDeceased,
    bio,
    location,
    contactEmail,
    contactPhone,
    claimedBy,
    claimedAt,
    isClaimable,
    proxyManagers,
    proxyReason,
    isElderlyAssisted,
    visibility,
    createdAt,
    updatedAt,
    isSynced,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('additional_photos')) {
      context.handle(
        _additionalPhotosMeta,
        additionalPhotos.isAcceptableOrUnknown(
          data['additional_photos']!,
          _additionalPhotosMeta,
        ),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('death_date')) {
      context.handle(
        _deathDateMeta,
        deathDate.isAcceptableOrUnknown(data['death_date']!, _deathDateMeta),
      );
    }
    if (data.containsKey('is_deceased')) {
      context.handle(
        _isDeceasedMeta,
        isDeceased.isAcceptableOrUnknown(data['is_deceased']!, _isDeceasedMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('contact_email')) {
      context.handle(
        _contactEmailMeta,
        contactEmail.isAcceptableOrUnknown(
          data['contact_email']!,
          _contactEmailMeta,
        ),
      );
    }
    if (data.containsKey('contact_phone')) {
      context.handle(
        _contactPhoneMeta,
        contactPhone.isAcceptableOrUnknown(
          data['contact_phone']!,
          _contactPhoneMeta,
        ),
      );
    }
    if (data.containsKey('claimed_by')) {
      context.handle(
        _claimedByMeta,
        claimedBy.isAcceptableOrUnknown(data['claimed_by']!, _claimedByMeta),
      );
    }
    if (data.containsKey('claimed_at')) {
      context.handle(
        _claimedAtMeta,
        claimedAt.isAcceptableOrUnknown(data['claimed_at']!, _claimedAtMeta),
      );
    }
    if (data.containsKey('is_claimable')) {
      context.handle(
        _isClaimableMeta,
        isClaimable.isAcceptableOrUnknown(
          data['is_claimable']!,
          _isClaimableMeta,
        ),
      );
    }
    if (data.containsKey('proxy_managers')) {
      context.handle(
        _proxyManagersMeta,
        proxyManagers.isAcceptableOrUnknown(
          data['proxy_managers']!,
          _proxyManagersMeta,
        ),
      );
    }
    if (data.containsKey('proxy_reason')) {
      context.handle(
        _proxyReasonMeta,
        proxyReason.isAcceptableOrUnknown(
          data['proxy_reason']!,
          _proxyReasonMeta,
        ),
      );
    }
    if (data.containsKey('is_elderly_assisted')) {
      context.handle(
        _isElderlyAssistedMeta,
        isElderlyAssisted.isAcceptableOrUnknown(
          data['is_elderly_assisted']!,
          _isElderlyAssistedMeta,
        ),
      );
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tree_id'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      additionalPhotos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}additional_photos'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      deathDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}death_date'],
      ),
      isDeceased: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deceased'],
      )!,
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      contactEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_email'],
      ),
      contactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_phone'],
      ),
      claimedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}claimed_by'],
      ),
      claimedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}claimed_at'],
      ),
      isClaimable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_claimable'],
      )!,
      proxyManagers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proxy_managers'],
      ),
      proxyReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proxy_reason'],
      ),
      isElderlyAssisted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_elderly_assisted'],
      )!,
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibility'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $PersonsTableTable createAlias(String alias) {
    return $PersonsTableTable(attachedDatabase, alias);
  }
}

class PersonsTableData extends DataClass
    implements Insertable<PersonsTableData> {
  final String id;
  final String treeId;
  final String createdBy;
  final String firstName;
  final String lastName;
  final String? nickname;
  final String? photoUrl;
  final String? additionalPhotos;
  final DateTime? birthDate;
  final DateTime? deathDate;
  final bool isDeceased;
  final String? bio;
  final String? location;
  final String? contactEmail;
  final String? contactPhone;
  final String? claimedBy;
  final DateTime? claimedAt;
  final bool isClaimable;
  final String? proxyManagers;
  final String? proxyReason;
  final bool isElderlyAssisted;
  final String visibility;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final DateTime? lastSyncedAt;
  const PersonsTableData({
    required this.id,
    required this.treeId,
    required this.createdBy,
    required this.firstName,
    required this.lastName,
    this.nickname,
    this.photoUrl,
    this.additionalPhotos,
    this.birthDate,
    this.deathDate,
    required this.isDeceased,
    this.bio,
    this.location,
    this.contactEmail,
    this.contactPhone,
    this.claimedBy,
    this.claimedAt,
    required this.isClaimable,
    this.proxyManagers,
    this.proxyReason,
    required this.isElderlyAssisted,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tree_id'] = Variable<String>(treeId);
    map['created_by'] = Variable<String>(createdBy);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || additionalPhotos != null) {
      map['additional_photos'] = Variable<String>(additionalPhotos);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || deathDate != null) {
      map['death_date'] = Variable<DateTime>(deathDate);
    }
    map['is_deceased'] = Variable<bool>(isDeceased);
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || contactEmail != null) {
      map['contact_email'] = Variable<String>(contactEmail);
    }
    if (!nullToAbsent || contactPhone != null) {
      map['contact_phone'] = Variable<String>(contactPhone);
    }
    if (!nullToAbsent || claimedBy != null) {
      map['claimed_by'] = Variable<String>(claimedBy);
    }
    if (!nullToAbsent || claimedAt != null) {
      map['claimed_at'] = Variable<DateTime>(claimedAt);
    }
    map['is_claimable'] = Variable<bool>(isClaimable);
    if (!nullToAbsent || proxyManagers != null) {
      map['proxy_managers'] = Variable<String>(proxyManagers);
    }
    if (!nullToAbsent || proxyReason != null) {
      map['proxy_reason'] = Variable<String>(proxyReason);
    }
    map['is_elderly_assisted'] = Variable<bool>(isElderlyAssisted);
    map['visibility'] = Variable<String>(visibility);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  PersonsTableCompanion toCompanion(bool nullToAbsent) {
    return PersonsTableCompanion(
      id: Value(id),
      treeId: Value(treeId),
      createdBy: Value(createdBy),
      firstName: Value(firstName),
      lastName: Value(lastName),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      additionalPhotos: additionalPhotos == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalPhotos),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      deathDate: deathDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deathDate),
      isDeceased: Value(isDeceased),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      contactEmail: contactEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(contactEmail),
      contactPhone: contactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPhone),
      claimedBy: claimedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(claimedBy),
      claimedAt: claimedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(claimedAt),
      isClaimable: Value(isClaimable),
      proxyManagers: proxyManagers == null && nullToAbsent
          ? const Value.absent()
          : Value(proxyManagers),
      proxyReason: proxyReason == null && nullToAbsent
          ? const Value.absent()
          : Value(proxyReason),
      isElderlyAssisted: Value(isElderlyAssisted),
      visibility: Value(visibility),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory PersonsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonsTableData(
      id: serializer.fromJson<String>(json['id']),
      treeId: serializer.fromJson<String>(json['treeId']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      additionalPhotos: serializer.fromJson<String?>(json['additionalPhotos']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      deathDate: serializer.fromJson<DateTime?>(json['deathDate']),
      isDeceased: serializer.fromJson<bool>(json['isDeceased']),
      bio: serializer.fromJson<String?>(json['bio']),
      location: serializer.fromJson<String?>(json['location']),
      contactEmail: serializer.fromJson<String?>(json['contactEmail']),
      contactPhone: serializer.fromJson<String?>(json['contactPhone']),
      claimedBy: serializer.fromJson<String?>(json['claimedBy']),
      claimedAt: serializer.fromJson<DateTime?>(json['claimedAt']),
      isClaimable: serializer.fromJson<bool>(json['isClaimable']),
      proxyManagers: serializer.fromJson<String?>(json['proxyManagers']),
      proxyReason: serializer.fromJson<String?>(json['proxyReason']),
      isElderlyAssisted: serializer.fromJson<bool>(json['isElderlyAssisted']),
      visibility: serializer.fromJson<String>(json['visibility']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeId': serializer.toJson<String>(treeId),
      'createdBy': serializer.toJson<String>(createdBy),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'nickname': serializer.toJson<String?>(nickname),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'additionalPhotos': serializer.toJson<String?>(additionalPhotos),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'deathDate': serializer.toJson<DateTime?>(deathDate),
      'isDeceased': serializer.toJson<bool>(isDeceased),
      'bio': serializer.toJson<String?>(bio),
      'location': serializer.toJson<String?>(location),
      'contactEmail': serializer.toJson<String?>(contactEmail),
      'contactPhone': serializer.toJson<String?>(contactPhone),
      'claimedBy': serializer.toJson<String?>(claimedBy),
      'claimedAt': serializer.toJson<DateTime?>(claimedAt),
      'isClaimable': serializer.toJson<bool>(isClaimable),
      'proxyManagers': serializer.toJson<String?>(proxyManagers),
      'proxyReason': serializer.toJson<String?>(proxyReason),
      'isElderlyAssisted': serializer.toJson<bool>(isElderlyAssisted),
      'visibility': serializer.toJson<String>(visibility),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  PersonsTableData copyWith({
    String? id,
    String? treeId,
    String? createdBy,
    String? firstName,
    String? lastName,
    Value<String?> nickname = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> additionalPhotos = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    Value<DateTime?> deathDate = const Value.absent(),
    bool? isDeceased,
    Value<String?> bio = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> contactEmail = const Value.absent(),
    Value<String?> contactPhone = const Value.absent(),
    Value<String?> claimedBy = const Value.absent(),
    Value<DateTime?> claimedAt = const Value.absent(),
    bool? isClaimable,
    Value<String?> proxyManagers = const Value.absent(),
    Value<String?> proxyReason = const Value.absent(),
    bool? isElderlyAssisted,
    String? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => PersonsTableData(
    id: id ?? this.id,
    treeId: treeId ?? this.treeId,
    createdBy: createdBy ?? this.createdBy,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    nickname: nickname.present ? nickname.value : this.nickname,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    additionalPhotos: additionalPhotos.present
        ? additionalPhotos.value
        : this.additionalPhotos,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    deathDate: deathDate.present ? deathDate.value : this.deathDate,
    isDeceased: isDeceased ?? this.isDeceased,
    bio: bio.present ? bio.value : this.bio,
    location: location.present ? location.value : this.location,
    contactEmail: contactEmail.present ? contactEmail.value : this.contactEmail,
    contactPhone: contactPhone.present ? contactPhone.value : this.contactPhone,
    claimedBy: claimedBy.present ? claimedBy.value : this.claimedBy,
    claimedAt: claimedAt.present ? claimedAt.value : this.claimedAt,
    isClaimable: isClaimable ?? this.isClaimable,
    proxyManagers: proxyManagers.present
        ? proxyManagers.value
        : this.proxyManagers,
    proxyReason: proxyReason.present ? proxyReason.value : this.proxyReason,
    isElderlyAssisted: isElderlyAssisted ?? this.isElderlyAssisted,
    visibility: visibility ?? this.visibility,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  PersonsTableData copyWithCompanion(PersonsTableCompanion data) {
    return PersonsTableData(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      additionalPhotos: data.additionalPhotos.present
          ? data.additionalPhotos.value
          : this.additionalPhotos,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      deathDate: data.deathDate.present ? data.deathDate.value : this.deathDate,
      isDeceased: data.isDeceased.present
          ? data.isDeceased.value
          : this.isDeceased,
      bio: data.bio.present ? data.bio.value : this.bio,
      location: data.location.present ? data.location.value : this.location,
      contactEmail: data.contactEmail.present
          ? data.contactEmail.value
          : this.contactEmail,
      contactPhone: data.contactPhone.present
          ? data.contactPhone.value
          : this.contactPhone,
      claimedBy: data.claimedBy.present ? data.claimedBy.value : this.claimedBy,
      claimedAt: data.claimedAt.present ? data.claimedAt.value : this.claimedAt,
      isClaimable: data.isClaimable.present
          ? data.isClaimable.value
          : this.isClaimable,
      proxyManagers: data.proxyManagers.present
          ? data.proxyManagers.value
          : this.proxyManagers,
      proxyReason: data.proxyReason.present
          ? data.proxyReason.value
          : this.proxyReason,
      isElderlyAssisted: data.isElderlyAssisted.present
          ? data.isElderlyAssisted.value
          : this.isElderlyAssisted,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonsTableData(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('createdBy: $createdBy, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickname: $nickname, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('additionalPhotos: $additionalPhotos, ')
          ..write('birthDate: $birthDate, ')
          ..write('deathDate: $deathDate, ')
          ..write('isDeceased: $isDeceased, ')
          ..write('bio: $bio, ')
          ..write('location: $location, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('claimedBy: $claimedBy, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('isClaimable: $isClaimable, ')
          ..write('proxyManagers: $proxyManagers, ')
          ..write('proxyReason: $proxyReason, ')
          ..write('isElderlyAssisted: $isElderlyAssisted, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    treeId,
    createdBy,
    firstName,
    lastName,
    nickname,
    photoUrl,
    additionalPhotos,
    birthDate,
    deathDate,
    isDeceased,
    bio,
    location,
    contactEmail,
    contactPhone,
    claimedBy,
    claimedAt,
    isClaimable,
    proxyManagers,
    proxyReason,
    isElderlyAssisted,
    visibility,
    createdAt,
    updatedAt,
    isSynced,
    lastSyncedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonsTableData &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.createdBy == this.createdBy &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.nickname == this.nickname &&
          other.photoUrl == this.photoUrl &&
          other.additionalPhotos == this.additionalPhotos &&
          other.birthDate == this.birthDate &&
          other.deathDate == this.deathDate &&
          other.isDeceased == this.isDeceased &&
          other.bio == this.bio &&
          other.location == this.location &&
          other.contactEmail == this.contactEmail &&
          other.contactPhone == this.contactPhone &&
          other.claimedBy == this.claimedBy &&
          other.claimedAt == this.claimedAt &&
          other.isClaimable == this.isClaimable &&
          other.proxyManagers == this.proxyManagers &&
          other.proxyReason == this.proxyReason &&
          other.isElderlyAssisted == this.isElderlyAssisted &&
          other.visibility == this.visibility &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class PersonsTableCompanion extends UpdateCompanion<PersonsTableData> {
  final Value<String> id;
  final Value<String> treeId;
  final Value<String> createdBy;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> nickname;
  final Value<String?> photoUrl;
  final Value<String?> additionalPhotos;
  final Value<DateTime?> birthDate;
  final Value<DateTime?> deathDate;
  final Value<bool> isDeceased;
  final Value<String?> bio;
  final Value<String?> location;
  final Value<String?> contactEmail;
  final Value<String?> contactPhone;
  final Value<String?> claimedBy;
  final Value<DateTime?> claimedAt;
  final Value<bool> isClaimable;
  final Value<String?> proxyManagers;
  final Value<String?> proxyReason;
  final Value<bool> isElderlyAssisted;
  final Value<String> visibility;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const PersonsTableCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.nickname = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.additionalPhotos = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.deathDate = const Value.absent(),
    this.isDeceased = const Value.absent(),
    this.bio = const Value.absent(),
    this.location = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.claimedBy = const Value.absent(),
    this.claimedAt = const Value.absent(),
    this.isClaimable = const Value.absent(),
    this.proxyManagers = const Value.absent(),
    this.proxyReason = const Value.absent(),
    this.isElderlyAssisted = const Value.absent(),
    this.visibility = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonsTableCompanion.insert({
    required String id,
    required String treeId,
    required String createdBy,
    required String firstName,
    required String lastName,
    this.nickname = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.additionalPhotos = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.deathDate = const Value.absent(),
    this.isDeceased = const Value.absent(),
    this.bio = const Value.absent(),
    this.location = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.claimedBy = const Value.absent(),
    this.claimedAt = const Value.absent(),
    this.isClaimable = const Value.absent(),
    this.proxyManagers = const Value.absent(),
    this.proxyReason = const Value.absent(),
    this.isElderlyAssisted = const Value.absent(),
    this.visibility = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       treeId = Value(treeId),
       createdBy = Value(createdBy),
       firstName = Value(firstName),
       lastName = Value(lastName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PersonsTableData> custom({
    Expression<String>? id,
    Expression<String>? treeId,
    Expression<String>? createdBy,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? nickname,
    Expression<String>? photoUrl,
    Expression<String>? additionalPhotos,
    Expression<DateTime>? birthDate,
    Expression<DateTime>? deathDate,
    Expression<bool>? isDeceased,
    Expression<String>? bio,
    Expression<String>? location,
    Expression<String>? contactEmail,
    Expression<String>? contactPhone,
    Expression<String>? claimedBy,
    Expression<DateTime>? claimedAt,
    Expression<bool>? isClaimable,
    Expression<String>? proxyManagers,
    Expression<String>? proxyReason,
    Expression<bool>? isElderlyAssisted,
    Expression<String>? visibility,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (createdBy != null) 'created_by': createdBy,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (nickname != null) 'nickname': nickname,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (additionalPhotos != null) 'additional_photos': additionalPhotos,
      if (birthDate != null) 'birth_date': birthDate,
      if (deathDate != null) 'death_date': deathDate,
      if (isDeceased != null) 'is_deceased': isDeceased,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (contactEmail != null) 'contact_email': contactEmail,
      if (contactPhone != null) 'contact_phone': contactPhone,
      if (claimedBy != null) 'claimed_by': claimedBy,
      if (claimedAt != null) 'claimed_at': claimedAt,
      if (isClaimable != null) 'is_claimable': isClaimable,
      if (proxyManagers != null) 'proxy_managers': proxyManagers,
      if (proxyReason != null) 'proxy_reason': proxyReason,
      if (isElderlyAssisted != null) 'is_elderly_assisted': isElderlyAssisted,
      if (visibility != null) 'visibility': visibility,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? treeId,
    Value<String>? createdBy,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String?>? nickname,
    Value<String?>? photoUrl,
    Value<String?>? additionalPhotos,
    Value<DateTime?>? birthDate,
    Value<DateTime?>? deathDate,
    Value<bool>? isDeceased,
    Value<String?>? bio,
    Value<String?>? location,
    Value<String?>? contactEmail,
    Value<String?>? contactPhone,
    Value<String?>? claimedBy,
    Value<DateTime?>? claimedAt,
    Value<bool>? isClaimable,
    Value<String?>? proxyManagers,
    Value<String?>? proxyReason,
    Value<bool>? isElderlyAssisted,
    Value<String>? visibility,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return PersonsTableCompanion(
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
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<String>(treeId.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (additionalPhotos.present) {
      map['additional_photos'] = Variable<String>(additionalPhotos.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (deathDate.present) {
      map['death_date'] = Variable<DateTime>(deathDate.value);
    }
    if (isDeceased.present) {
      map['is_deceased'] = Variable<bool>(isDeceased.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (contactEmail.present) {
      map['contact_email'] = Variable<String>(contactEmail.value);
    }
    if (contactPhone.present) {
      map['contact_phone'] = Variable<String>(contactPhone.value);
    }
    if (claimedBy.present) {
      map['claimed_by'] = Variable<String>(claimedBy.value);
    }
    if (claimedAt.present) {
      map['claimed_at'] = Variable<DateTime>(claimedAt.value);
    }
    if (isClaimable.present) {
      map['is_claimable'] = Variable<bool>(isClaimable.value);
    }
    if (proxyManagers.present) {
      map['proxy_managers'] = Variable<String>(proxyManagers.value);
    }
    if (proxyReason.present) {
      map['proxy_reason'] = Variable<String>(proxyReason.value);
    }
    if (isElderlyAssisted.present) {
      map['is_elderly_assisted'] = Variable<bool>(isElderlyAssisted.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsTableCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('createdBy: $createdBy, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('nickname: $nickname, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('additionalPhotos: $additionalPhotos, ')
          ..write('birthDate: $birthDate, ')
          ..write('deathDate: $deathDate, ')
          ..write('isDeceased: $isDeceased, ')
          ..write('bio: $bio, ')
          ..write('location: $location, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('claimedBy: $claimedBy, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('isClaimable: $isClaimable, ')
          ..write('proxyManagers: $proxyManagers, ')
          ..write('proxyReason: $proxyReason, ')
          ..write('isElderlyAssisted: $isElderlyAssisted, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationshipsTableTable extends RelationshipsTable
    with TableInfo<$RelationshipsTableTable, RelationshipsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<String> treeId = GeneratedColumn<String>(
    'tree_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _person1IdMeta = const VerificationMeta(
    'person1Id',
  );
  @override
  late final GeneratedColumn<String> person1Id = GeneratedColumn<String>(
    'person1_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _person2IdMeta = const VerificationMeta(
    'person2Id',
  );
  @override
  late final GeneratedColumn<String> person2Id = GeneratedColumn<String>(
    'person2_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treeId,
    person1Id,
    person2Id,
    type,
    startDate,
    endDate,
    createdBy,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationships';
  @override
  VerificationContext validateIntegrity(
    Insertable<RelationshipsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('person1_id')) {
      context.handle(
        _person1IdMeta,
        person1Id.isAcceptableOrUnknown(data['person1_id']!, _person1IdMeta),
      );
    } else if (isInserting) {
      context.missing(_person1IdMeta);
    }
    if (data.containsKey('person2_id')) {
      context.handle(
        _person2IdMeta,
        person2Id.isAcceptableOrUnknown(data['person2_id']!, _person2IdMeta),
      );
    } else if (isInserting) {
      context.missing(_person2IdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RelationshipsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationshipsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tree_id'],
      )!,
      person1Id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person1_id'],
      )!,
      person2Id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person2_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $RelationshipsTableTable createAlias(String alias) {
    return $RelationshipsTableTable(attachedDatabase, alias);
  }
}

class RelationshipsTableData extends DataClass
    implements Insertable<RelationshipsTableData> {
  final String id;
  final String treeId;
  final String person1Id;
  final String person2Id;
  final String type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String createdBy;
  final DateTime createdAt;
  final bool isSynced;
  const RelationshipsTableData({
    required this.id,
    required this.treeId,
    required this.person1Id,
    required this.person2Id,
    required this.type,
    this.startDate,
    this.endDate,
    required this.createdBy,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tree_id'] = Variable<String>(treeId);
    map['person1_id'] = Variable<String>(person1Id);
    map['person2_id'] = Variable<String>(person2Id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  RelationshipsTableCompanion toCompanion(bool nullToAbsent) {
    return RelationshipsTableCompanion(
      id: Value(id),
      treeId: Value(treeId),
      person1Id: Value(person1Id),
      person2Id: Value(person2Id),
      type: Value(type),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory RelationshipsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationshipsTableData(
      id: serializer.fromJson<String>(json['id']),
      treeId: serializer.fromJson<String>(json['treeId']),
      person1Id: serializer.fromJson<String>(json['person1Id']),
      person2Id: serializer.fromJson<String>(json['person2Id']),
      type: serializer.fromJson<String>(json['type']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeId': serializer.toJson<String>(treeId),
      'person1Id': serializer.toJson<String>(person1Id),
      'person2Id': serializer.toJson<String>(person2Id),
      'type': serializer.toJson<String>(type),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  RelationshipsTableData copyWith({
    String? id,
    String? treeId,
    String? person1Id,
    String? person2Id,
    String? type,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    String? createdBy,
    DateTime? createdAt,
    bool? isSynced,
  }) => RelationshipsTableData(
    id: id ?? this.id,
    treeId: treeId ?? this.treeId,
    person1Id: person1Id ?? this.person1Id,
    person2Id: person2Id ?? this.person2Id,
    type: type ?? this.type,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  RelationshipsTableData copyWithCompanion(RelationshipsTableCompanion data) {
    return RelationshipsTableData(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      person1Id: data.person1Id.present ? data.person1Id.value : this.person1Id,
      person2Id: data.person2Id.present ? data.person2Id.value : this.person2Id,
      type: data.type.present ? data.type.value : this.type,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsTableData(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('person1Id: $person1Id, ')
          ..write('person2Id: $person2Id, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    treeId,
    person1Id,
    person2Id,
    type,
    startDate,
    endDate,
    createdBy,
    createdAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationshipsTableData &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.person1Id == this.person1Id &&
          other.person2Id == this.person2Id &&
          other.type == this.type &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class RelationshipsTableCompanion
    extends UpdateCompanion<RelationshipsTableData> {
  final Value<String> id;
  final Value<String> treeId;
  final Value<String> person1Id;
  final Value<String> person2Id;
  final Value<String> type;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const RelationshipsTableCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.person1Id = const Value.absent(),
    this.person2Id = const Value.absent(),
    this.type = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipsTableCompanion.insert({
    required String id,
    required String treeId,
    required String person1Id,
    required String person2Id,
    required String type,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String createdBy,
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       treeId = Value(treeId),
       person1Id = Value(person1Id),
       person2Id = Value(person2Id),
       type = Value(type),
       createdBy = Value(createdBy),
       createdAt = Value(createdAt);
  static Insertable<RelationshipsTableData> custom({
    Expression<String>? id,
    Expression<String>? treeId,
    Expression<String>? person1Id,
    Expression<String>? person2Id,
    Expression<String>? type,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (person1Id != null) 'person1_id': person1Id,
      if (person2Id != null) 'person2_id': person2Id,
      if (type != null) 'type': type,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? treeId,
    Value<String>? person1Id,
    Value<String>? person2Id,
    Value<String>? type,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<String>? createdBy,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return RelationshipsTableCompanion(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      person1Id: person1Id ?? this.person1Id,
      person2Id: person2Id ?? this.person2Id,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<String>(treeId.value);
    }
    if (person1Id.present) {
      map['person1_id'] = Variable<String>(person1Id.value);
    }
    if (person2Id.present) {
      map['person2_id'] = Variable<String>(person2Id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsTableCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('person1Id: $person1Id, ')
          ..write('person2Id: $person2Id, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FamilyTreesTableTable extends FamilyTreesTable
    with TableInfo<$FamilyTreesTableTable, FamilyTreesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamilyTreesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('private'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    ownerId,
    visibility,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'family_trees';
  @override
  VerificationContext validateIntegrity(
    Insertable<FamilyTreesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FamilyTreesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FamilyTreesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibility'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $FamilyTreesTableTable createAlias(String alias) {
    return $FamilyTreesTableTable(attachedDatabase, alias);
  }
}

class FamilyTreesTableData extends DataClass
    implements Insertable<FamilyTreesTableData> {
  final String id;
  final String name;
  final String? description;
  final String ownerId;
  final String visibility;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const FamilyTreesTableData({
    required this.id,
    required this.name,
    this.description,
    required this.ownerId,
    required this.visibility,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['owner_id'] = Variable<String>(ownerId);
    map['visibility'] = Variable<String>(visibility);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  FamilyTreesTableCompanion toCompanion(bool nullToAbsent) {
    return FamilyTreesTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      ownerId: Value(ownerId),
      visibility: Value(visibility),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory FamilyTreesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FamilyTreesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      visibility: serializer.fromJson<String>(json['visibility']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'ownerId': serializer.toJson<String>(ownerId),
      'visibility': serializer.toJson<String>(visibility),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  FamilyTreesTableData copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? ownerId,
    String? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => FamilyTreesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    ownerId: ownerId ?? this.ownerId,
    visibility: visibility ?? this.visibility,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  FamilyTreesTableData copyWithCompanion(FamilyTreesTableCompanion data) {
    return FamilyTreesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FamilyTreesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('ownerId: $ownerId, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    ownerId,
    visibility,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FamilyTreesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.ownerId == this.ownerId &&
          other.visibility == this.visibility &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class FamilyTreesTableCompanion extends UpdateCompanion<FamilyTreesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> ownerId;
  final Value<String> visibility;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const FamilyTreesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.visibility = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FamilyTreesTableCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String ownerId,
    this.visibility = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FamilyTreesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? ownerId,
    Expression<String>? visibility,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (ownerId != null) 'owner_id': ownerId,
      if (visibility != null) 'visibility': visibility,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FamilyTreesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? ownerId,
    Value<String>? visibility,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return FamilyTreesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      visibility: visibility ?? this.visibility,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamilyTreesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('ownerId: $ownerId, ')
          ..write('visibility: $visibility, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TreeMembersTableTable extends TreeMembersTable
    with TableInfo<$TreeMembersTableTable, TreeMembersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreeMembersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<String> treeId = GeneratedColumn<String>(
    'tree_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('viewer'),
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    treeId,
    userId,
    personId,
    role,
    joinedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tree_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreeMembersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tree_id')) {
      context.handle(
        _treeIdMeta,
        treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {treeId, userId};
  @override
  TreeMembersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreeMembersTableData(
      treeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tree_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_id'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
    );
  }

  @override
  $TreeMembersTableTable createAlias(String alias) {
    return $TreeMembersTableTable(attachedDatabase, alias);
  }
}

class TreeMembersTableData extends DataClass
    implements Insertable<TreeMembersTableData> {
  final String treeId;
  final String userId;
  final String? personId;
  final String role;
  final DateTime joinedAt;
  const TreeMembersTableData({
    required this.treeId,
    required this.userId,
    this.personId,
    required this.role,
    required this.joinedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tree_id'] = Variable<String>(treeId);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || personId != null) {
      map['person_id'] = Variable<String>(personId);
    }
    map['role'] = Variable<String>(role);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    return map;
  }

  TreeMembersTableCompanion toCompanion(bool nullToAbsent) {
    return TreeMembersTableCompanion(
      treeId: Value(treeId),
      userId: Value(userId),
      personId: personId == null && nullToAbsent
          ? const Value.absent()
          : Value(personId),
      role: Value(role),
      joinedAt: Value(joinedAt),
    );
  }

  factory TreeMembersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreeMembersTableData(
      treeId: serializer.fromJson<String>(json['treeId']),
      userId: serializer.fromJson<String>(json['userId']),
      personId: serializer.fromJson<String?>(json['personId']),
      role: serializer.fromJson<String>(json['role']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'treeId': serializer.toJson<String>(treeId),
      'userId': serializer.toJson<String>(userId),
      'personId': serializer.toJson<String?>(personId),
      'role': serializer.toJson<String>(role),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
    };
  }

  TreeMembersTableData copyWith({
    String? treeId,
    String? userId,
    Value<String?> personId = const Value.absent(),
    String? role,
    DateTime? joinedAt,
  }) => TreeMembersTableData(
    treeId: treeId ?? this.treeId,
    userId: userId ?? this.userId,
    personId: personId.present ? personId.value : this.personId,
    role: role ?? this.role,
    joinedAt: joinedAt ?? this.joinedAt,
  );
  TreeMembersTableData copyWithCompanion(TreeMembersTableCompanion data) {
    return TreeMembersTableData(
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      userId: data.userId.present ? data.userId.value : this.userId,
      personId: data.personId.present ? data.personId.value : this.personId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreeMembersTableData(')
          ..write('treeId: $treeId, ')
          ..write('userId: $userId, ')
          ..write('personId: $personId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(treeId, userId, personId, role, joinedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreeMembersTableData &&
          other.treeId == this.treeId &&
          other.userId == this.userId &&
          other.personId == this.personId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt);
}

class TreeMembersTableCompanion extends UpdateCompanion<TreeMembersTableData> {
  final Value<String> treeId;
  final Value<String> userId;
  final Value<String?> personId;
  final Value<String> role;
  final Value<DateTime> joinedAt;
  final Value<int> rowid;
  const TreeMembersTableCompanion({
    this.treeId = const Value.absent(),
    this.userId = const Value.absent(),
    this.personId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreeMembersTableCompanion.insert({
    required String treeId,
    required String userId,
    this.personId = const Value.absent(),
    this.role = const Value.absent(),
    required DateTime joinedAt,
    this.rowid = const Value.absent(),
  }) : treeId = Value(treeId),
       userId = Value(userId),
       joinedAt = Value(joinedAt);
  static Insertable<TreeMembersTableData> custom({
    Expression<String>? treeId,
    Expression<String>? userId,
    Expression<String>? personId,
    Expression<String>? role,
    Expression<DateTime>? joinedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (treeId != null) 'tree_id': treeId,
      if (userId != null) 'user_id': userId,
      if (personId != null) 'person_id': personId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreeMembersTableCompanion copyWith({
    Value<String>? treeId,
    Value<String>? userId,
    Value<String?>? personId,
    Value<String>? role,
    Value<DateTime>? joinedAt,
    Value<int>? rowid,
  }) {
    return TreeMembersTableCompanion(
      treeId: treeId ?? this.treeId,
      userId: userId ?? this.userId,
      personId: personId ?? this.personId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (treeId.present) {
      map['tree_id'] = Variable<String>(treeId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreeMembersTableCompanion(')
          ..write('treeId: $treeId, ')
          ..write('userId: $userId, ')
          ..write('personId: $personId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tableName_Meta = const VerificationMeta(
    'tableName_',
  );
  @override
  late final GeneratedColumn<String> tableName_ = GeneratedColumn<String>(
    'table_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tableName_,
    recordId,
    operation,
    payload,
    createdAt,
    retryCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('table_name')) {
      context.handle(
        _tableName_Meta,
        tableName_.isAcceptableOrUnknown(data['table_name']!, _tableName_Meta),
      );
    } else if (isInserting) {
      context.missing(_tableName_Meta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tableName_: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}table_name'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final int id;
  final String tableName_;
  final String recordId;
  final String operation;
  final String payload;
  final DateTime createdAt;
  final int retryCount;
  const SyncQueueTableData({
    required this.id,
    required this.tableName_,
    required this.recordId,
    required this.operation,
    required this.payload,
    required this.createdAt,
    required this.retryCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['table_name'] = Variable<String>(tableName_);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      tableName_: Value(tableName_),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(payload),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
    );
  }

  factory SyncQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      tableName_: serializer.fromJson<String>(json['tableName_']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tableName_': serializer.toJson<String>(tableName_),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  SyncQueueTableData copyWith({
    int? id,
    String? tableName_,
    String? recordId,
    String? operation,
    String? payload,
    DateTime? createdAt,
    int? retryCount,
  }) => SyncQueueTableData(
    id: id ?? this.id,
    tableName_: tableName_ ?? this.tableName_,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
  );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      tableName_: data.tableName_.present
          ? data.tableName_.value
          : this.tableName_,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('tableName_: $tableName_, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tableName_,
    recordId,
    operation,
    payload,
    createdAt,
    retryCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.tableName_ == this.tableName_ &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<int> id;
  final Value<String> tableName_;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.tableName_ = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String tableName_,
    required String recordId,
    required String operation,
    required String payload,
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
  }) : tableName_ = Value(tableName_),
       recordId = Value(recordId),
       operation = Value(operation),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? tableName_,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tableName_ != null) 'table_name': tableName_,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
    });
  }

  SyncQueueTableCompanion copyWith({
    Value<int>? id,
    Value<String>? tableName_,
    Value<String>? recordId,
    Value<String>? operation,
    Value<String>? payload,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
  }) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      tableName_: tableName_ ?? this.tableName_,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tableName_.present) {
      map['table_name'] = Variable<String>(tableName_.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('tableName_: $tableName_, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonsTableTable personsTable = $PersonsTableTable(this);
  late final $RelationshipsTableTable relationshipsTable =
      $RelationshipsTableTable(this);
  late final $FamilyTreesTableTable familyTreesTable = $FamilyTreesTableTable(
    this,
  );
  late final $TreeMembersTableTable treeMembersTable = $TreeMembersTableTable(
    this,
  );
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final PersonDao personDao = PersonDao(this as AppDatabase);
  late final RelationshipDao relationshipDao = RelationshipDao(
    this as AppDatabase,
  );
  late final FamilyTreeDao familyTreeDao = FamilyTreeDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    personsTable,
    relationshipsTable,
    familyTreesTable,
    treeMembersTable,
    syncQueueTable,
  ];
}

typedef $$PersonsTableTableCreateCompanionBuilder =
    PersonsTableCompanion Function({
      required String id,
      required String treeId,
      required String createdBy,
      required String firstName,
      required String lastName,
      Value<String?> nickname,
      Value<String?> photoUrl,
      Value<String?> additionalPhotos,
      Value<DateTime?> birthDate,
      Value<DateTime?> deathDate,
      Value<bool> isDeceased,
      Value<String?> bio,
      Value<String?> location,
      Value<String?> contactEmail,
      Value<String?> contactPhone,
      Value<String?> claimedBy,
      Value<DateTime?> claimedAt,
      Value<bool> isClaimable,
      Value<String?> proxyManagers,
      Value<String?> proxyReason,
      Value<bool> isElderlyAssisted,
      Value<String> visibility,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$PersonsTableTableUpdateCompanionBuilder =
    PersonsTableCompanion Function({
      Value<String> id,
      Value<String> treeId,
      Value<String> createdBy,
      Value<String> firstName,
      Value<String> lastName,
      Value<String?> nickname,
      Value<String?> photoUrl,
      Value<String?> additionalPhotos,
      Value<DateTime?> birthDate,
      Value<DateTime?> deathDate,
      Value<bool> isDeceased,
      Value<String?> bio,
      Value<String?> location,
      Value<String?> contactEmail,
      Value<String?> contactPhone,
      Value<String?> claimedBy,
      Value<DateTime?> claimedAt,
      Value<bool> isClaimable,
      Value<String?> proxyManagers,
      Value<String?> proxyReason,
      Value<bool> isElderlyAssisted,
      Value<String> visibility,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$PersonsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTableTable> {
  $$PersonsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treeId => $composableBuilder(
    column: $table.treeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get additionalPhotos => $composableBuilder(
    column: $table.additionalPhotos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deathDate => $composableBuilder(
    column: $table.deathDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeceased => $composableBuilder(
    column: $table.isDeceased,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get claimedBy => $composableBuilder(
    column: $table.claimedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get claimedAt => $composableBuilder(
    column: $table.claimedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isClaimable => $composableBuilder(
    column: $table.isClaimable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proxyManagers => $composableBuilder(
    column: $table.proxyManagers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proxyReason => $composableBuilder(
    column: $table.proxyReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isElderlyAssisted => $composableBuilder(
    column: $table.isElderlyAssisted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTableTable> {
  $$PersonsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treeId => $composableBuilder(
    column: $table.treeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get additionalPhotos => $composableBuilder(
    column: $table.additionalPhotos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deathDate => $composableBuilder(
    column: $table.deathDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeceased => $composableBuilder(
    column: $table.isDeceased,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get claimedBy => $composableBuilder(
    column: $table.claimedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get claimedAt => $composableBuilder(
    column: $table.claimedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isClaimable => $composableBuilder(
    column: $table.isClaimable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proxyManagers => $composableBuilder(
    column: $table.proxyManagers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proxyReason => $composableBuilder(
    column: $table.proxyReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isElderlyAssisted => $composableBuilder(
    column: $table.isElderlyAssisted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTableTable> {
  $$PersonsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeId =>
      $composableBuilder(column: $table.treeId, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get additionalPhotos => $composableBuilder(
    column: $table.additionalPhotos,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<DateTime> get deathDate =>
      $composableBuilder(column: $table.deathDate, builder: (column) => column);

  GeneratedColumn<bool> get isDeceased => $composableBuilder(
    column: $table.isDeceased,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get claimedBy =>
      $composableBuilder(column: $table.claimedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get claimedAt =>
      $composableBuilder(column: $table.claimedAt, builder: (column) => column);

  GeneratedColumn<bool> get isClaimable => $composableBuilder(
    column: $table.isClaimable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proxyManagers => $composableBuilder(
    column: $table.proxyManagers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proxyReason => $composableBuilder(
    column: $table.proxyReason,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isElderlyAssisted => $composableBuilder(
    column: $table.isElderlyAssisted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$PersonsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonsTableTable,
          PersonsTableData,
          $$PersonsTableTableFilterComposer,
          $$PersonsTableTableOrderingComposer,
          $$PersonsTableTableAnnotationComposer,
          $$PersonsTableTableCreateCompanionBuilder,
          $$PersonsTableTableUpdateCompanionBuilder,
          (
            PersonsTableData,
            BaseReferences<_$AppDatabase, $PersonsTableTable, PersonsTableData>,
          ),
          PersonsTableData,
          PrefetchHooks Function()
        > {
  $$PersonsTableTableTableManager(_$AppDatabase db, $PersonsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> treeId = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> additionalPhotos = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<DateTime?> deathDate = const Value.absent(),
                Value<bool> isDeceased = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> contactEmail = const Value.absent(),
                Value<String?> contactPhone = const Value.absent(),
                Value<String?> claimedBy = const Value.absent(),
                Value<DateTime?> claimedAt = const Value.absent(),
                Value<bool> isClaimable = const Value.absent(),
                Value<String?> proxyManagers = const Value.absent(),
                Value<String?> proxyReason = const Value.absent(),
                Value<bool> isElderlyAssisted = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonsTableCompanion(
                id: id,
                treeId: treeId,
                createdBy: createdBy,
                firstName: firstName,
                lastName: lastName,
                nickname: nickname,
                photoUrl: photoUrl,
                additionalPhotos: additionalPhotos,
                birthDate: birthDate,
                deathDate: deathDate,
                isDeceased: isDeceased,
                bio: bio,
                location: location,
                contactEmail: contactEmail,
                contactPhone: contactPhone,
                claimedBy: claimedBy,
                claimedAt: claimedAt,
                isClaimable: isClaimable,
                proxyManagers: proxyManagers,
                proxyReason: proxyReason,
                isElderlyAssisted: isElderlyAssisted,
                visibility: visibility,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String treeId,
                required String createdBy,
                required String firstName,
                required String lastName,
                Value<String?> nickname = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> additionalPhotos = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<DateTime?> deathDate = const Value.absent(),
                Value<bool> isDeceased = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> contactEmail = const Value.absent(),
                Value<String?> contactPhone = const Value.absent(),
                Value<String?> claimedBy = const Value.absent(),
                Value<DateTime?> claimedAt = const Value.absent(),
                Value<bool> isClaimable = const Value.absent(),
                Value<String?> proxyManagers = const Value.absent(),
                Value<String?> proxyReason = const Value.absent(),
                Value<bool> isElderlyAssisted = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonsTableCompanion.insert(
                id: id,
                treeId: treeId,
                createdBy: createdBy,
                firstName: firstName,
                lastName: lastName,
                nickname: nickname,
                photoUrl: photoUrl,
                additionalPhotos: additionalPhotos,
                birthDate: birthDate,
                deathDate: deathDate,
                isDeceased: isDeceased,
                bio: bio,
                location: location,
                contactEmail: contactEmail,
                contactPhone: contactPhone,
                claimedBy: claimedBy,
                claimedAt: claimedAt,
                isClaimable: isClaimable,
                proxyManagers: proxyManagers,
                proxyReason: proxyReason,
                isElderlyAssisted: isElderlyAssisted,
                visibility: visibility,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonsTableTable,
      PersonsTableData,
      $$PersonsTableTableFilterComposer,
      $$PersonsTableTableOrderingComposer,
      $$PersonsTableTableAnnotationComposer,
      $$PersonsTableTableCreateCompanionBuilder,
      $$PersonsTableTableUpdateCompanionBuilder,
      (
        PersonsTableData,
        BaseReferences<_$AppDatabase, $PersonsTableTable, PersonsTableData>,
      ),
      PersonsTableData,
      PrefetchHooks Function()
    >;
typedef $$RelationshipsTableTableCreateCompanionBuilder =
    RelationshipsTableCompanion Function({
      required String id,
      required String treeId,
      required String person1Id,
      required String person2Id,
      required String type,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      required String createdBy,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$RelationshipsTableTableUpdateCompanionBuilder =
    RelationshipsTableCompanion Function({
      Value<String> id,
      Value<String> treeId,
      Value<String> person1Id,
      Value<String> person2Id,
      Value<String> type,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String> createdBy,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$RelationshipsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RelationshipsTableTable> {
  $$RelationshipsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treeId => $composableBuilder(
    column: $table.treeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get person1Id => $composableBuilder(
    column: $table.person1Id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get person2Id => $composableBuilder(
    column: $table.person2Id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RelationshipsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationshipsTableTable> {
  $$RelationshipsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treeId => $composableBuilder(
    column: $table.treeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get person1Id => $composableBuilder(
    column: $table.person1Id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get person2Id => $composableBuilder(
    column: $table.person2Id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RelationshipsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationshipsTableTable> {
  $$RelationshipsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeId =>
      $composableBuilder(column: $table.treeId, builder: (column) => column);

  GeneratedColumn<String> get person1Id =>
      $composableBuilder(column: $table.person1Id, builder: (column) => column);

  GeneratedColumn<String> get person2Id =>
      $composableBuilder(column: $table.person2Id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$RelationshipsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RelationshipsTableTable,
          RelationshipsTableData,
          $$RelationshipsTableTableFilterComposer,
          $$RelationshipsTableTableOrderingComposer,
          $$RelationshipsTableTableAnnotationComposer,
          $$RelationshipsTableTableCreateCompanionBuilder,
          $$RelationshipsTableTableUpdateCompanionBuilder,
          (
            RelationshipsTableData,
            BaseReferences<
              _$AppDatabase,
              $RelationshipsTableTable,
              RelationshipsTableData
            >,
          ),
          RelationshipsTableData,
          PrefetchHooks Function()
        > {
  $$RelationshipsTableTableTableManager(
    _$AppDatabase db,
    $RelationshipsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> treeId = const Value.absent(),
                Value<String> person1Id = const Value.absent(),
                Value<String> person2Id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RelationshipsTableCompanion(
                id: id,
                treeId: treeId,
                person1Id: person1Id,
                person2Id: person2Id,
                type: type,
                startDate: startDate,
                endDate: endDate,
                createdBy: createdBy,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String treeId,
                required String person1Id,
                required String person2Id,
                required String type,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                required String createdBy,
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RelationshipsTableCompanion.insert(
                id: id,
                treeId: treeId,
                person1Id: person1Id,
                person2Id: person2Id,
                type: type,
                startDate: startDate,
                endDate: endDate,
                createdBy: createdBy,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RelationshipsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RelationshipsTableTable,
      RelationshipsTableData,
      $$RelationshipsTableTableFilterComposer,
      $$RelationshipsTableTableOrderingComposer,
      $$RelationshipsTableTableAnnotationComposer,
      $$RelationshipsTableTableCreateCompanionBuilder,
      $$RelationshipsTableTableUpdateCompanionBuilder,
      (
        RelationshipsTableData,
        BaseReferences<
          _$AppDatabase,
          $RelationshipsTableTable,
          RelationshipsTableData
        >,
      ),
      RelationshipsTableData,
      PrefetchHooks Function()
    >;
typedef $$FamilyTreesTableTableCreateCompanionBuilder =
    FamilyTreesTableCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required String ownerId,
      Value<String> visibility,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$FamilyTreesTableTableUpdateCompanionBuilder =
    FamilyTreesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String> ownerId,
      Value<String> visibility,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$FamilyTreesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FamilyTreesTableTable> {
  $$FamilyTreesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FamilyTreesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FamilyTreesTableTable> {
  $$FamilyTreesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FamilyTreesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamilyTreesTableTable> {
  $$FamilyTreesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$FamilyTreesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FamilyTreesTableTable,
          FamilyTreesTableData,
          $$FamilyTreesTableTableFilterComposer,
          $$FamilyTreesTableTableOrderingComposer,
          $$FamilyTreesTableTableAnnotationComposer,
          $$FamilyTreesTableTableCreateCompanionBuilder,
          $$FamilyTreesTableTableUpdateCompanionBuilder,
          (
            FamilyTreesTableData,
            BaseReferences<
              _$AppDatabase,
              $FamilyTreesTableTable,
              FamilyTreesTableData
            >,
          ),
          FamilyTreesTableData,
          PrefetchHooks Function()
        > {
  $$FamilyTreesTableTableTableManager(
    _$AppDatabase db,
    $FamilyTreesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamilyTreesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamilyTreesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamilyTreesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FamilyTreesTableCompanion(
                id: id,
                name: name,
                description: description,
                ownerId: ownerId,
                visibility: visibility,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required String ownerId,
                Value<String> visibility = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FamilyTreesTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                ownerId: ownerId,
                visibility: visibility,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FamilyTreesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FamilyTreesTableTable,
      FamilyTreesTableData,
      $$FamilyTreesTableTableFilterComposer,
      $$FamilyTreesTableTableOrderingComposer,
      $$FamilyTreesTableTableAnnotationComposer,
      $$FamilyTreesTableTableCreateCompanionBuilder,
      $$FamilyTreesTableTableUpdateCompanionBuilder,
      (
        FamilyTreesTableData,
        BaseReferences<
          _$AppDatabase,
          $FamilyTreesTableTable,
          FamilyTreesTableData
        >,
      ),
      FamilyTreesTableData,
      PrefetchHooks Function()
    >;
typedef $$TreeMembersTableTableCreateCompanionBuilder =
    TreeMembersTableCompanion Function({
      required String treeId,
      required String userId,
      Value<String?> personId,
      Value<String> role,
      required DateTime joinedAt,
      Value<int> rowid,
    });
typedef $$TreeMembersTableTableUpdateCompanionBuilder =
    TreeMembersTableCompanion Function({
      Value<String> treeId,
      Value<String> userId,
      Value<String?> personId,
      Value<String> role,
      Value<DateTime> joinedAt,
      Value<int> rowid,
    });

class $$TreeMembersTableTableFilterComposer
    extends Composer<_$AppDatabase, $TreeMembersTableTable> {
  $$TreeMembersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get treeId => $composableBuilder(
    column: $table.treeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TreeMembersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TreeMembersTableTable> {
  $$TreeMembersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get treeId => $composableBuilder(
    column: $table.treeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get personId => $composableBuilder(
    column: $table.personId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TreeMembersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreeMembersTableTable> {
  $$TreeMembersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get treeId =>
      $composableBuilder(column: $table.treeId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);
}

class $$TreeMembersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TreeMembersTableTable,
          TreeMembersTableData,
          $$TreeMembersTableTableFilterComposer,
          $$TreeMembersTableTableOrderingComposer,
          $$TreeMembersTableTableAnnotationComposer,
          $$TreeMembersTableTableCreateCompanionBuilder,
          $$TreeMembersTableTableUpdateCompanionBuilder,
          (
            TreeMembersTableData,
            BaseReferences<
              _$AppDatabase,
              $TreeMembersTableTable,
              TreeMembersTableData
            >,
          ),
          TreeMembersTableData,
          PrefetchHooks Function()
        > {
  $$TreeMembersTableTableTableManager(
    _$AppDatabase db,
    $TreeMembersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreeMembersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreeMembersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreeMembersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> treeId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> personId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TreeMembersTableCompanion(
                treeId: treeId,
                userId: userId,
                personId: personId,
                role: role,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String treeId,
                required String userId,
                Value<String?> personId = const Value.absent(),
                Value<String> role = const Value.absent(),
                required DateTime joinedAt,
                Value<int> rowid = const Value.absent(),
              }) => TreeMembersTableCompanion.insert(
                treeId: treeId,
                userId: userId,
                personId: personId,
                role: role,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TreeMembersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TreeMembersTableTable,
      TreeMembersTableData,
      $$TreeMembersTableTableFilterComposer,
      $$TreeMembersTableTableOrderingComposer,
      $$TreeMembersTableTableAnnotationComposer,
      $$TreeMembersTableTableCreateCompanionBuilder,
      $$TreeMembersTableTableUpdateCompanionBuilder,
      (
        TreeMembersTableData,
        BaseReferences<
          _$AppDatabase,
          $TreeMembersTableTable,
          TreeMembersTableData
        >,
      ),
      TreeMembersTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableTableCreateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      required String tableName_,
      required String recordId,
      required String operation,
      required String payload,
      required DateTime createdAt,
      Value<int> retryCount,
    });
typedef $$SyncQueueTableTableUpdateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      Value<String> tableName_,
      Value<String> recordId,
      Value<String> operation,
      Value<String> payload,
      Value<DateTime> createdAt,
      Value<int> retryCount,
    });

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tableName_ => $composableBuilder(
    column: $table.tableName_,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tableName_ => $composableBuilder(
    column: $table.tableName_,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tableName_ => $composableBuilder(
    column: $table.tableName_,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData,
          $$SyncQueueTableTableFilterComposer,
          $$SyncQueueTableTableOrderingComposer,
          $$SyncQueueTableTableAnnotationComposer,
          $$SyncQueueTableTableCreateCompanionBuilder,
          $$SyncQueueTableTableUpdateCompanionBuilder,
          (
            SyncQueueTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueTableTable,
              SyncQueueTableData
            >,
          ),
          SyncQueueTableData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableTableManager(
    _$AppDatabase db,
    $SyncQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tableName_ = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
              }) => SyncQueueTableCompanion(
                id: id,
                tableName_: tableName_,
                recordId: recordId,
                operation: operation,
                payload: payload,
                createdAt: createdAt,
                retryCount: retryCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tableName_,
                required String recordId,
                required String operation,
                required String payload,
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
              }) => SyncQueueTableCompanion.insert(
                id: id,
                tableName_: tableName_,
                recordId: recordId,
                operation: operation,
                payload: payload,
                createdAt: createdAt,
                retryCount: retryCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTableTable,
      SyncQueueTableData,
      $$SyncQueueTableTableFilterComposer,
      $$SyncQueueTableTableOrderingComposer,
      $$SyncQueueTableTableAnnotationComposer,
      $$SyncQueueTableTableCreateCompanionBuilder,
      $$SyncQueueTableTableUpdateCompanionBuilder,
      (
        SyncQueueTableData,
        BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>,
      ),
      SyncQueueTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonsTableTableTableManager get personsTable =>
      $$PersonsTableTableTableManager(_db, _db.personsTable);
  $$RelationshipsTableTableTableManager get relationshipsTable =>
      $$RelationshipsTableTableTableManager(_db, _db.relationshipsTable);
  $$FamilyTreesTableTableTableManager get familyTreesTable =>
      $$FamilyTreesTableTableTableManager(_db, _db.familyTreesTable);
  $$TreeMembersTableTableTableManager get treeMembersTable =>
      $$TreeMembersTableTableTableManager(_db, _db.treeMembersTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
}
