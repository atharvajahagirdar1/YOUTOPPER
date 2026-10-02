import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../main_shell/presentation/main_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Match background color exactly
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s20,
            vertical: AppSpacing.s24,
          ),
          children: const [
            _HomeHeader(),
            SizedBox(height: 32),
            _SectionTitleWithIcon(
              icon: Icons.lightbulb_outline_rounded,
              title: 'WHAT SHOULD I STUDY RIGHT NOW?',
            ),
            SizedBox(height: 16),
            _HomeHeroCard(),
            SizedBox(height: 32),
            _SectionTitleWithAction(
              title: "TODAY'S PROGRESS",
              actionText: '2h 10m / 3h goal',
              actionColor: Colors.white,
            ),
            SizedBox(height: 16),
            _TodayProgressCard(),
            SizedBox(height: 32),
            _SectionTitle(title: 'CONTINUE LEARNING'),
            SizedBox(height: 16),
            _ContinueLearningCard(),
            SizedBox(height: 32),
            _SectionTitleWithAction(
              title: 'NEEDS ATTENTION',
              actionText: '2 pending',
              actionColor: Colors.white,
            ),
            SizedBox(height: 16),
            _NeedsAttentionCard1(),
            SizedBox(height: 12),
            _NeedsAttentionCard2(),
            SizedBox(height: 32),
            _SectionTitle(title: 'COMING UP'),
            SizedBox(height: 16),
            _ComingUpCard(),
            SizedBox(height: 32),
            _SectionTitle(title: 'WORKSPACE PORTALS'),
            SizedBox(height: 16),
            _WorkspacePortals(),
            SizedBox(height: 100), // padding for floating nav
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                rootScaffoldKey.currentState?.openDrawer();
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Good morning, Atharva',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5)),
              const SizedBox(height: 4),
              Text('Ready to make progress today?',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                context.push('/home/notifications');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E212D), // Dark grey
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.notifications_none_rounded, color: Colors.white.withValues(alpha: 0.8), size: 22),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                context.push('/home/profile');
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3A7CFF), Color(0xFF1E54E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3A7CFF).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'A',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white.withValues(alpha: 0.7),
        letterSpacing: 1.0,
      ),
    );
  }
}

