# YOUTOPPER — DEVELOPMENT RULES

**File:** `RULES.md`
**Project:** YOUTOPPER
**Document Version:** 1.0
**Document Status:** ACTIVE
**Authority:** Development / Implementation Rules
**Primary Users:** Developer, ChatGPT, Antigravity, future contributors

---

# 1. PURPOSE

This document defines the mandatory development rules for YOUTOPPER.

These rules exist to protect:

* product quality
* architectural integrity
* visual consistency
* development speed
* scope control
* screen stability
* code maintainability
* user experience
* project continuity

These rules are especially important because YOUTOPPER is being developed incrementally.

The project must not become:

> a collection of screens that happen to compile.

It must become:

> a coherent product with connected user journeys, controlled architecture, and consistent UX.

---

# 2. GOLDEN RULE

## Rule #1

> **Do not build code merely because code can be built. Build only what the product currently requires.**

Every implementation must have a clear relationship to:

* the PRD
* the current development phase
* the current screen/feature
* the approved architecture
* the approved design

---

# 3. SOURCE OF TRUTH RULE

YOUTOPPER has six permanent control documents:

```text
PRD.md
ARCHITECTURE.md
RULES.md
PHASES.md
DESIGN.md
MEMORY.md
```

These files must remain at the **project root**.

---

# 4. CONTROL DOCUMENT RESPONSIBILITIES

## PRD.md

Defines:

> What YOUTOPPER is and what the product should do.

---

## ARCHITECTURE.md

Defines:

> How YOUTOPPER is technically structured.

---

## RULES.md

Defines:

> How YOUTOPPER must be developed.

---

## PHASES.md

Defines:

> In what sequence YOUTOPPER should be developed.

---

## DESIGN.md

Defines:

> How YOUTOPPER should look and feel.

---

## MEMORY.md

Defines:

> Important project decisions, locked states, historical context, and information that must not be forgotten.

---

# 5. DOCUMENT PRIORITY

When instructions conflict, use this priority:

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

An explicit current task may intentionally override a previous decision.

However, the override must be intentional and visible.

---

# 6. CURRENT TASK RULE

Work only on the task explicitly assigned.

If the task is:

> Implement Screen 24.

Do not automatically:

* redesign Screen 22
* redesign Screen 23
* refactor Home
* add Firebase
* redesign navigation
* create Screen 25
* rewrite the theme
* reorganize the entire project

unless the current task explicitly requires it.

---

# 7. ONE VERTICAL SLICE AT A TIME

YOUTOPPER must be developed incrementally.

Preferred:

```text
Plan
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

Do not attempt to implement the entire application in one operation.

---

# 8. ONE SCREEN AT A TIME

Unless multiple screens are explicitly part of one tightly coupled workflow, implementation should focus on one screen at a time.

Example:

```text
Screen 22
 ↓
Lock
 ↓
Screen 23
 ↓
Lock
 ↓
