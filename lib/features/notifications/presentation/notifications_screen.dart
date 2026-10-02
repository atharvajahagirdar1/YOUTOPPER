import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';

class _Notif {
  final String id;
  final String title;
  final String time;
  final String body;
  final String boldText;
  final String endBody;
  final String type; // 'Revision', 'Planner', 'Study'
  final String tag;
  final String actionLabel;
  final bool isActionText;
  final String section;
  bool isRead;
  final bool isSpecial;
  final IconData? iconOverride;
  final Color? iconColorOverride;
  final Color? iconBgOverride;

  _Notif({
    required this.id,
    required this.title,
    required this.time,
    required this.body,
    this.boldText = '',
    this.endBody = '',
    required this.type,
    required this.tag,
    required this.actionLabel,
    this.isActionText = false,
    required this.section,
    this.isRead = false,
    this.isSpecial = false,
    this.iconOverride,
    this.iconColorOverride,
    this.iconBgOverride,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';

  final List<_Notif> _notifications = [
    _Notif(
      id: '1',
      title: 'Time to revisit a topic',
      time: '10m ago',
      body: 'A topic in your revision plan is due for review: ',
      boldText: 'DBMS Normalization',
      endBody: '.',
      type: 'Revision',
      tag: 'Revision',
      actionLabel: 'Start Revision',
      section: 'TODAY',
      isRead: false,
    ),
    _Notif(
      id: '2',
      title: 'Your planned study session ...',
      time: '1h ago',
      body: 'Check your upcoming study task before you begin: ',
      boldText: 'B-Tree Indexing',
      endBody: '.',
      type: 'Planner',
      tag: 'Planner',
      actionLabel: 'View in Planner',
      section: 'TODAY',
      isRead: false,
      iconOverride: Icons.next_plan_outlined,
    ),
    _Notif(
      id: '3',
      title: 'You completed a study task',
      time: '3h ago',
      body: 'Your completed work on ',
      boldText: 'Heap Invariants',
      endBody: ' has been reflected in your learning workspace.',
      type: 'Study',
      tag: 'Study',
      actionLabel: 'Synchronized',
      isActionText: true,
      section: 'TODAY',
      isRead: false,
    ),
    _Notif(
      id: '4',
      title: 'One study task is still pendi...',
      time: 'Yesterday',
      body: 'Review your remaining tasks and decide what to carry forward into this week.',
      type: 'Planner',
      tag: 'Planner',
      actionLabel: 'Review Tasks',
      section: 'YESTERDAY',
      isRead: true,
      iconOverride: Icons.assignment_late_outlined,
    ),
    _Notif(
      id: '5',
      title: 'Revision session completed',
      time: 'Yesterday',
      body: 'Your 25-minute spaced repetition cycle on ',
      boldText: 'Core Algorithms',
      endBody: ' has been recorded.',
      type: 'Revision',
      tag: 'Revision',
      actionLabel: '+42 Mastery XP',
      isActionText: true,
      section: 'YESTERDAY',
      isRead: true,
      iconOverride: Icons.check_circle_outline,
      iconColorOverride: const Color(0xFF67B4E0),
      iconBgOverride: const Color(0xFF1E2833),
    ),
    _Notif(
      id: '6',
      title: 'Stay aligned with your schedule',
      time: '',
      body: 'Have 15 minutes? Check your upcoming study sequence or adjust your daily pace to avoid cognitive overload.',
      type: 'Planner',
      tag: '',
      actionLabel: 'Review your study plan',
      section: 'YESTERDAY',
      isRead: true,
      isSpecial: true,
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n.isRead = true;
      }
    });
  }

  void _markRead(String id) {
    setState(() {
      final idx = _notifications.indexWhere((n) => n.id == id);
      if (idx >= 0) _notifications[idx].isRead = true;
    });
  }

