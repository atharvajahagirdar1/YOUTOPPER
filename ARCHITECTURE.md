# YOUTOPPER — ARCHITECTURE

**File:** `ARCHITECTURE.md`
**Project:** YOUTOPPER
**Document Version:** 1.0
**Architecture Status:** Active
**Primary Framework:** Flutter
**Language:** Dart
**Primary Target:** Android
**Architecture Philosophy:** Feature-oriented, layered, modular, maintainable, frontend-first

---

# 1. PURPOSE

This document defines the technical architecture of YOUTOPPER.

It establishes:

* project structure
* feature boundaries
* layer responsibilities
* navigation architecture
* state-management architecture
* data-model architecture
* repository boundaries
* service boundaries
* dependency direction
* shared component strategy
* local/demo-data strategy
* future backend integration strategy
* testing architecture
* scalability rules
* architectural constraints
* forbidden architectural patterns

This document answers:

> **“How should YOUTOPPER be built?”**

The `PRD.md` answers:

> **“What should YOUTOPPER do?”**

The two documents must remain complementary.

---

# 2. ARCHITECTURAL GOAL

YOUTOPPER should use an architecture that is:

* understandable by a solo developer
* appropriate for a production-quality Flutter application
* easy to test
* easy to extend
* feature-oriented
* resistant to uncontrolled coupling
* suitable for frontend-first development
* ready for future persistence/backend integration
* not unnecessarily complex

The architecture should follow:

> **Simple structure, clear boundaries, controlled dependencies.**

---

# 3. CORE ARCHITECTURAL PHILOSOPHY

## 3.1 No Overengineering

YOUTOPPER is a serious production-oriented application, but it is still being developed by a small team/solo developer.

Therefore the architecture must not introduce complexity merely because a pattern is considered “enterprise”.

Do not add:

* unnecessary abstraction layers
* interfaces with only one trivial implementation
* excessive dependency injection
* unnecessary use cases
* service wrappers around simple operations
* generic repository frameworks
* complex event buses
* unnecessary state-management layers
* microservice-style separation
* premature backend abstractions

Architecture should be introduced because it solves a real problem.

---

# 4. PRIMARY ARCHITECTURAL STYLE

YOUTOPPER uses:

> **Feature-Oriented Layered Architecture**

The application is organized primarily by **feature**, while each feature may contain clear layers.

Conceptually:

```text
Presentation
     ↓
State / Application Logic
     ↓
Repository / Data Access
     ↓
Data Source
```

A feature owns its relevant presentation and behavior.

---

# 5. HIGH-LEVEL ARCHITECTURE

The application can be represented as:

```text
                         YOUTOPPER APP
                              │
                              ▼
                    ┌───────────────────┐
                    │   App Bootstrap   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    Main Shell     │
                    └─────────┬─────────┘
                              │
              ┌───────────────┼────────────────┐
              │               │                │
              ▼               ▼                ▼
           Primary         Secondary        Deep
        Navigation        Navigation       Screens
              │               │                │
              └───────────────┼────────────────┘
                              ▼
                     Feature Presentation
                              │
                              ▼
                     Feature State / Logic
                              │
                              ▼
                       Repository Layer
                              │
                              ▼
                         Data Sources
                              │
                              ▼
                  Local / Future Remote Data
```

---

# 6. ARCHITECTURAL LAYERS

YOUTOPPER uses the following conceptual layers.

---

## 6.1 Presentation Layer

Responsible for:

* Flutter screens
* widgets
* layouts
* visual states
* animations
* user interaction
* accessibility
* navigation triggers

Examples:

```text
HomeScreen
LearnScreen
TopicConceptScreen
ConceptLearningScreen
PlannerScreen
ProgressScreen
```

Presentation code should not directly perform database operations.

---

# 7. STATE / APPLICATION LAYER

Responsible for:

* screen state
* user actions
* feature workflows
* derived UI state
* coordination between presentation and repositories

Examples:

```text
HomeState
LearnState
PlannerState
RevisionState
PracticeState
ProgressState
```

The exact state-management mechanism should remain consistent with the project's approved state-management approach.

The architecture should not introduce multiple competing state-management systems.

---

# 8. DOMAIN / MODEL LAYER

The domain/model layer represents meaningful product concepts.

Examples:

```text
Learner
Subject
Unit
Topic
Concept
LearningActivity
StudyPlan
RevisionItem
PracticeQuestion
PracticeResult
LearningMethod
Progress
Goal
Notification
```

Models should represent product concepts rather than UI widgets.

A model should not contain Flutter-specific rendering logic.

---

# 9. REPOSITORY LAYER

Repositories provide controlled access to data.

Examples:

```text
LearnerRepository
SubjectRepository
TopicRepository
ConceptRepository
StudyPlanRepository
RevisionRepository
PracticeRepository
LearningMethodRepository
ProgressRepository
NotificationRepository
```

A repository should answer questions such as:

```text
getSubjects()
getTopic()
getSavedConcepts()
getRevisionItems()
saveLearningMethod()
removeLearningMethod()
getProgress()
```

The screen should not know whether the data comes from:

* local demo data
* local persistence
* Firestore
* REST API
* another future data source

That decision belongs below the repository boundary.

---

# 10. DATA SOURCE LAYER

Data sources are responsible for actual data retrieval/storage.

Possible future structure:

```text
Local Data Source
Remote Data Source
Cached Data Source
```

During the frontend-first stage, local deterministic data is sufficient.

Future backend integration may introduce:

```text
Repository
     ↓
Remote Data Source
     ↓
Firebase / API
```

without forcing screens to change their responsibilities.

---

# 11. FEATURE-ORIENTED PROJECT STRUCTURE

The project should be organized around product features rather than around one giant global folder for every screen.

Recommended structure:

