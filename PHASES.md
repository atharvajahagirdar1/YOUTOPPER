# YOUTOPPER — PHASES.md

## Project Development Phases & Execution Roadmap

**Project:** YOUTOPPER
**Platform:** Flutter Mobile Application
**Primary Target:** Android / Google Play
**Development Model:** Frontend-first, vertical-slice, screen-by-screen
**Backend Status:** Deferred until frontend is complete and verified
**Architecture Principle:** Feature-oriented, scalable, maintainable, no overengineering

---

# 1. PURPOSE OF THIS DOCUMENT

This document defines the official development phases for the YOUTOPPER application.

It answers:

* What should be built first?
* What should be built next?
* Which features belong to which phase?
* When should backend development begin?
* When should screens be locked?
* What must be verified before moving forward?
* What work is explicitly forbidden before its appropriate phase?
* How should ChatGPT, Antigravity, and the developer coordinate?
* What constitutes completion of a phase?

This document is a **development sequencing document**.

It does not replace:

* `PRD.md` — what YOUTOPPER is
* `ARCHITECTURE.md` — how YOUTOPPER is structured
* `RULES.md` — how development must be performed
* `DESIGN.md` — how YOUTOPPER should look and feel
* `MEMORY.md` — important project decisions and historical context

---

# 2. DEVELOPMENT PHILOSOPHY

YOUTOPPER will not be developed as one giant implementation task.

Development will proceed through controlled vertical slices.

The fundamental process is:

```text
Plan
  ↓
Inspect
  ↓
Design
  ↓
Review
  ↓
Implement
  ↓
Test
  ↓
Run
  ↓
Visually Verify
  ↓
Fix
  ↓
Lock
  ↓
Move Forward
```

The project must always prefer:

> **One completed and verified part over many partially completed parts.**

---

# 3. MASTER DEVELOPMENT STRATEGY

The complete project is divided into the following major phases:

```text
PHASE 0 — Project Control & Preparation
        ↓
PHASE 1 — Foundation & Design System
        ↓
PHASE 2 — Entry & Authentication
        ↓
PHASE 3 — Learner Setup
        ↓
PHASE 4 — Core Learning Vertical Slice
        ↓
PHASE 5 — Learn How to Learn
        ↓
PHASE 6 — Revision
        ↓
PHASE 7 — Practice
        ↓
PHASE 8 — Planner
        ↓
PHASE 9 — Progress & Weekly Review
        ↓
PHASE 10 — Notifications
        ↓
PHASE 11 — Profile, Settings & Support
        ↓
PHASE 12 — Search & Cross-Feature Integration
        ↓
PHASE 13 — Frontend Completion & Product Audit
        ↓
PHASE 14 — Backend & Persistence
        ↓
PHASE 15 — Production Hardening
        ↓
PHASE 16 — Release Preparation
        ↓
PHASE 17 — Google Play Deployment
        ↓
PHASE 18 — Post-Launch Validation & Iteration
```

The exact order of individual screens may be adjusted only when there is a legitimate architectural dependency.

---

# 4. PHASE STATUS SYSTEM

Every phase must have one of these states:

### NOT STARTED

No implementation work has begun.

### PLANNED

Scope and implementation approach are defined.

### IN PROGRESS

Implementation is actively being performed.

### VERIFICATION

Implementation exists and is undergoing:

* static analysis
* testing
* runtime verification
* visual verification
* responsive verification

### COMPLETE

All required acceptance criteria have passed.

### LOCKED

The phase is approved and should not be casually modified.

### BLOCKED

Progress cannot continue because a dependency or unresolved issue exists.

---

# 5. SCREEN STATUS SYSTEM

Every screen follows the same lifecycle:

```text
UNPLANNED
   ↓
PLANNED
   ↓
DESIGNING
   ↓
DESIGN APPROVED
   ↓
IMPLEMENTING
   ↓
TESTING
   ↓
VISUAL VERIFICATION
   ↓
APPROVED
   ↓
LOCKED
```

A screen must not be considered complete merely because Flutter renders it.

---

# 6. SCREEN LOCK RULE

Once a screen is approved and locked:

* do not redesign it casually
* do not change its visual language
* do not refactor it unnecessarily
* do not change its navigation unnecessarily
* do not modify it merely because a later screen uses a different approach
* do not reopen it for aesthetic experimentation

A locked screen may be modified only when:

1. A genuine defect is discovered.
2. A required integration dependency exists.
3. An accessibility problem is discovered.
4. A responsive problem is discovered.
5. A security/data-flow problem requires it.
6. The product owner explicitly requests a change.

---

# 7. PHASE 0 — PROJECT CONTROL & PREPARATION

## Objective

