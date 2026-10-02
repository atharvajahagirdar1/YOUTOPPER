import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class ConceptLearningExperienceScreen extends StatefulWidget {
  const ConceptLearningExperienceScreen({super.key});

  @override
  State<ConceptLearningExperienceScreen> createState() => _ConceptLearningExperienceScreenState();
}

class _ConceptLearningExperienceScreenState extends State<ConceptLearningExperienceScreen> {
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Subtle radial glow / texture layer
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3A7CFF).withValues(alpha: 0.03),
                    Colors.transparent,
                  ],
                  center: const Alignment(0, -0.4),
                  radius: 1.2,
                ),
              ),
            ),
          ),
          SafeArea(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s20,
                  vertical: AppSpacing.s24,
                ),
          children: [
            const _Header(),
            const SizedBox(height: 32),
            const _ActionRow(),
            const SizedBox(height: 24),
            _buildSectionLabel('THE IDEA', const Color(0xFF00E5FF)),
            const SizedBox(height: 8),
            const Text(
              'Functional Dependencies',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 24),
            _buildIdeaCard(),
            const SizedBox(height: 40),
            _buildSectionLabel('VISUALIZE THE MAPPING', const Color(0xFF00E5FF), trailing: _buildLightningTrailing()),
            const SizedBox(height: 16),
            const _VisualMappingDiagram(),
            const SizedBox(height: 40),
            _buildSectionLabel('SEE IT WITH DATA', const Color(0xFFB388FF), trailing: const Text('table: Student_Directory', style: TextStyle(color: Colors.white54, fontSize: 11, fontFamily: 'monospace'))),
            const SizedBox(height: 16),
            const _DataExampleTable(),
            const SizedBox(height: 40),
            _buildSectionLabel('WHY IT WORKS', Colors.white54),
            const SizedBox(height: 16),
            const _WhyItWorksCard(),
            const SizedBox(height: 40),
            const _RememberCoreRuleCard(),
            const SizedBox(height: 40),
            _buildSectionLabel('QUICK CHECK', Colors.white54, trailing: const Text('Verify your understanding', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.bold))),
            const SizedBox(height: 16),
            _buildQuickCheck(),
            const SizedBox(height: 40),
            const _ConceptPrincipleCard(),
            const SizedBox(height: 32),
            _buildContinueButton(context),
            const SizedBox(height: 24),
            _buildBottomNavLinks(),
            const SizedBox(height: 120), // Padding for global bottom navigation
          ],
        ),
            ),
      ),
    ],
  ),
);
  }

  Widget _buildSectionLabel(String text, Color dotColor, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        ?trailing,
      ],
    );
  }

  Widget _buildLightningTrailing() {
    return Row(
      children: const [
        Icon(Icons.bolt, color: Color(0xFF00E5FF), size: 14),
        SizedBox(width: 4),
        Text(
          'Unidirectional',
          style: TextStyle(
            color: Color(0xFF00E5FF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIdeaCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '"One value can uniquely determine another value."',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8C9EFF), // Light indigo/purple text
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'If each '),
                TextSpan(text: 'Student_ID', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                TextSpan(text: ' identifies exactly one '),
                TextSpan(text: 'Student_Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                TextSpan(text: ', knowing the ID is always enough to guarantee the name.'),
              ],
            ),
            style: TextStyle(
              fontSize: 15,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCheck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'If Student_ID uniquely identifies Student_Name in the university registry, which notation is accurate?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        _buildOption(
          index: 0,
          label: 'A',
          text: 'Student_ID → Student_Name',
          isCorrect: true,
        ),
        const SizedBox(height: 12),
        _buildOption(
          index: 1,
          label: 'B',
          text: 'Student_Name → Student_ID',
          isCorrect: false,
        ),
        const SizedBox(height: 12),
        _buildOption(
          index: 2,
          label: 'C',
          text: 'Neither determines the other',
          isCorrect: false,
        ),
        if (_selectedOptionIndex != null) ...[
          const SizedBox(height: 20),
          _buildFeedbackBox(),
        ],
      ],
    );
  }

  Widget _buildOption({
    required int index,
    required String label,
    required String text,
    required bool isCorrect,
  }) {
    final isSelected = _selectedOptionIndex == index;
    final showResult = _selectedOptionIndex != null;
    
    Color borderColor = Colors.white.withValues(alpha: 0.05);
    Color bgColor = const Color(0xFF161A25);
    Color labelColor = Colors.white54;
    Color labelBg = Colors.white.withValues(alpha: 0.1);
    Color textColor = Colors.white54;
    
    if (showResult && isSelected) {
      if (isCorrect) {
        borderColor = const Color(0xFF00E5FF).withValues(alpha: 0.5);
        bgColor = const Color(0xFF00E5FF).withValues(alpha: 0.05);
        labelColor = const Color(0xFF00E5FF);
        labelBg = const Color(0xFF00E5FF).withValues(alpha: 0.15);
        textColor = Colors.white;
      } else {
        // We aren't selecting an incorrect option in the reference, but standard styling:
        borderColor = Colors.redAccent.withValues(alpha: 0.5);
        bgColor = Colors.redAccent.withValues(alpha: 0.05);
        labelColor = Colors.redAccent;
        labelBg = Colors.redAccent.withValues(alpha: 0.15);
        textColor = Colors.white;
      }
    } else if (showResult && !isSelected) {
       // Dim unselected options
       textColor = Colors.white30;
       labelColor = Colors.white24;
    } else {
      textColor = Colors.white70;
    }

    return GestureDetector(
      onTap: () {
        if (_selectedOptionIndex == null) {
          setState(() {
            _selectedOptionIndex = index;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: borderColor.withValues(alpha: 0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: labelBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'monospace', // Or just stick to standard with monospace feel
                ),
              ),
            ),
            if (showResult && isSelected && isCorrect)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF00E5FF), size: 24),
            if (showResult && !isSelected)
              Icon(Icons.circle, color: Colors.white.withValues(alpha: 0.05), size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackBox() {
    final isCorrect = _selectedOptionIndex == 0; // Only A is correct here
    if (!isCorrect) return const SizedBox.shrink(); // Assuming we only show detailed feedback for correct based on design

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161A25), // Darker box inside
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Exactly.',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Because each Student_ID uniquely identifies one student, knowing the ID resolves to exactly one Student_Name.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigation logic for continuing
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8C9EFF), // The blue/purple from design
          foregroundColor: const Color(0xFF0F121B), // Dark text
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Continue to Normal Forms',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: const [
              Icon(Icons.arrow_back, color: Colors.white54, size: 14),
              SizedBox(width: 4),
              Text(
                'Previous: Relational Basics',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Next: 1NF & 2NF',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
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
              ),
              child: const Icon(Icons.school_outlined, color: Colors.white70, size: 22),
            ),
            const SizedBox(width: 14),
            const Text(
              'Concept',
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
          children: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white70),
              onPressed: () {},
            ),
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.notifications_none_rounded, color: Colors.white70),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00E5FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF3A7CFF).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person_outline, color: Color(0xFF3A7CFF), size: 20),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => context.pop(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'MODULE 3 • RELATIONAL DESIGN',
                style: TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Database Normalization',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF8C9EFF), // Light indigo
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                '02 / 05',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.bookmark_border_rounded, color: Colors.white70),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

