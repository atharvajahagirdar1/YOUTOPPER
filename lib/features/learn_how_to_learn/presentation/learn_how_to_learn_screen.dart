import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearnHowToLearnScreen extends StatefulWidget {
  const LearnHowToLearnScreen({super.key});

  @override
  State<LearnHowToLearnScreen> createState() => _LearnHowToLearnScreenState();
}

class _LearnHowToLearnScreenState extends State<LearnHowToLearnScreen> {
  int _selectedCategoryIndex = 0;
  final List<Map<String, dynamic>> _categories = [
    {'label': 'All', 'count': '14', 'icon': Icons.circle, 'color': const Color(0xFF00E5FF)},
    {'label': 'Remember', 'count': '5', 'icon': Icons.psychology_outlined, 'color': Colors.white70},
    {'label': 'Understand', 'count': '4', 'icon': Icons.lightbulb_outline, 'color': Colors.white70},
    {'label': 'Connect', 'count': '3', 'icon': Icons.hub_outlined, 'color': Colors.white70},
    {'label': 'Focus', 'count': '2', 'icon': Icons.center_focus_strong_outlined, 'color': Colors.white70},
  ];

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
            child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildHeader(),
                    const SizedBox(height: 32),
                    _buildHeroCard(),
                    const SizedBox(height: 24),
                    _buildMyMethodsCard(context),
                    const SizedBox(height: 40),
                    _buildExploreHeader(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildCategoryChips(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    _buildSectionHeader('Start With These', 'Foundational Set'),
                    const SizedBox(height: 16),
                    _buildActiveRecallCard(),
                    const SizedBox(height: 16),
                    _buildSpacedRepetitionCard(),
                    const SizedBox(height: 16),
                    _buildFeynmanCard(),
                    const SizedBox(height: 16),
                    _buildInterleavingCard(),
                    const SizedBox(height: 40),
                    _buildGuidanceSection(),
                    const SizedBox(height: 120), // Bottom padding for nav bar
                  ],
                ),
              ),
            ),
          ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      backgroundColor: const Color(0xFF07111F),
      elevation: 0,
      pinned: true,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF3F51B5).withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUTOPPER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Learn How To Learn',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFFB388FF).withValues(alpha: 0.8),
            child: const Icon(Icons.person, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology, color: Color(0xFF00E5FF), size: 12),
                  const SizedBox(width: 4),
                  const Text(
                    'Cognitive Mechanics',
                    style: TextStyle(
                      color: Color(0xFF00E5FF),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '· Self-Directed Study',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Learn How To Learn',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Discover techniques that can make studying more effective.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
            height: 1.4,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return _PressableCard(
      onTap: () {},
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const RadialGradient(
          center: Alignment(-0.8, -0.8),
          radius: 1.5,
          colors: [
            Color(0xFF1E2A45),
            Color(0xFF0D1A2B),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Learn the skill behind every subject.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Understand how effective learning works, then choose the techniques that fit the way you study.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.4,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF07111F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeroNode(Icons.remove_red_eye_outlined, 'ENCODING', 'Info', true),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF3F51B5).withValues(alpha: 0.3),
                              const Color(0xFF00E5FF).withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildHeroNode(Icons.psychology, 'CONSOLIDATION', 'Processing', true),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3F51B5).withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    _buildHeroNode(Icons.inventory_2_outlined, 'RETRIEVAL', 'Retention', false),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Active generation strengthens retrieval circuits',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildHeroNode(IconData icon, String topLabel, String bottomLabel, bool isActive) {
    return Column(
      children: [
        Text(
          topLabel,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF00E5FF).withValues(alpha: 0.1) : const Color(0xFF3F51B5).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? const Color(0xFF00E5FF).withValues(alpha: 0.3) : Colors.transparent,
            ),
          ),
          child: Icon(
            icon,
            color: isActive ? const Color(0xFF00E5FF) : Colors.white54,
            size: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          bottomLabel,
          style: TextStyle(
            color: isActive ? const Color(0xFF00E5FF) : Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildMyMethodsCard(BuildContext context) {
    return _PressableCard(
      onTap: () {
        context.push('/home/saved-concepts');
      },
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1A2B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bookmark, color: Color(0xFF00E5FF), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'MY METHODS',
                      style: TextStyle(
                        color: Color(0xFF00E5FF),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '3 saved',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Active Recall, Spaced Repetit...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Text(
                  'Saved',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: Colors.white, size: 14),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildExploreHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore Learning Techniques',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Different techniques help with different parts of learning.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          final category = _categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF00E5FF).withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF00E5FF).withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.05),
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ] : [],
                ),
                child: Row(
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      color: isSelected ? const Color(0xFF00E5FF) : Colors.white54,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category['label'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category['count'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.white70 : Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildBaseTechniqueCard({
    required Widget topRow,
    required String title,
    required String description,
    required Widget visualDiagram,
    required Widget bottomRow,
    VoidCallback? onTap,
  }) {
    return _PressableCard(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF142133),
            Color(0xFF0A1321),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topRow,
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.4,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          visualDiagram,
          const SizedBox(height: 16),
          bottomRow,
        ],
      ),
    ));
  }

  Widget _buildActiveRecallCard() {
    return _buildBaseTechniqueCard(
      topRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF3F51B5).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Memory & Retrieval',
              style: TextStyle(
                color: Color(0xFF8C9EFF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'High Impact · Effort: Moderate',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      title: 'Active Recall',
      description: 'Test what you remember instead of only rereading. Retrieval practice builds stronger neural pathways.',
      onTap: () {
        context.push('/how-to-learn/technique-detail');
      },
      visualDiagram: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProcessNode(Icons.menu_book, 'Prompt'),
          _buildProcessArrow(),
          _buildProcessNode(Icons.psychology, 'Retrieval', isActive: true),
          _buildProcessArrow(),
          _buildProcessNode(Icons.check_circle_outline, 'Consolidation'),
        ],
      ),
      bottomRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF00E5FF), size: 16),
              const SizedBox(width: 6),
              Text(
                'Applied in Flashcards',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          _buildPrimaryButton('Explore'),
        ],
      ),
    );
  }

  Widget _buildSpacedRepetitionCard() {
    return _buildBaseTechniqueCard(
      topRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Retention Timeline',
              style: TextStyle(
                color: Color(0xFF00E5FF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'High Retention · Effort: Consistent',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      title: 'Spaced Repetition',
      description: 'Revisit information at increasing intervals to interrupt the forgetting curve before memory fades.',
      onTap: () {
        debugPrint('Navigate to Technique Detail: Spaced Repetition');
      },
      visualDiagram: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimelineNode('Day 1', true),
              _buildTimelineDash(),
              _buildTimelineNode('Day 3', true),
              _buildTimelineDash(),
              _buildTimelineNode('Day 7', true),
              const Text('...', style: TextStyle(color: Colors.white54, fontSize: 10)),
              _buildTimelineNode('Day 16', false),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimelineDesc('Immediate\nreview'),
              _buildTimelineDesc('Halts forgetting curve\ndecay', isHighlight: true),
              _buildTimelineDesc('Permanent\nschema'),
            ],
          ),
        ],
      ),
      bottomRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.sync, color: Colors.white60, size: 16),
              const SizedBox(width: 6),
              Text(
                'Automated in Planner',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          _buildSecondaryButton('Explore'),
        ],
      ),
    );
  }

  Widget _buildFeynmanCard() {
    return _buildBaseTechniqueCard(
      topRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF9C27B0).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Comprehension',
              style: TextStyle(
                color: Color(0xFFE1BEE7),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'Deep Clarity · Effort: High',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      title: 'Feynman Technique',
      description: 'Explain a concept simply in plain language. Wherever you stumble or reach for jargon reveals an underlying gap.',
      onTap: () {
        debugPrint('Navigate to Technique Detail: Feynman Technique');
      },
      visualDiagram: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildNumberedBlock('1', 'Target Concept')),
              const SizedBox(width: 8),
              Expanded(child: _buildNumberedBlock('2', 'Explain Simply')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildNumberedBlock('3', 'Spot The Gaps')),
              const SizedBox(width: 8),
              Expanded(child: _buildNumberedBlock('4', 'Refine & Anchor')),
            ],
          ),
        ],
      ),
      bottomRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.people_alt_outlined, color: Colors.white60, size: 16),
              const SizedBox(width: 6),
              Text(
                'Self-Explanation Method',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          _buildSecondaryButton('Explore'),
        ],
      ),
    );
  }

  Widget _buildInterleavingCard() {
    return _buildBaseTechniqueCard(
      topRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF3F51B5).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Problem Solving',
              style: TextStyle(
                color: Color(0xFF8C9EFF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'Transfer Skill · Effort: Challenging',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      title: 'Interleaving',
      description: 'Alternate between related topics or problem types instead of mass blocking to train cognitive discrimination.',
      onTap: () {
        debugPrint('Navigate to Technique Detail: Interleaving');
      },
      visualDiagram: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF07111F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'INTERLEAVED SEQUENCE',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Adaptive Selection',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInterleaveBlock('Topic A'),
                _buildInterleaveBlock('Topic B', isActive: true),
                _buildInterleaveBlock('Topic C'),
                _buildInterleaveBlock('Topic A'),
              ],
            ),
          ],
        ),
      ),
      bottomRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.shuffle, color: Colors.white60, size: 16),
              const SizedBox(width: 6),
              Text(
                'Prevents Pattern Memorization',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          _buildSecondaryButton('Explore'),
        ],
      ),
    );
  }

  Widget _buildGuidanceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF07111F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.explore_outlined, color: Colors.white70, size: 20),
              SizedBox(width: 8),
              Text(
                'Build Your Learning Approach',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'You don\'t need one technique for everything. The most resilient learners rotate methods based on the material: spaced recall for foundational facts, simple explanations for knotty principles, and interleaved problem sets before exams. Keep only what serves your understanding.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              height: 1.5,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildGuidanceTip(
                  'Foundations First',
                  'Focus on 1-2 methods until they feel habitual.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGuidanceTip(
                  'Friction Is Normal',
                  'Desirable difficulty signals consolidation.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuidanceTip(String title, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1A2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF00E5FF),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets for Diagrams ---

  Widget _buildProcessNode(IconData icon, String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3F51B5).withValues(alpha: 0.4) : const Color(0xFF07111F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? const Color(0xFF8C9EFF) : Colors.transparent),
      ),
      child: Column(
        children: [
          Icon(icon, color: isActive ? const Color(0xFF00E5FF) : Colors.white54, size: 16),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(Icons.arrow_forward_rounded, color: Colors.white30, size: 16),
    );
  }

  Widget _buildTimelineNode(String label, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00E5FF).withValues(alpha: 0.1) : const Color(0xFF07111F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? const Color(0xFF00E5FF).withValues(alpha: 0.3) : Colors.transparent),
        boxShadow: isActive ? [
          BoxShadow(
            color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
            blurRadius: 8,
          )
        ] : [],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF00E5FF) : Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
            constraints: const BoxConstraints(minWidth: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDash() {
    return Container(
      width: 12,
      height: 1,
      color: Colors.white24,
    );
  }

  Widget _buildTimelineDesc(String text, {bool isHighlight = false}) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isHighlight ? const Color(0xFF00E5FF) : Colors.white54,
          fontSize: 9,
          height: 1.3,
          fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildNumberedBlock(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF07111F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFF00E5FF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterleaveBlock(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF004D40) : const Color(0xFF141826),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? const Color(0xFF00BFA5) : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? const Color(0xFF00E5FF) : Colors.white70,
          fontSize: 11,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF3A7CFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
        ],
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