Establish a controlled development environment before feature development.

## Required control files

The project root must contain:

```text
PRD.md
ARCHITECTURE.md
RULES.md
PHASES.md
DESIGN.md
MEMORY.md
```

These files form the project's control layer.

## Required actions

* verify Flutter project
* verify Dart configuration
* verify project name
* verify package/application identity
* verify source structure
* verify assets
* verify existing navigation
* verify theme
* verify dependencies
* verify test configuration
* verify Git repository
* verify Android configuration
* verify application launches

## Important rule

No feature development should proceed if the project foundation is broken.

## Exit criteria

* project launches
* Flutter environment works
* no unexplained build failure
* control documents exist
* architecture is understood
* development rules are established
* baseline screenshot/runtime verification is possible

---

# 8. PHASE 1 — FOUNDATION & DESIGN SYSTEM

## Objective

Create the technical and visual foundation required by all future screens.

## Scope

### Application foundation

* Flutter Material 3
* application entry point
* root navigation
* MainShell
* primary navigation
* route structure
* feature folders
* shared constants
* shared theme
* typography
* spacing
* reusable primitives

### Visual foundation

YOUTOPPER's design language:

* deep navy foundation
* restrained blue accent
* controlled indigo
* semantic supporting colors
* premium typography
* rounded surfaces
* restrained neumorphic depth
* subtle elevation
* intentional whitespace
* tactile interaction states
* subtle textures
* purposeful motion

## Navigation

Primary bottom navigation:

```text
Home
Learn
Learn How to Learn
Planner
Progress
```

Global shell must be established once.

Do not create separate bottom navigation implementations per screen.

## Exit criteria

* MainShell works
* bottom navigation works
* navigation architecture is stable
* design primitives are reusable
* no duplicate root navigation
* responsive foundation works
* accessibility baseline exists
* project passes analysis/tests

---

# 9. PHASE 2 — ENTRY & AUTHENTICATION

## Objective

Build the complete application entry flow.

## Screens

```text
1. Splash
2. Onboarding — Welcome
3. Onboarding — Learn Smarter
4. Onboarding — Stay Consistent
5. Onboarding — Achieve More
6. Welcome / Authentication Choice
7. Sign In
8. Create Account
9. Forgot Password
10. Email Verification
```

## Version 1 frontend behavior

During frontend-first development:

* use deterministic local/demo authentication state
* do not introduce Firebase
* do not introduce backend authentication
* do not introduce API calls

The UI and navigation must be designed so real authentication can replace demo behavior later.

## Required flow

```text
Splash
 ↓
Onboarding
 ↓
Authentication Choice
 ├── Sign In
 └── Create Account
       ↓
Email Verification
       ↓
Learner Setup
```

## Required validation

* navigation
* form validation
* keyboard behavior
* password visibility
* error states
* loading states
* responsive layout
* accessibility
* back behavior

## Exit criteria

The complete entry flow works using local/demo state.

---

# 10. PHASE 3 — LEARNER SETUP

## Objective

Collect enough information to establish the learner's academic/learning context.

## Screens

```text
11. Personal Information
12. Learner Type
13. Academic / Learning Context
14. Goals & Study Preferences
15. Profile Review
16. Learning Setup
17. Subject Selection
18. Syllabus Overview
19. Subject Detail
20. Topic Detail
```

## Learner types

The system must support different learning contexts, including:

* school
* college/university
* postgraduate/master's
* competitive examination
* certification
* self-learning

YOUTOPPER must not assume every learner follows a university syllabus.

## Setup flow

```text
Personal Information
        ↓
Learner Type
        ↓
Academic / Learning Context
        ↓
Goals & Study Preferences
        ↓
Profile Review
        ↓
Learning Setup
        ↓
Subject Selection
        ↓
Syllabus Overview
        ↓
Subject Detail
        ↓
Topic Detail
```

## Important principle

Setup should collect useful information without becoming unnecessarily long or complicated.

## Exit criteria

A demo learner can successfully complete setup and reach the core application.

---

# 11. PHASE 4 — CORE LEARNING VERTICAL SLICE

## Objective

Build the most important product loop:

> **Discover → Understand → Learn**

This is the first major end-to-end product vertical slice.

## Screens

```text
21. Home / Smart Workspace
22. Learn Hub
23. Topic / Concept
24. Concept Learning Experience
25. Saved Concepts
```

---

## 11.1 Screen 21 — Home / Smart Workspace

Purpose:

> “What should I study right now?”

The Home screen is the daily command center.

Required sections:

1. Greeting
2. What should I study right now?
3. Primary learning recommendation
4. Today's progress
5. Continue Learning
6. Needs Attention
7. Coming Up
8. Workspace Portals

