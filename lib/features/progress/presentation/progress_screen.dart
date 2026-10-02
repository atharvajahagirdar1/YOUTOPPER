import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../app/theme/app_colors.dart';

// --- DATA MODELS ---
class _SubjectData {
  final String title;
  final int completed;
  final int total;
  final Color color1;
  final Color color2;
  const _SubjectData(this.title, this.completed, this.total, this.color1, this.color2);
  double get progress => total > 0 ? completed / total : 0.0;
}

class _MilestoneData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final bool isDone;
  final bool isUpcoming;
  const _MilestoneData(this.icon, this.title, this.subtitle, this.status, {this.isDone = false, this.isUpcoming = false});
}

class _GoalData {
  final String title;
  final int completed;
  final int total;
  final IconData icon;
  final String footerText;
  const _GoalData(this.title, this.completed, this.total, this.icon, this.footerText);
  double get progress => total > 0 ? completed / total : 0.0;
}

final _demoSubjects = [
  _SubjectData('Database Management Systems', 17, 25, Color(0xFF6366F1), Color(0xFF06B6D4)),
  _SubjectData('Data Structures & Algorithms', 14, 26, Color(0xFF8B5CF6), Color(0xFFC084FC)),
  _SubjectData('Operating Systems', 8, 20, Color(0xFF0EA5E9), Color(0xFF7DD3FC)),
  _SubjectData('Computer Networks', 5, 20, Color(0xFF64748B), Color(0xFF94A3B8)),
];

final _demoMilestones = [
  _MilestoneData(Icons.verified_rounded, 'First Topic Mastered', 'Database Normalization completed with solid recall', 'Completed', isDone: true),
  _MilestoneData(Icons.checklist_rtl_rounded, 'Active Recall Habit', 'Completed 10 self-testing sessions without prompt aids', 'Completed', isDone: true),
  _MilestoneData(Icons.flag_outlined, 'DBMS Syllabus Milestone', '17 / 20 core topics verified', '85% Done', isDone: false),
  _MilestoneData(Icons.account_tree_outlined, 'Cross-Subject Synthesis', 'Complete revision sessions across all 4 subjects', 'Upcoming', isDone: false, isUpcoming: true),
];

