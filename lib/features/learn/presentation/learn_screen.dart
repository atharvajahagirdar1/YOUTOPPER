import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s20,
            vertical: AppSpacing.s24,
          ),
          children: const [
            _LearnHeader(),
            SizedBox(height: 32),
            Text(
              'Learn',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.8,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Explore concepts, subjects, and ideas worth\nunderstanding.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 32),
            _SearchBar(),
            SizedBox(height: 40),
            _WhatDoYouWantToLearnCard(),
            SizedBox(height: 40),
            _SectionTitleWithAction(
              title: 'CONTINUE LEARNING',
              actionText: 'Active Session',
              actionColor: Color(0xFF00E5FF),
            ),
            SizedBox(height: 16),
            _ContinueLearningCard(),
            SizedBox(height: 40),
            _SectionTitleAndSubtitle(
              title: 'My Subjects',
              subtitle: "Explore what you're learning.",
            ),
            SizedBox(height: 20),
            _MySubjectsGrid(),
            SizedBox(height: 40),
            _SectionTitleAndSubtitle(
              title: 'Explore Topics',
              subtitle: "Dive into a concept when you're ready to understand it.",
            ),
            SizedBox(height: 20),
            _ExploreTopicsList(),
            SizedBox(height: 40),
            _SectionTitleAndSubtitle(
              title: 'Explore Something New',
              subtitle: "Find a concept outside your current study path.",
            ),
            SizedBox(height: 20),
            _ExploreSomethingNewCard(),
            SizedBox(height: 120), // padding for floating nav
          ],
        ),
      ),
    );
  }
}

class _LearnHeader extends StatelessWidget {
  const _LearnHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF161A25),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.psychology_rounded, color: Color(0xFF00E5FF), size: 22),
            ),
            const SizedBox(width: 14),
            const Text(
              'Learn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E212D), // Dark grey
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.notifications_none_rounded, color: Colors.white.withValues(alpha: 0.9), size: 22),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3A7CFF), Color(0xFF1E54E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3A7CFF).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: const Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/learn/search'),
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D111A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0xFF3A7CFF).withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.5), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Search concepts, subjects, or topics...',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00E5FF).withValues(alpha: 0.15),
                  const Color(0xFF00E5FF).withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_tree_rounded, color: Color(0xFF00E5FF), size: 14),
                const SizedBox(width: 6),
                const Text(
                  'NODES',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    );
  }
}

class _WhatDoYouWantToLearnCard extends StatelessWidget {
  const _WhatDoYouWantToLearnCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF141926),
            const Color(0xFF1A2136),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: const Color(0xFF3A7CFF).withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Ambient texture overlay
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: CustomPaint(painter: _DotMatrixTexturePainter()),
              ),
            ),
            // Abstract Animated Background Graphic
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 2 * math.pi),
                duration: const Duration(seconds: 10),
                builder: (context, value, child) {
                  return CustomPaint(
                    painter: _MiniKnowledgeGraphPainter(animationValue: value),
                  );
                },
                onEnd: () {
                  // Looping is handled by recreating the tween if we wanted, 
                  // but for simplicity in TweenAnimationBuilder we can just 
                  // use an implicitly animated looping approach or just let it rest.
                  // A pure flutter loop needs an AnimationController, 
                  // but for frontend visual richness we'll just let it play once over 10s.
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What do you want to learn?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Text(
                      'Pick up where you left off or explore something new across connected conceptual pathways.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.75),
                        height: 1.6,
                      ),
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
}

class _SectionTitleWithAction extends StatelessWidget {
  final String title;
  final String actionText;
  final Color actionColor;