### Deterministic demo data

Example:

* Student: Atharva
* Goal: 3 hours
* Completed: 2h 10m
* Progress: 72%
* Sessions: 2
* Revision remaining: 1
* Primary concept: Database Normalization
* Continue: Operating Systems — Process Management
* Attention: Data Structures Trees
* Practice: DBMS Normalization
* Upcoming: OS Scheduling
* Upcoming practice: DBMS Unit Test

No fake AI reasoning.

---

# 11.2 Screen 22 — Learn Hub

Purpose:

> “What do I want to learn?”

The Learn Hub is the discovery layer.

It must provide access to:

* subjects
* learning topics
* concepts
* saved learning
* relevant learning paths

The screen must not become a generic dashboard.

---

# 11.3 Screen 23 — Topic / Concept

Purpose:

> “What is this concept, why does it matter, and what can I do with it?”

Current approved concept example:

**Database Normalization**

Context:

**DATABASE MANAGEMENT SYSTEMS · CHAPTER 3**

Details:

* 25 min
* Intermediate
* Concept + Examples

Primary CTA:

**Start Learning →**

---

# 11.4 Screen 24 — Concept Learning Experience

Purpose:

> “Teach me this concept.”

Learning rhythm:

```text
Explanation
 ↓
Visual
 ↓
Example
 ↓
Understanding Check
 ↓
Remember
 ↓
Continue
```

The learning experience should emphasize comprehension rather than document-style reading.

---

# 11.5 Screen 25 — Saved Concepts

Purpose:

Allow learners to return to concepts they intentionally saved.

Frontend-first state:

* deterministic local state
* no cloud persistence

---

## Vertical slice acceptance criteria

A learner must be able to:

```text
Home
 ↓
Learn Hub
 ↓
Topic / Concept
 ↓
Concept Learning Experience
 ↓
Understand concept
 ↓
Return / Continue
```

The flow must feel coherent.

---

# 12. PHASE 5 — LEARN HOW TO LEARN

## Objective

Help students learn effective learning methods.

## Screens

```text
26. Learn How to Learn
27. Technique Detail
28. Technique Application
```

## Product role

This feature is not another content library.

It teaches learners:

* how learning works
* how to remember
* how to understand
* how to revise
* how to practice effectively

## Example techniques

Potential techniques include:

* Active Recall
* Spaced Repetition
* Feynman Technique
* Interleaving
* Elaboration
* Retrieval Practice

Existing technique data must be reused.

Do not duplicate technique models.

## Screen relationship

```text
Learn How to Learn
        ↓
Technique Detail
        ↓
Technique Application
```

## Personal methods

The future personal learning-method workspace may reference selected technique IDs.

It must not create a second competing technique data model.

## Exit criteria

Learner can discover, understand, and apply learning techniques.

---

# 13. PHASE 6 — REVISION

## Objective

Help students revisit previously learned material systematically.

## Screens

```text
29. Revision
30. Revision Session
```

## Revision screen

Should organize:

* due today
* upcoming
* history
* concepts needing revision

## Revision Session

May contain different modes/states:

* flashcard reveal
* active recall
* answer checking
* session completion

These are states of Revision Session, not separate screens.

## Important rule

Do not create a separate screen for every revision interaction.

## Frontend-first state

Use deterministic local data.

Do not introduce real spaced-repetition persistence until the backend phase.

---

# 14. PHASE 7 — PRACTICE

## Objective

Allow learners to apply knowledge through questions and problems.

## Screens

```text
31. Practice Hub
32. Practice Session
33. Practice Results
```

## Practice Hub

Can provide:

* subject practice
* topic practice
* curated problems
* saved practice
* recommended practice

## Practice Session

Contains:

* question
* options/input
* answer submission
* explanation
* navigation
* progress

## Practice Results

Contains:

* correct answers
* incorrect answers
* explanations
* topics requiring review
* next actions

## Prohibition

Do not introduce:

* competitive rankings
* fake XP
* fake scores beyond actual session results
* unnecessary gamification

---

# 15. PHASE 8 — PLANNER

## Objective

Help learners answer:

> “What should I study and when?”

## Screens

```text
34. Planner
35. Focus Session
```

## Planner

The main Planner screen may provide:

* Today
* Week
* Calendar
* study tasks
* revision tasks
* practice tasks
* focus sessions

Creation/editing should use:

* bottom sheets
* dialogs
* inline states

rather than unnecessary new screens.

## Focus Session

Purpose:

Provide a focused study execution mode.

It may contain:

* current task
* timer/focus state
* progress
* completion
* pause/resume
* exit

## Exit criteria

Learner can create/select a study task and enter a focused study session.