final _demoGoals = [
  _GoalData('Complete Core Semester Syllabus', 17, 25, Icons.calendar_today_rounded, 'Target: Mid-Term Exam (Oct 15)'),
  _GoalData('Maintain 15m Daily Revision Routine', 5, 7, Icons.sync_rounded, 'Weekly consistency'),
];

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {
  String _selectedTime = 'Week';
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  BoxDecoration _neuDecoration({bool isElevated = false, double radius = 16}) {
    return BoxDecoration(
      color: isElevated ? AppColors.surfaceElevated : AppColors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 6)),
        BoxShadow(color: Colors.white.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(-1, -1)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          // Subtle radial texture accent
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.info.withValues(alpha: 0.07), Colors.transparent],
                  stops: const [0.2, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.primary.withValues(alpha: 0.05), Colors.transparent],
                  stops: const [0.2, 1.0],
                ),
              ),
            ),
          ),
          // Content
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildLearningJourneyCard(),
              const SizedBox(height: 32),
              _buildProgressOverTime(),
              const SizedBox(height: 32),
              _buildProgressBySubject(context),
              const SizedBox(height: 32),
              _buildMilestones(),
              const SizedBox(height: 32),
              _buildLearningGoals(),
              const SizedBox(height: 32),
              _buildQuoteFooter(),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: const Icon(Icons.public, color: AppColors.info, size: 20),
        ),
      ),
      leadingWidth: 56,
      title: const Text(
        'Progress',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white70),
          onPressed: () {},
        ),
        IconButton(
          icon: const Badge(
            smallSize: 8,
            backgroundColor: AppColors.info,
            child: Icon(Icons.notifications_none_rounded, color: Colors.white70),
          ),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withValues(alpha: 0.3),
            child: const Icon(Icons.person_rounded, color: AppColors.info, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic)),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: const Text(
                'LEARNING OVERVIEW',
                style: TextStyle(
                  color: AppColors.info,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your Progress',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Every step forward counts. See how your learning is\ngrowing.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningJourneyCard() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: const Interval(0.1, 0.6, curve: Curves.easeOutCubic)),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.1, 0.6)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: _neuDecoration(radius: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Learning Journey',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      'Active Cycle',
                      style: TextStyle(
                        color: AppColors.info.withValues(alpha: 0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildAnimatedCircularProgress(),
              const SizedBox(height: 32),
              const Text(
                "17 of 25 topics completed across active\nsubjects. You're moving forward, one completed\nlearning step at a time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildJourneyStat(Icons.schedule_rounded, '32h', 'Total Study'),
                    Container(width: 1, height: 30, color: Colors.white.withValues(alpha: 0.08)),
                    _buildJourneyStat(Icons.school_rounded, '4', 'Subjects'),
                    Container(width: 1, height: 30, color: Colors.white.withValues(alpha: 0.08)),
                    _buildJourneyStat(Icons.psychology_rounded, '84%', 'Recall Rate'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCircularProgress() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 0.68),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: _DonutChartPainter(
                  percentage: value,
                  strokeWidth: 16,
                  trackColor: Colors.white.withValues(alpha: 0.03),
                  gradientColors: [AppColors.secondary, AppColors.info, const Color(0xFF00E5FF)],
                  glowColor: AppColors.info.withValues(alpha: 0.3),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(value * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Overall Completed',
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJourneyStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.info, size: 14),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressOverTime() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic)),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress Over Time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'See how your learning activity has changed.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: _neuDecoration(radius: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSegment('Week'),
                  _buildSegment('Month'),
                  _buildSegment('All Time'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: _neuDecoration(radius: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.info, 
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(color: AppColors.info.withValues(alpha: 0.5), blurRadius: 6)
                                    ]
                                  ),
                                ),
                                const SizedBox(width: 8),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                    children: [
                                      TextSpan(text: 'Wed Focus: ', style: TextStyle(color: AppColors.textSecondary)),
                                      TextSpan(text: '2h 45m ', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.info)),
                                      TextSpan(text: '· 4 topics', style: TextStyle(fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Peak Intensity',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        TweenAnimationBuilder<double>(
                          key: ValueKey(_selectedTime),
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          builder: (context, val, child) {
                            return SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: CustomPaint(
                                painter: _LineChartPainter(animationValue: val, selectedTime: _selectedTime),
                              ),
                            );
                          }
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                              .map((day) => Text(
                                    day,
                                    style: TextStyle(
                                      color: day == 'Wed' ? AppColors.info : AppColors.textSecondary,
                                      fontSize: 11,
                                      fontWeight: day == 'Wed' ? FontWeight.w700 : FontWeight.w500,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.15),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.03))),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.auto_graph_rounded, color: AppColors.info, size: 16),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Consistent upward pacing with highest study concentration midweek.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
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

  Widget _buildSegment(String label) {
    final isSelected = _selectedTime == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTime = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceElevated.withValues(alpha: 0.8) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected ? [
             BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))
          ] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBySubject(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic)),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.3, 0.8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress by Subject',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "See where you're moving forward.",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            ..._demoSubjects.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildSubjectRow(context, s),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectRow(BuildContext context, _SubjectData s) {
    return Container(
      decoration: _neuDecoration(radius: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          splashColor: Colors.white.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        s.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${(s.progress * 100).toInt()}%',
                          style: const TextStyle(
                            color: AppColors.info,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${s.completed} of ${s.total} topics completed',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 6,
                    width: double.infinity,
                    color: Colors.black.withValues(alpha: 0.3),
                    alignment: Alignment.centerLeft,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: s.progress),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, child) {
                        return FractionallySizedBox(
                          widthFactor: val,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(colors: [s.color1, s.color2]),
                              boxShadow: [
                                BoxShadow(color: s.color2.withValues(alpha: 0.5), blurRadius: 4, offset: const Offset(0, 2))
                              ]
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMilestones() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: const Interval(0.4, 0.9, curve: Curves.easeOutCubic)),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.4, 0.9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Milestones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Recognize the learning steps you've completed.",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            ..._demoMilestones.map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildMilestoneRow(m),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneRow(_MilestoneData m) {
    return Container(
      decoration: _neuDecoration(radius: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          splashColor: Colors.white.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: m.isDone
                        ? AppColors.surfaceElevated
                        : (m.isUpcoming ? Colors.transparent : AppColors.surfaceElevated),
                    borderRadius: BorderRadius.circular(12),
                    border: m.isUpcoming ? Border.all(color: AppColors.surfaceElevated) : Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    boxShadow: m.isDone ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))] : null,
                  ),
                  child: Icon(
                    m.icon,
                    color: m.isDone ? AppColors.info : AppColors.textMuted,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              m.title,
                              style: TextStyle(
                                color: m.isUpcoming ? AppColors.textSecondary : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: m.isDone ? AppColors.surfaceElevated : (m.isUpcoming ? AppColors.surfaceElevated : Colors.black.withValues(alpha: 0.2)),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  m.status,
                                  style: TextStyle(
                                    color: m.isDone ? AppColors.info : AppColors.textSecondary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (m.isDone) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.check, color: AppColors.info, size: 10),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m.subtitle,
                        style: TextStyle(
                          color: m.isUpcoming ? AppColors.textMuted : AppColors.textSecondary,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearningGoals() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
        CurvedAnimation(parent: _entranceController, curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic)),
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: _entranceController, curve: const Interval(0.5, 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Learning Goals',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            ..._demoGoals.map((g) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildGoalCard(g),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(_GoalData g) {
    return Container(
      decoration: _neuDecoration(radius: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          highlightColor: Colors.white.withValues(alpha: 0.05),
          splashColor: Colors.white.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            g.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${g.completed} of ${g.total} ${g.title.contains("Routine") ? "days logged this week" : "topics completed"}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${(g.progress * 100).toInt()}%',
                      style: const TextStyle(
                        color: AppColors.info,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 6,
                    width: double.infinity,
                    color: Colors.black.withValues(alpha: 0.3),
                    alignment: Alignment.centerLeft,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: g.progress),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, child) {
                        return FractionallySizedBox(
                          widthFactor: val,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.info,
                              boxShadow: [
                                BoxShadow(color: AppColors.info.withValues(alpha: 0.5), blurRadius: 4, offset: const Offset(0, 2))
                              ]
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(g.icon, color: AppColors.textSecondary, size: 14),
                    const SizedBox(width: 8),
                    Text(
                      g.footerText,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(Icons.format_quote_rounded, color: AppColors.info.withValues(alpha: 0.3), size: 32),
          const SizedBox(height: 8),
          const Text(
            '"Success is the sum of small efforts,\nrepeated day in and day out."',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color trackColor;
  final List<Color> gradientColors;
  final Color glowColor;

  _DonutChartPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.trackColor,
    required this.gradientColors,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    // Slight inner shadow for track effect
    canvas.drawCircle(center, radius, trackPaint);

    // Progress Gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: gradientColors,
      stops: const [0.0, 0.5, 1.0],
    );

    // Glow Effect behind progress line
    if (percentage > 0.05) {
      final glowPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * percentage, false, glowPaint);
    }

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * percentage, false, progressPaint);
    
    // Draw endpoint marker if percentage > 0
    if (percentage > 0) {
      final endAngle = -math.pi / 2 + (2 * math.pi * percentage);
      final markerX = center.dx + radius * math.cos(endAngle);
      final markerY = center.dy + radius * math.sin(endAngle);
      
      final markerPaint = Paint()..color = Colors.white;
      canvas.drawCircle(Offset(markerX, markerY), strokeWidth * 0.25, markerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}

class _LineChartPainter extends CustomPainter {
  final double animationValue;
  final String selectedTime;
  
  _LineChartPainter({this.animationValue = 1.0, this.selectedTime = 'Week'});
  
  @override
  void paint(Canvas canvas, Size size) {
    // Generate deterministic dummy data based on selected time
    List<double> values;
    if (selectedTime == 'Month') {
       values = [0.2, 0.5, 0.3, 0.7, 0.4, 0.9, 0.8];
    } else if (selectedTime == 'All Time') {
       values = [0.1, 0.2, 0.4, 0.5, 0.7, 0.8, 1.0];
    } else {
       values = [0.3, 0.5, 0.9, 0.4, 0.6, 0.2, 0.5]; // Week
    }

    final path = Path();
    final areaPath = Path();

    final dx = size.width / (values.length - 1);
    
    // Scale animation vertically
    final mappedValues = values.map((v) => v * animationValue).toList();
    
    path.moveTo(0, size.height - (mappedValues[0] * size.height));
    areaPath.moveTo(0, size.height);
    areaPath.lineTo(0, size.height - (mappedValues[0] * size.height));

    for (int i = 0; i < mappedValues.length - 1; i++) {
      final x1 = i * dx;
      final y1 = size.height - (mappedValues[i] * size.height);
      final x2 = (i + 1) * dx;
      final y2 = size.height - (mappedValues[i + 1] * size.height);

      final controlPointX1 = x1 + (dx / 2);
      final controlPointX2 = x1 + (dx / 2);

      path.cubicTo(controlPointX1, y1, controlPointX2, y2, x2, y2);
      areaPath.cubicTo(controlPointX1, y1, controlPointX2, y2, x2, y2);
    }

    areaPath.lineTo(size.width, size.height);
    areaPath.close();

    // Fill gradient
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.info.withValues(alpha: 0.3),
        AppColors.info.withValues(alpha: 0.0),
      ],
    );

    final areaPaint = Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(areaPath, areaPaint);

    // Line
    final linePaint = Paint()
      ..color = AppColors.info
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
      
    // Line glow
    final glowPaint = Paint()
      ..color = AppColors.info.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), gridPaint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), gridPaint);

    // Points
    final pointPaint = Paint()..color = AppColors.info;
    final outerPointPaint = Paint()..color = AppColors.background;
    
    for (int i = 0; i < mappedValues.length; i++) {
      // Highlight Wednesday (index 2)
      if (i == 2) {
        final x = i * dx;
        final y = size.height - (mappedValues[i] * size.height);
        canvas.drawCircle(Offset(x, y), 6, outerPointPaint);
        canvas.drawCircle(Offset(x, y), 4, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.selectedTime != selectedTime;
  }
}