class _SectionTitleWithIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitleWithIcon({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF3A7CFF)), // Blue accent
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 1.0,
          ),
        ),
      ],
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
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.7),
            letterSpacing: 1.0,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: actionColor.withValues(alpha: 0.9),
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1D2644), // Rich navy
            Color(0xFF111522), // Deep dark base
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF3A7CFF).withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: const Color(0xFF3A7CFF).withValues(alpha: 0.08), // Atmospheric blue glow
            blurRadius: 48,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Abstract Background Graphic
            Positioned.fill(
              child: CustomPaint(
                painter: _KnowledgeGraphPainter(),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A7CFF).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF3A7CFF).withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A7CFF), // Blue dot
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF3A7CFF).withValues(alpha: 0.6),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Your next unfinished topic',
                              style: TextStyle(
                                color: Color(0xFFD4E1FF), // Very light blue
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                        ),
                        child: const Icon(Icons.account_tree_outlined, color: Colors.white70, size: 20),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Understand Database Normalization',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Flexible(
                        child: Text(
                          'Database Management Systems · Chapter 3 ·',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.access_time, size: 14, color: Color(0xFFD4E1FF)),
                      const SizedBox(width: 4),
                      const Text(
                        '25 min',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFD4E1FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '1NF, 2NF, 3NF & BCNF functional dependencies with university exam questions and decomposition proofs.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3A7CFF).withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A88FF), Color(0xFF1E54E5)], // Vibrant premium blue
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Start Learning', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
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

class _TodayProgressCard extends StatelessWidget {
  const _TodayProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Subtle cyan/blue radial background
            Positioned(
              top: -30,
              left: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00E5FF).withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomPaint(
                          painter: _ProgressRingPainter(progress: 0.72),
                          size: const Size(72, 72),
                        ),
                        const Center(
                          child: Text(
                            '72%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daily Study Time Goal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '50 mins left to hit target',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle_outline, color: const Color(0xFF4CAF50), size: 14),
                                  const SizedBox(width: 4),
                                  const Text('2 sessions d...', style: TextStyle(color: Color(0xFF81C784), fontSize: 11, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFB388FF).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFB388FF).withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.history, color: const Color(0xFFB388FF), size: 14),
                                  const SizedBox(width: 4),
                                  const Text('1 revision ...', style: TextStyle(color: Color(0xFFD1C4E9), fontSize: 11, fontWeight: FontWeight.w500)),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3A7CFF), Color(0xFF5E95FF)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.3), blurRadius: 4),
                  ],
                ),
                child: const Text(
                  'CHAPTER 4',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('14 min remaining', style: TextStyle(color: Colors.white60, fontSize: 13), overflow: TextOverflow.ellipsis),
              ),
              const Text('65%', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Operating Systems — Process Management',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          // Custom Gradient Progress Bar
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F30),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.65,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3A7CFF), Color(0xFF00E5FF)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Last active 2 hours ago', style: TextStyle(color: Colors.white60, fontSize: 13)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2435), // Dark grey pill
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Continue', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, size: 16, color: const Color(0xFF3A7CFF)), // Blue arrow
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NeedsAttentionCard1 extends StatelessWidget {
  const _NeedsAttentionCard1();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF151926),
            const Color(0xFF311B92).withValues(alpha: 0.1), // Subtle violet semantic tint
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB388FF).withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB388FF).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFB388FF).withValues(alpha: 0.2)),
                      ),
                      child: const Text(
                        'Revision due',
                        style: TextStyle(color: Color(0xFFD1C4E9), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('SRS Algorithm', style: TextStyle(color: Colors.white70, fontSize: 13), overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF311B92).withValues(alpha: 0.4),
                  foregroundColor: const Color(0xFFD1C4E9),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  minimumSize: const Size(0, 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  side: BorderSide(color: const Color(0xFFB388FF).withValues(alpha: 0.1)),
                ),
                child: const Text('Revise', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Data Structures — Trees',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _NeedsAttentionCard2 extends StatelessWidget {
  const _NeedsAttentionCard2();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF151926),
            const Color(0xFF004D40).withValues(alpha: 0.1), // Subtle teal semantic tint
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00BFA5).withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BFA5).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF00BFA5).withValues(alpha: 0.2)),
                      ),
                      child: const Text(
                        'Practice',
                        style: TextStyle(color: Color(0xFF80CBC4), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('4 flagged questions', style: TextStyle(color: Colors.white70, fontSize: 13), overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D40).withValues(alpha: 0.4),
                  foregroundColor: const Color(0xFF80CBC4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  minimumSize: const Size(0, 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  side: BorderSide(color: const Color(0xFF00BFA5).withValues(alpha: 0.1)),
                ),
                child: const Text('Solve Qs', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'DBMS — Normalization',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ComingUpCard extends StatelessWidget {
  const _ComingUpCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141824),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          // Timeline vertical line
          Positioned(
            left: 40,
            top: 24,
            bottom: 24,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF3A7CFF).withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2865FF), Color(0xFF1E54E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF2865FF).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('TOM', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                          Text('16', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('OS — Process Scheduling Algorithms', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text('Round Robin & Priority Multi-level', style: TextStyle(color: Colors.white60, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.white.withValues(alpha: 0.05), height: 1, indent: 80),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1F30),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('FRI', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
                          Text('18', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DBMS — Unit Test Practice Mock', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text('Timed test · 45 minutes', style: TextStyle(color: Colors.white60, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkspacePortals extends StatelessWidget {
  const _WorkspacePortals();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        const _PortalCard(
          icon: Icons.menu_book_outlined,
          title: 'Study',
          subtitle: 'Concepts & Lessons',
          accentColor: Color(0xFF3A7CFF), // Blue
        ),
        _PortalCard(
          icon: Icons.sync_rounded,
          title: 'Revise',
          subtitle: 'Spaced Repetition',
          accentColor: const Color(0xFFB388FF), // Violet
          onTap: () {
            context.go('/home/revision');
          },
        ),
        _PortalCard(
          icon: Icons.code_rounded,
          title: 'Practice',
          subtitle: 'Curated Problems',
          accentColor: const Color(0xFF00E5FF), // Cyan
          onTap: () {
            context.go('/home/practice');
          },
        ),
        _PortalCard(
          icon: Icons.bookmark_border_rounded,
          title: 'Saved',
          subtitle: 'Formulas & Notes',
          accentColor: const Color(0xFFF48FB1), // Soft Pink
          onTap: () {
            context.go('/home/saved-concepts');
          },
        ),
      ],
    );
  }
}

class _PortalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final VoidCallback? onTap;

  const _PortalCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A2033),
            Color(0xFF141826),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle accent glow in top right
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accentColor.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: accentColor, size: 16),
                    ),
                  ],
                ),
                const Spacer(),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

// ---------------------------------------------------------
// Custom Painters for Abstract Visuals
// ---------------------------------------------------------

class _KnowledgeGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF3A7CFF).withValues(alpha: 0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = const Color(0xFF3A7CFF).withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
      
    final highlightNodePaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    // A web of connections representing knowledge paths
    final path = Path();
    
    // Path 1
    path.moveTo(size.width * 0.9, -20);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.3, size.width * 0.95, size.height * 0.6);
    path.quadraticBezierTo(size.width * 1.1, size.height * 0.8, size.width * 0.7, size.height * 1.2);
    
    // Path 2
    path.moveTo(size.width * 0.4, -20);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.4, size.width * 0.8, size.height * 0.3);
    
    // Path 3
    path.moveTo(size.width * 0.6, size.height * 1.2);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.7, size.width * 0.95, size.height * 0.6);
    
    canvas.drawPath(path, linePaint);
    
    // Nodes at intersections or key points
    canvas.drawCircle(Offset(size.width * 0.82, size.height * 0.25), 3, nodePaint);
    canvas.drawCircle(Offset(size.width * 0.95, size.height * 0.6), 4, highlightNodePaint);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.95), 2, nodePaint);
    canvas.drawCircle(Offset(size.width * 0.53, size.height * 0.35), 3, nodePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;

  _ProgressRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 3; // Subtract half strokeWidth

    // Draw track
    final trackPaint = Paint()
      ..color = const Color(0xFF1E2638)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    
    canvas.drawCircle(center, radius, trackPaint);

    // Draw progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = const SweepGradient(
      colors: [Color(0xFF3A7CFF), Color(0xFF00E5FF)],
      stops: [0.0, 0.72], // Ensures color hits target right at end of arc
      transform: GradientRotation(-math.pi / 2), // Start at top
    );

    final arcPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