Screen 24
```

This allows:

* controlled review
* visual verification
* easier debugging
* smaller changes
* lower regression risk

---

# 9. SCREEN LOCK RULE

When a screen is explicitly approved and marked:

> **LOCKED**

it must be treated as stable.

Do not modify a locked screen merely because:

* another screen is being implemented
* a developer prefers a different pattern
* code can be “cleaned up”
* a different visual style looks attractive
* a refactor seems interesting

A locked screen may be modified only when:

1. The user explicitly requests it.
2. A genuine defect is discovered.
3. A necessary architectural dependency requires it.
4. A product requirement has intentionally changed.

---

# 10. CURRENT LOCKED SCREENS

The current approved learning flow contains:

```text
Screen 21 — Home
Screen 22 — Learn Hub
Screen 23 — Topic / Concept
```

These screens are considered locked unless explicitly reopened.

The next screen in the learning vertical slice is:

```text
Screen 24 — Concept Learning Experience
```

---

# 11. PLAN BEFORE IMPLEMENTATION

For meaningful new screens/features:

1. inspect the existing project
2. inspect related screens
3. inspect existing models
4. inspect navigation
5. inspect reusable components
6. inspect tests
7. define the implementation plan
8. obtain approval where required
9. implement

Do not immediately start coding based only on the screen name.

---

# 12. INSPECT BEFORE MODIFYING

Before modifying existing code, inspect:

* relevant screen
* parent feature
* existing navigation
* models
* state management
* shared widgets
* theme/constants
* tests
* related approved screens

Never assume that a required component does not already exist.

---

# 13. REUSE BEFORE CREATE

Before creating a new:

* model
* widget
* provider
* repository
* service
* utility
* navigation helper

check whether an existing implementation already serves the same responsibility.

Prefer:

> reuse → extend → create

rather than:

> create → duplicate → reconcile later

---

# 14. NO DUPLICATE MODELS

Never create two models representing the same product concept.

For example, if the project already contains:

```text
LearningTechniqueData
```

do not create:

```text
TechniqueModel
LearningMethodModel
TechniqueEntity2
```

just to support another screen.

Extend or reuse the existing model when appropriate.

---

# 15. SINGLE SOURCE OF TRUTH

Important product data must have one canonical source.

Examples:

* learning techniques
* subjects
* concepts
* topics
* navigation destinations
* design tokens

Do not hard-code the same information independently across multiple screens.

---

# 16. DATA IDENTITY RULE

Stable identifiers should be used to connect related entities.

Examples:

```text
subjectId
topicId
conceptId
techniqueId
revisionId
practiceId
planId
```

When a screen only needs an identifier, prefer passing the identifier rather than duplicating a large mutable object.

---

# 17. UNKNOWN DATA MUST NOT CRASH

If an identifier is invalid or data is missing:

> The application must fail gracefully.

For example:

```text
Unknown technique ID
```

must not crash the entire screen.

Valid data should continue rendering.

---

# 18. DUPLICATE DATA MUST BE CONTROLLED

Duplicate IDs should not produce duplicate visual entries where uniqueness is expected.

Example:

```text
active_recall
active_recall
feynman
```

should render:

```text
Active Recall
Feynman Technique
```

once each.

---

# 19. FRONTEND-FIRST RULE

During the frontend-first phase:

> **Do not introduce backend infrastructure unless explicitly approved.**

This includes:

* Firebase
* Firestore
* Firebase Authentication
* Firebase Storage
* REST APIs
* GraphQL
* AI APIs
* cloud databases
* analytics services
* external persistence services

Use deterministic local/demo data where necessary.

---

# 20. NO PREMATURE BACKEND

Do not add Firebase merely because:

* the app will eventually need it
* a screen has user data
* the architecture could support it
* the developer wants to “prepare everything”

Backend integration happens when the project reaches the appropriate phase.

---

# 21. NO PREMATURE AI

AI is not a requirement for basic YOUTOPPER functionality.

Do not add:

* OpenAI APIs
* Gemini APIs
* Claude APIs
* AI chat
* AI-generated recommendations
* AI-generated content

unless explicitly approved as part of the current product phase.

---

# 22. DETERMINISTIC DEMO DATA

Frontend demo data must be:

* manually defined
* deterministic
* repeatable
* realistic
* internally consistent

Do not use random data to make screens look dynamic.

Bad:

```text
Random progress
Random recommendation
Random technique
Random score
```

Good:

```text
Explicitly defined demo state
```

---

# 23. NO FAKE INTELLIGENCE

Never present arbitrary logic as intelligence.

Do not display:

> “AI recommends this.”

when no AI exists.

Do not fabricate:

* learning scores
* effectiveness percentages
* personalized claims
* predictive results
* performance analysis

If demo logic is deterministic, it should behave like deterministic logic.

---

# 24. DEMO DATA MUST NOT LOOK LIKE REAL USER HISTORY

Demo data may be used during development.

However, it must not create false assumptions about actual user behavior.

For example:

> “You studied 12 hours last week”

should only exist as clearly defined demo content until real activity tracking exists.

---

# 25. NO RANDOMNESS

Avoid random values in:

* progress
* recommendations
* cards
* ordering
* scores
* dates
* statistics
* user state

unless randomness is explicitly part of the feature.

---

# 26. NO SCREENPLACEHOLDER IMPLEMENTATION

Do not create fake screens simply to make navigation technically work.

Bad:

```text
Button → “Coming Soon”
```

when the product does not require that screen yet.

Better:

* implement only the available destination
* disable/defer the action if appropriate
* preserve the intended architecture

Do not create fake product functionality.

---

# 27. NO FUTURE-SCREEN EXPLOSION

Do not create Screen 40, 41, 42, etc. merely because a current screen has a future concept.

Future destinations should only be implemented when their development phase arrives.

---

# 28. NO “COMING SOON” UI BY DEFAULT

Do not fill unfinished product areas with:

* Coming Soon
* Under Development
* Future Feature
* Placeholder cards

unless explicitly requested for the current UX.

---

# 29. NO FAKE BUTTONS

A button should either:

* perform a meaningful implemented action
* navigate to an implemented destination
* update a valid state
* intentionally remain unavailable with an appropriate UX

Do not add buttons that appear functional but do nothing.

---

# 30. NO DEAD-END NAVIGATION

Every implemented navigation action must have an intentional destination or state.

Avoid:

```text
Tap
 ↓
Nothing
```

---

# 31. NAVIGATION ARCHITECTURE RULE

YOUTOPPER must maintain:

> **One primary MainShell/root navigation architecture.**

Do not create multiple independent bottom navigation systems.

---

# 32. PRIMARY BOTTOM NAVIGATION

The primary navigation is:

```text
Home
Learn
Learn How to Learn
Planner
Progress
```

Do not add deep screens as bottom-navigation destinations unless the product architecture is intentionally changed.

---

# 33. NO DUPLICATE BOTTOM NAVIGATION

Do not place another bottom navigation inside:

* Topic
* Concept Learning
* Revision Session
* Practice Session
* Focus Session

Deep screens use the existing navigation architecture.

---

# 34. BACK NAVIGATION

Deep navigation should preserve expected back behavior.

Example:

```text
Screen 24
 ↓ Back
Screen 23
 ↓ Back
Screen 22
```

Do not unexpectedly send users to Home unless the product flow requires it.

---

# 35. FEATURE BOUNDARIES

Each feature owns its own:

* presentation
* feature state
* feature-specific widgets
* feature-specific logic
* feature-specific data

Do not casually reach into another feature's internal implementation.

---

# 36. NO CROSS-FEATURE HACKS

Avoid:

```text
Feature A
 ↓
imports private widget from Feature B
 ↓
changes Feature B internal state
```

Prefer:

* shared model
* repository
* state interface
* navigation
* controlled application service

---

# 37. STATE MANAGEMENT RULE

Use the project's approved state-management approach consistently.

Current approved direction:

> **Provider**

Do not introduce another state-management library unless explicitly approved.

Do not mix:

* Provider
* Riverpod
* Bloc
* GetX
* MobX

without a deliberate architectural decision.

---

# 38. LOCAL UI STATE

Use local widget state for small temporary UI behavior such as:

* selected tab
* expanded section
* temporary toggle
* animation state
* text input state

Do not make every UI state global.

---

# 39. FEATURE STATE

Use feature state for:

* loaded feature data
* feature workflows
* selected entities
* loading/error states
* feature actions

---

# 40. GLOBAL STATE

Global state should be limited to genuinely global information.

Examples:

* authentication state
* current learner
* global settings
* application-level configuration

Do not put temporary screen state into global providers.

---

# 41. NO GIANT PROVIDER

Avoid a provider that owns the entire application.

Bad:

```text
YoutopperProvider
```

containing:

* Home
* Learn
* Planner
* Practice
* Revision
* Profile
* Settings
* Progress

Feature state should remain feature-oriented.

---

# 42. BUSINESS LOGIC RULE

Business logic must not be scattered across widgets.

Avoid large amounts of logic inside:

```text
build()
onPressed()
onTap()
```

Move meaningful logic into:

* provider/state
* feature logic
* repository
* use case where justified

---

# 43. NO BUSINESS LOGIC IN PRESENTATION

Presentation should answer:

> “How do I display this?”

Business/application logic should answer:

> “What should happen?”

---

# 44. USE CASE RULE

Use cases are optional.

Create one when:

* logic is non-trivial
* logic is reused
* logic requires isolated testing
* workflow complexity justifies it

Do not create a use-case class for every method.

---

# 45. REPOSITORY RULE

Repositories should provide a controlled data boundary.

UI must not directly call:

* Firestore
* HTTP clients
* local databases
* storage SDKs

from presentation widgets.

---

# 46. DATA SOURCE RULE

Data sources handle actual storage/retrieval.

Possible future sources:

* local
* Firebase
* API
* cache

The UI must remain independent from the implementation.

---

# 47. FIREBASE RULE

When Firebase is eventually introduced:

```text
UI
 ↓
