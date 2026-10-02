import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/models/practice_models.dart';

class PracticeHubScreen extends StatefulWidget {
  const PracticeHubScreen({super.key});

  @override
  State<PracticeHubScreen> createState() => _PracticeHubScreenState();
}

class _PracticeHubScreenState extends State<PracticeHubScreen> {
  late PracticeHubData _data;
  String _selectedFilterId = 'all';

  @override
  void initState() {
    super.initState();
    _loadDemoData();
  }

  void _loadDemoData() {
    _data = PracticeHubData(
      totalSetsReady: 3,
      filters: const [
        PracticeFilter(id: 'all', label: 'All Sets', count: 3),
        PracticeFilter(id: 'concept', label: 'Concept Check'),
        PracticeFilter(id: 'problem', label: 'Problem Solving'),
      ],
      recommendedSet: const PracticeSet(
        id: 'rec_1',
        subject: 'DBMS',
        chapter: 'Chapter 3',
        title: 'Database Normalization',
        description: 'Test functional dependencies, BCNF decomposition & anomaly elimination with authentic schema scenarios.',
        questionCount: 8,
        estimatedMinutes: 14,
        difficulty: 'Medium Depth',
        isRecommended: true,
        overviewSteps: [
          PracticeStep(label: 'Learn', icon: Icons.lightbulb_outline),
          PracticeStep(label: 'Question', icon: Icons.help_outline),
          PracticeStep(label: 'Solve', icon: Icons.build_circle_outlined),
          PracticeStep(label: 'Understand', icon: Icons.verified_user_outlined),
        ],
      ),
      inProgressSet: const PracticeSet(
        id: 'prog_1',
        subject: 'DBMS',
        chapter: 'Chapter 3',
        title: 'DBMS — Functional Depen...',
        progressSubtitle: 'Left off at Candidate Key derivation ...',
        questionCount: 8,
        estimatedMinutes: 14,
        difficulty: 'Medium',
        isInProgress: true,
        progressStep: 4,
        totalSteps: 8,
      ),
      topicSets: const [
        PracticeSet(
          id: 'topic_1',
          subject: 'Data Structures & Algorithms',
          chapter: 'C...',
          title: 'Binary Search Trees',
          questionCount: 6,
          estimatedMinutes: 10,
          difficulty: 'Medium',
          topicIcon: Icons.account_tree_outlined,
        ),
        PracticeSet(
          id: 'topic_2',
          subject: 'Operating Systems',
          chapter: 'Ch. 4',
          title: 'Process Scheduling & ...',
          questionCount: 8,
          estimatedMinutes: 15,
          difficulty: 'Medium',
          topicIcon: Icons.memory,
        ),
        PracticeSet(
          id: 'topic_3',
          subject: 'Computer Networks',
          chapter: 'Ch. 2',
          title: 'TCP/IP Protocol Suite',
          questionCount: 5,
          estimatedMinutes: 8,
          difficulty: 'Easy',
          topicIcon: Icons.layers_outlined,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E111A),
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
            _buildAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  _buildTopInfoCard(),
                  const SizedBox(height: 24),
                  _buildFilters(),
                  const SizedBox(height: 24),
                  if (_data.recommendedSet != null) _buildRecommendedCard(_data.recommendedSet!),
                  const SizedBox(height: 24),
                  if (_data.inProgressSet != null) _buildInProgressCard(_data.inProgressSet!),
                  const SizedBox(height: 32),
                  _buildPracticeByTopicSection(),
                  const SizedBox(height: 32),
                  _buildBottomInfoCard(),
                  const SizedBox(height: 40),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF151926),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Practice Hub', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Turn what you learned into real u...', style: TextStyle(color: Colors.white60, fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF151926),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFB388FF).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, color: Color(0xFFB388FF), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTopInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.5), blurRadius: 4)],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Practice Workspace', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10131E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${_data.totalSetsReady} Sets Ready', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Turn conceptual models into intuitive problem-solving instinct. Complete targeted challenges to lock in mental retention.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.psychology, color: Colors.white54, size: 16),
              const SizedBox(width: 6),
              const Text('Active Retrieval Mode', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(width: 16),
              const Icon(Icons.settings_suggest, color: Color(0xFF00E5FF), size: 16),
              const SizedBox(width: 6),
              const Text('Spaced Spacing: Calibrated', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _data.filters.map((filter) {
          bool isSelected = _selectedFilterId == filter.id;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterId = filter.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6B5DE6) : const Color(0xFF151926),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.05)),
                boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF6B5DE6).withValues(alpha: 0.3), blurRadius: 8)] : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected) ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.5), blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    filter.count > 0 ? '${filter.label} (${filter.count})' : filter.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecommendedCard(PracticeSet set) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1F35),
            const Color(0xFF10131E),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: const Color(0xFF6B5DE6).withValues(alpha: 0.1), blurRadius: 24, offset: const Offset(0, 8)),
          BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6B5DE6).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFF6B5DE6).withValues(alpha: 0.5)),
                          ),
                          child: const Text('RECOMMENDED PRACTICE', style: TextStyle(color: Color(0xFFB388FF), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('${set.subject} · ${set.chapter}', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      set.title,
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2435),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.account_tree, color: Color(0xFF80CBC4), size: 24),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(set.description ?? '', style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5)),
          const SizedBox(height: 20),
          
          if (set.overviewSteps != null && set.overviewSteps!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0C0F16),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < set.overviewSteps!.length; i++) ...[
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF151926),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.1), blurRadius: 8)],
                            border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.2)),
                          ),
                          child: Icon(set.overviewSteps![i].icon, color: const Color(0xFF00E5FF), size: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(set.overviewSteps![i].label.toUpperCase(), style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ],
                    ),
                    if (i < set.overviewSteps!.length - 1)
                      Expanded(
                        child: Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF00E5FF).withValues(alpha: 0.1),
                                const Color(0xFF00E5FF).withValues(alpha: 0.5),
                                const Color(0xFF00E5FF).withValues(alpha: 0.1),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ]
                ],
              ),
            ),
            
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.library_books, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              Text('${set.questionCount} Questions', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, color: Colors.white54, size: 14),
              const SizedBox(width: 4),
              Text('~${set.estimatedMinutes} min', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(set.difficulty, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6B5DE6), Color(0xFF4530B3)]),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: const Color(0xFF6B5DE6).withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: ScaleButton(
              onTap: () => context.go('${GoRouterState.of(context).uri.toString()}/session'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Start Practice', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildInProgressCard(PracticeSet set) {
    return ScaleButton(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF151926),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))],
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
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.5), blurRadius: 4)],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('IN PROGRESS', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ],
              ),
              Text('Step ${set.progressStep} of ${set.totalSteps}', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(set.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(set.progressSubtitle ?? '', style: const TextStyle(color: Colors.white60, fontSize: 12), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2435),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.go('${GoRouterState.of(context).uri.toString()}/session'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Resume', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                          SizedBox(width: 4),
                          Icon(Icons.play_arrow, color: Color(0xFF00E5FF), size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF10131E),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (set.progressStep ?? 0) / (set.totalSteps ?? 1),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3A7CFF),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.5), blurRadius: 4)],
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildPracticeByTopicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Practice by Topic', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2435),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('3 Available', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const Text('Simulate Empty', style: TextStyle(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        ..._data.topicSets.map((set) => _buildTopicCard(set)),
      ],
    );
  }

  Widget _buildTopicCard(PracticeSet set) {
    return ScaleButton(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF151926),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2435),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(set.topicIcon ?? Icons.book, color: const Color(0xFF80CBC4), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${set.subject} · ${set.chapter}', style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(set.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2435),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.go('${GoRouterState.of(context).uri.toString()}/session'),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Start', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Colors.white70, size: 14),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('${set.questionCount} Questions', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('·', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Text(set.difficulty, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('·', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Text('${set.estimatedMinutes} min', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildBottomInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF10131E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.psychology_outlined, color: Colors.white70, size: 20),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Why practice now? ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Retrieval practice solidifies neural pathways into durable intuition that passive review simply cannot match.'),
                ],
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _DotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;
    
    const spacing = 20.0;
    const radius = 1.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleDownTo;
  
  const ScaleButton({
    super.key,
    required this.child,
    required this.onTap,
    this.scaleDownTo = 0.98,
  });

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleDownTo).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}