---

# 16. PHASE 9 — PROGRESS & WEEKLY REVIEW

## Objective

Show meaningful progress without becoming an analytics dashboard.

## Screens

```text
37. Progress
38. Weekly Review
```

---

## 16.1 Progress

May contain:

* learning progress
* study activity
* subject progress
* completion
* performance
* revision activity

Use meaningful data only.

Avoid:

* decorative charts
* fake percentages
* fake trends
* meaningless analytics

---

## 16.2 Weekly Review

Combines:

* study summary
* consistency
* goals
* achievements
* milestones
* streak

The information must be grounded in available data.

---

# 17. PHASE 10 — NOTIFICATIONS

## Objective

Provide a central place for learner notifications.

## Screen

```text
39. Notifications
```

Possible categories:

* study reminders
* revision reminders
* practice reminders
* system messages

Notification detail can be:

* expanded state
* bottom sheet
* deep-linked destination

Do not create a separate detail screen unless a real requirement appears.

---

# 18. PHASE 11 — PROFILE, SETTINGS & SUPPORT

## Objective

Complete the account and support experience.

## Screens

```text
40. Profile
41. Settings
42. Help & Support
43. About / Legal
```

## Profile

May include:

* personal information
* learner information
* goals
* learning preferences
* account information

## Settings

May contain:

* appearance
* notifications
* study preferences
* accessibility
* account controls
* privacy
* application settings

## Help & Support

Provide:

* FAQs
* contact/support entry
* issue reporting
* guidance

## About / Legal

Provide:

* About YOUTOPPER
* Terms
* Privacy
* application information

---

# 19. PHASE 12 — SEARCH & CROSS-FEATURE INTEGRATION

## Objective

Connect the product's separate learning areas into a coherent system.

## Screen

```text
44. Search
```

## Search should eventually cover

Where appropriate:

* subjects
* topics
* concepts
* saved concepts
* learning techniques
* revision content
* practice content

## Cross-feature integration

Verify:

```text
Home
 ↕
Learn
 ↕
Revision
 ↕
Practice
 ↕
Planner
 ↕
Progress
 ↕
Learn How to Learn
```

Features should not feel like disconnected mini-applications.

---

# 20. PHASE 13 — FRONTEND COMPLETION & PRODUCT AUDIT

## Objective

Finish the entire frontend before introducing backend infrastructure.

This is a mandatory gate.

## Required audit areas

### Navigation

Verify every intended navigation path.

### UI consistency

Verify:

* typography
* spacing
* colors
* elevation
* buttons
* cards
* bottom navigation
* app bars
* sheets
* dialogs

### Responsive behavior

Test:

* small phones
* normal phones
* larger screens

### Accessibility

Verify:

* contrast
* tap targets
* semantics
* readable text
* focus behavior
* non-color-only communication

### Empty states

Verify all major features.

### Error states

Verify:

* invalid input
* unavailable content
* failed local operations
* unexpected state

### Loading states

Verify where appropriate.

### No Internet

Frontend must gracefully represent unavailable network-dependent functionality even before backend integration.

### Performance

Check:

* scrolling
* animation smoothness
* large lists
* image loading
* unnecessary rebuilds

---

# 21. PHASE 13 PRODUCT LOOP AUDIT

The following user journeys must work coherently:

## Journey 1 — Daily learning

```text
Home
 ↓
Recommended Topic
 ↓
Concept
 ↓
Learning Experience
 ↓
Completion
```

## Journey 2 — Discover learning

```text
Learn
 ↓
Subject
 ↓
Topic
 ↓
Concept
 ↓
Learning
```

## Journey 3 — Revision

```text
Home / Revision
 ↓
Due Concept
 ↓
Revision Session
 ↓
Result
 ↓
Next Action
```

## Journey 4 — Practice

```text
Home / Practice
 ↓
Practice Hub
 ↓
Practice Session
 ↓
Results
 ↓
Revision / Learning
```

## Journey 5 — Planning

```text
Planner
 ↓
Study Task
 ↓
Focus Session
 ↓
Completion
 ↓
Progress
```

## Journey 6 — Learning methods

```text
Learn How to Learn
 ↓
Technique
 ↓
Application
```

---

# 22. PHASE 14 — BACKEND & PERSISTENCE

## IMPORTANT GATE

Backend development begins **only after the frontend product is complete and audited**.

The backend must not be introduced merely because a screen contains a button that could eventually require persistence.

## Potential backend responsibilities

Depending on final architecture:

* authentication
* learner profile persistence
* academic data
* syllabus data
* subjects
* topics
* saved concepts
* learning methods
* study plans
* revision state
* practice results
* progress
* notifications
* synchronization