class _VisualMappingDiagram extends StatelessWidget {
  const _VisualMappingDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Determinant Box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F2D), // Slightly lighter background
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF3A7CFF).withValues(alpha: 0.3)), // Blue border
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3A7CFF).withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.vpn_key_outlined, size: 12, color: Colors.white54),
                          SizedBox(width: 4),
                          Text('X', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Student_ID',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A7CFF).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Determinant',
                          style: TextStyle(
                            color: Color(0xFF8C9EFF),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Arrow connecting them
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const Text(
                      'uniquely\ndetermines',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.arrow_right_alt, color: Color(0xFF00E5FF), size: 24),
                    const SizedBox(height: 4),
                    const Text(
                      'X → Y',
                      style: TextStyle(color: Colors.white30, fontSize: 10, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
              
              // Dependent Box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F2D),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFB388FF).withValues(alpha: 0.3)), // Purple border
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB388FF).withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.portrait_rounded, size: 12, color: Colors.white54),
                          SizedBox(width: 4),
                          Text('Y', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Student_Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB388FF).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Dependent',
                          style: TextStyle(
                            color: Color(0xFFB388FF),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Legend below
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF3A7CFF), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('Determinant\n(Given)', style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.3)),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('Produces Exactly One\nResult', style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.3)),
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

class _DataExampleTable extends StatelessWidget {
  const _DataExampleTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          // Table header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: const [
                      Icon(Icons.vpn_key_outlined, size: 12, color: Colors.white54),
                      SizedBox(width: 4),
                      Text('STUDENT_ID', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: const Text('STUDENT_NAME', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 1,
                  child: const Text('DEPT', textAlign: TextAlign.right, style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white10),
          // Rows
          _buildTableRow('101', 'Rahul', 'CS', true),
          const Divider(height: 1, color: Colors.white10),
          _buildTableRow('102', 'Priya', 'EE', false),
          const Divider(height: 1, color: Colors.white10),
          _buildTableRow('103', 'Arjun', 'CS', true),
          
          // Explanatory note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Transform.rotate(
                    angle: 1.5708, // 90 degrees in radians
                    child: const Icon(Icons.call_split_rounded, color: Colors.white54, size: 14),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Why Dept is NOT a Determinant:',
                        style: TextStyle(color: Color(0xFFB388FF), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Dept = \'CS\' maps to both '),
                            const TextSpan(text: 'Rahul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            const TextSpan(text: ' and '),
                            const TextSpan(text: 'Arjun', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            const TextSpan(text: '. Because one input yields multiple outputs, '),
                            const TextSpan(text: 'Dept ↘ Student_Name', style: TextStyle(color: Colors.redAccent, fontFamily: 'monospace')),
                            const TextSpan(text: ' is invalid.'),
                          ],
                        ),
                        style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String id, String name, String dept, bool highlight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A7CFF).withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(id, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_right_alt, color: Colors.white30, size: 16),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
                if (highlight) ...[
                  const SizedBox(width: 6),
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(dept, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white54, fontSize: 13, fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }
}

class _WhyItWorksCard extends StatelessWidget {
  const _WhyItWorksCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Each registered student holds exactly one unique '),
                TextSpan(text: 'Student_ID', style: TextStyle(color: Color(0xFF8C9EFF), fontFamily: 'monospace')),
                TextSpan(text: '. Knowing that singular identifier always resolves without ambiguity to the exact record:'),
              ],
            ),
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.verified_outlined, color: Color(0xFF00E5FF), size: 16),
                SizedBox(width: 8),
                Text(
                  'Student_ID → Student_Name',
                  style: TextStyle(color: Color(0xFF00E5FF), fontSize: 13, fontFamily: 'monospace', fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RememberCoreRuleCard extends StatelessWidget {
  const _RememberCoreRuleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF00E5FF), Color(0xFFB388FF)],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.lightbulb_outline, color: Color(0xFF00E5FF), size: 16),
                        SizedBox(width: 8),
                        Text(
                          'REMEMBER · CORE RULE',
                          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '"If X always determines Y, then X → Y."',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('X', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('DETERMINANT', style: TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            const Text('uniquely determines', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_right_alt, color: Color(0xFF00E5FF), size: 16),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text('Y', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('DEPENDENT', style: TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConceptPrincipleCard extends StatelessWidget {
  const _ConceptPrincipleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb_outline, color: Color(0xFFB388FF), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CONCEPT PRINCIPLE',
                  style: TextStyle(
                    color: Color(0xFFB388FF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'A functional dependency describes a '),
                      TextSpan(text: 'structural relationship between attributes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      TextSpan(text: ' across the entire domain, not just coincidence in individual sample rows.'),
                    ],
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