```text
lib/
│
├── app/
│   ├── app.dart
│   ├── router/
│   ├── theme/
│   └── shell/
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── utils/
│   ├── widgets/
│   └── services/
│
├── features/
│   │
│   ├── authentication/
│   ├── onboarding/
│   ├── learner_setup/
│   ├── home/
│   ├── learn/
│   ├── learn_how_to_learn/
│   ├── revision/
│   ├── practice/
│   ├── planner/
│   ├── insights/
│   ├── progress/
│   ├── weekly_review/
│   ├── notifications/
│   ├── profile/
│   ├── settings/
│   ├── support/
│   └── search/
│
└── main.dart
```

The exact folder names may adapt to the existing project if an equivalent structure is already established.

Do not restructure the entire application simply to match this diagram if the current architecture already satisfies the same boundaries.

---

# 12. FEATURE STRUCTURE

A feature may use:

```text
feature_name/
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── screens/
    ├── widgets/
    └── state/
```

However:

> This structure is a capability, not a requirement to create every folder.

If a feature is small, it may use a simpler structure.

---

# 13. SMALL FEATURE RULE

A small feature should not automatically receive:

```text
entity
model
repository interface
repository implementation
data source interface
data source implementation
use case
provider
controller
service
mapper
```

unless the complexity actually justifies those layers.

For example, a small frontend-only learning-technique feature may reasonably contain:

```text
learn_how_to_learn/
├── data/
│   └── learning_technique_data.dart
└── presentation/
    ├── screens/
    └── widgets/
```

Architecture should scale with feature complexity.

---

# 14. FEATURE OWNERSHIP

Each feature owns:

* its screens
* feature-specific widgets
* feature-specific state
* feature-specific data structures
* feature-specific business rules

Example:

```text
features/home/
```

owns Home-specific presentation and state.

It should not own:

* authentication logic
* global navigation
* unrelated learning-technique models

---

# 15. SHARED CODE

Shared code belongs in `core/` only when it is genuinely shared.

Examples:

```text
core/
├── widgets/
├── constants/
├── utils/
├── extensions/
└── services/
```

Do not move something into `core/` simply because it might be reused someday.

---

# 16. SHARED WIDGET RULE

A widget should become shared when:

1. It is actually reused.
2. Its behavior is sufficiently stable.
3. Its API is clear.
4. Sharing reduces duplication.

Do not create generic components such as:

```text
UniversalCard
UniversalContainer
UniversalSection
UniversalButton
UniversalAnything
```

unless their responsibility is genuinely reusable.

---

# 17. DESIGN SYSTEM BOUNDARY

Visual primitives should be centralized where appropriate.

Examples:

* colors
* typography
* spacing
* radii
* shadows
* elevations
* button styles
* common surface treatments

However, screen-specific composition belongs inside the feature.

Do not force every screen into one generic card layout.

---

# 18. APPLICATION ENTRY POINT

The application entry point is:

```text
lib/main.dart
```

Responsibilities should remain minimal:

* initialize application-level requirements
* launch the Flutter application
* connect to the root application widget

`main.dart` should not contain:

* screen UI
* feature business logic
* large configuration blocks
* navigation definitions
* data models

---

# 19. APP ROOT

The application root should manage:

* global theme
* application configuration
* root navigation
* global providers/state where necessary
* application-level lifecycle

Conceptually:

```text
main.dart
   ↓
App
   ↓
Router
   ↓
MainShell / Deep Routes
```

---

# 20. MAIN SHELL

YOUTOPPER uses one primary shell.

The MainShell owns:

* primary bottom navigation
* selected primary destination
* root-level layout
* persistent navigation behavior

Primary navigation:

```text
Home
Learn
Learn How to Learn
Planner
Progress
```

---

# 21. MAIN SHELL NAVIGATION RULE

There must be:

> **One primary MainShell/root navigation architecture.**

Do not create separate independent bottom-navigation systems inside individual features.

Do not duplicate the bottom navigation on deep screens.

---

# 22. PRIMARY NAVIGATION

Primary destinations:

```text
Home
Learn
Learn How to Learn
Planner
Progress
```

These should remain persistent when the user is within the corresponding top-level area.

---

# 23. DEEP NAVIGATION

Deep screens should use normal navigation routes.

Example:

```text
Learn
  ↓
Topic / Concept
  ↓
Concept Learning Experience
```

The deep screen should not create another copy of the bottom navigation.

---

# 24. NAVIGATION HIERARCHY

Conceptually:

```text
Root
│
├── MainShell
│   ├── Home
│   ├── Learn
│   ├── Learn How to Learn
│   ├── Planner
│   └── Progress
│
└── Deep Routes
    ├── Topic
    ├── Concept Learning
    ├── Revision Session
    ├── Practice Session
    ├── Focus Session
    └── Other feature-specific destinations
```

---

# 25. NAVIGATION RESPONSIBILITY

Navigation should be defined centrally.

Feature screens may request navigation.

They should not recreate the entire application navigation system.

---

# 26. NAVIGATION EXAMPLE

The learning vertical slice is:

```text
Home
  ↓
Learn
  ↓
Topic / Concept
  ↓
Concept Learning Experience
```

Specifically:

```text
Screen 22 Learn Hub
        ↓
Screen 23 Topic / Concept
        ↓
Screen 24 Concept Learning Experience
```

Back navigation:

```text
Screen 24
   ↓ Back
Screen 23
   ↓ Back
Screen 22
```

---

# 27. BOTTOM NAVIGATION RULE

The bottom navigation:

```text
Home
Learn
Learn How to Learn
Planner
Progress
```

is the global primary navigation.

It must not become:

```text
Concept
Revision
Practice
Settings
```

through local modifications.

Deep features are reached through the appropriate primary destination or secondary navigation.

---

# 28. STATE MANAGEMENT

YOUTOPPER requires a predictable state-management approach.

The project should use one approved state-management system consistently.

The current product architecture is compatible with:

> **Provider-based state management**

unless a later explicit architectural decision replaces it.

---

# 29. STATE MANAGEMENT RESPONSIBILITY

State objects should handle:

* current state
* user actions
* loading
* success
* error
* derived values
* repository interaction

UI widgets should primarily:

* render state
* send user actions
* respond to state changes