## Firebase / backend integration

The exact backend technology must follow the final architecture decision.

Do not add backend services prematurely.

## Migration principle

Replace deterministic local repositories/data sources with real repositories while preserving:

* UI
* feature boundaries
* domain models
* navigation
* user experience

Backend integration should not require redesigning the entire application.

---

# 23. PHASE 15 — PRODUCTION HARDENING

## Objective

Prepare the application for real-world usage.

## Areas

### Security

Verify:

* authentication
* authorization
* data access
* secure configuration
* secrets
* storage rules
* API access

### Reliability

Handle:

* network failures
* retries
* invalid data
* partial failures
* session expiration
* unavailable services

### Performance

Measure and optimize:

* startup
* scrolling
* database operations
* images
* memory
* unnecessary rebuilds
* network usage

### Data integrity

Verify:

* duplicate prevention
* missing references
* deleted content
* stale data
* synchronization

---

# 24. PHASE 16 — RELEASE PREPARATION

## Objective

Prepare a production Android build.

## Required areas

### Application identity

Verify:

* application ID
* app name
* version
* launcher icon
* splash
* package metadata

### Release configuration

Verify:

* signing
* release build
* ProGuard/R8 where applicable
* permissions
* manifest
* assets

### Store assets

Prepare:

* app icon
* screenshots
* feature graphics
* store description
* short description
* privacy policy
* support information

### Quality checks

Run:

* Flutter analyze
* tests
* release build
* installation test
* clean-install test
* upgrade test where applicable

---

# 25. PHASE 17 — GOOGLE PLAY DEPLOYMENT

## Objective

Publish YOUTOPPER as a real Android application.

## Deployment stages

```text
Internal Testing
      ↓
Closed Testing
      ↓
Production Readiness
      ↓
Production Release
```

## Verify before production

* authentication
* core learning
* revision
* practice
* planner
* progress
* notifications
* account
* privacy
* support
* crash-free startup
* release configuration

---

# 26. PHASE 18 — POST-LAUNCH VALIDATION

## Objective

Improve YOUTOPPER based on real usage rather than assumptions.

## Monitor

Where legally and technically appropriate:

* crashes
* performance
* navigation problems
* feature usage
* retention
* user feedback
* onboarding friction
* learning workflow friction

## Important principle

Do not immediately add features because they sound impressive.

First identify:

> What real student problem is still unresolved?

Then prioritize changes.

---

# 27. FEATURE PRIORITY

When multiple features compete for implementation time, prioritize according to the product's core student problems.

Highest priority:

1. Knowing what to study
2. Understanding concepts
3. Remembering what was studied
4. Revising consistently
5. Learning how to study effectively

Then:

6. Staying consistent
7. Organizing resources
8. Identifying weak areas
9. Measuring improvement
10. Reducing planning effort

Features that do not meaningfully support these problems should not automatically receive implementation priority.

---

# 28. FRONTEND-FIRST RULE

Before backend integration:

### Allowed

* local state
* deterministic demo data
* mock repositories
* static content
* local state management
* UI validation
* navigation
* animations
* responsive behavior
* accessibility
* local persistence only when necessary for frontend behavior

### Not allowed

* Firebase
* Firestore
* Firebase Authentication
* REST APIs
* AI APIs
* external cloud services
* production analytics
* remote recommendation engines

unless the current development phase explicitly permits them.

---

# 29. DETERMINISTIC DEMO DATA RULE

Demo data must be deterministic.

Do not use:

* random selection
* random user states
* random percentages
* random recommendations
* fake AI-generated decisions
* time-dependent fake behavior

The same application state should produce the same expected result.

This makes:

* testing easier
* screenshots stable
* debugging easier
* demonstrations reliable
* implementation predictable

---

# 30. NO FAKE INTELLIGENCE RULE

Before real intelligence/backend exists, YOUTOPPER must not pretend that a recommendation came from an intelligent system if it is actually hardcoded.

If a screen requires a recommendation, use clearly defined deterministic demo logic.

Example:

```text
Demo recommendation:
Database Normalization
```

is acceptable.

Pretending:

```text
YOUTOPPER AI analyzed your behavior and determined...
```

is not acceptable when no such system exists.

---

# 31. VERTICAL SLICE RULE

Every major feature should be built as a vertical slice.

Example:

```text
Screen
 ↓
State
 ↓
Data
 ↓
Interaction
 ↓
Navigation
 ↓
Tests
```

Do not build:

```text
50 screens first
↓
state later
↓
navigation later
↓
testing later
```

---

# 32. ONE SCREEN AT A TIME RULE

During UI implementation:

> One screen is the active implementation target.

Antigravity must not receive permission to redesign or implement unrelated screens.

