import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/practice/presentation/practice_hub_screen.dart';
import '../../features/practice/presentation/practice_session_screen.dart';
import '../../features/practice/presentation/practice_results_screen.dart';
import '../../features/learn/presentation/concept_screen.dart';
import '../../features/learn/presentation/concept_learning_experience_screen.dart';
import '../../features/learn/presentation/learn_screen.dart';
import '../../features/learn_how_to_learn/presentation/learn_how_to_learn_screen.dart';
import '../../features/learn_how_to_learn/presentation/learning_technique_application_screen.dart';
import '../../features/learn_how_to_learn/presentation/learning_technique_detail_screen.dart';
import '../../features/main_shell/presentation/main_shell.dart';
import '../../features/planner/presentation/planner_screen.dart';
import '../../features/planner/presentation/focus_session_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/progress/presentation/smart_insights_screen.dart';
import '../../features/revision/presentation/revision_screen.dart';
import '../../features/revision/presentation/revision_session_screen.dart';
import '../../features/weekly_review/presentation/weekly_review_screen.dart';

import '../../features/saved/presentation/saved_concepts_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/help_support/presentation/help_support_screen.dart';
import '../../features/about_legal/presentation/about_legal_screen.dart';
import '../../features/search/presentation/search_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _shellNavigatorLearnKey =
    GlobalKey<NavigatorState>(debugLabel: 'learn');
final GlobalKey<NavigatorState> _shellNavigatorHowToLearnKey =
    GlobalKey<NavigatorState>(debugLabel: 'how_to_learn');
final GlobalKey<NavigatorState> _shellNavigatorPlannerKey =
    GlobalKey<NavigatorState>(debugLabel: 'planner');
final GlobalKey<NavigatorState> _shellNavigatorProgressKey =
    GlobalKey<NavigatorState>(debugLabel: 'progress');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'practice',
                  builder: (context, state) => const PracticeHubScreen(),
                  routes: [
                    GoRoute(
                      path: 'session',
                      builder: (context, state) =>
                          const PracticeSessionScreen(),
                      parentNavigatorKey: _rootNavigatorKey,
                      routes: [
                        GoRoute(
                          path: 'results',
                          builder: (context, state) =>
                              const PracticeResultsScreen(),
                          parentNavigatorKey: _rootNavigatorKey,
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: 'saved-concepts',
                  builder: (context, state) => const SavedConceptsScreen(),
                ),
                GoRoute(
                  path: 'notifications',
                  builder: (context, state) => const NotificationsScreen(),
                ),
                GoRoute(
                  path: 'profile',
                  builder: (context, state) => const ProfileScreen(),
                ),
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                ),
                GoRoute(
                  path: 'help-support',
                  builder: (context, state) => const HelpSupportScreen(),
                  routes: [
                    GoRoute(
                      path: 'about-legal',
                      builder: (context, state) => const AboutLegalScreen(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'revision',
                  builder: (context, state) => const RevisionScreen(),
                  routes: [
                    GoRoute(
                      path: 'session',
                      builder: (context, state) =>
                          const RevisionSessionScreen(),
                      parentNavigatorKey: _rootNavigatorKey,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLearnKey,
          routes: [
            GoRoute(
              path: '/learn',
              builder: (context, state) => const LearnScreen(),
              routes: [
                GoRoute(
                  path: 'practice',
                  builder: (context, state) => const PracticeHubScreen(),
                  routes: [
                    GoRoute(
                      path: 'session',
                      builder: (context, state) =>
                          const PracticeSessionScreen(),
                      parentNavigatorKey: _rootNavigatorKey,
                      routes: [
                        GoRoute(
                          path: 'results',
                          builder: (context, state) =>
                              const PracticeResultsScreen(),
                          parentNavigatorKey: _rootNavigatorKey,
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: 'search',
                  builder: (context, state) => const SearchScreen(),
                ),
                GoRoute(
                  path: 'concept',
                  builder: (context, state) => const ConceptScreen(),
                  routes: [
                    GoRoute(
                      path: 'experience',
                      builder: (context, state) =>
                          const ConceptLearningExperienceScreen(),
                      parentNavigatorKey: _rootNavigatorKey,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHowToLearnKey,
          routes: [
            GoRoute(
              path: '/how-to-learn',
              builder: (context, state) => const LearnHowToLearnScreen(),
              routes: [
                GoRoute(
                  path: 'practice',
                  builder: (context, state) => const PracticeHubScreen(),
                  routes: [
                    GoRoute(
                      path: 'session',
                      builder: (context, state) =>
                          const PracticeSessionScreen(),
                      parentNavigatorKey: _rootNavigatorKey,
                      routes: [
                        GoRoute(
                          path: 'results',
                          builder: (context, state) =>
                              const PracticeResultsScreen(),
                          parentNavigatorKey: _rootNavigatorKey,
                        ),
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  path: 'technique-detail',
                  builder: (context, state) =>
                      const LearningTechniqueDetailScreen(),
                  routes: [
                    GoRoute(
                      path: 'application',
                      builder: (context, state) =>
                          const LearningTechniqueApplicationScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorPlannerKey,
          routes: [
            GoRoute(
              path: '/planner',
              builder: (context, state) => const PlannerScreen(),
              routes: [
                GoRoute(
                  path: 'focus-session',
                  builder: (context, state) => const FocusSessionScreen(),
                  parentNavigatorKey: _rootNavigatorKey,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProgressKey,
          routes: [
            GoRoute(
              path: '/progress',
              builder: (context, state) => const ProgressScreen(),
              routes: [
                GoRoute(
                  path: 'insights',
                  builder: (context, state) => const SmartInsightsScreen(),
                  parentNavigatorKey: _rootNavigatorKey,
                ),
                GoRoute(
                  path: 'weekly-review',
                  builder: (context, state) => const WeeklyReviewScreen(),
                  parentNavigatorKey: _rootNavigatorKey,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