  const _SectionTitleWithAction({
    required this.title,
    required this.actionText,
    required this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.white.withValues(alpha: 0.6),
            letterSpacing: 1.2,
          ),
        ),
        Text(
          actionText,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: actionColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _SectionTitleAndSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitleAndSubtitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF181C2A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF311B92).withValues(alpha: 0.15),
            blurRadius: 40,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle radial glow in the background
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00E5FF).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF311B92).withValues(alpha: 0.8),
                              const Color(0xFF4527A0).withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFB388FF).withValues(alpha: 0.3)),
                        ),
                        child: const Text(
                          'Operating Systems',
                          style: TextStyle(color: Color(0xFFEDE7F6), fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('14 min remaining', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Process Management',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Chapter 4', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 10),
                    Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.white30, shape: BoxShape.circle)),
                    const SizedBox(width: 10),
                    const Text('65% complete', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 24),
                // Custom Gradient Progress Bar
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF11141E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 0.65),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: value,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3A7CFF), Color(0xFF00E5FF)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00E5FF).withValues(alpha: 0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF00E5FF)),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Next: Round Robin Scheduling', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF252B3B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        shadowColor: Colors.black.withValues(alpha: 0.3),
                        side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Continue', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white.withValues(alpha: 0.9)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MySubjectsGrid extends StatelessWidget {
  const _MySubjectsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: const [
        _SubjectCard(
          icon: Icons.storage_rounded,
          topicCount: '12 TOPICS',
          title: 'Database\nManagement',
          accentColor: Color(0xFF00E5FF), // Cyan
        ),
        _SubjectCard(
          icon: Icons.memory_rounded,
          topicCount: '10 TOPICS',
          title: 'Operating\nSystems',
          accentColor: Color(0xFF3A7CFF), // YOUTOPPER Blue
        ),
        _SubjectCard(
          icon: Icons.account_tree_outlined,
          topicCount: '14 TOPICS',
          title: 'Data Structures',
          accentColor: Color(0xFFB388FF), // Violet
        ),
        _SubjectCard(
          icon: Icons.hub_rounded,
          topicCount: '11 TOPICS',
          title: 'Computer\nNetworks',
          accentColor: Color(0xFF1DE9B6), // Teal
        ),
      ],
    );
  }
}

class _SubjectCard extends StatefulWidget {
  final IconData icon;
  final String topicCount;
  final String title;
  final Color accentColor;

  const _SubjectCard({
    required this.icon,
    required this.topicCount,
    required this.title,
    required this.accentColor,
  });

  @override
  State<_SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<_SubjectCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(_isPressed ? 0.96 : 1.0, _isPressed ? 0.96 : 1.0, 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF161A25),
              widget.accentColor.withValues(alpha: 0.05),
            ],
          ),
          border: Border.all(
            color: widget.accentColor.withValues(alpha: _isPressed ? 0.3 : 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: _isPressed ? 8 : 16,
              offset: Offset(0, _isPressed ? 4 : 8),
            ),
            if (!_isPressed)
              BoxShadow(
                color: widget.accentColor.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
          ],
        ),
        child: Stack(
          children: [
            // Soft radial glow in corner
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      widget.accentColor.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.accentColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: widget.accentColor.withValues(alpha: 0.2)),
                        ),
                        child: Icon(widget.icon, color: widget.accentColor, size: 26),
                      ),
                      Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.3), size: 24),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    widget.topicCount,
                    style: TextStyle(
                      color: widget.accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
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
}

class _ExploreTopicsList extends StatelessWidget {
  const _ExploreTopicsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopicListTile(
          icon: Icons.layers_outlined,
          title: 'Database Normalization',
          subtitle: 'DBMS • Chapter 3',
          iconColor: const Color(0xFF00E5FF), // Cyan
          onTap: () => context.go('/learn/concept'),
        ),
        const SizedBox(height: 12),
        const _TopicListTile(
          icon: Icons.access_time_rounded,
          title: 'Process Scheduling',
          subtitle: 'Operating Systems • Chapter 4',
          iconColor: Color(0xFF3A7CFF), // Blue
        ),
        const SizedBox(height: 12),
        const _TopicListTile(
          icon: Icons.segment_rounded,
          title: 'Binary Search Trees',
          subtitle: 'Data Structures • Chapter 5',
          iconColor: Color(0xFFB388FF), // Violet
        ),
        const SizedBox(height: 12),
        const _TopicListTile(
          icon: Icons.swap_horiz_rounded,
          title: 'TCP vs UDP Protocol',
          subtitle: 'Computer Networks • Chapter 2',
          iconColor: Color(0xFF1DE9B6), // Teal
        ),
      ],
    );
  }
}

