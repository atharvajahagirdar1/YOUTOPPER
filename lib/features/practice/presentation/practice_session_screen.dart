import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/models/practice_session_models.dart';
import '../data/practice_session_data.dart';
import 'practice_hub_screen.dart' show ScaleButton;

class PracticeSessionScreen extends StatefulWidget {
  const PracticeSessionScreen({super.key});

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> with SingleTickerProviderStateMixin {
  final PracticeSession _session = demoPracticeSession;
  late final PracticeQuestion _question;
  
  String? _selectedOptionId;
  bool _isAnswerChecked = false;
  
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _question = _session.questions.first;
    
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _entranceController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic)
    );
    _entranceController.forward();
  }
  
  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _onOptionSelected(String optionId) {
    if (_isAnswerChecked) return;
    setState(() {
      _selectedOptionId = optionId;
    });
  }

  void _checkAnswer() {
    if (_selectedOptionId == null) return;
    setState(() {
      _isAnswerChecked = true;
    });
  }

  void _nextQuestion() {
    context.go('${GoRouterState.of(context).uri.toString()}/results');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B14),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text('Practice Session', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.white70), onPressed: () {}),
          IconButton(icon: const Icon(Icons.tune, color: Colors.white70), onPressed: () {}),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF80CBC4),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: const Color(0xFF80CBC4).withValues(alpha: 0.3), blurRadius: 8),
              ],
            ),
            padding: const EdgeInsets.all(2),
            child: const Icon(Icons.person, color: Color(0xFF07111F), size: 20),
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildAmbientBackground(),
          SafeArea(
            bottom: false,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 140, top: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProgressTrack(),
                      const SizedBox(height: 24),
                      _buildContextArea(),
                      const SizedBox(height: 28),
                      if (_question.visualData != null) _buildVisualArea(),
                      const SizedBox(height: 32),
                      _buildQuestionArea(),
                      const SizedBox(height: 28),
                      _buildOptionsArea(),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topCenter,
                        child: _isAnswerChecked && _question.feedback != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: _buildFeedbackArea(),
                              )
                            : const SizedBox(width: double.infinity),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildBottomActionArea(),
        ],
      ),
    );
  }

  Widget _buildAmbientBackground() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Dot grid
          Positioned.fill(
            child: CustomPaint(
              painter: _AmbientGridPainter(),
            ),
          ),
          // Glows
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withValues(alpha: 0.05),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.05), blurRadius: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3A7CFF).withValues(alpha: 0.04),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.04), blurRadius: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTrack() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.5, end: 1.0),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeInOut,
                    builder: (context, val, child) {
                      return Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.5 * val), blurRadius: 6 * val),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('IN PROGRESS', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ],
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '0${_question.number}', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.bold)),
                    TextSpan(text: ' / 0${_session.totalQuestions}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_session.totalQuestions, (index) {
              bool isPast = index < _question.number - 1;
              bool isCurrent = index == _question.number - 1;
              
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index == _session.totalQuestions - 1 ? 0 : 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151926),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1) , blurStyle: BlurStyle.inner),
                    ],
                  ),
                  child: (isPast || isCurrent)
                      ? TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: isPast ? 1.0 : 0.5),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                          builder: (context, val, child) {
                            return FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: val,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3A7CFF),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.6), blurRadius: 6),
                                  ],
                                ),
                              ),
                            );
                          }
                        )
                      : null,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildContextArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_tree_outlined, color: Color(0xFF00E5FF), size: 12),
                const SizedBox(width: 8),
                Text(
                  '${_session.subject} · ${_session.chapter} · ${_session.topic}'.toUpperCase(),
                  style: const TextStyle(color: Colors.white60, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _session.title,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 26, 
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualArea() {
    if (_question.visualData is FunctionalDependencyVisual) {
      final visual = _question.visualData as FunctionalDependencyVisual;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0A111C),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8)),
              BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.05), blurRadius: 30),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _SessionDotMatrixPainter()),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(visual.headerIcon, color: Colors.white60, size: 16),
                              const SizedBox(width: 8),
                              Text(visual.headerTitle, style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF051B24),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.4)),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.2), blurRadius: 8),
                              ],
                            ),
                            child: Text(visual.pillText, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Determinant
                      _buildVisualNode(visual.determinant.title, visual.determinant.role, true),
                      
                      // Arrow
                      Column(
                        children: [
                          _buildAnimatedLine(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF07111F),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.3)),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 4, offset: const Offset(0, 2)),
                              ],
                            ),
                            child: Text(visual.relationshipText, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                          ),
                          _buildAnimatedLine(),
                        ],
                      ),
                      
                      // Dependent
                      _buildVisualNode(visual.dependent.title, visual.dependent.role, false),
                      
                      const SizedBox(height: 32),
                      
                      // Footer
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF131B2B).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline, color: Color(0xFF80CBC4), size: 14),
                            const SizedBox(width: 8),
                            Text(visual.footerText, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
                          ],
                        ),
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
    return const SizedBox.shrink();
  }

  Widget _buildAnimatedLine() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, val, child) {
        return Container(
          width: 1.5,
          height: 16 * val,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.1),
                const Color(0xFF00E5FF).withValues(alpha: 0.5),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVisualNode(String title, String role, bool isDeterminant) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4)),
          if (isDeterminant)
            BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.15), blurRadius: 20),
          BoxShadow(color: Colors.white.withValues(alpha: 0.02), blurRadius: 2, offset: const Offset(0, -1), blurStyle: BlurStyle.inner),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isDeterminant ? const Color(0xFF3A7CFF) : const Color(0xFF80CBC4),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isDeterminant ? const Color(0xFF3A7CFF).withValues(alpha: 0.6) : const Color(0xFF80CBC4).withValues(alpha: 0.4), 
                  blurRadius: 8
                )
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2638),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black26),
            ),
            child: Text(role, style: const TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'QUESTION 0${_question.number}',
                style: const TextStyle(color: Color(0xFF80CBC4), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('·', style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const Text(
                'Single Correct',
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _question.text,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              fontWeight: FontWeight.w600, 
              height: 1.4,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _question.options.map((option) {
          bool isSelected = _selectedOptionId == option.id;
          bool isCorrect = option.id == _question.correctAnswerId;
          
          Color borderColor = Colors.white.withValues(alpha: 0.04);
          Color bgColor = const Color(0xFF0F1522);
          List<BoxShadow>? shadows = [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4)),
            BoxShadow(color: Colors.white.withValues(alpha: 0.02), blurRadius: 2, offset: const Offset(0, -1)),
          ];
          
          if (isSelected) {
            if (_isAnswerChecked) {
              borderColor = isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444);
              bgColor = isCorrect ? const Color(0xFF14B8A6).withValues(alpha: 0.08) : const Color(0xFFEF4444).withValues(alpha: 0.08);
              shadows = [
                BoxShadow(color: borderColor.withValues(alpha: 0.2), blurRadius: 16),
              ];
            } else {
              borderColor = const Color(0xFF3A7CFF).withValues(alpha: 0.6);
              bgColor = const Color(0xFF3A7CFF).withValues(alpha: 0.08);
              shadows = [
                BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.2), blurRadius: 16, offset: const Offset(0, 4)),
                BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2), blurStyle: BlurStyle.inner),
              ];
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ScaleButton(
              onTap: () => _onOptionSelected(option.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1.0),
                  boxShadow: shadows,
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (_isAnswerChecked 
                                ? (isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444)) 
                                : const Color(0xFF3A7CFF))
                            : const Color(0xFF192132),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: (_isAnswerChecked 
                                ? (isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444)) 
                                : const Color(0xFF3A7CFF)).withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ] : null,
                      ),
                      child: Center(
                        child: Text(
                          option.label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white54,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.title,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontSize: 15,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                          if (option.subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              option.subtitle!,
                              style: TextStyle(
                                color: isSelected ? Colors.white70 : Colors.white38, 
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? (_isAnswerChecked ? (isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444)) : const Color(0xFF3A7CFF)) 
                            : const Color(0xFF0F1522),
                        shape: BoxShape.circle,
                        border: isSelected ? null : Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: (_isAnswerChecked ? (isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444)) : const Color(0xFF3A7CFF)).withValues(alpha: 0.4),
                            blurRadius: 8,
                          )
                        ] : [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 4, blurStyle: BlurStyle.inner)
                        ],
                      ),
                      child: isSelected
                          ? Icon(
                              _isAnswerChecked 
                                ? (isCorrect ? Icons.check : Icons.close) 
                                : Icons.check, 
                              color: Colors.white, 
                              size: 16
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeedbackArea() {
    final feedback = _question.feedback!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1421),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8)),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: feedback.isCorrect ? const Color(0xFF14B8A6).withValues(alpha: 0.1) : const Color(0xFFEF4444).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(feedback.isCorrect ? Icons.verified_user : Icons.error_outline, 
                       color: feedback.isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444), size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  feedback.title,
                  style: TextStyle(
                    color: feedback.isCorrect ? const Color(0xFF14B8A6) : const Color(0xFFEF4444), 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              feedback.description,
              style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.6, fontWeight: FontWeight.w400),
            ),
            if (feedback.visualElements != null && feedback.visualElements!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Row(
                children: feedback.visualElements!.map((el) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: el == feedback.visualElements!.last ? 0 : 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF151C2B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(el.icon, color: Colors.white54, size: 20),
                          const SizedBox(height: 12),
                          Text(el.title, style: const TextStyle(color: Color(0xFF80CBC4), fontSize: 12, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(el.subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            if (feedback.whyThisHolds != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0B192C),
                      const Color(0xFF0B192C).withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.15)),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.05), blurRadius: 20),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb_outline, color: Color(0xFF00E5FF), size: 16),
                        const SizedBox(width: 8),
                        Text('WHY THIS HOLDS', style: TextStyle(color: const Color(0xFF00E5FF).withValues(alpha: 0.9), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      feedback.whyThisHolds!,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionArea() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            decoration: BoxDecoration(
              color: const Color(0xFF050B14).withValues(alpha: 0.85),
              border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 30, offset: const Offset(0, -10)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF131B2B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: const Icon(Icons.flag_outlined, color: Colors.white60),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _isAnswerChecked
                        ? _buildNextButton()
                        : _buildCheckButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      key: const ValueKey('next'),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2338),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _nextQuestion,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 48), // balance
                Text(
                  'Next Question (${_question.number + 1} of ${_session.totalQuestions})',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.4), blurRadius: 8),
                      ],
                    ),
                    child: const Icon(Icons.arrow_forward, color: Color(0xFF050B14), size: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckButton() {
    bool isEnabled = _selectedOptionId != null;
    return Container(
      key: const ValueKey('check'),
      decoration: BoxDecoration(
        gradient: isEnabled ? LinearGradient(
          colors: [
            const Color(0xFF3A7CFF),
            const Color(0xFF2A5BBF),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ) : null,
        color: isEnabled ? null : const Color(0xFF131B2B),
        borderRadius: BorderRadius.circular(16),
        border: isEnabled ? null : Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: isEnabled ? [
          BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 6)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
        ] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? _checkAnswer : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'Check Answer',
                style: TextStyle(
                  color: isEnabled ? Colors.white : Colors.white38,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionDotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;

    const double spacing = 16.0;
    const double radius = 1.0;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AmbientGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const double spacing = 40.0;
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