---

# 30. STATE FLOW

Preferred direction:

```text
User Action
    ↓
Widget
    ↓
Provider / State Object
    ↓
Repository
    ↓
Data Source
    ↓
Updated State
    ↓
Widget
```

Avoid:

```text
Widget
 ↓
Firebase/API
 ↓
Widget
```

or:

```text
Widget
 ↓
Global Random State
 ↓
Everything
```

---

# 31. STATE OWNERSHIP

State should live at the lowest level that needs to own it.

Examples:

### Screen-local UI state

Use local widget state for:

* selected tab
* expanded section
* temporary animation state
* text field state

### Feature state

Use feature-level state for:

* loaded concepts
* selected learning method IDs
* planner items
* revision state
* practice state

### App-level state

Use global state only for:

* authentication state
* global user state
* application-level settings
* truly global information

Do not make every state global.

---

# 32. STATE LIFETIME

State should have an intentional lifetime.

Examples:

```text
Screen-local
Feature-session
Application-session
Persistent
```

Do not persist state simply because it exists.

---

# 33. DATA MODELS

Models represent real product concepts.

Example:

```dart
class LearningTechniqueData {
  final String id;
  final String title;
  final String description;
  final String category;
}
```

The exact implementation may differ.

The important principle is:

> Models represent data and product concepts, not UI layout.

---

# 34. MODEL RESPONSIBILITIES

Models should:

* hold meaningful data
* provide safe representation
* support serialization when required
* remain independent of presentation

Models should not:

* render widgets
* navigate
* show snackbars
* access BuildContext
* directly call UI code

---

# 35. DATA MODEL OWNERSHIP

A feature should own models that are primarily relevant to that feature.

If a model becomes genuinely cross-feature, move it to a shared domain location intentionally.

Do not duplicate models.

---

# 36. SINGLE SOURCE OF TRUTH FOR TECHNIQUE DATA

Learning techniques must have one canonical definition.

Example:

```text
LearningTechniqueData
```

must remain the source of:

* technique ID
* title
* description
* category
* icon
* technique metadata

Other features should reference the technique ID.

---

# 37. PERSONAL LEARNING METHOD STATE

A personal learning-method collection should reference technique IDs.

Conceptually:

```text
MyLearningMethodState
---------------------
techniqueId
isActive
```

Do not duplicate the entire technique object.

Example:

```text
Selected IDs:

[
  active_recall,
  spaced_repetition,
  feynman
]
```

The screen resolves those IDs against the canonical technique data.

---

# 38. UNKNOWN DATA SAFETY

If a selected ID does not exist:

```text
Do not crash.
```

The application should:

* ignore the invalid item
* optionally log/debug it
* continue rendering valid items

---

# 39. DUPLICATE DATA SAFETY

Duplicate IDs should not result in duplicate UI entries.

Example:

```text
[
  active_recall,
  active_recall,
  feynman
]
```

should render:

```text
Active Recall
Feynman Technique
```

once each.

---

# 40. LOCAL / DEMO DATA

During frontend-first development, deterministic local data is allowed.

Example:

```text
lib/features/.../data/
```

may contain:

* demo subjects
* demo topics
* demo concepts
* demo learning methods
* demo planner data
* demo progress data

---

# 41. DEMO DATA RULE

Demo data must be:

* deterministic
* understandable
* realistic
* consistent
* manually defined

Do not use:

* random selection
* random numbers
* timestamps that change every launch without reason
* fake generated analytics
* arbitrary data generation

---

# 42. DEMO DATA PURPOSE

Demo data exists to:

* make screens visually complete
* test workflows
* validate UI
* demonstrate product behavior
* support development before backend integration

It must not be confused with real user data.

---

# 43. FRONTEND-FIRST ARCHITECTURE

During the frontend-first stage:

```text
UI
 ↓
State
 ↓
Local Repository
 ↓
Deterministic Data
```

is acceptable.

Example:

```text
HomeScreen
   ↓
HomeProvider
   ↓
HomeRepository
   ↓
HomeDemoData
```

---

# 44. FUTURE BACKEND ARCHITECTURE

When backend integration begins:

```text
UI
 ↓
Provider / State
 ↓
Repository
 ↓
Remote Data Source
 ↓
Firebase / API
```

The presentation layer should not need to know whether the repository is backed by local or remote data.

---

# 45. BACKEND REPLACEMENT PRINCIPLE

Frontend development must not hard-code assumptions such as:

```text
FirebaseFirestore.instance.collection(...)
```

inside screens.

Prefer:

```text
Screen
 ↓
Provider
 ↓
Repository
```

This makes future persistence integration safer.

---

# 46. FIREBASE BOUNDARY

Firebase may eventually provide:

* Authentication
* Firestore
* Storage
* cloud persistence
* other approved backend capabilities

Firebase-specific code must remain below the feature/application boundary.

Example:

```text
presentation
      ↓
state
      ↓
repository
      ↓
firebase datasource
```

not:

```text
presentation
      ↓
firebase
```

---

# 47. AI BOUNDARY

AI APIs must not be embedded directly into widgets.

Future architecture should follow:

```text
UI
 ↓
Feature State
 ↓
AI Service / Repository
 ↓
AI Provider
```

AI should remain replaceable.

---

# 48. SERVICES

Services should represent meaningful cross-cutting operations.

Examples may include:

* notification service
* analytics service
* authentication service
* file service
* AI service

Do not create a service class merely to wrap one line of code.

---

# 49. UTILITIES

Utilities should contain genuinely reusable stateless helpers.

Examples:

* date formatting
* validation helpers
* parsing helpers
* safe conversion helpers

Do not place business logic inside random utility classes.

---

# 50. CONSTANTS

Global constants may include:

* application name
* route names
* fixed design values
* stable identifiers

Feature-specific constants should remain within their feature where appropriate.

Avoid creating one enormous constants file.

---

# 51. CONFIGURATION

Environment/configuration values should not be scattered throughout the application.

Sensitive credentials must never be hard-coded into UI code.

