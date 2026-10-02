import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../domain/models/practice_results_models.dart';
import '../data/practice_results_data.dart';
import 'practice_hub_screen.dart' show ScaleButton;

class PracticeResultsScreen extends StatefulWidget {
  const PracticeResultsScreen({super.key});

  @override
  State<PracticeResultsScreen> createState() => _PracticeResultsScreenState();
}

class _PracticeResultsScreenState extends State<PracticeResultsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = demoPracticeResult;

    return Scaffold(
      backgroundColor: const Color(0xFF090D14), // Deeper navy
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _AmbientGridPainter())),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight + 24, // More breathing room
                bottom: 80, // More footer breathing room
              ),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FadeSlide(
                    animation: _entranceController,
                    interval: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
                    child: _buildProgressTrack(),
                  ),
                  const SizedBox(height: 32),
                  _FadeSlide(
                    animation: _entranceController,
                    interval: const Interval(0.1, 0.5, curve: Curves.easeOutCubic),
                    child: _buildHeader(result),
                  ),
                  const SizedBox(height: 32),
                  _FadeSlide(
                    animation: _entranceController,
                    interval: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
                    child: _buildSessionAccuracy(result),
                  ),
                  const SizedBox(height: 24),
                  _FadeSlide(
                    animation: _entranceController,
                    interval: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
                    child: _buildStatsRow(result),
                  ),
                  if (result.attentionConcepts.isNotEmpty) ...[
                    const SizedBox(height: 48), // Increased spacing
                    _FadeSlide(
                      animation: _entranceController,
                      interval: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
                      child: _buildNeedsAnotherLook(result),
                    ),
                  ],
                  if (result.successfulConcepts.isNotEmpty) ...[
                    const SizedBox(height: 48), // Increased spacing
                    _FadeSlide(
                      animation: _entranceController,
                      interval: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
                      child: _buildWhatYouDidWell(result),
                    ),
                  ],
                  const SizedBox(height: 48),
                  _FadeSlide(
                    animation: _entranceController,
                    interval: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
                    child: _buildBottomActions(context, result),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ScaleButton(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF131824),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
      ),
      title: const Text('Practice Results', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
      centerTitle: false,
      actions: [
        IconButton(icon: const Icon(Icons.more_vert, color: Colors.white70), onPressed: () {}),
        Container(
          margin: const EdgeInsets.only(right: 20, left: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE6E6FA), // Soft lavender
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(Icons.person, color: Color(0xFF333333), size: 16),
        ),
      ],
    );
  }

  Widget _buildProgressTrack() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF131824),
          borderRadius: BorderRadius.circular(24), // Capsule
          border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProgressStep('Understand', false, isPast: true),
            _buildProgressDivider(),
            _buildProgressStep('Practice', false, isPast: true),
            _buildProgressDivider(),
            _buildProgressStep('Reflect', true),
            _buildProgressDivider(),
            _buildProgressStep('Master', false),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String label, bool active, {bool isPast = false}) {
    if (active) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2838),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2)),
            BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.6), blurRadius: 4)],
              ),
            ),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: isPast ? const Color(0xFF475569) : const Color(0xFF334155),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: isPast ? const Color(0xFF94A3B8) : const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildProgressDivider() {
    return Container(width: 12, height: 1, color: const Color(0xFF334155));
  }

  Widget _buildHeader(PracticeResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF131824),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.2)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 2, offset: const Offset(0, 1)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('PRACTICE COMPLETE', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '· ${result.totalQuestions} Questions', 
                  style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            result.session.title,
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5, height: 1.2),
          ),
          const SizedBox(height: 8),
          Text(
            '${result.session.subject} · ${result.session.chapter} · ${result.session.topic}',
            style: const TextStyle(color: Colors.white54, fontSize: 13, height: 1.4, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionAccuracy(PracticeResult result) {
    final correctQs = result.questionStatuses.entries
        .where((e) => e.value == AnswerStatus.correct)
        .map((e) => 'Q${e.key}')
        .join(', ');
        
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _NeumorphicSurface(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
        borderRadius: 24,
        isHero: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: _buildAnimatedResultRing(result)),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('QUESTION BREAKDOWN', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                Expanded(
                  child: Text(
                    '$correctQs Clear', 
                    style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 9, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(result.totalQuestions, (index) {
                final int qNum = index + 1;
                final bool isCorrect = result.questionStatuses[qNum] == AnswerStatus.correct;
                
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index == result.totalQuestions - 1 ? 0 : 6),
                    child: Column(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: isCorrect ? const Color(0xFF00E5FF) : const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: isCorrect ? [
                              BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.3), blurRadius: 4),
                            ] : [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 2, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Q$qNum', 
                          style: TextStyle(
                            color: isCorrect ? Colors.white : const Color(0xFF94A3B8), 
                            fontSize: 9, 
                            fontWeight: isCorrect ? FontWeight.w700 : FontWeight.w500,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0B101A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 8, offset: const Offset(0, 4), blurStyle: BlurStyle.inner),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132838),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.lightbulb_outline, color: Color(0xFF00E5FF), size: 16),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'Diagnostic takeaway: ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          TextSpan(text: result.diagnosticTakeaway, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
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

  Widget _buildAnimatedResultRing(PracticeResult result) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: result.accuracy),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        final int percentage = (value * 100).round();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0A0F1A),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 16, offset: const Offset(0, 8), blurStyle: BlurStyle.inner),
                      ],
                    ),
                  ),
                  CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 10,
                    color: const Color(0xFF161E2E),
                  ),
                  CustomPaint(
                    size: const Size(160, 160),
                    painter: _ProgressArcPainter(
                      progress: value,
                      color: const Color(0xFF29B6F6),
                      strokeWidth: 10,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('${result.correctCount}', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: -1.0, height: 1.0)),
                          const Text('/', style: TextStyle(color: Color(0xFFD4B595), fontSize: 32, fontWeight: FontWeight.bold, height: 1.0)),
                          Text('${result.totalQuestions}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1.0, height: 1.0)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('ANSWERED', style: TextStyle(color: Color(0xFFD4B595), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2333),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4)),
                  BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xFF29B6F6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF29B6F6).withValues(alpha: 0.6), blurRadius: 4),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$percentage% Precision Index',
                    style: const TextStyle(color: Color(0xFF29B6F6), fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatsRow(PracticeResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildStatCard('Correct', '${result.correctCount}', const Color(0xFF00E5FF)),
          const SizedBox(width: 12),
          _buildStatCard('Revisit', '${result.incorrectCount}', Colors.white),
          const SizedBox(width: 12),
          _buildStatCard('Skipped', '${result.skippedCount}', Colors.white),
          const SizedBox(width: 12),
          _buildStatCard('Pace / Q', result.pacePerQuestion, Colors.white),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor) {
    return Expanded(
      child: _NeumorphicSurface(
        padding: const EdgeInsets.symmetric(vertical: 16),
        borderRadius: 16,
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildNeedsAnotherLook(PracticeResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    child: const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 14),
                  ),
                  const SizedBox(width: 12),
                  const Text('NEEDS ANOTHER LOOK', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ],
              ),
              Text('${result.attentionConcepts.length} Opportunities', style: const TextStyle(color: Colors.white54, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 20),
          ...result.attentionConcepts.map((ac) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _InteractiveCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B), // Inset pill
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(0, 1), blurStyle: BlurStyle.inner)],
                        ),
                        child: Text(ac.questionLabel, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(ac.title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(ac.description, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2838),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(ac.actionIcon, color: Colors.white, size: 14),
                          const SizedBox(width: 8),
                          Text(ac.actionLabel, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildWhatYouDidWell(PracticeResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF132838),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.2), blurRadius: 4)],
                ),
                child: const Icon(Icons.check, color: Color(0xFF00E5FF), size: 14),
              ),
              const SizedBox(width: 12),
              const Text('WHAT YOU DID WELL', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 20),
          ...result.successfulConcepts.map((sc) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _InteractiveCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2639),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 4, offset: const Offset(0, 2), blurStyle: BlurStyle.inner),
                        BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 1, offset: const Offset(0, 1)),
                      ],
                    ),
                    child: Icon(sc.icon, color: const Color(0xFF00E5FF), size: 16),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(sc.title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))),
                            Text(sc.rightLabel, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(sc.description, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, PracticeResult result) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ScaleButton(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5A5FDE), Color(0xFF4338CA)], // Refined indigo
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF4338CA).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6)),
                  BoxShadow(color: Colors.white.withValues(alpha: 0.2), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_fix_high, color: Colors.white, size: 18),
                  const SizedBox(width: 12),
                  Text('Review Weak Areas (${result.incorrectCount} Qs)', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ScaleButton(
                  onTap: () {},
                  child: _NeumorphicSurface(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    borderRadius: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.refresh, color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        const Text('Practice Again', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ScaleButton(
                  onTap: () => context.go('/home/practice'),
                  child: _NeumorphicSurface(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    borderRadius: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.grid_view, color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        const Text('Practice Hub', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_done_outlined, color: Colors.white38, size: 14),
              const SizedBox(width: 8),
              const Text('Session archived to your Chapter Mastery Ledger', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: Neumorphic Surface
// ---------------------------------------------------------
class _NeumorphicSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isHero;

  const _NeumorphicSurface({
    required this.child,
    required this.padding,
    this.borderRadius = 16,
    this.isHero = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF131824),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: isHero ? const Color(0xFF00E5FF).withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.03)),
        boxShadow: [
          // Ambient shadow (soft deep drop)
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          // Contact shadow (tight drop)
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
          // Inner top/left highlight
          BoxShadow(
            color: isHero ? const Color(0xFF00E5FF).withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.03),
            blurRadius: 1,
            offset: const Offset(0, 1),
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: Interactive Card
// ---------------------------------------------------------
class _InteractiveCard extends StatefulWidget {
  final Widget child;

  const _InteractiveCard({required this.child});

  @override
  State<_InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<_InteractiveCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutQuad,
        padding: const EdgeInsets.all(24), // Comfortable internal spacing
        transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFF131824),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.05)),
          boxShadow: _isPressed
              ? [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 4, offset: const Offset(0, 2), blurStyle: BlurStyle.inner),
                ]
              : [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 8)),
                  BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2)),
                  BoxShadow(color: Colors.white.withValues(alpha: 0.03), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: FadeSlide Entrance Animation
// ---------------------------------------------------------
class _FadeSlide extends StatelessWidget {
  final Animation<double> animation;
  final Interval interval;
  final Widget child;

  const _FadeSlide({
    required this.animation,
    required this.interval,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final double t = interval.transform(animation.value);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - t)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

// ---------------------------------------------------------
// PAINTER: Progress Arc Glow
// ---------------------------------------------------------
class _ProgressArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _ProgressArcPainter({required this.progress, required this.color, this.strokeWidth = 6.0});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * progress;

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Paint glowPaint = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..strokeWidth = strokeWidth + 2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..style = PaintingStyle.stroke;

    canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ProgressArcPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

// ---------------------------------------------------------
// PAINTER: Ambient Grid Texture
// ---------------------------------------------------------
class _AmbientGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint dotPaint = Paint()
      ..color = const Color(0xFFffffff).withValues(alpha: 0.02) // Faint dot texture
      ..style = PaintingStyle.fill;
      
    const double spacing = 28.0;
    
    // Draw faint grid dots
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.8, dotPaint);
      }
    }
    
    // Draw extremely subtle blue atmospheric gradient
    _drawOrb(canvas, size, const Offset(0.2, 0.05), const Color(0xFF00E5FF).withValues(alpha: 0.02), 200);
    _drawOrb(canvas, size, const Offset(0.8, 0.5), const Color(0xFF3A7CFF).withValues(alpha: 0.02), 250);
  }
  
  void _drawOrb(Canvas canvas, Size size, Offset relativePos, Color color, double radius) {
    final center = Offset(size.width * relativePos.dx, size.height * relativePos.dy);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
      
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