Provider
 ↓
Repository
 ↓
Firebase Data Source
```

Never:

```text
UI
 ↓
Firestore
```

---

# 48. API RULE

When APIs are eventually introduced:

* isolate API clients
* isolate DTOs if required
* map API responses to application models
* do not expose HTTP response objects to widgets

---

# 49. AI SERVICE RULE

If AI is eventually introduced:

```text
UI
 ↓
Feature State
 ↓
AI Service / Repository
 ↓
AI Provider
```

Do not call an AI API directly from a widget.

---

# 50. NO SECRET KEYS IN CODE

Never commit:

* API keys
* private tokens
* service credentials
* passwords
* private Firebase credentials

into source code.

---

# 51. DEPENDENCY RULE

Before adding a package:

1. Check whether Flutter already provides the functionality.
2. Check whether the project already has an equivalent package.
3. Determine whether the dependency solves a real problem.
4. Consider maintenance risk.
5. Consider build-size impact.
6. Consider architectural complexity.

If the package is unnecessary:

> Do not add it.

---

# 52. NO PACKAGE FOR SIMPLE UI

Do not add packages merely for:

* rounded cards
* gradients
* shadows
* basic animations
* ordinary navigation
* simple forms
* simple validation

Prefer Flutter's existing capabilities when sufficient.

---

# 53. DEPENDENCY APPROVAL

A new dependency that materially affects architecture should be explicitly reviewed before adoption.

Examples:

* state management
* database
* networking
* authentication
* animation framework
* routing framework

---

# 54. NO GLOBAL THEME CHANGES FOR LOCAL PROBLEMS

If one screen has a visual problem:

> Fix the screen locally first.

Do not modify the global theme merely to solve one component.

Global changes require evidence that the design-system level is actually wrong.

---

# 55. LOCKED DESIGN SYSTEM PROTECTION

Do not casually modify:

* typography
* colors
* spacing
* radii
* shadows
* navigation
* global buttons
* shared cards

because one screen looks imperfect.

---

# 56. SCREEN DESIGN SOURCE OF TRUTH

When a finalized screen design/screenshot exists:

> It is the visual source of truth for that screen.

Implementation should reproduce the approved design faithfully.

---

# 57. SCREENSHOT DOES NOT MEAN PIXEL-PASTE

A screenshot is a visual reference, not permission to create:

* hard-coded pixel layouts
* fragile absolute positioning
* inaccessible text
* non-responsive UI

The implementation must preserve the intended visual hierarchy while behaving correctly across devices.

---

# 58. MODERNIZATION RULE

Implementation should not be a low-quality screenshot recreation.

Approved UI should be implemented as:

> **The same approved design, executed as a modern, responsive, production-quality Flutter interface.**

This includes:

* proper elevation
* correct typography
* meaningful color
* subtle texture
* responsive layout
* polished interactions
* appropriate animation

without redesigning the product.

---

# 59. NO UNAPPROVED REDESIGN

Do not change:

* hierarchy
* primary CTA
* content
* navigation
* section structure
* information architecture

just because another design seems better.

Suggest improvements separately.

Do not silently implement them.

---

# 60. TEXTURE RULE

Texture may be used where approved.

Acceptable:

* subtle dot matrix
* subtle grain
* knowledge-network texture
* low-opacity background pattern

Avoid:

* noisy textures
* decorative backgrounds that reduce readability
* excessive visual noise

---

# 61. ELEVATION RULE

Elevation must communicate hierarchy.

Use:

* primary surfaces
* secondary surfaces
* inset surfaces
* pressed states

Avoid:

* every component floating
* excessive shadows
* plastic/cardboard appearance

---

# 62. COLOR RULE

Color should communicate:

* hierarchy
* interaction
* status
* emphasis

Do not add random colors to make a screen “more attractive”.

---

# 63. MOTION RULE

Motion must have a purpose.

Use animation for:

* state changes
* transitions
* progress
* feedback
* continuity

Avoid:

* unnecessary bouncing
* long animations
* flashy effects
* animation everywhere

---

# 64. ANIMATION PERFORMANCE

Animations must remain appropriate for mobile devices.

Avoid unnecessary:

* expensive painters
* continuous animations
* large blur effects
* excessive rebuilds

Animations should be subtle and performant.

---

# 65. RESPONSIVE DESIGN RULE

Every implemented screen must work on:

* small phones
* normal phones
* larger screens

Never assume one fixed screen size.

---

# 66. NO FIXED-LAYOUT DEPENDENCY

Avoid unnecessary:

```text
Positioned
hard-coded widths
hard-coded heights
overflow-prone rows
```

especially for major content.

Use:

* Flexible
* Expanded
* constraints
* scrolling
* wrapping
* adaptive layout

where appropriate.

---

# 67. BOTTOM DOCK SAFETY

The floating bottom navigation must never cover important content.

Scrollable screens must provide appropriate bottom padding.

---

# 68. ACCESSIBILITY RULE

Every interactive element should have:

* meaningful label
* sufficient tap target
* readable contrast
* understandable selected state

Do not rely exclusively on color to communicate meaning.

---

# 69. CONTENT RULE

UI text must be:

* concise
* clear
* student-friendly
* action-oriented

Avoid unnecessarily technical copy.

---

# 70. NO PLACEHOLDER COPY IN FINALIZED UI

Avoid:

```text
Lorem ipsum
Test text
Sample title
Placeholder
Coming soon
```

unless explicitly required during temporary development.

---

# 71. PRODUCT COPY CONSISTENCY

Use the product language defined in the PRD.

Examples:

```text
Start Learning
Continue
Revise
Practice
Explore More Methods
```

Do not randomly rename established product concepts.

---

# 72. NO GENERIC EDUCATION SYMBOLS

Do not introduce generic visual clichés such as:

* graduation-cap logos
* random books
* stock student illustrations
* generic education clip art

unless explicitly approved.

Use YOUTOPPER's own visual language.

---

# 73. OFFICIAL BRAND ASSET

Use the canonical YOUTOPPER logo:

```text
assets/images/youtopper_logo.png
```

Do not recreate or replace it with an arbitrary icon.

---

# 74. SCREEN RESPONSIBILITY RULE

Every screen must have a clear answer to:

> “Why does this screen exist?”

If two screens answer the same question, reconsider whether both are necessary.

---

# 75. SCREEN CONSOLIDATION RULE

Prefer states, sections, tabs, and sheets when they are sufficient.

Do not create separate screens for every minor action.

---

# 76. NO SCREEN EXPLOSION

Do not create a new screen for:

* editing one field
* selecting a filter
* confirming an action
* viewing one small piece of information
* temporary feedback

unless the UX genuinely requires a full-screen context.

---

# 77. HOME SCREEN RULE

Home is the daily command center.

Its primary responsibility is:

> **What should I do now?**

Do not turn Home into:

* analytics dashboard
* feature catalog
* settings page
* giant notification feed
* generic card wall

---

# 78. LEARN HUB RULE

Learn answers:

> **What do I want to learn?**

It is discovery.

It is not the full lesson.

---

# 79. TOPIC / CONCEPT RULE

Topic/Concept answers:

> **What is this concept and why should I learn it?**

It is an overview.

It is not the full lesson.

---

# 80. CONCEPT LEARNING RULE

Concept Learning answers:

> **Teach me this concept.**

It must prioritize comprehension.

It should not become:

* a generic article page
* a practice engine
* an analytics dashboard
* an AI chatbot

---

# 81. LEARNING VISUAL RULE

When visual representation improves understanding:

> Prefer meaningful visuals.

Examples:

* relationships
* tables
* flows
* transformations
* highlighted values
* concept maps

Do not add decorative graphics that communicate nothing.

---

# 82. PRACTICE RULE

Practice should connect to learning.

A practice session should ideally identify:

* what is being practiced
* whether the student succeeded
* where improvement is needed

---

# 83. REVISION RULE

Revision should connect to learned material.

Avoid turning Revision into an unrelated generic checklist.

---

# 84. PLANNER RULE

Planner should organize meaningful learning activities.

Avoid turning it into a generic task manager detached from:

* learning
* revision
* practice
* goals

---

# 85. PROGRESS RULE

Progress should help students make decisions.

Avoid:

* meaningless charts
* fake percentages
* unnecessary statistics
* decorative analytics

---

# 86. MOTIVATION RULE

Motivation must support learning.

Do not allow:

* XP
* streaks
* badges
* rankings

to become more important than the learning activity itself.

---

# 87. NO FAKE ANALYTICS

Never fabricate:

* completion percentages
* study hours
* streaks
* accuracy
* improvement
* learning effectiveness

Demo values are allowed only as deterministic development data.

---

# 88. NO FAKE PERSONALIZATION

Do not claim:

> “This is the best method for you.”

unless the product has meaningful evidence supporting that statement.

Prefer:

> “You’re using this method.”

or:

> “This method may help with revision.”

---

# 89. EMPTY STATE RULE

Every meaningful collection should have an intentional empty state.

An empty state should contain:

1. What is empty?
2. Why does it matter?
3. What can the user do next?

---

# 90. LOADING STATE RULE

Important data-loading experiences should provide appropriate loading feedback.

Avoid freezing the UI without explanation.

---

# 91. ERROR STATE RULE

Errors should be:

* understandable
* contextual
* actionable

Example:

> Unable to load your revision items.

CTA:

> Retry

Avoid technical error dumps in the user interface.

---

# 92. UNKNOWN STATE RULE

Unexpected or incomplete data should produce a safe fallback.

The application must prioritize stability.

---

# 93. TESTING RULE

Every meaningful implementation must include appropriate tests.

At minimum, test:

* primary rendering
* key interaction
* navigation
* state changes
* empty state where applicable
* edge cases where relevant

---

# 94. DO NOT DELETE TESTS TO PASS

Never remove or weaken existing tests simply because a new implementation causes them to fail.

Instead:

1. understand why the test fails
2. determine whether behavior intentionally changed
3. update the test only if the product behavior changed intentionally
4. preserve regression protection

---

# 95. TEST BEHAVIOR, NOT IMPLEMENTATION DETAILS

Tests should verify:

> What the user experiences.

rather than:

> Internal implementation trivia.

---

# 96. ANALYZE BEFORE CLAIMING SUCCESS

After meaningful code changes, run appropriate static analysis.

For Flutter this generally means:

```text
flutter analyze
```

A successful compile alone is not sufficient evidence of quality.

---

# 97. TEST BEFORE LOCKING

Before declaring a screen complete:

* analyze
* run relevant tests
* launch the application
* verify runtime behavior
* verify navigation
* verify visual behavior

---

# 98. RUNTIME VERIFICATION RULE

A screen is not complete merely because:

```text
flutter analyze
```

passes.

It must be verified in actual runtime where practical.

Check:

* startup
* navigation
* interaction
* scrolling
* overflow
* state transitions
* bottom navigation
* responsiveness

---

# 99. VISUAL VERIFICATION RULE

For visually important screens, inspect the actual rendered screen.

Check:

* spacing
* typography
* hierarchy
* contrast
* elevation
* colors
* animations
* responsiveness
* clipping
* bottom navigation overlap

---

# 100. REGRESSION RULE

After modifying shared code, verify affected screens.

Especially verify:

* MainShell
* bottom navigation
* theme
* shared components
* navigation
* global state

---

# 101. NO BROAD REFACTOR DURING SCREEN IMPLEMENTATION

Do not use a screen task as an excuse to:

* reorganize all folders
* rename unrelated files
* rewrite state management
* replace routing
* replace Provider
* rewrite the theme

unless the current implementation genuinely blocks the task.

---

# 102. LOCAL FIX FIRST

If a problem appears on one screen:

```text
Local fix
 ↓