Future API keys or service configuration should use the appropriate configuration mechanism.

---

# 52. DEPENDENCY DIRECTION

Dependencies should flow inward toward stable abstractions.

Preferred:

```text
Presentation
     ↓
State
     ↓
Repository
     ↓
Data Source
```

Avoid reverse dependencies.

For example:

```text
Data Source
   ✕
   ↓
Widget
```

is prohibited.

---

# 53. FEATURE DEPENDENCIES

Features should depend on shared/core functionality rather than directly reaching deeply into unrelated features.

Bad:

```text
Practice
 ↓
Learn Screen internal widget
```

Better:

```text
Practice
 ↓
Shared Topic/Concept model
```

or:

```text
Practice
 ↓
Repository
```

where appropriate.

---

# 54. CROSS-FEATURE COMMUNICATION

Cross-feature communication should happen through:

* shared domain models
* repositories
* controlled state
* navigation parameters
* application-level services where justified

Avoid direct manipulation of another feature's private state.

---

# 55. NAVIGATION PARAMETERS

When opening a deep screen, pass stable identifiers.

Example:

```text
topicId
conceptId
techniqueId
revisionId
practiceId
```

Prefer:

```text
ConceptScreen(conceptId)
```

over passing an entire mutable object when the screen can resolve the required data itself.

---

# 56. DEEP-LINKABLE DESIGN

Important deep screens should conceptually be identifiable by stable IDs.

Examples:

```text
/topic/:topicId
/concept/:conceptId
/technique/:techniqueId
```

The exact routing syntax may vary.

This makes future deep links and notifications easier to support.

---

# 57. SCREEN RESPONSIBILITY

A screen should have one primary responsibility.

Example:

### Screen 22

Discovery.

### Screen 23

Concept overview.

### Screen 24

Concept teaching.

Do not combine all three into one giant screen.

---

# 58. SCREEN VS STATE

Create a new screen when the user is entering a distinct product context.

Use a state/mode when the interaction is part of the same context.

Example:

```text
Practice Hub
Practice Session
Practice Results
```

are distinct contexts.

But:

```text
Create Task
Edit Task
Reschedule Task
```

can often be bottom sheets/states inside Planner.

---

# 59. SCREEN EXPLOSION PREVENTION

Do not create screens for:

* confirmation dialogs
* simple forms
* filter selections
* small editing interactions
* one-step actions
* temporary success states

unless the UX genuinely requires a full-screen context.

---

# 60. HOME ARCHITECTURE

Home is the primary orchestration screen.

It should consume information from multiple domains:

```text
Learning
Planning
Revision
Practice
Progress
```

Conceptually:

```text
                HOME
                  │
       ┌──────────┼──────────┐
       │          │          │
     Learn      Plan      Revision
       │          │          │
       └──────┬───┴──────┬───┘
              │          │
           Practice   Progress
```

Home should not duplicate business logic from those features.

It should consume derived information.

---

# 61. HOME RECOMMENDATION ARCHITECTURE

The Home recommendation should be produced by application logic, not hard-coded directly into UI widgets.

Conceptually:

```text
Learning State
+
Plan State
+
Revision State
+
Practice State
+
Progress State
        ↓
Recommendation Logic
        ↓
Home State
        ↓
Home UI
```

During demo development, the recommendation can come from deterministic local data.

---

# 62. LEARNING ARCHITECTURE

Learning is divided into:

```text
Learn Hub
   ↓
Topic / Concept
   ↓
Concept Learning Experience
```

The separation is intentional.

### Learn Hub

Discovery.

### Topic / Concept

Overview.

### Concept Learning Experience

Teaching.

---

# 63. CONCEPT LEARNING ARCHITECTURE

The learning experience should support structured lesson sections.

Conceptually:

```text
Lesson
 ├── Introduction
 ├── Core Idea
 ├── Visual
 ├── Example
 ├── Understanding Check
 ├── Remember
 └── Completion
```

Lesson progress should belong to the learning feature/session state.

---

# 64. LEARNING METHOD ARCHITECTURE

Learning-method data should be centralized.

Conceptually:

```text
LearningTechniqueData
        │
        ├── Learn How to Learn
        ├── Technique Detail
        ├── Technique Application
        └── My Learning Methods
```

Do not create separate copies of the same technique definitions.

---

# 65. REVISION ARCHITECTURE

Revision should connect to learned content.

Conceptually:

```text
Learned Concept
      ↓
Revision Item
      ↓
Revision Schedule
      ↓
Revision Session
      ↓
Revision Result
```

Revision should not be an unrelated task list.

---

# 66. PRACTICE ARCHITECTURE

Practice should connect to learning content.

Conceptually:

```text
Concept / Topic
      ↓
Practice Set
      ↓
Practice Session
      ↓
Practice Result
      ↓
Weak Area
      ↓
Learn / Revise Again
```

---

# 67. PLANNER ARCHITECTURE

Planner should connect academic actions to time.

Conceptually:

```text
Learning Activity
Practice
Revision
Goal
     ↓
Study Plan
     ↓
Scheduled Activity
     ↓
Focus Session
     ↓
Completion
```

---

# 68. PROGRESS ARCHITECTURE

Progress should aggregate meaningful signals.

Conceptually:

```text
Learning Activity
Practice
Revision
Study Sessions
Goals
      ↓
Progress Calculation
      ↓
Progress State
      ↓
Progress UI
```

Do not calculate complex progress separately in multiple screens.

---

# 69. INSIGHTS ARCHITECTURE

Insights should consume existing state rather than duplicate data.

Conceptually:

```text
Progress
+
Practice
+
Revision
+
Learning
+
Planner
       ↓
Insight Logic
       ↓
Smart Insights
```

---

# 70. WEEKLY REVIEW ARCHITECTURE

Weekly Review should aggregate activity from existing systems.

It should not maintain a second independent version of:

* study activity
* practice activity
* revision history
* progress

Prefer derived summaries.

---

# 71. NOTIFICATION ARCHITECTURE