If Screen 24 is active:

Allowed:

* Screen 24
* required navigation connection to Screen 23
* required shared integration

Not allowed:

* redesign Screen 22
* redesign Screen 21
* implement Screen 25
* refactor unrelated features

unless explicitly approved.

---

# 33. DESIGN WORKFLOW

Each screen follows:

```text
Product Definition
      ↓
UX Specification
      ↓
Google Stitch Design
      ↓
Human Review
      ↓
Design Finalization
      ↓
Screenshot Saved
      ↓
Antigravity Implementation
      ↓
Runtime Verification
      ↓
Visual Comparison
      ↓
Polish
      ↓
Lock
```

The finalized screenshot becomes the primary visual reference.

---

# 34. STITCH PHASE RULE

Google Stitch is used for:

* visual exploration
* layout exploration
* hierarchy
* component composition
* interaction ideas
* visual direction

Stitch does not define:

* architecture
* repository structure
* state management
* backend
* production data flow
* feature boundaries

---

# 35. ANTIGRAVITY PHASE RULE

Antigravity is the implementation engineer.

Its responsibility is to:

* inspect existing architecture
* implement approved design
* reuse existing systems
* create appropriate files
* implement state
* connect navigation
* write tests
* run analysis
* verify runtime
* report changes

It must not independently redesign product architecture.

---

# 36. CHATGPT RESPONSIBILITY

ChatGPT acts as:

* product architect
* UX reviewer
* development manager
* prompt engineer
* architecture reviewer
* implementation reviewer
* risk detector
* integration planner

ChatGPT should identify:

* missing states
* navigation loopholes
* architecture issues
* UX problems
* duplicated functionality
* unnecessary complexity
* student pain points
* edge cases

---

# 37. PRODUCT OWNER RESPONSIBILITY

The developer/product owner makes the final decisions regarding:

* product scope
* visual approval
* screen lock
* feature priorities
* release decisions

No screen is considered final without explicit approval.

---

# 38. SCREEN COMPLETION CHECKLIST

A screen can be marked complete only when all applicable criteria pass.

### Product

* [ ] Purpose is clear
* [ ] User problem is addressed
* [ ] Content is correct
* [ ] No unnecessary sections

### Architecture

* [ ] Correct feature folder
* [ ] Correct state ownership
* [ ] Existing models reused
* [ ] No duplicate architecture
* [ ] No unnecessary dependencies

### UI

* [ ] Approved design implemented
* [ ] Typography correct
* [ ] Spacing correct
* [ ] Colors correct
* [ ] Elevation correct
* [ ] Texture/graphics correct
* [ ] Interactions feel intentional
* [ ] Animations restrained

### Responsive

* [ ] Small phone
* [ ] Normal phone
* [ ] Larger screen
* [ ] No overflow
* [ ] No clipping
* [ ] Bottom navigation does not cover content

### Accessibility

* [ ] Contrast
* [ ] Tap targets
* [ ] Semantic labels
* [ ] Readable text
* [ ] States understandable without color alone

### Engineering

* [ ] `flutter analyze`
* [ ] tests pass
* [ ] runtime verified
* [ ] no unnecessary warnings
* [ ] no unrelated modifications

### Final

* [ ] Product owner reviewed
* [ ] Screen approved
* [ ] Screen locked

---

# 39. PHASE COMPLETION CHECKLIST

A phase is complete only when:

* all required screens are implemented
* all required states exist
* navigation works
* tests pass
* runtime works
* responsive behavior is verified
* accessibility baseline is satisfied
* no known blocking defect remains
* architecture remains consistent
* no unrelated work was introduced
* product owner approves the phase

Then:

```text
PHASE COMPLETE
      ↓
PHASE LOCKED
      ↓
NEXT PHASE
```

---

# 40. BUG CLASSIFICATION

When a problem is discovered, classify it before fixing it.

### P0 — Blocking

Examples:

* app does not launch
* navigation completely broken
* data loss
* crash on core path

Fix immediately.

### P1 — Major

Examples:

* core feature unusable
* important state broken
* major layout failure

Fix before locking.

### P2 — Moderate

Examples:

* responsive issue on a device class
* incorrect spacing
* interaction inconsistency

Fix before final phase completion when practical.

### P3 — Cosmetic

Examples:

* minor alignment
* subtle spacing difference
* small visual refinement

Do not reopen locked screens unnecessarily.

---

# 41. NO PREMATURE POLISH RULE

Do not spend large amounts of time polishing a feature that is not functionally complete.

Preferred order:

```text
Function
 ↓
Correct State
 ↓
Navigation
 ↓
Responsive
 ↓
Accessibility
 ↓
Visual Polish
 ↓
Micro-interactions
```

