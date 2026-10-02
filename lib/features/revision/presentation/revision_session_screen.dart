import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';

import '../domain/models/revision_session_models.dart';

class RevisionSessionScreen extends StatefulWidget {
  const RevisionSessionScreen({super.key});

  @override
  State<RevisionSessionScreen> createState() => _RevisionSessionScreenState();
}

class _RevisionSessionScreenState extends State<RevisionSessionScreen> {
  bool _isRevealed = false;
  String? _selectedRecognitionId;
  String? _selectedAssessmentId;

  final RevisionSessionData _data = const RevisionSessionData(
    currentConceptIndex: 2,
    totalConcepts: 4,
    subject: 'DBMS',
    chapter: 'CHAPTER 3',
    lastReviewed: '4d ago',
    conceptTitle: 'Functional Dependencies',
    description: 'Refresh the core constraint before tackling Normal Forms. Take your time to recall.',
    recallAnchor: RecallAnchorData(
      flowTime: '~8 min flow',
      question: 'What does *Student_ID* determine in this schema?',
      determinantText: 'Student_ID',
      determinantSub: 'Determinant (X)',
      dependentTextHidden: '[  ?  \n?  ?  ?\n   ]',
      dependentTextRevealed: 'Student_Name',
      dependentSub: 'Dependent (Y)',
      relationText: 'determines',
    ),
    tableAnchor: TableAnchorData(
      title: 'Concrete Anchor Table',
      tupleCount: '3 Tuples',
      headers: ['Student_ID', 'Student_Name'],
      rows: [
        ['101', 'Atharva'],
        ['102', 'Riya'],
        ['103', 'Aman'],
      ],
      note: 'Notice how every distinct *Student_ID* maps to exactly one *Student_Name*. There is zero ambiguity in mapping.',
    ),
    universalRule: UniversalRuleData(
      title: 'UNIVERSAL RULE',
      equation: 'X → Y',
      text: '"Whenever two tuples agree on attribute X, they must also agree on attribute Y."',
      leftSub: 'Formal name: Functional\nDeterminancy',
      rightSub: "Armstrong's\nAxioms",
    ),
    recognitionCheck: RecognitionCheckData(
      question: 'If each unique *Student_ID* determines a specific *Student_Name*, what is this relational rule called?',
      options: [
        RecognitionOption(id: '1', text: 'Functional Dependency', isCorrect: true, badge: 'Familiar'),
        RecognitionOption(id: '2', text: 'Foreign Key Constraint', isCorrect: false),
        RecognitionOption(id: '3', text: 'Multivalued Dependency', isCorrect: false),
      ],
      feedback: 'Spot on — that connection is crystal clear again.',
    ),
    nextConceptTitle: '2NF Decomposition',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home/revision');
            }
          },
        ),
        title: const Text('Database Normalization', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white), onPressed: () {}),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xFFB388FF),
              child: Icon(Icons.person, color: Color(0xFF151926), size: 18),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _DotMatrixPainter(),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                _buildProgressHeader(),
                const SizedBox(height: 24),
                _buildMetadata(),
                const SizedBox(height: 12),
                Text(_data.conceptTitle, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                Text(_data.description, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14, height: 1.4)),
                const SizedBox(height: 32),
                _buildMemoryAnchor(),
                
                // Animated Reveal Section
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: _isRevealed ? Column(
                    children: [
                      const SizedBox(height: 32),
                      _buildTableAnchor(),
                      const SizedBox(height: 32),
                      _buildUniversalRule(),
                      const SizedBox(height: 32),
                      _buildRecognitionCheck(),
                      const SizedBox(height: 32),
                      _buildSelfAssessment(),
                    ],
                  ) : const SizedBox.shrink(),
                ),
                const SizedBox(height: 140), // Padding for sticky bottom
              ],
            ),
          ),
          
          // Sticky Bottom Action (Fades in when revealed, or is it always there? Let's show it only when revealed or maybe it's the final action)
          if (_isRevealed)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomAction(),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                const Text('ACTIVE SESSION', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ],
            ),
            Text('Concept ${_data.currentConceptIndex} of ${_data.totalConcepts}', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_data.totalConcepts - 1, (index) {
            bool isActive = index < _data.currentConceptIndex;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index == _data.totalConcepts - 2 ? 0 : 8),
                height: 4,
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF00E5FF) : const Color(0xFF1E2435),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isActive ? [const BoxShadow(color: Color(0xFF00E5FF), blurRadius: 4, offset: Offset(0, 1))] : [],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMetadata() {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF252A36),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${_data.subject} · ${_data.chapter}',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        Text('· Last reviewed ${_data.lastReviewed}', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildMemoryAnchor() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF12151E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text('PEDAGOGICAL MEMORY ANCHOR', style: TextStyle(color: Color(0xFFB388FF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.pie_chart_outline, color: Color(0xFF00E5FF), size: 14),
                  const SizedBox(width: 4),
                  Text(_data.recallAnchor.flowTime, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('COGNITIVE RECALL TARGET', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          _parseMarkup(_data.recallAnchor.question, baseStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, height: 1.4)),
          const SizedBox(height: 24),
          
          // Diagram
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0C12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: const Color(0xFF1E2435), borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.key_outlined, color: Colors.white54, size: 14),
                            const SizedBox(width: 6),
                            Flexible(child: Text(_data.recallAnchor.determinantText, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_data.recallAnchor.determinantSub, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                    ],
                  ),
                ),
                
                // Arrow
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDashes(),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _isRevealed ? const Color(0xFF00E5FF).withValues(alpha: 0.15) : const Color(0xFF1E2435), 
                              shape: BoxShape.circle,
                              boxShadow: _isRevealed ? [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.3), blurRadius: 8)] : [],
                            ),
                            child: Icon(Icons.arrow_forward, color: _isRevealed ? const Color(0xFF00E5FF) : Colors.white54, size: 12),
                          ),
                          _buildDashes(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(_data.recallAnchor.relationText, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ),
                
                // Right
                Expanded(
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: _isRevealed
                            ? Container(
                                key: const ValueKey('revealed'),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(color: const Color(0xFF1E2435), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.3))),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.person_outline, color: Color(0xFF00E5FF), size: 14),
                                    const SizedBox(width: 6),
                                    Flexible(child: Text(_data.recallAnchor.dependentTextRevealed, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                                  ],
                                ),
                              )
                            : Container(
                                key: const ValueKey('hidden'),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(color: const Color(0xFF151926), borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    const Text('[  ?  ]', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.lock_outline, color: Colors.white54, size: 12),
                                        const SizedBox(width: 4),
                                        const Text('?  ?  ?', style: TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const Text('[     ]', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 8),
                      Text(_data.recallAnchor.dependentSub, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          if (!_isRevealed) ...[
            const SizedBox(height: 24),
            _ScaleButton(
              onTap: () => setState(() => _isRevealed = true),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Color(0xFF6B5DE6), Color(0xFF4530B3)]),
                  boxShadow: [BoxShadow(color: const Color(0xFF6B5DE6).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Reveal Key Idea', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildDashes() {
    return Row(
      children: List.generate(4, (index) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 4,
        height: 1,
        color: _isRevealed ? const Color(0xFF00E5FF).withValues(alpha: 0.5) : Colors.white30,
      )),
    );
  }

  Widget _buildTableAnchor() {
    if (_data.tableAnchor == null) return const SizedBox.shrink();
    final table = _data.tableAnchor!;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.table_chart_outlined, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(table.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Text(table.tupleCount, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Table
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E2435),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.key_outlined, color: Colors.white54, size: 14),
                            const SizedBox(width: 6),
                            Expanded(child: Text(table.headers[0], style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.person_outline, color: Color(0xFF00E5FF), size: 14),
                            const SizedBox(width: 6),
                            Expanded(child: Text(table.headers[1], style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 13, fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Rows
                ...table.rows.asMap().entries.map((entry) {
                  int idx = entry.key;
                  List<String> row = entry.value;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: idx % 2 == 0 ? const Color(0xFF10131E) : const Color(0xFF151926),
                      border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.03))),
                      borderRadius: idx == table.rows.length - 1 ? const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)) : BorderRadius.zero,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(row[0], style: const TextStyle(color: Colors.white, fontSize: 13))),
                        Expanded(child: Text(row[1], style: const TextStyle(color: Colors.white, fontSize: 13))),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          // Note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2435),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline, color: Color(0xFF00E5FF), size: 18),
                const SizedBox(width: 12),
                Expanded(child: _parseMarkup(table.note, baseStyle: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUniversalRule() {
    if (_data.universalRule == null) return const SizedBox.shrink();
    final rule = _data.universalRule!;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bookmark_outline, color: Colors.white54, size: 18),
              const SizedBox(width: 8),
              Text(rule.title, style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(color: const Color(0xFF0A0C12), borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(rule.equation, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          Text(rule.text, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(rule.leftSub, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.4))),
              Expanded(child: Text(rule.rightSub, style: const TextStyle(color: Color(0xFFB388FF), fontSize: 11, height: 1.4, fontWeight: FontWeight.w600), textAlign: TextAlign.right)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecognitionCheck() {
    if (_data.recognitionCheck == null) return const SizedBox.shrink();
    final check = _data.recognitionCheck!;
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.track_changes_outlined, color: Color(0xFF00E5FF), size: 20),
                  const SizedBox(width: 8),
                  const Text('Can you recognize it?', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const Text('Check-in', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          _parseMarkup(check.question, baseStyle: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
          const SizedBox(height: 20),
          
          ...check.options.map((opt) {
            bool isSelected = _selectedRecognitionId == opt.id;
            return GestureDetector(
              onTap: () => setState(() => _selectedRecognitionId = opt.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2A3A) : const Color(0xFF10131E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? const Color(0xFF00E5FF).withValues(alpha: 0.5) : Colors.transparent),
                  boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4))] : [],
                ),
                child: Row(
                  children: [
                    Icon(isSelected ? Icons.check_circle : Icons.circle, color: isSelected ? const Color(0xFF00E5FF) : Colors.white24, size: 20),
                    const SizedBox(width: 12),
                    Expanded(child: Text(opt.text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal))),
                    if (isSelected && opt.badge != null)
                      Text(opt.badge!, style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          }),
          
          if (_selectedRecognitionId != null && check.options.firstWhere((o) => o.id == _selectedRecognitionId).isCorrect)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2A3A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 18),
                  const SizedBox(width: 12),
                  Expanded(child: Text(check.feedback, style: const TextStyle(color: Colors.white, fontSize: 12))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelfAssessment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('How does this feel now?', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Calibrate your revision queue without pressure.', style: TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildAssessmentCard('1', Icons.sentiment_satisfied_alt, 'Solid', 'Move on', const Color(0xFF00E5FF)),
            const SizedBox(width: 12),
            _buildAssessmentCard('2', Icons.sentiment_neutral, 'A bit fuzzy', 'Queue in 2d', Colors.white70),
            const SizedBox(width: 12),
            _buildAssessmentCard('3', Icons.refresh, 'Review once', 'Replay cue', Colors.white70),
          ],
        ),
      ],
    );
  }

  Widget _buildAssessmentCard(String id, IconData icon, String title, String sub, Color iconColor) {
    bool isSelected = _selectedAssessmentId == id;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedAssessmentId = id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E2A3A) : const Color(0xFF1E2435),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? const Color(0xFF00E5FF).withValues(alpha: 0.5) : Colors.transparent),
            boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 4))] : [],
          ),
          child: Column(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ScaleButton(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Color(0xFF6B5DE6), Color(0xFF4530B3)]),
                  boxShadow: [BoxShadow(color: const Color(0xFF6B5DE6).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text('Next Concept: ${_data.nextConceptTitle}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home/revision');
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white54, size: 14),
                      const SizedBox(width: 4),
                      const Text('Back to Revision Queue', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Text('Concept ${_data.currentConceptIndex} of ${_data.totalConcepts}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Simple markup parser to turn *Text* into cyan colored text
  Widget _parseMarkup(String text, {required TextStyle baseStyle}) {
    List<TextSpan> spans = [];
    List<String> parts = text.split('*');
    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 1) {
        // It's inside asterisks
        spans.add(TextSpan(text: parts[i], style: baseStyle.copyWith(color: const Color(0xFF00E5FF))));
      } else {
        spans.add(TextSpan(text: parts[i], style: baseStyle));
      }
    }
    return RichText(text: TextSpan(children: spans));
  }
}

class _ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _ScaleButton({required this.child, required this.onTap});

  @override
  State<_ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<_ScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.98).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

class _DotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.03)
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