Notifications should reference existing entities.

Example:

```text
Notification
   ↓
revisionId
```

or:

```text
Notification
   ↓
topicId
```

The notification should not duplicate entire objects unnecessarily.

---

# 72. SEARCH ARCHITECTURE

Search should query a controlled searchable data source.

Conceptually:

```text
Search Input
     ↓
Search State
     ↓
Search Repository
     ↓
Searchable Data
     ↓
Grouped Results
```

Search should not directly inspect arbitrary widget state.

---

# 73. AUTHENTICATION ARCHITECTURE

Authentication should be centralized.

Conceptually:

```text
Authentication UI
       ↓
Authentication State
       ↓
Authentication Repository / Service
       ↓
Authentication Provider
```

Screens should respond to authentication state rather than manually deciding whether the user is logged in from arbitrary local flags.

---

# 74. AUTHENTICATION ROUTING

The application should conceptually support:

```text
Unauthenticated
     ↓
Authentication Flow

Authenticated but Setup Incomplete
     ↓
Learner Setup

Authenticated + Setup Complete
     ↓
Main Application
```

The exact implementation may evolve.

---

# 75. LEARNER SETUP ARCHITECTURE

Learner setup should collect information progressively.

Conceptually:

```text
Personal
   ↓
Learner Type
   ↓
Academic Context
   ↓
Goals / Preferences
   ↓
Review
   ↓
Learning Setup
   ↓
Subjects / Syllabus
```

The setup process should not create multiple competing learner-profile objects.

---

# 76. SYLLABUS ARCHITECTURE

Syllabus should have a structured hierarchy.

Recommended conceptual model:

```text
Syllabus
  └── Subject
        └── Unit / Chapter
              └── Topic
                    └── Concept
```

The exact academic hierarchy may vary depending on learner type.

---

# 77. CONTENT IDENTITY

Important entities should have stable IDs.

Examples:

```text
subjectId
unitId
topicId
conceptId
techniqueId
revisionId
practiceId
planId
```

Stable IDs allow:

* navigation
* references
* persistence
* deep links
* relationships

---

# 78. ENTITY RELATIONSHIPS

The system should conceptually support:

```text
Subject
  ↓
Unit
  ↓
Topic
  ↓
Concept
```

and:

```text
Concept
 ├── Study Activity
 ├── Practice
 ├── Revision
 ├── Saved State
 └── Progress
```

---

# 79. BUSINESS LOGIC LOCATION

Business rules should not be scattered through widgets.

Bad:

```dart
if (...)
```

repeated across multiple screens.

Better:

```text
Feature State
or
Feature Logic
or
Domain Use Case
```

depending on complexity.

---

# 80. WHEN TO INTRODUCE USE CASES

Use cases are appropriate when:

* business logic is non-trivial
* logic is reused
* logic needs isolated testing
* a workflow contains multiple operations
* the feature is becoming difficult to reason about

Do not create use cases for trivial getters.

Example:

Good candidate:

```text
GenerateNextStudyRecommendation
```

Potentially unnecessary:

```text
GetAppNameUseCase
```

---

# 81. BUSINESS LOGIC EXAMPLE

Instead of:

```text
HomeScreen
 ↓
check unfinished topic
 ↓
check revision
 ↓
check practice
 ↓
calculate priority
```

prefer:

```text
HomeScreen
 ↓
HomeState
 ↓
RecommendationLogic
 ↓
Recommendation
```

The screen displays the result.

---

# 82. ERROR ARCHITECTURE

Errors should be represented intentionally.

Possible states:

```text
Initial
Loading
Loaded
Empty
Error
```

The exact state model can be simpler for trivial screens.

Do not make every screen implement an unnecessarily complex state machine.

---

# 83. LOADING ARCHITECTURE

Loading indicators should exist at the smallest useful scope.

Avoid replacing the entire application with a global spinner when only one section is loading.

---

# 84. EMPTY STATE ARCHITECTURE

Empty states belong to the feature that owns the data.

Example:

```text
My Learning Methods
      ↓
No methods selected
      ↓
Feature-specific empty state
```

---

# 85. ERROR STATE ARCHITECTURE

Feature errors should be displayed in context.

Example:

```text
Revision
 ↓
Unable to load revision items
 ↓
Retry
```

Do not show generic application errors for every feature failure.

---

# 86. CACHING

Caching may be introduced when justified.

Potential cached data:

* syllabus
* concepts
* saved items
* user profile
* recent learning state

Caching should not be introduced prematurely.

---

# 87. OFFLINE SUPPORT

Future offline support may allow:

* viewing cached learning content
* reviewing saved material
* recording offline study state
* syncing later

The architecture should avoid making offline support impossible, but full offline infrastructure is not required before the product needs it.

---

# 88. PERSISTENCE STRATEGY

Persistence should be introduced independently from UI.

Possible progression:

```text
Stage 1
Static deterministic demo data

Stage 2
Local persistence

Stage 3
Remote persistence

Stage 4
Synchronization / offline support
```

Each stage should preserve the feature contracts where possible.

---

# 89. REPOSITORY CONTRACT

Repositories should provide stable feature-level contracts.

For example:

```text
LearningRepository
    getTopics()
    getConcept()
    getSavedConcepts()
```

The implementation may change from:

```text
DemoLearningRepository
```

to:

```text
FirebaseLearningRepository
```

without forcing UI redesign.

---

# 90. TESTING ARCHITECTURE

Testing should occur at multiple levels.

## Unit Tests

For:

* business logic
* calculations
* recommendation logic
* progress calculations
* validation
* data transformations

---

## Widget Tests

For:

* screen rendering
* user interactions
* state changes
* navigation triggers
* empty states
* error states

---

## Integration / Runtime Tests

For:

* important user journeys
* authentication flow
* learning flow
* planning flow
* revision flow
* practice flow

---

# 91. TEST OWNERSHIP

Tests should live near the feature where practical.

Example:

```text
features/
  learn/
    presentation/
      learn_screen.dart
      learn_screen_test.dart
```

