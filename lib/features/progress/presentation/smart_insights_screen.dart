import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class SmartInsightsScreen extends StatefulWidget {
  const SmartInsightsScreen({super.key});

  @override
  State<SmartInsightsScreen> createState() => _SmartInsightsScreenState();
}

class _SmartInsightsScreenState extends State<SmartInsightsScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.background.withValues(alpha: 0.85),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.transparent),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Smart Insights',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white70),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.3),
              child: const Icon(Icons.person_rounded, color: AppColors.info, size: 18),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Subtle background texture (radial glows)
          Positioned(
            top: -100,
            left: -100,
            child: _buildAmbientGlow(AppColors.primary, 250),
          ),
          Positioned(
            top: 400,
            right: -150,
            child: _buildAmbientGlow(const Color(0xFF1E3A8A), 300),
          ),
          // Content
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20, vertical: AppSpacing.s16),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildAnimatedItem(
                  index: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'See what deserves your attention next.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.info,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.info.withValues(alpha: 0.5),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Derived from recent learning activity & memory decay',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                _buildAnimatedItem(index: 1, child: _buildLearningSignalsCard()),
                const SizedBox(height: 28),
                _buildAnimatedItem(index: 2, child: _buildPrimaryRevisionCard(context)),
                const SizedBox(height: 32),
                _buildAnimatedItem(
                  index: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Needs Attention', 'Direct interventions yielding highest score delta'),
                      const SizedBox(height: 16),
                      _buildPracticeGapCard(context),
                      const SizedBox(height: 12),
                      _buildStudyBalanceCard(context),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildAnimatedItem(
                  index: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Observed Study Patterns', 'Deterministic observations from your last 14 sessions'),
                      const SizedBox(height: 16),
                      _buildPatternsCard(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildAnimatedItem(
                  index: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Suggested Next Actions', 'One-tap entry back into your learning flow'),
                      const SizedBox(height: 16),
                      _buildSuggestedActions(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildAnimatedItem(index: 6, child: _buildBottomControls()),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmbientGlow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: size / 2,
            spreadRadius: size / 4,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem({required int index, required Widget child}) {
    final startDelay = index * 0.05;
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animController,
          curve: Interval(startDelay, (startDelay + 0.5).clamp(0.0, 1.0), curve: Curves.easeOutCubic),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animController,
            curve: Interval(startDelay, (startDelay + 0.5).clamp(0.0, 1.0), curve: Curves.easeOutCubic),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildNeumorphicCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          // Dark shadow for depth
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            offset: const Offset(6, 6),
            blurRadius: 16,
            spreadRadius: -4,
          ),
          // Light highlight for neumorphic edge
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.015),
            offset: const Offset(-4, -4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildLearningSignalsCard() {
    return _buildNeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      color: AppColors.info,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Your Learning Signals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
                ),
                child: const Text(
                  '3 Active',
                  style: TextStyle(
                    color: AppColors.info,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '3 key areas identified from your recent study blocks, practice answers, and spacing logs.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSignalNode(Icons.edit_document, 'Logs', false),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.surfaceElevated, AppColors.info.withValues(alpha: 0.5)],
                    ),
                  ),
                ),
              ),
              _buildSignalNode(Icons.sensors, 'Signals', true),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.info.withValues(alpha: 0.5), AppColors.surfaceElevated],
                    ),
                  ),
                ),
              ),
              _buildSignalNode(Icons.flag_outlined, 'Actions', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignalNode(IconData icon, String label, bool isActive) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(isActive ? 14 : 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.info : AppColors.surfaceElevated,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.info.withValues(alpha: 0.5),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    )
                  ],
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : AppColors.textMuted,
            size: isActive ? 22 : 20,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textMuted,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryRevisionCard(BuildContext context) {
    return _buildNeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.surfaceElevated, AppColors.background],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    )
                  ]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.history_rounded,
                      color: AppColors.info,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'REVISION DUE',
                      style: TextStyle(
                        color: AppColors.info.withValues(alpha: 0.9),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '4d elapsed',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Database Normalization',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'DBMS · Chapter 3 · Relational Theory',
            style: TextStyle(
              color: AppColors.info,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  blurStyle: BlurStyle.inner,
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProgressionBox(
                  '1NF & 2NF',
                  'Verified',
                  'solid',
                  AppColors.surfaceElevated,
                  AppColors.success,
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                _buildProgressionBox(
                  'FDs &\nKeys',
                  'Recalling',
                  'fades',
                  AppColors.surfaceElevated.withValues(alpha: 0.5),
                  AppColors.secondary,
                  isGlowing: true,
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                _buildProgressionBox(
                  '3NF /\nBCNF',
                  '',
                  'Target state',
                  AppColors.background,
                  AppColors.textMuted,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            Icons.info_outline_rounded,
            'Signal:',
            ' Last reviewed 4 days ago. Spaced memory decay interval reached.',
          ),
          const SizedBox(height: 14),
          _buildInfoRow(
            Icons.lightbulb_outline_rounded,
            'Why now:',
            ' A 15m conceptual refresh will protect decomposition rules prior to next week\'s full mock.',
          ),
          const SizedBox(height: 28),
          _buildGradientButton(
            text: 'Review Now (15m)',
            icon: Icons.arrow_forward_rounded,
            colors: [AppColors.info, AppColors.primary],
            onTap: () {
              context.push('/home/revision/session');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required IconData icon,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.3),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressionBox(
    String title,
    String subtitle1,
    String subtitle2,
    Color bgColor,
    Color statusColor,
    {bool isGlowing = false}
  ) {
    return Container(
      width: 78,
      height: 78,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isGlowing
            ? [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                )
              ],
        border: isGlowing ? Border.all(color: statusColor.withValues(alpha: 0.3), width: 1.5) : Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          if (subtitle1.isNotEmpty)
            Text(
              subtitle1, 
              style: TextStyle(
                color: statusColor, 
                fontSize: 10,
                fontWeight: FontWeight.w600,
                shadows: isGlowing ? [Shadow(color: statusColor.withValues(alpha: 0.5), blurRadius: 4)] : null
              )
            ),
          Text(
            subtitle2,
            style: TextStyle(
              color: statusColor.withValues(alpha: 0.8),
              fontSize: 9,
              fontWeight: subtitle1.isNotEmpty
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: AppColors.textMuted, size: 14),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700, 
                    color: Colors.white
                  ),
                ),
                TextSpan(text: text),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeGapCard(BuildContext context) {
    return _buildSecondaryCard(
      context: context,
      pillBgColor: AppColors.warning.withValues(alpha: 0.15),
      pillBorderColor: AppColors.warning.withValues(alpha: 0.3),
      pillTextColor: AppColors.warning,
      pillIcon: Icons.bolt_rounded,
      pillText: 'PRACTICE GAP',
      timeText: 'Yesterday',
      title: 'Lossless Decomposition',
      subtitle: 'DBMS · Relational Synthesis',
      signal: ' 2 questions missed in Practice Session (Q4 & Q6).',
      why: ' Superkey intersection property was applied inconsistently.',
      ctaText: 'Solve 2 Focused Qs',
      ctaIcon: Icons.arrow_forward_rounded,
      onTap: () {
        context.push('/home/practice/session');
      },
    );
  }

  Widget _buildStudyBalanceCard(BuildContext context) {
    return _buildSecondaryCard(
      context: context,
      pillBgColor: AppColors.info.withValues(alpha: 0.15),
      pillBorderColor: AppColors.info.withValues(alpha: 0.3),
      pillTextColor: AppColors.info,
      pillIcon: Icons.balance_rounded,
      pillText: 'STUDY BALANCE',
      timeText: 'Load sync',
      title: 'Operating Systems: CPU Scheduling',
      subtitle: 'Core Coursework · Unit 2',
      signal: ' 45m planned this week, 0m logged so far.',
      why: ' Exam block in 8 days. Adding a 25m block prevents backlog stacking.',
      ctaText: 'Schedule in Planner',
      ctaIcon: Icons.calendar_today_rounded,
      onTap: () {
        context.go('/planner');
      },
    );
  }

  Widget _buildSecondaryCard({
    required BuildContext context,
    required Color pillBgColor,
    required Color pillBorderColor,
    required Color pillTextColor,
    required IconData pillIcon,
    required String pillText,
    required String timeText,
    required String title,
    required String subtitle,
    required String signal,
    required String why,
    required String ctaText,
    required IconData ctaIcon,
    required VoidCallback onTap,
  }) {
    return _buildNeumorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: pillBgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: pillBorderColor),
                  boxShadow: [
                    BoxShadow(
                      color: pillBgColor.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(pillIcon, color: pillTextColor, size: 12),
                    const SizedBox(width: 6),
                    Text(
                      pillText,
                      style: TextStyle(
                        color: pillTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  timeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary, 
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.sensors_rounded, 'Signal:', signal),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.psychology_rounded, 'Why it matters:', why),
          const SizedBox(height: 24),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.surfaceElevated, AppColors.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ctaText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(ctaIcon, color: AppColors.textSecondary, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternsCard() {
    return _buildNeumorphicCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildPatternRow(
                  Icons.dark_mode_rounded,
                  'Evening Focus Peak',
                  'Practice accuracy is highest during 06:00 PM – 09:00 PM (82% avg vs 65% in morning slots).',
                  const Color(0xFF818CF8),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(color: AppColors.surfaceElevated, height: 1),
                ),
                _buildPatternRow(
                  Icons.loop_rounded,
                  'Revision Rhythm',
                  'Revisiting Database Normalization twice this week has kept 1NF and 2NF recall above target threshold.',
                  AppColors.success,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(color: AppColors.surfaceElevated, height: 1),
                ),
                _buildPatternRow(
                  Icons.pie_chart_outline_rounded,
                  'Subject Load Share',
                  '70% DBMS, 20% Data Structures, 10% OS. Shifting 30m to OS balances weekly target parity.',
                  AppColors.warning,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Stacked Bar Chart with glow
                Container(
                  height: 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurStyle: BlurStyle.inner,
                        blurRadius: 4,
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 70,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF818CF8)]),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF67E8F9)]),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF475569), Color(0xFF64748B)]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLegendItem('DBMS', '70%', const Color(0xFF818CF8)),
                    _buildLegendItem('DS', '20%', const Color(0xFF67E8F9)),
                    _buildLegendItem('OS', '10%', const Color(0xFF64748B)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 4)]
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPatternRow(IconData icon, String title, String desc, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: iconColor.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                desc,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedActions() {
    return Column(
      children: [
        _buildActionItem(
          '1',
          'Review Normalization',
          '15 min · Revision',
          'Start',
          Icons.play_arrow_rounded,
          AppColors.primary,
        ),
        const SizedBox(height: 16),
        _buildActionItem(
          '2',
          'Drill Lossless Decomp',
          '2 Qs · Practice',
          'Solve',
          Icons.bolt_rounded,
          AppColors.secondary,
        ),
        const SizedBox(height: 16),
        _buildActionItem(
          '3',
          'Plan CPU Scheduling',
          '25 min · Learn',
          'Plan',
          Icons.calendar_today_rounded,
          AppColors.info,
        ),
      ],
    );
  }

  Widget _buildActionItem(
    String num,
    String title,
    String subtitle,
    String btnText,
    IconData btnIcon,
    Color accentColor,
  ) {
    return _buildNeumorphicCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor.withValues(alpha: 0.2), accentColor.withValues(alpha: 0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            ),
            alignment: Alignment.center,
            child: Text(
              num,
              style: TextStyle(
                color: accentColor,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: accentColor.withValues(alpha: 0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  btnText,
                  style: TextStyle(
                    color: accentColor.withValues(alpha: 0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(btnIcon, color: accentColor, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sync_rounded, color: AppColors.textMuted, size: 16),
            const SizedBox(width: 8),
            Text(
              'Updated after each study or test checkpoint',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurStyle: BlurStyle.inner,
                blurRadius: 8,
              )
            ]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.surfaceElevated, AppColors.surface],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                ),
                child: const Text(
                  'Active (3)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: const Text(
                  'Low Log',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
