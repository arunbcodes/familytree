# Family Tree App

A beautiful, interactive family tree visualization app that lets you explore your family connections through an intuitive graph-based interface with hexagonal photo avatars.

---

## Table of Contents

1. [Overview](#overview)
2. [Key Features](#key-features)
3. [How It Works](#how-it-works)
4. [User Journey](#user-journey)
5. [Data Model](#data-model)
6. [Privacy & Sharing](#privacy--sharing)
7. [Technical Architecture](#technical-architecture)
8. [Running the App](#running-the-app)
9. [Roadmap](#roadmap)

---

## Overview

Family Tree is designed to help you visualize and manage your family relationships in an engaging way. Unlike traditional family tree apps that show static charts, this app presents your family as an interactive graph where:

- **You are at the center** - Your profile sits in the middle, with family members radiating outward
- **Drag to explore** - Pan and zoom to navigate through generations
- **Connections appear as you explore** - Family members load dynamically as you move around
- **Hexagonal avatars** - Each person is represented by a distinctive hexagonal photo frame

---

## Key Features

### Visual Representation

| Feature | Description |
|---------|-------------|
| **Hexagonal Avatars** | Each family member appears in a hexagonal frame with their photo (or initials if no photo) |
| **Color-Coded Relationships** | Different relationship types have different colors (e.g., purple for parent-child, pink for spouse) |
| **Deceased Indicator** | Deceased family members have a grey/muted appearance with a different border style |
| **Elderly/Assisted Badge** | Family members who need proxy management show a special indicator |

### Multiple View Modes

You can switch between different visualization layouts:

1. **Radial View** (Default)
   - You at center, family members in concentric circles
   - Good for seeing immediate connections

2. **Sunburst View**
   - Generational rings expanding outward
   - Great for ancestry exploration (parents, grandparents, etc.)

3. **Tree View**
   - Traditional hierarchical layout
   - Shows parent-child relationships clearly

4. **Force-Directed View**
   - Physics-based layout where nodes naturally spread out
   - Good for complex family structures with many cross-connections

### Interaction

- **Tap** a person to select them and see their connections highlighted
- **Long-press** to view their detailed profile
- **Pinch to zoom** in/out of the tree
- **Drag/pan** to navigate around the tree
- **Double-tap** to quickly zoom in/out

---

## How It Works

### The Graph Structure

Your family is stored as a graph (network) data structure:

```
         [Grandma] ---- [Grandpa]
              |
           [Mother] ---- [Father]
              |              |
    [Sibling] - [YOU] - [Sibling]
                 |
             [Spouse]
                 |
             [Child]
```

- **Nodes** = People in your family
- **Edges** = Relationships between people

### Relationship Types

The app supports various relationship types:

| Type | Description | Visual Color |
|------|-------------|--------------|
| Parent-Child | Biological parent and child | Indigo |
| Spouse | Current marriage/partnership | Pink |
| Ex-Spouse | Former marriage/partnership | Dark pink (dashed line) |
| Sibling | Full siblings (same parents) | Green |
| Half-Sibling | Share one parent | Dark green |
| Step-Parent | Non-biological parental relationship | Orange |
| Adoptive Parent | Legal adoption relationship | Light blue |
| Godparent | Spiritual/ceremonial relationship | Purple |

### Person Profiles

Each person in the tree has:

**Basic Information:**
- First name, last name, nickname
- Photo (with support for multiple photos at different ages)
- Birth date, death date (if applicable)
- Living/deceased status

**Extended Information:**
- Bio/description
- Location
- Contact information (email, phone)

**System Information:**
- Who created this profile
- Whether the profile has been "claimed" by the actual person
- Proxy managers (for elderly assistance)

---

## User Journey

### First-Time User (Onboarding)

1. **Create Account**
   - Sign up with email or social login
   - Your account is private by default

2. **Set Up Your Profile**
   - Enter your name
   - Add your photo (optional)
   - Set your birth date (optional)

3. **Add Your Parents** (Guided)
   - The app walks you through adding your mother and father
   - You can skip if you prefer to add them later
   - Mark parents as deceased if applicable

4. **Add Your Siblings** (Guided)
   - Add brothers and sisters
   - Skip if you don't have siblings or want to add later

5. **View Your Tree**
   - See your initial family tree with you at the center
   - Start exploring and adding more family members

### Adding Family Members

You can add family members in several ways:

1. **From the main screen** - Tap the + button to add a new relative
2. **From a person's profile** - Tap "Add Relative" to add someone connected to them
3. **During exploration** - Tap the expand button on any person to add their connections

**Required Information:**
- Name (first name required, last name optional)
- Relationship type (how they're connected to an existing person)

**Optional Information:**
- Photo, birth date, contact info, bio, etc.

### Inviting Family Members

When you add a living family member:

1. **They exist as a "profile" in your tree** - You can see them and their connections
2. **You can invite them to join** - Send them a link to claim their profile
3. **When they join:**
   - They verify "yes, that's me"
   - They become the owner of their own profile
   - They can edit their own information
   - They can see and contribute to the shared tree

### Elderly/Assisted Mode

For family members who can't use the app themselves (elderly, young children, etc.):

1. **Mark them as "Proxy Managed"**
2. **Assign proxy managers** - Family members who can edit on their behalf
3. **A badge shows** that this profile is managed by someone else
4. **Transparency** - Other family members see who is managing the profile

---

## Data Model

### Person States

A person in the family tree can be in different states:

| State | Description | Who Can Edit |
|-------|-------------|--------------|
| **Unclaimed** | Added by someone, the actual person hasn't joined | Creator + tree editors |
| **Claimed** | The actual person has verified and taken ownership | The person themselves + allowed proxies |
| **Deceased** | Cannot be claimed | Creator + tree editors |
| **Proxy-Managed** | Living but managed by family due to inability to use app | Designated proxy managers |

### Family Tree Roles

| Role | Can View | Can Add/Edit | Can Invite | Can Delete Tree |
|------|----------|--------------|------------|-----------------|
| **Owner** | Yes | Yes | Yes (any role) | Yes |
| **Editor** | Yes | Yes | Yes (viewers only) | No |
| **Viewer** | Yes | No | No | No |

- The person who creates a tree is automatically the **Owner**
- Owners can promote Editors to co-Owners
- Multiple Owners are allowed (e.g., siblings sharing management)

---

## Privacy & Sharing

### Privacy Levels

Each person's profile can have different visibility:

1. **Private** - Only you can see
2. **Tree Members** - All members of your family tree can see
3. **Public** - Anyone can see (for those who want public profiles)

### Sharing Options

1. **View-Only Link** - Share a link that lets others see your tree but not edit
2. **Invite as Editor** - Invite family members who can add and edit
3. **Invite as Viewer** - Invite people who can only view

### Consent & Control

- When you add a living person, they can later "claim" their profile
- Once claimed, **they control their own information**
- They can choose to leave a tree (unlink themselves)
- Deceased family members cannot be claimed

---

## Technical Architecture

### Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | Flutter | Cross-platform UI (iOS, Android, Web) |
| **State Management** | Riverpod | Reactive state management |
| **Navigation** | GoRouter | Declarative routing |
| **Backend** | Supabase | Database, auth, real-time sync |
| **Local Storage** | Drift (SQLite) | Offline support |
| **Image Caching** | cached_network_image | Efficient image loading |
| **Animations** | flutter_animate | Smooth UI transitions |

### Project Structure

```
lib/
├── main.dart                 # App entry point with ProviderScope
├── app.dart                  # App configuration & theming
├── core/
│   ├── constants/            # Colors, sizes, app-wide values
│   │   ├── app_colors.dart   # Color palette & relationship colors
│   │   └── app_sizes.dart    # Spacing, sizing, animation durations
│   ├── extensions/           # Dart extension methods
│   ├── router/               # Navigation configuration
│   │   └── app_router.dart   # GoRouter setup with routes
│   ├── theme/                # App theming
│   │   └── app_theme.dart    # Light/dark theme configuration
│   └── utils/                # Utilities
│       └── graph_layout.dart # Graph layout algorithms
├── data/
│   ├── database/             # Drift database setup
│   │   └── database.dart     # Tables, DAOs, migrations
│   ├── models/               # Data classes
│   │   ├── person.dart       # Person model with claim/proxy support
│   │   ├── relationship.dart # Relationship model & types
│   │   ├── family_tree.dart  # Family tree & membership
│   │   └── user.dart         # User profile model
│   ├── providers/            # Riverpod providers
│   │   └── database_provider.dart # Database & repository providers
│   ├── repositories/         # Data access layer
│   │   └── tree_repository.dart # CRUD operations for tree data
│   └── services/             # Backend integration (planned)
└── features/
    ├── auth/                 # Authentication
    │   └── screens/          # Login, signup screens
    ├── onboarding/           # First-time user setup
    │   └── screens/          # Onboarding wizard
    ├── tree_view/            # Main visualization
    │   ├── screens/          # Tree screen (ConsumerStatefulWidget)
    │   ├── widgets/          # Hexagon, nodes, edges, canvas
    │   │   ├── hexagon_avatar.dart  # Hexagonal photo frame
    │   │   ├── person_node.dart     # Full & simplified person nodes
    │   │   ├── relationship_edge.dart # Connection lines
    │   │   └── tree_canvas.dart     # Interactive canvas with zoom/pan
    │   └── providers/        # Feature-specific providers
    │       └── tree_provider.dart # Tree state management
    ├── person_detail/        # Person profile view
    │   └── screens/          # Detail screen (ConsumerWidget)
    └── settings/             # App settings
        └── screens/          # Settings screen
```

### State Management with Riverpod

The app uses Riverpod for reactive state management with several provider patterns:

#### Database Providers (`database_provider.dart`)
```dart
// Main database instance
final databaseProvider = Provider<AppDatabase>((ref) {...});

// Repository provider with automatic dependency injection
final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TreeRepository(db);
});
```

#### Tree Providers (`tree_provider.dart`)
```dart
// State providers for UI state
final currentTreeIdProvider = StateProvider<String?>((ref) => null);
final selectedPersonIdProvider = StateProvider<String?>((ref) => null);
final centerPersonIdProvider = StateProvider<String?>((ref) => null);

// FutureProvider for one-time data fetching
final treeDataProvider = FutureProvider.autoDispose.family<TreeData?, String>(...);

// StreamProvider for reactive data watching
final personsStreamProvider = StreamProvider.autoDispose.family<List<Person>, String>(...);

// StateNotifier for mutations
final treeNotifierProvider = StateNotifierProvider.autoDispose
    .family<TreeNotifier, AsyncValue<TreeData?>, String>(...);
```

#### Usage in Widgets
```dart
class TreeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TreeScreen> createState() => _TreeScreenState();
}

class _TreeScreenState extends ConsumerState<TreeScreen> {
  void _someMethod() {
    // Read provider value once
    final repository = ref.read(treeRepositoryProvider);

    // Watch provider value (rebuilds on change)
    final treeData = ref.watch(treeNotifierProvider(_treeId!));

    // Get notifier for mutations
    final notifier = ref.read(treeNotifierProvider(_treeId!).notifier);
    await notifier.addPerson(...);
  }
}
```

### Repository Pattern

The `TreeRepository` provides a clean data access layer:

```dart
class TreeRepository {
  final AppDatabase _db;

  // Tree operations
  Future<FamilyTree> createTree({...});
  Stream<List<FamilyTree>> watchTreesForUser(String userId);

  // Person operations
  Future<Person> addPerson({...});
  Stream<List<Person>> watchPersons(String treeId);

  // Relationship operations
  Future<Relationship> addRelationship({...});
  Stream<List<Relationship>> watchRelationships(String treeId);

  // Bulk operations
  Future<TreeData> getCompleteTree(String treeId);
  Stream<TreeData> watchCompleteTree(String treeId);
}
```

### Graph Layout Algorithms

The app includes four layout algorithms in `graph_layout.dart`:

1. **Radial Layout** - BFS traversal placing nodes in circles around center
2. **Tree Layout** - Reingold-Tilford style hierarchical placement
3. **Sunburst Layout** - Generational rings (you at center, ancestors radiating out)
4. **Force-Directed Layout** - Physics simulation with repulsion and attraction forces

### Level of Detail (LOD) Optimization

The tree canvas automatically adjusts detail based on zoom level:

- **Zoomed out**: Simplified circular nodes for performance
- **Zoomed in**: Full hexagonal avatars with names and expand buttons
- **Threshold configurable**: `AppSizes.lodZoomThreshold` and `AppSizes.lodSimplifiedThreshold`

---

## Running the App

### Prerequisites

- Flutter SDK (3.10+)
- For iOS: Xcode and iOS Simulator
- For Android: Android Studio and Android Emulator
- For Web: Chrome browser

### Commands

```bash
# Navigate to project
cd /Users/abalak/Mine/Experiments/familytree

# Get dependencies
flutter pub get

# Run on available device
flutter run

# Run specifically on Chrome (web)
flutter run -d chrome

# Run on iOS simulator
flutter run -d ios

# Run on Android emulator
flutter run -d android

# List available devices
flutter devices
```

### Demo Mode

The app currently runs with **demo data** showing:
- 8 family members (You, parents, sibling, spouse, grandparents, child)
- 9 relationships connecting them
- All four layout modes available

This lets you explore the UI without needing a backend.

---

## Roadmap

### Phase 1: MVP (Current)
- [x] Hexagonal avatar widget
- [x] Interactive pan/zoom canvas
- [x] Multiple layout algorithms
- [x] Demo data visualization
- [x] Onboarding flow (UI)
- [x] Basic screens (auth, settings, person detail)
- [x] Riverpod state management integration
- [x] Repository pattern for data access
- [x] Local database with Drift (SQLite)
- [x] Add family members with relationships
- [x] Reactive data updates (streams)
- [ ] Supabase integration (backend sync)
- [ ] User authentication (currently demo mode)

### Phase 2: Core Features
- [ ] Edit existing family members
- [ ] Photo upload with face centering
- [ ] Offline view support
- [ ] Share tree (view-only link)
- [ ] Invite family members
- [ ] Search within tree

### Phase 3: Collaboration
- [ ] Real-time sync
- [ ] Profile claiming
- [ ] Proxy management (elderly assistance)
- [ ] Activity feed
- [ ] Notifications

### Phase 4: Advanced
- [ ] Dispute system (with family consensus)
- [ ] GEDCOM import/export
- [ ] Search within tree
- [ ] PDF/image export
- [ ] Performance optimization for 1000+ nodes

---

## Dispute Resolution

When family members disagree about information (to be implemented in Phase 3+):

1. **Level 1: Direct Parties** (7 days)
   - The claimer and creator try to resolve

2. **Level 2: Immediate Family** (14 days)
   - Parents, siblings, spouse, children vote
   - Needs 3/4 majority

3. **Level 3: Extended Family** (14 days)
   - Grandparents, aunts, uncles, cousins vote
   - Needs 3/4 majority

4. **Level 4: Tree Owner Decides**
   - Final authority if no consensus

---

## Glossary

| Term | Definition |
|------|------------|
| **Claim** | When a user verifies that a profile in the tree is actually them |
| **Proxy** | A family member who manages another person's profile on their behalf |
| **Tree** | A family tree containing multiple people and their relationships |
| **Node** | A person in the family tree visualization |
| **Edge** | A line connecting two people showing their relationship |
| **Sunburst** | A circular visualization with generations as concentric rings |
| **Force-Directed** | A physics-based layout algorithm that spreads nodes naturally |

---

## FAQ

**Q: Can I have multiple family trees?**
A: Yes, you can create multiple trees (e.g., one for each side of your family).

**Q: What happens if someone disputes information about me?**
A: You have control over your own claimed profile. Disputes go through a family consensus process.

**Q: Can I add someone without their permission?**
A: Yes, but they can claim their profile later and take control of their own information.

**Q: Is my data private?**
A: By default, yes. You control who can see your tree through privacy settings.

**Q: Can I use this offline?**
A: View-only offline mode is planned. You'll be able to browse your tree without internet.

**Q: What if an elderly relative can't use the app?**
A: Use the proxy management feature to manage their profile on their behalf.

---

## Support

For questions, issues, or feature requests, please refer to the documentation or contact the development team.