or the project's established testing convention.

Do not create one enormous test file for the entire application.

---

# 92. TESTING PRINCIPLE

Tests should verify behavior, not implementation trivia.

Good:

> Tapping Start Learning opens the correct learning experience.

Less useful:

> Private helper `_buildCard()` was called exactly once.

---

# 93. REGRESSION SAFETY

Existing tests must not be deleted simply to make a new feature pass.

When changing shared architecture:

1. understand existing behavior
2. preserve existing behavior
3. add/update tests
4. verify affected features

---

# 94. VISUAL VALIDATION

Important screens should be visually verified after implementation.

Validation should check:

* hierarchy
* spacing
* typography
* colors
* elevation
* responsiveness
* navigation
* bottom navigation
* interaction states

A screen is not complete merely because the Dart code compiles.

---

# 95. SCREEN IMPLEMENTATION STRATEGY

YOUTOPPER should be built one meaningful vertical slice at a time.

Preferred process:

```text
Product Definition
      ↓
Screen Architecture
      ↓
UI Design
      ↓
Implementation
      ↓
Functional Verification
      ↓
Runtime Verification
      ↓
Visual Verification
      ↓
Lock
      ↓
Next Screen
```

---

# 96. SCREEN LOCKING

Once a screen is approved and locked:

* do not redesign it casually
* do not refactor it unnecessarily
* do not alter its navigation without reason
* do not change shared components to satisfy minor screen-specific preferences

Reopen a locked screen only when:

* a genuine defect exists
* a product requirement changes
* an architectural dependency requires it
* the user explicitly requests a change

---

# 97. CURRENT LOCKED LEARNING SCREENS

The current approved vertical slice includes:

### Screen 21 — Home

**LOCKED**

### Screen 22 — Learn Hub

**LOCKED**

### Screen 23 — Topic / Concept

**LOCKED**

The next implementation target after this slice is:

### Screen 24 — Concept Learning Experience

unless the current development state explicitly changes.

---

# 98. SCREEN 22 ARCHITECTURE

Screen 22 should remain a feature-owned learning discovery screen.

It should:

* consume learning data
* render learning categories/topics
* navigate to Screen 23
* preserve the MainShell
* avoid owning concept-learning logic

---

# 99. SCREEN 23 ARCHITECTURE

Screen 23 should:

* receive or resolve a concept/topic identifier
* display concept overview
* expose Start Learning
* navigate to Screen 24
* preserve back navigation to Screen 22

It should not contain the complete lesson.

---

# 100. SCREEN 24 ARCHITECTURE

Screen 24 should own the learning-session presentation/state.

Conceptually:

```text
Concept ID
   ↓
Concept Data
   ↓
Lesson State
   ↓
Current Lesson Section
   ↓
Visual Explanation
   ↓
Understanding Check
   ↓
Completion
```

It should not become the Practice feature.

---

# 101. SHARED LEARNING DATA

Learning data should have one source of truth.

Example:

```text
LearningTechniqueData
ConceptData
TopicData
SubjectData
```

Screens should consume these models rather than duplicating content.

---

# 102. UI DATA VS PRODUCT DATA

Do not mix product data with layout configuration unnecessarily.

Bad:

```text
ConceptData
contains:
padding
fontSize
borderRadius
```

Better:

```text
ConceptData
```

contains learning information.

The UI decides how to render it.

---

# 103. WIDGET RESPONSIBILITY

Widgets should generally:

* receive data
* render data
* expose callbacks
* remain reusable when appropriate

Widgets should not:

* directly query backend
* mutate unrelated feature state
* perform navigation architecture decisions
* contain large business algorithms

---

# 104. SCREEN RESPONSIBILITY

Screens may coordinate:

* layout
* feature state
* navigation callbacks
* screen-specific composition

But should avoid becoming 1,000+ line monoliths.

When a screen becomes too complex, extract meaningful feature widgets.

Do not split files merely to reduce line count.

---

# 105. WIDGET EXTRACTION RULE

Extract a widget when it has:

* a meaningful visual responsibility
* repeated use
* independent interaction
* enough complexity to improve readability

Do not extract every `Container`, `Row`, or `Text`.

---

# 106. FILE SIZE PRINCIPLE

There is no arbitrary universal line-count limit.

Instead:

> A file should have one coherent responsibility.

If a file contains:

* multiple unrelated features
* several large state machines
* unrelated data models
* navigation architecture
* design-system definitions

it should be reconsidered.

---

# 107. SIX-FILE CONTROL SYSTEM

The six root-level control documents are:

```text
PRD.md
ARCHITECTURE.md
RULES.md
PHASES.md
DESIGN.md
MEMORY.md
```

They are project-control documents.

They should live at the project root.

---

# 108. CONTROL DOCUMENT RESPONSIBILITIES

## PRD.md

Defines:

> What the product is.

---

## ARCHITECTURE.md

Defines:

> How the product is technically structured.

---

## RULES.md

Defines:

> How development must be performed.

---

## PHASES.md

Defines:

> In what order development should happen.

---

## DESIGN.md

Defines:

> How the product should look and feel.

---

## MEMORY.md

Defines:

> Important decisions, locked states, lessons, and project context that must not be forgotten.

---

# 109. CONTROL DOCUMENT PRIORITY

When instructions conflict, use:

```text
1. Explicit current task
2. RULES.md
3. ARCHITECTURE.md
4. PRD.md
5. PHASES.md
6. DESIGN.md
7. MEMORY.md
8. Existing implementation
9. Tool/agent assumptions
```

The explicit current task has priority because it may intentionally override a previous decision.

---

# 110. ROOT PROJECT STRUCTURE

The project root should conceptually contain:

```text
YOUTOPPER/
│
├── PRD.md
├── ARCHITECTURE.md
├── RULES.md
├── PHASES.md
├── DESIGN.md
├── MEMORY.md
│
├── pubspec.yaml
├── README.md
├── analysis_options.yaml
│
├── assets/
│   ├── images/
│   ├── animations/
│   └── fonts/
│
├── lib/
│   ├── main.dart
│   ├── app/
│   ├── core/
│   └── features/
│
├── test/
│
└── android/
```