Feature fix
 ↓
Shared fix
 ↓
Architecture change
```

Use the smallest scope that solves the actual problem.

---

# 103. SHARED COMPONENT MODIFICATION RULE

Before modifying a shared component, determine:

1. Is the component actually defective?
2. Does the desired behavior belong globally?
3. Will existing screens change?
4. Can the issue be solved locally?

If the issue is screen-specific:

> Fix it locally.

---

# 104. NO GLOBAL REGRESSION FOR LOCAL BEAUTIFICATION

Do not change a global component simply to make one screen look slightly better if it risks changing locked screens.

---

# 105. CODE QUALITY RULE

Code should be:

* readable
* consistent
* intentionally named
* reasonably modular
* maintainable

Avoid clever code that saves five lines but makes behavior difficult to understand.

---

# 106. NO MAGIC VALUES WHEN MEANINGFUL CONSTANTS EXIST

Avoid scattering meaningful values across code.

Examples:

* route names
* stable IDs
* design tokens
* fixed durations
* feature configuration

Use appropriate constants where they improve clarity.

Do not turn every number into a constant.

---

# 107. BUILD METHOD QUALITY

`build()` should primarily describe UI.

Do not put:

* network requests
* database operations
* expensive computation
* complicated business decisions

inside it.

---

# 108. ASYNC OPERATION RULE

Async work must have appropriate:

* loading state
* success state
* error state
* cancellation/lifecycle consideration where necessary

Do not trigger uncontrolled async work from repeated rebuilds.

---

# 109. MEMORY SAFETY

Be careful with:

* controllers
* animation controllers
* listeners
* streams
* timers
* subscriptions

Dispose resources when required.

---

# 110. PERFORMANCE RULE

Optimize real problems.

Do not prematurely optimize everything.

However, avoid obvious problems such as:

* rebuilding huge widget trees unnecessarily
* continuous expensive animations
* loading massive assets unnecessarily
* doing expensive work in build

---

# 111. IMAGE/ASSET RULE

Use appropriately sized assets.

Do not load enormous images when a smaller asset is sufficient.

Prefer optimized assets for mobile.

---

# 112. SCROLL RULE

Scrollable content must remain scrollable on smaller devices.

Do not rely on a layout that only works at the developer's emulator resolution.

---

# 113. OVERFLOW RULE

No known overflow should remain before a screen is locked.

Especially verify:

* long titles
* metadata
* buttons
* cards
* navigation labels
* small screens
* localization-sensitive text

---

# 114. TYPOGRAPHY RULE

Typography must follow the established design system.

Do not randomly change:

* font families
* weights
* letter spacing
* sizes

within individual screens without design justification.

---

# 115. DESIGN SYSTEM RULE

The design system should provide consistency.

But:

> **Consistency does not mean every screen must look identical.**

Each feature may have unique visual composition while maintaining the same underlying design language.

---

# 116. VISUAL HIERARCHY RULE

Every screen must have:

1. Primary purpose
2. Primary action
3. Secondary information
4. Supporting information

Do not give every element equal visual weight.

---

# 117. CTA RULE

Primary CTA should be obvious.

Avoid:

* five equally prominent buttons
* unclear action hierarchy
* primary CTA hidden below unnecessary content

---

# 118. INTERACTION RULE

Interactive elements should visually communicate:

* default
* pressed
* selected
* disabled
* loading
* success/error where appropriate

---

# 119. TOUCH TARGET RULE

Interactive controls should have sufficiently large touch targets for mobile use.

Do not make important actions tiny simply for visual compactness.

---

# 120. NO HIDDEN FUNCTIONALITY

Important functionality should not depend on obscure gestures unless the user is clearly taught about the gesture.

---

# 121. ACCESSIBILITY OVER DECORATION

If a decorative effect reduces:

* contrast
* readability
* interaction clarity

remove or reduce the decorative effect.

---

# 122. PRODUCT CONTENT RULE

Do not silently invent academic content that is supposed to represent real curriculum information.

Demo content may be explicitly defined for development.

Real academic content should come from:

* approved source
* user input
* configured data
* backend data when available

---

# 123. NO UNSUPPORTED ACADEMIC CLAIMS

Do not make unsupported claims such as:

> “This method guarantees better memory.”

Use careful language when scientific certainty is not established by the product's source.

---

# 124. NO UNSUPPORTED STUDENT CLAIMS

Never assume:

* what the student knows
* what the student prefers
* what they are weak at
* how effective they are
* what their ideal study method is

unless the system has meaningful data supporting it.

---

# 125. SECURITY RULE

Never expose sensitive information unnecessarily.

Avoid logging:

* passwords
* authentication tokens
* private user data
* private credentials

---

# 126. GIT / VERSION CONTROL RULE

Meaningful changes should be version-controlled.

Commits should ideally represent coherent changes.

Avoid mixing:

```text
Screen 24 implementation
+
Firebase setup
+
theme rewrite
+
unrelated bug fixes
```

in one unrelated change.

---

# 127. COMMIT SCOPE

Prefer commits such as:

```text
Implement Screen 24 concept learning experience
```

rather than:

```text
Updated everything
```

---

# 128. NO UNTRACKED EXPERIMENTAL CODE

Temporary experiments should not remain silently inside production code.

Remove or isolate them after experimentation.

---

# 129. NO DEAD CODE

Do not leave unused:

* imports
* widgets
* providers
* models
* services
* routes
* assets

unless there is a documented reason.

---

# 130. FILE CREATION RULE

Create a new file only when it has a clear responsibility.

Before creating one ask:

> Can this cleanly live inside an existing feature file?

If yes, prefer the existing file unless it is becoming too large or responsibilities are mixed.

---

# 131. FILE MOVEMENT RULE

Do not repeatedly move files during development.

Choose the correct feature-oriented location before implementation where reasonably possible.

---

# 132. NO TEMPORARY FLAT SCREENS

Do not create:

```text
screen24.dart
screen25.dart
test_screen.dart
new_screen.dart
final_screen.dart
final_screen2.dart
```

as temporary architecture.

Use the feature-oriented structure from the beginning.

---

# 133. NAMING RULE

Names must describe purpose.

Good:

```text
concept_learning_screen.dart
technique_detail_screen.dart
revision_session_screen.dart
```

Bad:

```text
page1.dart
screen_new.dart
abc.dart
test.dart
```

---

# 134. NO VERSIONED PRODUCTION FILES

Do not create:

```text
home_v2.dart
home_final.dart
home_final2.dart
```

Production architecture should have one canonical implementation.

---

# 135. DOCUMENTATION RULE

When an architectural decision is important enough to affect future development:

> Record it in `MEMORY.md`.

Do not rely on chat history as the only source of truth.

---

# 136. LOCKED DECISION RULE

When a product or architecture decision is explicitly locked:

* record it
* preserve it
* do not casually reopen it

---

# 137. MEMORY RULE

`MEMORY.md` should preserve:

* locked screens
* major architectural decisions
* important rejected approaches
* known project constraints
* important implementation lessons
* current development state

It should not become a duplicate PRD.

---

# 138. ANTIGRAVITY ROLE

Antigravity is an implementation agent.

Its job is to:

* inspect
* plan where required
* implement approved work
* test
* report

It is not authorized to redesign the product independently.

---

# 139. ANTIGRAVITY MUST READ CONTROL FILES

Before meaningful implementation, Antigravity should read:

```text
PRD.md
ARCHITECTURE.md
RULES.md
PHASES.md
DESIGN.md
MEMORY.md
```

and the relevant existing source code.

---

# 140. ANTIGRAVITY MUST NOT GUESS

If existing code contradicts assumptions:

> Inspect the code and follow the documented architecture.

Do not invent:

* new models
* new routes
* new patterns
* new dependencies

without justification.

---

# 141. ANTIGRAVITY SCOPE RULE

The implementation prompt should clearly define:

* target screen
* allowed files
* allowed integrations
* forbidden changes
* required tests
* expected output

Antigravity should not expand scope automatically.

---

# 142. ANTIGRAVITY NO-REDESIGN RULE

When given an approved screenshot/design:

> Implement it faithfully.

Do not silently redesign:

* hierarchy
* content
* CTA
* navigation
* information architecture

---

# 143. ANTIGRAVITY MODERNIZATION RULE

Antigravity may improve implementation quality through:

* responsive layout
* proper elevation
* meaningful texture
* smooth animation
* correct Flutter patterns
* accessibility
* clean componentization

provided the approved design direction remains intact.

---

# 144. ANTIGRAVITY NO-OVERENGINEERING RULE

Antigravity must not introduce:

* unnecessary architecture
* unnecessary packages
* unnecessary files
* unnecessary abstractions
* future infrastructure

to solve a simple current requirement.

---

# 145. STOP CONDITION

Antigravity should stop and report instead of making assumptions if implementation requires:

* major architecture changes
* replacing state management
* replacing routing
* adding backend
* adding AI
* adding a significant dependency
* modifying multiple locked screens
* changing the product flow

unless the current task explicitly authorizes it.

---

# 146. IMPLEMENTATION REPORT RULE

After implementation, the report should include:

1. What changed
2. Files created
3. Files modified
4. Files intentionally untouched
5. Dependencies added
6. Tests run
7. Analysis result
8. Runtime verification
9. Visual verification
10. Known limitations
11. Any architectural concerns

Do not claim verification that was not actually performed.

---

# 147. NO FALSE SUCCESS REPORTING

Never say:

> “Tests passed”

if tests were not run.

Never say:

> “Runtime verified”

if the application was not actually run.

Never say:

> “Screenshot matched”

if visual comparison was not performed.

---

# 148. VERIFICATION HONESTY

Reports must distinguish:

```text
Verified
Not verified
Not applicable
```

This is mandatory for trustworthy development.

---

# 149. APPROVAL GATE

For major screen implementations:

```text
Plan
 ↓