The product must work before it is perfected.

---

# 42. NO PREMATURE BACKEND RULE

Do not introduce backend infrastructure to solve a problem that can be solved locally during frontend development.

Backend integration begins only after:

* core frontend is complete
* navigation is complete
* major states are complete
* product loop is verified
* architecture is stable

---

# 43. NO PREMATURE AI RULE

AI is not a prerequisite for YOUTOPPER's core value.

Do not add AI simply to make a feature sound intelligent.

The product must first prove that its deterministic learning workflows are useful.

Future AI features must solve a clearly identified problem.

---

# 44. INTEGRATION PHASE RULE

When a new feature requires an older locked screen to change:

1. identify the exact dependency
2. explain why the change is required
3. modify only the necessary integration point
4. preserve the approved visual design
5. re-run tests
6. re-verify the previously locked screen
7. relock it

Never use a new feature as an excuse to redesign an older screen.

---

# 45. REFACTORING RULE

Refactoring is allowed only when it produces a clear benefit.

Valid reasons:

* duplicated architecture
* incorrect feature boundary
* broken state ownership
* performance issue
* testability issue
* maintainability issue
* real integration requirement

Invalid reasons:

* “cleaner”
* personal preference
* changing style unnecessarily
* moving files without benefit
* rewriting working code because a different pattern looks nicer

---

# 46. DEPENDENCY RULE

New packages should be added only when:

1. the requirement genuinely needs them
2. Flutter/Dart cannot reasonably provide the functionality
3. the package is appropriate for production
4. the package does not introduce unnecessary architectural complexity

Avoid dependency accumulation.

---

# 47. TESTING PHASE RULE

Testing is not postponed until the end.

Each screen must receive appropriate testing immediately after implementation.

Testing levels:

```text
Widget / Unit Test
      ↓
Flutter Analyze
      ↓
Runtime Test
      ↓
Visual Verification
      ↓
Responsive Verification
```

---

# 48. DEMO READINESS RULE

Every completed major vertical slice should be demonstrable.

A demo should show:

* user action
* system response
* meaningful outcome

Avoid demos that only show static UI.

---

# 49. CURRENT CORE VERTICAL SLICE STATUS

The project has established the following learning flow:

```text
Screen 21
Home / Smart Workspace
        ↓
Screen 22
Learn Hub
        ↓
Screen 23
Topic / Concept
        ↓
Screen 24
Concept Learning Experience
```

Approved screens:

* Screen 21 — LOCKED
* Screen 22 — LOCKED
* Screen 23 — LOCKED

Screen 24 follows the same controlled implementation and verification process.

---

# 50. SCREEN IMPLEMENTATION TEMPLATE

Every future screen should follow this template.

## Step 1 — Product definition

Define:

* purpose
* user question
* role in product
* inputs
* outputs
* states
* dependencies

## Step 2 — UX specification

Define:

* hierarchy
* content
* interactions
* navigation
* empty state
* loading state
* error state

## Step 3 — Design

Create and review the Stitch design.

## Step 4 — Freeze

Save the approved screenshot in:

```text
UI references/
```

## Step 5 — Implementation plan

Define:

* files
* models
* state
* repository/data source
* navigation
* tests

## Step 6 — Implementation

Implement only the approved scope.

## Step 7 — Verification

Run:

```text
flutter analyze
flutter test
flutter run
```

and visually verify the screen.

## Step 8 — Polish

Only after correctness is established.

## Step 9 — Approval

Product owner reviews.

## Step 10 — Lock

Screen becomes frozen.

---

# 51. FEATURE COMPLETION TEMPLATE

Every major feature should answer:

### What problem does it solve?

### Which screen owns the feature?

### What state does it require?

### What data does it require?

### What other features does it connect to?

### What happens when data is empty?

### What happens when something fails?

### What happens when the user leaves midway?

### What happens when the user returns?

### What happens on small screens?

### What happens without network access?

### What is local demo behavior?

### What will eventually become backend behavior?

These questions must be answered before the feature is considered production-ready.

---

# 52. FRONTEND → BACKEND MIGRATION STRATEGY

The frontend phase should use interfaces that make later persistence possible.

Preferred conceptual structure:

```text
UI
 ↓
State / Controller
 ↓
Repository
 ↓
Local Data Source
```

Later:

```text
UI
 ↓
State / Controller
 ↓
Repository
 ↓
Remote Data Source
```

The UI should not directly depend on Firebase/HTTP implementation details.

---

# 53. BACKEND MIGRATION RULE

When backend begins:

Do not rewrite the product.

Instead replace:

```text
DemoLocalDataSource
```

with:

```text
RemoteDataSource
```

where appropriate.

The goal is:

> **Change the data source, not the entire product architecture.**

---

# 54. RELEASE GATE

YOUTOPPER must not be considered production-ready merely because the app builds.

Before release, the following must be verified:

```text
Core learning
✓

Concept understanding
✓

Revision
✓

Practice
✓

Planning
✓

Progress
✓

Learning methods
✓

Authentication
✓

Profile
✓

Settings
✓

Notifications
✓

Search
✓

Error handling
✓

Responsive UI
✓

Accessibility
✓

Performance
✓

Security
✓

Release build
✓
```

---

# 55. FINAL PRODUCT VALIDATION

Before release, evaluate YOUTOPPER from the learner's perspective.

Ask:

### Can a new learner understand what YOUTOPPER does?

### Can the learner quickly determine what to study?

### Can the learner actually learn a concept?

### Can the learner return to important concepts?

### Can the learner revise?

### Can the learner practice?

### Can the learner plan?

### Can the learner understand progress?

### Can the learner learn how to learn?

### Can the learner move between these systems naturally?

### Does the application solve a student problem rather than merely present features?

If the answer to these questions is no, the product is not finished.

---

# 56. FINAL EXECUTION ORDER

The official execution order is:

```text
PHASE 0
Project Control
        ↓
PHASE 1
Foundation
        ↓
PHASE 2
Entry & Authentication
        ↓
PHASE 3
Learner Setup
        ↓
PHASE 4
Core Learning
        ↓
PHASE 5
Learn How to Learn
        ↓
PHASE 6
Revision
        ↓
PHASE 7
Practice
        ↓
PHASE 8
Planner
        ↓
PHASE 9
Progress & Weekly Review
        ↓
PHASE 10
Notifications
        ↓
PHASE 11
Profile / Settings / Support
        ↓
PHASE 12
Search & Integration
        ↓
PHASE 13
Frontend Completion Audit
        ↓
PHASE 14
Backend & Persistence
        ↓
PHASE 15
Production Hardening
        ↓
PHASE 16
Release Preparation
        ↓
PHASE 17
Google Play Deployment
        ↓
PHASE 18
Post-Launch Validation
```

---

# 57. ABSOLUTE PHASE RULES

The following rules apply throughout the entire project.

1. Never skip a required phase without documenting why.

2. Never implement backend before the frontend gate.

3. Never introduce AI merely for appearance.

4. Never implement multiple unrelated screens simultaneously.

5. Never bypass screen approval.

6. Never modify locked screens casually.

7. Never create duplicate navigation systems.

8. Never create duplicate data models unnecessarily.

9. Never introduce fake analytics.

10. Never introduce fake personalization.

11. Never use random demo data.

12. Never create unnecessary screens for simple states.

13. Never use a screenshot as an excuse for poor engineering.

14. Never use architecture as an excuse for poor UX.

15. Never use visual polish as an excuse for incomplete functionality.

16. Never allow a feature to become isolated from the rest of the product without a deliberate reason.

17. Never add a dependency without justification.

18. Never perform broad refactoring during a screen implementation unless explicitly approved.

19. Always verify runtime behavior.

20. Always verify visual behavior.

21. Always preserve the product's core learning loop.

22. Always prefer the simplest architecture that can support the requirement.

23. Always build for real student problems.

24. Always keep the interface calmer than the complexity underneath it.

25. Always finish the product before attempting to perfect the product.

---

# 58. DEFINITION OF DONE

The entire YOUTOPPER project is considered **DONE** only when:

```text
Product requirements complete
        +
Architecture stable
        +
All required screens implemented
        +
All major user journeys functional
        +
Frontend audited
        +
Backend integrated
        +
Data persistence verified
        +
Authentication verified
        +
Security verified
        +
Performance verified
        +
Accessibility verified
        +
Release build verified
        +
Google Play requirements satisfied
        +
Production deployment completed
```

Only then should the project move from:

> **Development**

to:

> **Production / Continuous Improvement**

---

# 59. FINAL PRINCIPLE

YOUTOPPER is not being built by checking screens off a list.

It is being built by completing a connected learning system.

Every phase must move the product closer to answering the learner's fundamental questions:

> **What should I study?**

> **How do I understand it?**

> **How do I remember it?**

> **When should I revise it?**

> **How do I practice it?**

> **Am I making progress?**

> **How can I learn more effectively?**

The development process must therefore remain:

**Controlled.**

**Incremental.**

**Student-focused.**

**Architecturally disciplined.**

**Visually intentional.**

**Frontend-first.**

**Tested.**

**Verified.**

**Locked.**

And ultimately:

> **Finish the product first. Perfect the product second.**