Additional Flutter-generated directories/files may exist.

---

# 111. ASSET ARCHITECTURE

Assets should be organized by meaningful product purpose.

Example:

```text
assets/
├── images/
│   ├── branding/
│   ├── onboarding/
│   ├── home/
│   ├── profile/
│   └── ai/
│
├── animations/
│
└── fonts/
```

Do not place all assets in one directory.

---

# 112. BRAND ASSET

The official YOUTOPPER logo is:

```text
assets/images/youtopper_logo.png
```

Where the project currently uses this finalized asset, it must remain the canonical brand asset.

Do not replace it with:

* random icons
* graduation-cap imagery
* generic education logos
* manually recreated alternatives

unless explicitly approved.

---

# 113. FONT ARCHITECTURE

Typography should be centralized through the design system.

Current visual direction:

### Headings

Plus Jakarta Sans

### Body / Labels

Inter

The exact implementation belongs to `DESIGN.md`.

Features should not randomly introduce different fonts.

---

# 114. DEPENDENCY MANAGEMENT

Every dependency must have a clear reason.

Before adding a package ask:

1. Does Flutter already provide the capability?
2. Does the project already have a package that solves it?
3. Does the dependency materially improve the product?
4. Is it maintained?
5. Does it increase complexity?
6. Can the feature be implemented cleanly without it?

Avoid dependency accumulation.

---

# 115. PACKAGE RULE

Do not add packages merely for:

* simple animations
* basic UI
* ordinary navigation
* simple state
* basic utilities

Use existing Flutter/Dart capabilities when sufficient.

---

# 116. BACKEND DEPENDENCY RULE

Frontend screens must not require backend availability during frontend development unless the feature explicitly depends on backend functionality.

Deterministic local data should be used where appropriate.

---

# 117. API BOUNDARY

External APIs must be accessed through a controlled service/repository boundary.

Never call an API directly from:

```text
build()
```

or directly from a presentational widget.

---

# 118. FILE NAMING

Use consistent Dart naming.

Examples:

```text
home_screen.dart
home_provider.dart
home_repository.dart
home_state.dart
learning_technique_data.dart
technique_detail_screen.dart
```

Use:

* `snake_case` for filenames
* `PascalCase` for classes
* `camelCase` for variables/methods

---

# 119. CLASS NAMING

Prefer names that describe responsibility.

Good:

```text
HomeScreen
HomeProvider
LearningTechniqueData
ConceptLearningState
RevisionRepository
```

Avoid vague names:

```text
Manager
Helper
Handler
Controller2
Thing
Utils
```

unless their responsibility is genuinely clear.

---

# 120. IMPORT DISCIPLINE

Imports should remain clean.

Avoid:

* unnecessary imports
* circular imports
* feature internals imported by unrelated features
* direct imports into private implementation details

---

# 121. CIRCULAR DEPENDENCY PREVENTION

Avoid structures such as:

```text
Feature A
 ↓
Feature B
 ↓
Feature A
```

If two features require shared information, introduce a stable shared model/service/repository boundary.

---

# 122. GLOBAL STATE RULE

Global state is expensive conceptually.

Only promote state globally when:

* multiple unrelated features require it
* the state has application-wide meaning
* lifecycle requires global ownership

Examples:

* authentication
* current learner profile
* global app settings

Do not make:

* selected card
* expanded section
* temporary filter
* local screen state

global.

---

# 123. EVENT BUS RULE

Do not introduce a global event bus unless a real architectural requirement appears.

Prefer explicit:

```text
Action
 ↓
State
 ↓
Repository
```

over invisible application-wide events.

---

# 124. SINGLETON RULE

Singletons should be used sparingly.

Do not create global singleton managers for every feature.

If dependency lifetime matters, use the project's state/dependency mechanism.

---

# 125. LOGGING

Logging should:

* help diagnose failures
* avoid sensitive user information
* avoid excessive production noise

Debug logging should not become part of the user experience.

---

# 126. SECURITY ARCHITECTURE

Future security-sensitive operations must be kept outside presentation code.

Examples:

* authentication
* tokens
* user data
* cloud operations
* protected configuration

Never expose secrets directly inside widgets or committed source.

---

# 127. PERFORMANCE ARCHITECTURE

The architecture should support:

* lazy lists
* efficient rebuilds
* localized state updates
* asset optimization
* controlled animations
* avoiding unnecessary work in `build()`

Avoid premature micro-optimization.

Measure or identify an actual problem before introducing complexity.

---

# 128. BUILD METHOD RULE

Do not perform expensive operations inside `build()`.

Avoid:

* network calls
* heavy parsing
* unnecessary filtering of large data
* repeated expensive calculations

Precompute or derive state appropriately.

---

# 129. LIST PERFORMANCE

For large collections prefer:

```text
ListView.builder
GridView.builder
```

or appropriate lazy rendering.

Do not construct unnecessarily large static widget trees.

---

# 130. ANIMATION ARCHITECTURE

Animations should generally remain local to the feature/screen unless they are truly global design-system behavior.

Do not introduce a global animation framework for ordinary screen transitions.

---

# 131. RESPONSIVE ARCHITECTURE

Responsive layout should be handled within screen composition.

Avoid hard-coding:

```text
fixed width
fixed height
absolute positions
```

for major content.

Use:

* constraints
* flexible layouts
* adaptive spacing
* scrollable content
* responsive grids where appropriate

---

# 132. MAIN SHELL AND BOTTOM DOCK SAFETY

Screens inside MainShell must reserve sufficient bottom content space.

Important content must never be hidden behind the floating navigation dock.

Deep screens may hide the dock where appropriate.

---

# 133. ACCESSIBILITY ARCHITECTURE

Interactive widgets should support:

* semantics
* readable labels
* appropriate tap targets
* state descriptions
* non-color-only meaning