User approval
 ↓
Implementation
 ↓
Verification
 ↓
User review
 ↓
Lock
```

Do not skip the approval gate when the workflow explicitly requires it.

---

# 150. SCREEN LOCK REPORT

When a screen is approved, record:

```text
Screen
Status: LOCKED
Functional: PASS
Tests: PASS
Runtime: PASS
Visual: PASS
Responsive: PASS
```

where those checks have actually been performed.

---

# 151. NO REVISITING WITHOUT REASON

Once a screen is locked:

Do not reopen it because:

* a new design trend appeared
* another screen looks different
* a developer wants consistency in an unnecessary way
* the code could theoretically be cleaner

Only reopen for:

* explicit request
* real defect
* required architecture
* changed product requirement

---

# 152. BUG FIX RULE

Bug fixes should be:

* minimal
* targeted
* tested
* regression-safe

Do not turn a bug fix into a broad refactor unless necessary.

---

# 153. BUG PRIORITY

Prioritize:

1. Crash
2. Data corruption
3. Broken navigation
4. Broken primary action
5. Functional defect
6. Accessibility defect
7. Responsive defect
8. Visual defect
9. Minor polish

---

# 154. PRODUCT-BLOCKING BUGS

A screen must not be locked with:

* crash
* broken primary CTA
* broken navigation
* inaccessible essential content
* persistent overflow
* major state corruption

---

# 155. VISUAL POLISH RULE

Visual polish should happen after:

1. functionality
2. navigation
3. state handling
4. responsive behavior

are correct.

Do not spend hours polishing a screen whose core interaction is broken.

---

# 156. BUT QUALITY IS NOT OPTIONAL

“Functional first” does not mean:

> Ship ugly or broken UI.

The screen must eventually meet both:

```text
Functional Quality
+
Visual Quality
```

before being locked.

---

# 157. DESIGN ITERATION RULE

When design is being explored:

* explore freely before lock
* compare alternatives
* choose intentionally

After lock:

* preserve the chosen design

---

# 158. STITCH RULE

Google Stitch may be used for:

* visual exploration
* screen composition
* design experimentation

It is not the authoritative source for:

* product requirements
* architecture
* business logic
* backend
* navigation architecture

Those remain controlled by the six project documents and approved implementation decisions.

---

# 159. CHATGPT ROLE

ChatGPT acts as:

* product architect
* UX reviewer
* implementation-prompt engineer
* development manager
* architecture reviewer
* quality reviewer

ChatGPT should not encourage uncontrolled scope expansion.

---

# 160. USER ROLE

The user is the final product owner.

Final approval belongs to the user.

The user's explicit approval can:

* lock a screen
* change a product decision
* reopen a screen
* alter priorities
* override a previous decision

---

# 161. PRODUCT OWNER DECISION RULE

When the user explicitly says:

> “Lock this.”

The screen becomes locked.

When the user says:

> “Change this.”

The current approved requirement changes.

The change should be reflected in project memory when it has lasting architectural/product significance.

---

# 162. NO ASSUMPTION FROM CHAT HISTORY ALONE

Important project decisions should be recorded in the root control files.

Chat history is useful context but must not be the only permanent source of critical decisions.

---

# 163. ROOT CONTROL FILE RULE

The six control files should remain easy to locate.

They should not be hidden inside:

```text
lib/
docs/
config/
temporary/
```

They belong at the project root.

---

# 164. DO NOT DUPLICATE CONTROL DOCUMENTS

There should not be:

```text
docs/PRD.md
old/PRD.md
PRD-final.md
PRD-v2.md
```

unless explicitly required for archival purposes.

The canonical files are:

```text
PRD.md
ARCHITECTURE.md
RULES.md
PHASES.md
DESIGN.md
MEMORY.md
```

---

# 165. CONTROL FILE EDITING RULE

Do not casually rewrite the control documents during implementation.

Only modify them when:

* a lasting requirement changes
* an architectural decision changes
* development phases change
* design rules change
* important memory must be recorded
* the user explicitly requests an update

---

# 166. NO CONTRADICTORY DOCUMENTS

If a new decision invalidates an old statement:

> Update the authoritative document.

Do not leave contradictory rules in different files.

---

# 167. CHANGE IMPACT RULE

Before changing a shared architectural decision, identify affected:

* screens
* features
* state
* navigation
* tests
* documents

Do not make global changes blindly.

---

# 168. DOCUMENT CONSISTENCY RULE

When a major permanent decision changes:

```text
PRD
ARCHITECTURE
RULES
PHASES
DESIGN
MEMORY
```

must be considered for impact.

Only update documents that genuinely need the change.

---

# 169. NO OVERDOCUMENTATION IN CODE

Do not write comments that simply repeat obvious code.

Use comments for:

* architectural reasoning
* non-obvious behavior
* important constraints
* temporary decisions
* unusual workarounds

---

# 170. NO COMMENTED-OUT DEAD CODE

Do not keep large blocks of old code commented out.

Use version control to preserve history.

---

# 171. TODO RULE

TODOs should be meaningful.

Bad:

```text
TODO: fix
TODO: improve
TODO: later
```

Good:

```text
TODO: Replace demo repository with persistent repository during backend phase.
```

---

# 172. FUTURE WORK RULE

Future work belongs in:

* `PHASES.md`
* `MEMORY.md`

or an appropriate issue/task system.

Do not fill production code with speculative future hooks.

---

# 173. NO PREMATURE EXTENSIBILITY

Do not build abstractions solely because:

> “We might need this someday.”

Build extensibility when there is a credible current requirement.

---

# 174. SIMPLE FIRST RULE

When two architectures solve the current problem:

> Prefer the simpler one.

Unless the simpler solution creates clear future coupling or technical debt.

---

# 175. COMPLEXITY BUDGET

Every new abstraction has a cost.

Before introducing:

* repository
* service
* use case
* interface
* manager
* controller
* adapter

ask:

> What complexity does this remove?

If the answer is unclear:

> Do not introduce it.

---

# 176. NO ARCHITECTURE THEATER

Do not add architecture merely to make the project appear “professional”.

Professional architecture is:

* understandable
* maintainable
* testable
* appropriate
* stable

not necessarily large.

---

# 177. FEATURE COMPLETENESS RULE

A feature is not complete when its screen exists.

A feature is complete when:

* UI exists
* state exists
* required interaction exists
* navigation works
* edge states are handled
* tests exist
* runtime works
* visual verification passes

where applicable.

---

# 178. PRODUCT LOOP RULE

Always consider the surrounding journey.

For example:

```text
Learn
 ↓