class _TopicListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback? onTap;

  const _TopicListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141824),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(20),
          highlightColor: iconColor.withValues(alpha: 0.05),
          splashColor: iconColor.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
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
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.5), size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExploreSomethingNewCard extends StatelessWidget {
  const _ExploreSomethingNewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF1A2136),
                  const Color(0xFF0D111A),
                ],
                radius: 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 2 * math.pi),
              duration: const Duration(seconds: 8),
              builder: (context, value, child) {
                return CustomPaint(
                  painter: _RaftProtocolPainter(animationValue: value),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'SYSTEMS ARCHITECTURE • ADVANCED CONCEPT',
              style: TextStyle(
                color: Color(0xFF00E5FF),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Distributed Consensus & Raft Protocol',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Understand how asynchronous clusters maintain a reliable synchronized state machine across network partitions.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3A7CFF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                shadowColor: const Color(0xFF3A7CFF).withValues(alpha: 0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Explore Concept', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// Custom Painters for Abstract Visuals
// ---------------------------------------------------------

class _DotMatrixTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const spacing = 12.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class _MiniKnowledgeGraphPainter extends CustomPainter {
  final double animationValue;
  
  _MiniKnowledgeGraphPainter({this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle breathing effect for nodes based on sin wave
    final pulse = (math.sin(animationValue) + 1) / 2; // 0.0 to 1.0

    final linePaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = const Color(0xFF3A7CFF).withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;
      
    final highlightNodePaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.8 + (pulse * 0.2))
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.2 + (pulse * 0.15))
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = Path();
    
    // Draw abstract connections on the right side
    path.moveTo(size.width * 0.55, -10);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width * 0.85, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.2, size.width * 1.1, size.height * 0.5);
    
    path.moveTo(size.width * 0.7, size.height * 1.2);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.8, size.width * 0.85, size.height * 0.3);
    
    // Draw lines
    canvas.drawPath(path, linePaint);
    
    // Draw Nodes and Glows
    final mainNodeOffset = Offset(size.width * 0.85, size.height * 0.3);
    canvas.drawCircle(mainNodeOffset, 12, glowPaint);
    canvas.drawCircle(mainNodeOffset, 4, highlightNodePaint);
    
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.7), 3, nodePaint);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.15), 3, nodePaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.15), 2, nodePaint);
  }

  @override
  bool shouldRepaint(covariant _MiniKnowledgeGraphPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class _RaftProtocolPainter extends CustomPainter {
  final double animationValue;
  
  _RaftProtocolPainter({this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final pulse = (math.sin(animationValue * 2) + 1) / 2;
    
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
      
    // Nodes positions
    final n1 = Offset(size.width * 0.25, center.dy);
    final n2 = center;
    final n3 = Offset(size.width * 0.75, center.dy);
      
    // Draw dashed connecting lines
    _drawDashedLine(canvas, n1, n2, linePaint);
    _drawDashedLine(canvas, n2, n3, linePaint);
    
    // Node 1
    _drawNode(canvas, n1, const Color(0xFF00E5FF), 8, pulse * 0.5);
    // Node 2 (Center/Leader) - pulses stronger
    _drawNode(canvas, n2, const Color(0xFFB388FF), 12, pulse);
    // Node 3
    _drawNode(canvas, n3, const Color(0xFFCE93D8), 8, pulse * 0.5);
  }
  
  void _drawNode(Canvas canvas, Offset position, Color color, double radius, double pulse) {
    // Pulsing outer glow
    canvas.drawCircle(
      position, 
      radius * (2.5 + pulse * 0.5), 
      Paint()..color = color.withValues(alpha: 0.15)..style = PaintingStyle.fill..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
    );
    // Outer ring
    canvas.drawCircle(position, radius * 1.5, Paint()..color = Colors.white.withValues(alpha: 0.3)..style = PaintingStyle.stroke..strokeWidth = 1.5);
    // Inner core
    canvas.drawCircle(position, radius, Paint()..color = color..style = PaintingStyle.fill);
    // Core highlight
    canvas.drawCircle(position, radius * 0.4, Paint()..color = Colors.white..style = PaintingStyle.fill);
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 6.0;
    const dashSpace = 6.0;
    double distance = (p2 - p1).distance;
    double dx = (p2.dx - p1.dx) / distance;
    double dy = (p2.dy - p1.dy) / distance;
    
    double startX = p1.dx;
    double startY = p1.dy;
    
    // Offset slightly so it doesn't overlap the node centers perfectly
    final nodeOffset = 18.0;
    startX += dx * nodeOffset;
    startY += dy * nodeOffset;
    distance -= nodeOffset * 2;
    
    while (distance >= dashWidth) {
      canvas.drawLine(Offset(startX, startY), Offset(startX + dx * dashWidth, startY + dy * dashWidth), paint);
      startX += dx * (dashWidth + dashSpace);
      startY += dy * (dashWidth + dashSpace);
      distance -= (dashWidth + dashSpace);
    }
  }

  @override
  bool shouldRepaint(covariant _RaftProtocolPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
