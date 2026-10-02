import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class GlobalNavigationDrawer extends StatelessWidget {
  const GlobalNavigationDrawer({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _navigateToBranch(BuildContext context, int index) {
    Navigator.of(context).pop(); // Close drawer
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  void _navigateToRoute(BuildContext context, String routePath) {
    Navigator.of(context).pop(); // Close drawer
    context.push(routePath);
  }

  void _showUnavailable(BuildContext context, String featureName) {
    Navigator.of(context).pop(); // Close drawer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName is currently unavailable.'),
        backgroundColor: AppColors.surfaceElevated,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12, vertical: AppSpacing.s8),
                children: [
                  _buildSectionTitle('MAIN'),
                  _buildNavItem(
                    icon: Icons.home_rounded,
                    label: 'Home',
                    isSelected: navigationShell.currentIndex == 0,
                    onTap: () => _navigateToBranch(context, 0),
                  ),
                  _buildNavItem(
                    icon: Icons.explore_rounded,
                    label: 'Learn',
                    isSelected: navigationShell.currentIndex == 1,
                    onTap: () => _navigateToBranch(context, 1),
                  ),
                  _buildNavItem(
                    icon: Icons.psychology_rounded,
                    label: 'Learn How to Learn',
                    isSelected: navigationShell.currentIndex == 2,
                    onTap: () => _navigateToBranch(context, 2),
                  ),
                  _buildNavItem(
                    icon: Icons.calendar_today_rounded,
                    label: 'Planner',
                    isSelected: navigationShell.currentIndex == 3,
                    onTap: () => _navigateToBranch(context, 3),
                  ),
                  _buildNavItem(
                    icon: Icons.insights_rounded,
                    label: 'Progress',
                    isSelected: navigationShell.currentIndex == 4,
                    onTap: () => _navigateToBranch(context, 4),
                  ),
                  
                  const SizedBox(height: AppSpacing.s16),
                  _buildSectionTitle('LEARNING'),
                  _buildNavItem(
                    icon: Icons.auto_awesome_rounded,
                    label: 'My Learning Methods',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'My Learning Methods'),
                  ),
                  _buildNavItem(
                    icon: Icons.bookmark_rounded,
                    label: 'Saved Concepts',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/saved-concepts'),
                  ),
                  _buildNavItem(
                    icon: Icons.history_edu_rounded,
                    label: 'Revision',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/revision'),
                  ),
                  _buildNavItem(
                    icon: Icons.edit_note_rounded,
                    label: 'Practice',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/practice'),
                  ),

                  const SizedBox(height: AppSpacing.s16),
                  _buildSectionTitle('INSIGHTS'),
                  _buildNavItem(
                    icon: Icons.lightbulb_rounded,
                    label: 'Smart Insights',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/progress/insights'),
                  ),
                  _buildNavItem(
                    icon: Icons.analytics_rounded,
                    label: 'Learning Insights',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Learning Insights'),
                  ),
                  _buildNavItem(
                    icon: Icons.trending_down_rounded,
                    label: 'Weak Areas',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Weak Areas'),
                  ),
                  _buildNavItem(
                    icon: Icons.calendar_view_week_rounded,
                    label: 'Weekly Review',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/progress/weekly-review'),
                  ),

                  const SizedBox(height: AppSpacing.s16),
                  _buildSectionTitle('MOTIVATION'),
                  _buildNavItem(
                    icon: Icons.emoji_events_rounded,
                    label: 'Achievements',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Achievements'),
                  ),
                  _buildNavItem(
                    icon: Icons.flag_rounded,
                    label: 'Milestones',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Milestones'),
                  ),
                  _buildNavItem(
                    icon: Icons.track_changes_rounded,
                    label: 'Consistency',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Consistency'),
                  ),
                  _buildNavItem(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Learning Streaks',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Learning Streaks'),
                  ),

                  const SizedBox(height: AppSpacing.s16),
                  _buildSectionTitle('ACCOUNT'),
                  _buildNavItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/profile'),
                  ),
                  _buildNavItem(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/notifications'),
                  ),
                  _buildNavItem(
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/settings'),
                  ),

                  const SizedBox(height: AppSpacing.s16),
                  _buildSectionTitle('SUPPORT'),
                  _buildNavItem(
                    icon: Icons.help_rounded,
                    label: 'Help & Support',
                    isSelected: false,
                    onTap: () => _navigateToRoute(context, '/home/help-support'),
                  ),
                  _buildNavItem(
                    icon: Icons.info_rounded,
                    label: 'About YOUTOPPER',
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      context.push('/home/help-support/about-legal');
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.privacy_tip_rounded,
                    label: 'Terms & Privacy',
                    isSelected: false,
                    onTap: () => _showUnavailable(context, 'Terms & Privacy'),
                  ),
                  
                  const SizedBox(height: AppSpacing.s24),
                ],
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.school_rounded, // Using school as the closest available standard icon to a graduation cap, since we must reuse existing approved styles. The app already uses this implicitly for learning.
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUTOPPER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'Learning workspace',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close menu',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.s16, top: AppSpacing.s8, bottom: AppSpacing.s8),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? AppColors.primary : Colors.transparent;
    final textColor = isSelected ? Colors.white : AppColors.textSecondary;
    final iconColor = isSelected ? Colors.white : AppColors.textMuted;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: isSelected ? 0.2 : 0.0),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: AppSpacing.s16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s16),
      child: InkWell(
        onTap: () => _showUnavailable(context, 'Sign Out'),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error.withValues(alpha: 0.9), size: 22),
            const SizedBox(width: AppSpacing.s16),
            Text(
              'Sign Out',
              style: TextStyle(
                color: AppColors.error.withValues(alpha: 0.9),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
