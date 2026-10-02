import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> with SingleTickerProviderStateMixin {
  static const Color _background = Color(0xFF040914);
  static const Color _surface = Color(0xFF0A1121);
  static const Color _surfaceElevated = Color(0xFF131F37);
  static const Color _border = Color(0xFF1D2E4D);
  static const Color _cyan = Color(0xFF5BD6E8);
  static const Color _primary = Color(0xFF4A65D6);
  static const Color _textPrimary = Color(0xFFF2F5FC);
  static const Color _textSecondary = Color(0xFF8B9BB4);
  static const Color _muted = Color(0xFF516483);

  late AnimationController _entranceController;
  final TextEditingController _searchController = TextEditingController();
  
  String _searchQuery = '';
  
  final List<Map<String, String>> _allFaqs = [
    {
      'question': 'How do I get started with YOUTOPPER?',
      'answer': 'Begin by exploring the Learn tab to understand your learning methods. Use the Planner to schedule Focus Sessions and track your progress daily.',
    },
    {
      'question': 'How do I save a concept?',
      'answer': 'While reviewing a topic in the Learn section, tap the bookmark icon in the top right corner. You can view all saved concepts in your Account menu.',
    },
    {
      'question': 'How do I plan a study session?',
      'answer': 'Navigate to the Planner tab, select an upcoming day on the calendar, and tap "Add Session". Choose your topic, set a duration, and save.',
    },
    {
      'question': 'How do focus sessions work?',
      'answer': 'Focus sessions use the Pomodoro technique. Start a session from the Home screen, focus for the set duration without leaving the app, and take a short break when prompted.',
    },
    {
      'question': 'How can I review topics?',
      'answer': 'Go to the Revision tab. Topics you have learned are scheduled using spaced repetition to ensure long-term retention.',
    },
    {
      'question': 'Where can I see my progress?',
      'answer': 'The Progress tab provides detailed insights into your study consistency, weak areas, and weekly achievements.',
    },
    {
      'question': 'How do I change my study preferences?',
      'answer': 'Navigate to the Global Menu > Settings. From there, you can adjust your default focus duration, break duration, and theme preferences.',
    },
  ];

  List<Map<String, String>> _filteredFaqs = [];

  final List<Map<String, dynamic>> _helpTopics = [
    {'icon': Icons.rocket_launch_rounded, 'title': 'Getting Started'},
    {'icon': Icons.menu_book_rounded, 'title': 'Learning & Concepts'},
    {'icon': Icons.calendar_month_rounded, 'title': 'Study Planning'},
    {'icon': Icons.timer_rounded, 'title': 'Focus Sessions'},
    {'icon': Icons.history_edu_rounded, 'title': 'Revision & Practice'},
    {'icon': Icons.insights_rounded, 'title': 'Progress & Insights'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredFaqs = List.from(_allFaqs);
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
        _filteredFaqs = _allFaqs.where((faq) {
          final q = faq['question']!.toLowerCase();
          final a = faq['answer']!.toLowerCase();
          return q.contains(_searchQuery) || a.contains(_searchQuery);
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Stack(
        children: [
          // Ambient background glow
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _cyan.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                  stops: const [0.1, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(context),
                      const SizedBox(height: 32),
                      _animatedStagger(
                        index: 0,
                        child: _buildSearchSection(),
                      ),
                      if (_searchQuery.isEmpty) ...[
                        const SizedBox(height: 36),
                        _animatedStagger(
                          index: 1,
                          child: _buildSectionHeading('QUICK TOPICS'),
                        ),
                        const SizedBox(height: 16),
                        _animatedStagger(
                          index: 2,
                          child: _buildHelpTopicsGrid(),
                        ),
                      ],
                      const SizedBox(height: 36),
                      _animatedStagger(
                        index: 3,
                        child: _buildSectionHeading(_searchQuery.isEmpty ? 'FREQUENTLY ASKED QUESTIONS' : 'SEARCH RESULTS'),
                      ),
                      const SizedBox(height: 16),
                      _animatedStagger(
                        index: 4,
                        child: _buildFaqList(),
                      ),
                      if (_searchQuery.isEmpty) ...[
                        const SizedBox(height: 36),
                        _animatedStagger(
                          index: 5,
                          child: _buildSectionHeading('CONTACT US'),
                        ),
                        const SizedBox(height: 16),
                        _animatedStagger(
                          index: 6,
                          child: _buildContactCard(context),
                        ),
                      ],
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedStagger({required int index, required Widget child}) {
    final delay = index * 0.05;
    final animation = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(delay, (delay + 0.5).clamp(0.0, 1.0), curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _surfaceElevated,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _border),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_rounded, color: _textPrimary, size: 22),
              ),
            ),
            const Text(
              'Help & Support',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 46), // Balance center alignment
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'How can we help you?',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Find answers and get back to learning.',
          style: TextStyle(
            color: _textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: _muted, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: _textPrimary, fontSize: 15),
              cursorColor: _cyan,
              decoration: const InputDecoration(
                hintText: 'Search for help...',
                hintStyle: TextStyle(color: _muted, fontSize: 15),
                border: InputBorder.none,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () => _searchController.clear(),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: _surfaceElevated,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close_rounded, color: _textSecondary, size: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: _muted,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.6,
        ),
      ),
    );
  }

  Widget _buildHelpTopicsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _helpTopics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final topic = _helpTopics[index];
        return _buildTopicCard(topic['icon'] as IconData, topic['title'] as String);
      },
    );
  }

  Widget _buildTopicCard(IconData icon, String title) {
    return GestureDetector(
      onTap: () => _showDemoMessage(context, 'Topic: $title'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _cyan, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqList() {
    if (_filteredFaqs.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _surfaceElevated,
                shape: BoxShape.circle,
                border: Border.all(color: _border),
              ),
              child: const Icon(Icons.search_off_rounded, color: _muted, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'No results found',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search query.',
              style: TextStyle(color: _textSecondary, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: _filteredFaqs.asMap().entries.map((entry) {
              final isLast = entry.key == _filteredFaqs.length - 1;
              return Column(
                children: [
                  _FaqExpansionTile(
                    question: entry.value['question']!,
                    answer: entry.value['answer']!,
                  ),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(height: 1, color: _border.withValues(alpha: 0.5)),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF14223D),
            Color(0xFF0F1A30),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF23365A)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _cyan.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.support_agent_rounded, color: _cyan, size: 24),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Still need help?',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Send us a message and we will try to help.',
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showDemoFeedback(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Send Feedback',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: () => context.push('/home/help-support/about-legal'),
              child: const Text(
                'View About & Legal Information',
                style: TextStyle(
                  color: _cyan,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDemoMessage(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title is not available in demo.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _surfaceElevated,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void _showDemoFeedback(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              border: Border(top: BorderSide(color: _border)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Send Feedback',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, color: _textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _border),
                  ),
                  child: const TextField(
                    maxLines: 4,
                    style: TextStyle(color: _textPrimary, fontSize: 14),
                    cursorColor: _cyan,
                    decoration: InputDecoration(
                      hintText: 'Describe your issue or suggestion...',
                      hintStyle: TextStyle(color: _muted, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Feedback saved locally. (Demo Mode)'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: _cyan,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit Feedback',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FaqExpansionTile extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqExpansionTile({
    required this.question,
    required this.answer,
  });

  @override
  State<_FaqExpansionTile> createState() => _FaqExpansionTileState();
}

class _FaqExpansionTileState extends State<_FaqExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: const Color(0xFF5BD6E8).withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(
            color: _isExpanded ? const Color(0xFF5BD6E8) : const Color(0xFFF2F5FC),
            fontSize: 14,
            fontWeight: _isExpanded ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
        trailing: AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _isExpanded ? const Color(0xFF131F37) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: _isExpanded ? const Color(0xFF5BD6E8) : const Color(0xFF516483),
              size: 20,
            ),
          ),
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        children: [
          Text(
            widget.answer,
            style: const TextStyle(
              color: Color(0xFF8B9BB4),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