Concept
 ↓
Learning
 ↓
Practice
 ↓
Revision
 ↓
Progress
```

Do not build isolated screens that have no relationship to the product loop.

---

# 179. NEXT-ACTION RULE

Whenever a user completes an important activity, the product should provide an understandable next step where appropriate.

Examples:

After learning:

> Practice

After practice:

> Review Weak Area

After revision:

> Continue Learning

After weekly review:

> Plan Next Week

The exact action depends on the feature.

---

# 180. NO FORCED ACTION

The product should suggest next actions without trapping the user.

Avoid manipulative flows.

---

# 181. NO GAMIFICATION PRESSURE

Do not force users to:

* maintain streaks
* earn points
* compete
* collect badges

to access core learning functionality.

---

# 182. NO ADVERTISEMENT-FIRST DESIGN

Core learning workflows must not be designed around advertising placement.

---

# 183. PERFORMANCE OVER EFFECTS

If an effect creates meaningful performance problems:

> reduce or remove the effect.

Do not sacrifice usability for decoration.

---

# 184. VISUAL EFFECT PRIORITY

When adding visual effects, prioritize:

```text
Hierarchy
 ↓
Meaning
 ↓
Interaction
 ↓
Depth
 ↓
Decoration
```

---

# 185. RESPONSIVENESS OVER PIXEL PERFECTION

If a screenshot uses exact dimensions:

> Preserve the visual intent, not fragile pixel coordinates.

The implementation must adapt to real devices.

---

# 186. DESIGN FIDELITY RULE

The goal is:

> **High visual fidelity + real responsive behavior.**

Not:

> **Pixel-copy one screenshot and break everything else.**

---

# 187. TEST DATA RULE

Tests should use stable, readable data.

Avoid random test data unless randomness is specifically being tested.

---

# 188. TEST ISOLATION

Tests should not depend on:

* external network
* production backend
* unstable timing
* random data

unless the test explicitly validates that integration.

---

# 189. TEST NAMING

Test names should explain behavior.

Good:

```text
shows empty state when no learning methods are selected
```

Bad:

```text
test1
```

---

# 190. NO TEST BYPASS

Do not:

* disable tests
* skip failing tests
* weaken assertions
* remove test cases

simply to achieve green output.

---

# 191. ANALYSIS RULE

Warnings and errors should be investigated.

Do not routinely leave analyzer issues unresolved.

---

# 192. BUILD RULE

The project should remain buildable throughout development.

Do not leave the repository intentionally broken between implementation stages.

---

# 193. BREAKAGE WINDOW

If a temporary breaking change is unavoidable:

* keep it as short as possible
* complete the change in one controlled operation
* verify immediately afterward

---

# 194. NO UNRELATED MODIFICATIONS

A screen task should not modify unrelated files unless:

* required by architecture
* required by navigation
* required by shared integration
* required by tests

Every unrelated modification increases regression risk.

---

# 195. FILE MODIFICATION REPORT

Implementation reports should clearly state:

```text
Created:
...

