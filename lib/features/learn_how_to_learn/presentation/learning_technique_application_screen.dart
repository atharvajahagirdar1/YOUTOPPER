import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearningTechniqueApplicationScreen extends StatefulWidget {
  const LearningTechniqueApplicationScreen({super.key});

  @override
  State<LearningTechniqueApplicationScreen> createState() => _LearningTechniqueApplicationScreenState();
}

class _LearningTechniqueApplicationScreenState extends State<LearningTechniqueApplicationScreen> {
  String? _selectedAssessment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _DotMatrixPainter(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(context),
                const SizedBox(height: 12),
                _buildProgressBars(),
                const SizedBox(height: 16),
                _buildStepper(),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildQuestionCard(),
                        const SizedBox(height: 24),
                        _buildWorkspaceArea(),
                        const SizedBox(height: 24),
                        _buildReferenceModel(),
                        const SizedBox(height: 24),
                        _buildAssessmentArea(),
                        const SizedBox(height: 24),
                        _buildContinueButton(),
                        const SizedBox(height: 16),
                        _buildBottomActions(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _PressableCard(
            onTap: () => context.pop(),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Active Recall',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B3A5A).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'TRY THE TECHNIQUE',
                        style: TextStyle(
                          color: Color(0xFF8C9EFF),
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                    children: [
                      TextSpan(text: 'Step 2 of 3 • '),
                      TextSpan(
                        text: 'Cognitive Drill',
                        style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildIconButton(Icons.help_outline, Colors.white70),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF8C9EFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, color: Color(0xFF07111F), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color) {
    return _PressableCard(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildProgressBars() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _buildProgressBar(true)),
          const SizedBox(width: 4),
          Expanded(child: _buildProgressBar(true)),
          const SizedBox(width: 4),
          Expanded(child: _buildProgressBar(false)),
        ],
      ),
    );
  }

  Widget _buildProgressBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 3,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4285F4) : const Color(0xFF2A3649),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStepItem('1. Study', false),
          const Icon(Icons.chevron_right, color: Color(0xFF2A3649), size: 16),
          _buildStepItem('2. Close', false),
          const Icon(Icons.chevron_right, color: Color(0xFF2A3649), size: 16),
          _buildStepItem('3. Recall', true),
          const Icon(Icons.chevron_right, color: Color(0xFF2A3649), size: 16),
          _buildStepItem('4. Check', false),
        ],
      ),
    );
  }

  Widget _buildStepItem(String label, bool isActive) {
    return Column(
      children: [
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF00E5FF) : const Color(0xFF4A5568),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF718096),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 2,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF),
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5FF).withValues(alpha: 0.5),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A2235), Color(0xFF101520)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B3A5A).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'DATABASE\nNORMALIZATION',
                  style: TextStyle(
                    color: Color(0xFF8C9EFF),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'CS 204 •\nCore',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    height: 1.2,
                  ),
                ),
              ),
              const Icon(Icons.psychology, color: Color(0xFF00E5FF), size: 16),
              const SizedBox(width: 6),
              const Text(
                'Free\nRetrieval',
                style: TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Can you explain why normalization is needed?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Without checking reference notes, reconstruct the primary rationale and architectural failure modes it resolves.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontFamily: 'Inter',
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildGraphic(),
        ],
      ),
    );
  }

  Widget _buildGraphic() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGraphicBlock(80, 48, const Color(0xFF1E293B)),
              const SizedBox(width: 12),
              Column(
                children: [
                  Row(
                    children: [
                      Container(width: 16, height: 2, color: const Color(0xFF00E5FF)),
                      const SizedBox(width: 4),
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                      const SizedBox(width: 4),
                      Container(width: 16, height: 2, color: const Color(0xFF00E5FF)),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  _buildGraphicBlock(70, 20, const Color(0xFF2A3649)),
                  const SizedBox(height: 8),
                  _buildGraphicBlock(70, 20, const Color(0xFF2A3649)),
                ],
              ),
              const SizedBox(width: 8),
              Container(
                height: 48,
                width: 16,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.white.withValues(alpha: 0.3), width: 2),
                    top: BorderSide(color: Colors.white.withValues(alpha: 0.3), width: 2),
                    bottom: BorderSide(color: Colors.white.withValues(alpha: 0.3), width: 2),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle, color: Color(0xFF00E5FF), size: 8),
              SizedBox(width: 8),
              Text(
                'ENTITY DECOUPLING ARCHITECTURE',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGraphicBlock(double width, double height, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: width * 0.6, height: 3, color: Colors.white.withValues(alpha: 0.2)),
            const SizedBox(height: 4),
            Container(width: width * 0.4, height: 3, color: Colors.white.withValues(alpha: 0.2)),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspaceArea() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.edit_note, color: Color(0xFF00E5FF), size: 20),
                SizedBox(width: 8),
                Text(
                  'Your Recall Workspace',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.lock_outline, color: Colors.white70, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'Notes closed',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF101520),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Normalization splits large tables with redundant data into smaller, related tables to eliminate insertion, update, and deletion anomalies, keeping database records consistent.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.circle, color: Color(0xFF00E5FF), size: 8),
                      SizedBox(width: 6),
                      Text(
                        '28 words reconstructed',
                        style: TextStyle(
                          color: Color(0xFF00E5FF),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Retrieved in 44s',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReferenceModel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A2235),
            border: Border(
              left: const BorderSide(color: Color(0xFF00E5FF), width: 4),
              top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              right: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            ),
          ),
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.verified_outlined, color: Color(0xFF00E5FF), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Target Reference Model',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'CONCEPT ANCHOR',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Normalization systematically organizes data across related tables to eliminate redundancy (anomalies) and ensure logical dependencies are correctly preserved.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.5,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF101520),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildChecklistItem(Icons.check_circle, const Color(0xFF8C9EFF), 'Reduces anomalies:', 'Eliminates insertion, update, and deletion discrepancies.'),
                  const SizedBox(height: 16),
                  _buildChecklistItem(Icons.check_circle, const Color(0xFF8C9EFF), 'Decomposes structures:', 'Separates monolithic flat tables into discrete relational schemas.'),
                  const SizedBox(height: 16),
                  _buildChecklistItem(Icons.remove_circle, Colors.white30, 'Maintains dependencies:', 'Preserves lossless joins and functional constraints.', isMissed: true),
                ],
              ),
            ),
          ],
        ),
      ),
    )));
  }

  Widget _buildChecklistItem(IconData icon, Color iconColor, String title, String desc, {bool isMissed = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: isMissed ? Colors.white54 : Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.4,
                fontFamily: 'Inter',
              ),
              children: [
                TextSpan(
                  text: '$title ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isMissed ? Colors.white70 : const Color(0xFF8C9EFF),
                  ),
                ),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssessmentArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: Text(
                  'How accurately did your recall map?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Metacognitive\ncalibration',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildAssessmentCard(
                  'Accurate',
                  'Anchors\ncaptured',
                  Icons.check_circle_outline,
                  isActive: _selectedAssessment == 'Accurate',
                  onTap: () => setState(() => _selectedAssessment = 'Accurate'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAssessmentCard(
                  'Partial',
                  'Missed 1\nanchor',
                  Icons.tonality,
                  isActive: _selectedAssessment == 'Partial',
                  onTap: () => setState(() => _selectedAssessment = 'Partial'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAssessmentCard(
                  'Unclear',
                  'Gaps in\nmemory',
                  Icons.refresh,
                  isActive: _selectedAssessment == 'Unclear',
                  onTap: () => setState(() => _selectedAssessment = 'Unclear'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentCard(String title, String desc, IconData icon, {bool isActive = false, VoidCallback? onTap}) {
    return _PressableCard(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1A2B3C) : const Color(0xFF101520),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? const Color(0xFF00E5FF).withValues(alpha: 0.3) : Colors.transparent,
          ),
          boxShadow: isActive ? [
            BoxShadow(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
              blurRadius: 12,
              spreadRadius: 2,
            )
          ] : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF00E5FF) : Colors.white30,
              size: 20,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? const Color(0xFF00E5FF) : Colors.white30,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return _PressableCard(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3A7CFF), Color(0xFF2855E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3A7CFF).withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Continue to Step 3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PressableCard(
          onTap: () {},
          child: Row(
            children: const [
              Icon(Icons.shuffle, color: Colors.white70, size: 16),
              SizedBox(width: 6),
              Text(
                'Try Another Drill Prompt',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.white30, shape: BoxShape.circle)),
        const SizedBox(width: 16),
        _PressableCard(
          onTap: () {},
          child: Row(
            children: const [
              Icon(Icons.bookmark_add_outlined, color: Colors.white70, size: 16),
              SizedBox(width: 6),
              Text(
                'Save to Deck',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF07111F),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.circle, color: Color(0xFF00E5FF), size: 10),
                SizedBox(width: 8),
                Text(
                  'FOCUS LOCK //\n08:42',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    height: 1.3,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                _PressableCard(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2235),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Pause',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _PressableCard(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8C9EFF), Color(0xFF5C7EFA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5C7EFA).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Submit\nStep',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF07111F),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..style = PaintingStyle.fill;
    
    const double spacing = 16.0;
    const double radius = 1.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PressableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _PressableCard({required this.child, this.onTap});

  @override
  State<_PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<_PressableCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.onTap != null) widget.onTap!();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.9 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: widget.child,
        ),
      ),
    );
  }
}