Accessibility should be considered during implementation rather than added after completion.

---

# 134. ERROR BOUNDARY PRINCIPLE

A failure in one feature should not unnecessarily crash the entire application.

For example:

```text
Practice data failure
```

should not prevent:

```text
Home
Learn
Profile
```

from functioning where possible.

---

# 135. FEATURE ISOLATION

A feature should be independently understandable.

A developer should be able to inspect:

```text
features/revision/
```

and understand most of the revision implementation without navigating through unrelated features.

---

# 136. REFACTORING RULE

Do not refactor the entire architecture during the implementation of a single screen unless the existing architecture genuinely prevents correct implementation.

Preferred:

```text
Local fix
 ↓
Feature-level fix
 ↓
Shared fix only if proven necessary
 ↓
Architecture refactor only when justified
```

---

# 137. LOCKED SCREEN PROTECTION

If a previously approved screen works correctly:

Do not modify it merely to:

* make code “prettier”
* rename files unnecessarily
* introduce a new pattern
* satisfy a personal architectural preference
* change the visual style without approval

Architecture must serve product stability.

---

# 138. MIGRATION STRATEGY

When moving from frontend-only to backend-backed functionality:

```text
Existing UI
   ↓
Existing Provider/State
   ↓
Existing Repository Contract
   ↓
Replace Data Source
```

Do not rewrite the presentation layer unless required.

---

# 139. LOCAL-FIRST IMPLEMENTATION EXAMPLE

For a frontend-only learning feature:

```text
LearnScreen
     ↓
LearnProvider
     ↓
LearnRepository
     ↓
LearningTechniqueData / DemoData
```

No Firebase is required.

---

# 140. FUTURE REMOTE IMPLEMENTATION EXAMPLE

Later:

```text
LearnScreen
     ↓
LearnProvider
     ↓
LearnRepository
     ↓
FirebaseLearnDataSource
     ↓
Firestore
```

The screen remains conceptually unchanged.

---

# 141. DATA MAPPING

When backend models differ from domain models, mapping may be introduced.

Example:

```text
Firestore DTO
    ↓
Mapper
    ↓
Domain Model
    ↓
Provider
    ↓
UI
```

Do not introduce DTO/mapper layers before they are needed.

---

# 142. ARCHITECTURAL EVOLUTION

YOUTOPPER architecture should evolve incrementally.

The progression may be:

```text
Simple Feature
      ↓
Feature State
      ↓
Repository
      ↓
Local Persistence
      ↓
Remote Data
      ↓
Caching / Sync
```

Do not jump directly to the final theoretical architecture.

---

# 143. DEVELOPMENT VERTICAL SLICE

A vertical slice should include everything required for one feature to function.

Example:

```text
Screen
 ↓
State
 ↓
Repository
 ↓
Demo Data
 ↓
Test
```

This is preferable to building:

```text
All models
 ↓
All repositories
 ↓
All screens
```

before verifying any user journey.

---

# 144. CURRENT DEVELOPMENT STRATEGY

The project should proceed:

```text
Define
 ↓
Design
 ↓
Implement
 ↓
Test
 ↓
Run
 ↓
Review
 ↓
Lock
 ↓
Next
```

One screen or tightly related vertical slice at a time.

---

# 145. IMPLEMENTATION SCOPE CONTROL

When implementing a screen:

Allowed:

* required screen files
* required feature widgets
* required state
* required local data
* required route
* necessary integration

Avoid unrelated:

* refactoring
* dependency changes
* theme rewrites
* global navigation changes
* backend work
* other screen redesigns

---

# 146. ARCHITECTURAL ACCEPTANCE CRITERIA

A feature architecture is acceptable when:

1. Responsibilities are clear.
2. UI does not own data-access infrastructure.
3. Business logic is not scattered across widgets.
4. State ownership is intentional.
5. Feature boundaries are understandable.
6. Navigation remains centralized.
7. Shared code is genuinely shared.
8. Models are not duplicated.
9. Demo data is deterministic.
10. Future persistence can be introduced without rewriting the UI.
11. Tests can target important logic.
12. The architecture does not introduce unnecessary complexity.

---

# 147. ARCHITECTURAL RED FLAGS

Stop and reassess when implementation introduces:

* duplicate models
* duplicate navigation systems
* multiple state-management systems
* Firebase calls inside widgets
* API calls inside `build()`
* giant global providers
* giant utility classes
* global event buses
* unnecessary singletons
* unnecessary interfaces
* unnecessary use cases
* circular dependencies
* unrelated feature modifications
* architecture changes for one visual issue
* random demo data
* hard-coded business logic across multiple screens

---

# 148. ARCHITECTURAL DECISION TEST

Before adding an abstraction ask:

### Question 1

Does this solve a current problem?

### Question 2

Will this reduce future coupling?

### Question 3

Does it make the feature easier to understand?

### Question 4

Can the feature remain simpler without it?

If the fourth answer is yes, prefer the simpler architecture.

---

# 149. FINAL ARCHITECTURAL PRINCIPLE

YOUTOPPER should follow:

> **Feature-oriented architecture with clear layers, centralized navigation, controlled state, single sources of truth, deterministic frontend data, and incremental evolution toward persistence.**

The architecture should be:

**simple enough to understand, structured enough to scale, and disciplined enough to prevent the project from becoming a collection of disconnected screens.**

---

# 150. ARCHITECTURE AUTHORITY

This document is the technical architecture source of truth for YOUTOPPER.

It defines:

* where code belongs
* how features are separated
* how state flows
* how navigation is structured
* how data flows
* how persistence should eventually integrate
* how technical complexity should be controlled

It does not redefine product requirements.

For product behavior, consult:

```text
PRD.md
```

For implementation rules, consult:

```text
RULES.md
```

For development order, consult:

```text
PHASES.md
```

For visual/design requirements, consult:

```text
DESIGN.md
```

For important historical decisions and locked context, consult:

```text
MEMORY.md
```

---

# END OF ARCHITECTURE
