import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/supabase_config.dart';
import '../models/family_tree.dart';
import '../models/person.dart';
import '../models/relationship.dart';

/// Service for Supabase operations
class SupabaseService {
  static SupabaseClient? _client;

  /// Initialize Supabase
  static Future<void> initialize() async {
    if (!SupabaseConfig.isConfigured) {
      // Skip initialization if not configured
      return;
    }

    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
    _client = Supabase.instance.client;
  }

  /// Get the Supabase client
  static SupabaseClient? get client => _client;

  /// Check if Supabase is available
  static bool get isAvailable => _client != null && SupabaseConfig.isConfigured;

  /// Get current user
  static User? get currentUser => _client?.auth.currentUser;

  /// Get current session
  static Session? get currentSession => _client?.auth.currentSession;

  /// Auth state stream
  static Stream<AuthState>? get authStateChanges =>
      _client?.auth.onAuthStateChange;
}

/// Extension for Supabase auth operations
extension SupabaseAuthExtension on SupabaseClient {
  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    String? fullName,
  }) async {
    return auth.signUp(
      email: email,
      password: password,
      data: fullName != null ? {'full_name': fullName} : null,
    );
  }

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return auth.signInWithPassword(email: email, password: password);
  }

  /// Sign in with OAuth provider
  Future<bool> signInWithOAuth(OAuthProvider provider) async {
    return auth.signInWithOAuth(
      provider,
      redirectTo: SupabaseConfig.redirectUrl,
    );
  }

  /// Sign out
  Future<void> signOutUser() async {
    await auth.signOut();
  }

  /// Send password reset email
  Future<void> sendPasswordReset(String email) async {
    await auth.resetPasswordForEmail(email);
  }
}

/// Extension for Supabase data operations
extension SupabaseDataExtension on SupabaseClient {
  // ============ Family Trees ============

  /// Get all trees for current user
  Future<List<FamilyTree>> getTrees() async {
    final userId = auth.currentUser?.id;
    if (userId == null) return [];

    final response = await from('tree_members')
        .select('tree_id, family_trees(*)')
        .eq('user_id', userId);

    return (response as List).map((item) {
      final treeData = item['family_trees'] as Map<String, dynamic>;
      return FamilyTree.fromJson(treeData);
    }).toList();
  }

  /// Create a new tree
  Future<FamilyTree> createTree(FamilyTree tree) async {
    final response = await from('family_trees')
        .insert(tree.toJson())
        .select()
        .single();

    // Also add current user as owner
    await from('tree_members').insert({
      'tree_id': tree.id,
      'user_id': auth.currentUser!.id,
      'role': 'owner',
    });

    return FamilyTree.fromJson(response);
  }

  /// Update a tree
  Future<void> updateTree(FamilyTree tree) async {
    await from('family_trees')
        .update(tree.toJson())
        .eq('id', tree.id);
  }

  /// Delete a tree
  Future<void> deleteTree(String treeId) async {
    await from('family_trees').delete().eq('id', treeId);
  }

  // ============ Persons ============

  /// Get all persons in a tree
  Future<List<Person>> getPersons(String treeId) async {
    final response = await from('persons')
        .select()
        .eq('tree_id', treeId)
        .order('created_at');

    return (response as List)
        .map((item) => Person.fromJson(item))
        .toList();
  }

  /// Create a person
  Future<Person> createPerson(Person person) async {
    final response = await from('persons')
        .insert(person.toJson())
        .select()
        .single();

    return Person.fromJson(response);
  }

  /// Update a person
  Future<void> updatePerson(Person person) async {
    await from('persons')
        .update(person.toJson())
        .eq('id', person.id);
  }

  /// Delete a person
  Future<void> deletePerson(String personId) async {
    await from('persons').delete().eq('id', personId);
  }

  // ============ Relationships ============

  /// Get all relationships in a tree
  Future<List<Relationship>> getRelationships(String treeId) async {
    final response = await from('relationships')
        .select()
        .eq('tree_id', treeId);

    return (response as List)
        .map((item) => Relationship.fromJson(item))
        .toList();
  }

  /// Create a relationship
  Future<Relationship> createRelationship(Relationship relationship) async {
    final response = await from('relationships')
        .insert(relationship.toJson())
        .select()
        .single();

    return Relationship.fromJson(response);
  }

  /// Update a relationship
  Future<void> updateRelationship(Relationship relationship) async {
    await from('relationships')
        .update(relationship.toJson())
        .eq('id', relationship.id);
  }

  /// Delete a relationship
  Future<void> deleteRelationship(String relationshipId) async {
    await from('relationships').delete().eq('id', relationshipId);
  }

  // ============ Realtime Subscriptions ============

  /// Subscribe to persons changes
  RealtimeChannel subscribeToPersons(
    String treeId,
    void Function(PostgresChangePayload) callback,
  ) {
    return channel('persons:$treeId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'persons',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'tree_id',
            value: treeId,
          ),
          callback: callback,
        )
        .subscribe();
  }

  /// Subscribe to relationships changes
  RealtimeChannel subscribeToRelationships(
    String treeId,
    void Function(PostgresChangePayload) callback,
  ) {
    return channel('relationships:$treeId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'relationships',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'tree_id',
            value: treeId,
          ),
          callback: callback,
        )
        .subscribe();
  }
}