  List<_Notif> get _filteredNotifications {
    if (_selectedFilter == 'All') return _notifications;
    if (_selectedFilter == 'Unread') return _notifications.where((n) => !n.isRead).toList();
    return _notifications.where((n) => n.type == _selectedFilter).toList();
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  int _countFor(String filter) {
    if (filter == 'All') return _notifications.length;
    if (filter == 'Unread') return _unreadCount;
    return _notifications.where((n) => n.type == filter).length;
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Icon(Icons.psychology_outlined, color: const Color(0xFF67B4E0), size: 28),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('YOUTOPPER', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
              Text('MASTERY ENGINE', style: TextStyle(color: const Color(0xFF67B4E0), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFB5C4D9), // Light grayish blue
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Color(0xFF10131A), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -20,
            top: -40,
            child: Icon(
              Icons.notifications_active_outlined,
              size: 140,
              color: Colors.white.withValues(alpha: 0.02),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                    const SizedBox(height: 6),
                    Text('Stay on top of your learning and spaced cycles.', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.3)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: Icon(Icons.tune, color: AppColors.textSecondary, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatesRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Text('Your updates', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            if (_unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF202B36),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF67B4E0), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text('$_unreadCount unread', style: const TextStyle(color: Color(0xFF67B4E0), fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            const Spacer(),
            GestureDetector(
              onTap: _markAllRead,
              child: Row(
                children: [
                  Icon(Icons.done_all, color: AppColors.textSecondary, size: 16),
                  const SizedBox(width: 4),
                  Text('Mark all read', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['All', 'Unread', 'Revision', 'Planner'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: filters.map((f) {
          final isSelected = _selectedFilter == f;
          final count = _countFor(f);
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF202B36) : AppColors.surfaceElevated.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? const Color(0xFF67B4E0).withValues(alpha: 0.3) : Colors.transparent),
              ),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isSelected
                        ? Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF67B4E0), shape: BoxShape.circle)),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Text(f, style: TextStyle(color: isSelected ? const Color(0xFF67B4E0) : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 6),
                  Text('($count)', style: TextStyle(color: isSelected ? const Color(0xFF67B4E0).withValues(alpha: 0.7) : AppColors.textMuted, fontSize: 13)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 12),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(width: 12),
          Expanded(child: Container(height: 1, color: Colors.white.withValues(alpha: 0.1))),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(_Notif n) {
    if (n.isSpecial) return _buildSpecialCard(n);

    IconData icon;
    Color iconColor;
    Color iconBg;

    if (n.type == 'Revision') {
      icon = n.iconOverride ?? Icons.access_time_filled;
      iconColor = const Color(0xFFE6B450);
      iconBg = const Color(0xFF332916);
    } else if (n.type == 'Planner') {
      icon = n.iconOverride ?? Icons.event_note;
      iconColor = const Color(0xFF7C6FD9);
      iconBg = const Color(0xFF1E1C30);
    } else {
      icon = n.iconOverride ?? Icons.check_circle_outline;
      iconColor = const Color(0xFF27AE8A);
      iconBg = const Color(0xFF132B25);
    }

    if (n.isRead) {
      iconColor = AppColors.textSecondary;
      iconBg = AppColors.surfaceElevated;
    }

    if (n.iconColorOverride != null) iconColor = n.iconColorOverride!;
    if (n.iconBgOverride != null) iconBg = n.iconBgOverride!;

    return GestureDetector(
      onTap: () {
        _markRead(n.id);
        if (n.type == 'Revision') context.go('/home/revision');
        if (n.type == 'Planner') context.go('/planner');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutQuad,
        margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: n.isRead ? const Color(0xFF13151C) : const Color(0xFF181B24),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: n.isRead ? Colors.transparent : Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: n.isRead
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF67B4E0),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                      ),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          style: TextStyle(
                            color: n.isRead ? AppColors.textSecondary : Colors.white,
                            fontSize: 15,
                            fontWeight: n.isRead ? FontWeight.w500 : FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          child: Text(n.title),
                        ),
                      ),
                      Text(n.time, style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                      children: [
                        TextSpan(text: n.body),
                        if (n.boldText.isNotEmpty) TextSpan(text: n.boldText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        if (n.endBody.isNotEmpty) TextSpan(text: n.endBody),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(n.tag, style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w500)),
                      ),
                      const Spacer(),
                      if (n.isActionText)
                        Text(n.actionLabel, style: TextStyle(color: n.actionLabel.contains('+') ? const Color(0xFF27AE8A) : AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600))
                      else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(n.actionLabel, style: const TextStyle(color: Color(0xFF67B4E0), fontSize: 13, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward, color: Color(0xFF67B4E0), size: 14),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialCard(_Notif n) {
    return GestureDetector(
      onTap: () {
        _markRead(n.id);
        context.go('/planner');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: n.isRead ? const Color(0xFF161821) : const Color(0xFF1E212B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2E3B),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.explore, color: Colors.white70, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(n.title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(n.body, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5C4FF), // Light periwinkle blue
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(n.actionLabel, style: const TextStyle(color: Color(0xFF10131A), fontSize: 13, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward, color: Color(0xFF10131A), size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = _filteredNotifications.where((n) => n.section == 'TODAY').toList();
    final yesterday = _filteredNotifications.where((n) => n.section == 'YESTERDAY').toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D1016), // Slightly deeper background for more contrast
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -1.0),
            radius: 1.5,
            colors: [
              const Color(0xFF1C283F).withValues(alpha: 0.5), // Subtle indigo glow at top
              const Color(0xFF0D1016),
            ],
            stops: const [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            _buildTopBar(),
            const SizedBox(height: 8),
            _buildHeader(),
            _buildUpdatesRow(),
            _buildFilters(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  if (today.isNotEmpty) ...[
                    _buildSectionHeader('TODAY'),
                    ...today.map(_buildNotificationCard),
                  ],
                  if (yesterday.isNotEmpty) ...[
                    _buildSectionHeader('YESTERDAY'),
                    ...yesterday.map(_buildNotificationCard),
                  ],
                  if (today.isEmpty && yesterday.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: Text('No notifications', style: TextStyle(color: Colors.white54))),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