Modified:
...

Untouched:
...
```

This makes scope auditable.

---

# 196. DEPENDENCY REPORT

If a dependency is added, report:

* package name
* version
* reason
* where it is used
* why existing Flutter capabilities were insufficient

---

# 197. ARCHITECTURE CHANGE REPORT

If architecture changes, report:

* previous architecture
* new architecture
* reason
* affected features
* migration impact
* tests performed

---

# 198. STOP BEFORE SCOPE CREEP

If implementation reveals that the task is larger than expected:

> Stop and reassess.

Do not silently expand the scope.

---

# 199. ASK WHEN A DECISION IS PRODUCT-LEVEL

If a technical decision changes:

* user flow
* screen responsibility
* product behavior
* navigation
* core architecture

it should be surfaced for approval rather than silently decided during implementation.

---

# 200. DO NOT ASK FOR UNNECESSARY APPROVAL

Not every implementation detail requires user approval.

Do not interrupt development for:

* variable names
* private helper names
* small widget extraction
* ordinary layout implementation
* obvious bug fixes

Approval is required for meaningful product/architecture changes.

---

# 201. IMPLEMENTATION PRIORITY

When implementing a screen, prioritize:

```text
1. Correct product behavior
2. Correct architecture
3. Correct navigation
4. Correct state
5. Responsive behavior
6. Accessibility
7. Visual fidelity
8. Micro-polish
```

All must eventually reach the required quality bar before lock.

---

# 202. REVIEW PRIORITY

When reviewing a completed screen:

```text
1. Does it solve the intended problem?
2. Does the user understand what to do?
3. Does the primary flow work?
4. Does navigation work?
5. Are important states handled?
6. Is it responsive?
7. Is it accessible?
8. Does it match the approved design?
9. Is the visual polish appropriate?
10. Did implementation introduce unnecessary complexity?
```

---

# 203. LOCK CRITERIA

A screen can be locked when:

* intended functionality works
* primary interactions work
* navigation works
* no critical errors remain
* no known overflow remains
* tests pass
* analysis passes
* runtime is verified
* visual review is complete
* responsive behavior is acceptable
* scope is clean
* user approves the result

---

# 204. LOCKED MEANS LOCKED

After lock:

> Do not continuously polish.

The project must continue moving forward.

Revisit only when there is a meaningful reason.

---

# 205. PRODUCT-FIRST RULE

When a technical decision conflicts with the actual student experience:

> Reconsider the technical decision.

Architecture exists to support the product.

---

# 206. ENGINEERING-FIRST RULE

When a quick UI solution creates severe long-term coupling:

> Reconsider the quick solution.

Product speed must not create avoidable architectural damage.

---

# 207. BALANCE RULE

The correct YOUTOPPER approach is:

```text
Product quality
+
Engineering discipline
+
Controlled scope
+
Visual quality
```

None should completely dominate the others.

---

# 208. FINAL DEVELOPMENT PRINCIPLE

YOUTOPPER should be developed according to:

> **Build deliberately. Inspect before changing. Reuse before creating. Keep responsibilities clear. Work one vertical slice at a time. Verify before locking. Never silently expand scope.**

---

# 209. ABSOLUTE PROHIBITIONS

Unless explicitly authorized, do not:

* introduce Firebase during frontend-only development
* introduce AI APIs during frontend-only development
* introduce external APIs during frontend-only development
* replace Provider
* replace routing architecture
* redesign MainShell
* redesign locked screens
* create duplicate models
* create duplicate navigation
* create random demo data
* fabricate analytics
* fabricate personalization
* create fake AI
* create unnecessary screens
* add unnecessary packages
* perform broad refactors during screen implementation
* delete tests to make them pass
* claim tests passed when they were not run
* claim runtime verification when it was not performed
* claim visual verification when it was not performed
* silently modify product requirements

---

# 210. FINAL RULE

Above all:

> **YOUTOPPER is a product, not a code-generation exercise.**

The objective is not:

> “How much code can we generate?”

The objective is:

> **“Can we build a coherent, useful, trustworthy, production-quality learning product without losing control of the project?”**

Every implementation decision should support that objective.

---

# END OF RULES
