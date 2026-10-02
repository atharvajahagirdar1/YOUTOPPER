import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class ConceptScreen extends StatelessWidget {
  const ConceptScreen({super.key});

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
            _ConceptHeader(),
            SizedBox(height: 32),
            _ActionRow(),
            SizedBox(height: 32),
            Text(
              'DATABASE MANAGEMENT SYSTEMS • CHAPTER 3',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Database Normalization',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Organize data to reduce redundancy and improve consistency.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            SizedBox(height: 32),
            _ConceptVisualBox(),
            SizedBox(height: 40),
            _SectionHeader(title: "What You'll Learn", trailingText: '5 topics'),
            SizedBox(height: 16),
            _TopicList(),
            SizedBox(height: 32),
            _MetadataRow(),
            SizedBox(height: 32),
            _StartLearningButton(),
            SizedBox(height: 120), // Padding for global bottom navigation
          ],
        ),
      ),
    );
  }
}

class _ConceptHeader extends StatelessWidget {
  const _ConceptHeader();

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
              child: const Icon(Icons.school_outlined, color: Color(0xFF00E5FF), size: 22),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E212D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Icon(Icons.notifications_none_rounded, color: Colors.white.withValues(alpha: 0.9), size: 22),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFB388FF).withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 22),
            ),
          ],
        )
      ],
    );
  }
}

class _ActionRow extends StatefulWidget {
  const _ActionRow();

  @override
  State<_ActionRow> createState() => _ActionRowState();
}

class _ActionRowState extends State<_ActionRow> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF161A25),
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _isBookmarked = !_isBookmarked;
            });
          },
          icon: Icon(_isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded),
          color: _isBookmarked ? const Color(0xFF00E5FF) : Colors.white,
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF161A25),
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}

class _ConceptVisualBox extends StatelessWidget {
  const _ConceptVisualBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF11141E),
        borderRadius: BorderRadius.circular(24),
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
        children: [
          // Step 1: Unorganized Data
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F2C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFC107), // Yellow dot
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                const Text('Unorganized Data', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                const Spacer(),
                const Text('Flat • Duplicates', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF00E5FF), size: 24),
          const SizedBox(height: 8),
          // Step 2: Reduce Repetition
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3F51B5).withValues(alpha: 0.5),
                  const Color(0xFF3F51B5).withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF3F51B5).withValues(alpha: 0.8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.tune_rounded, color: Color(0xFF00E5FF), size: 20),
                const SizedBox(width: 16),
                const Text('Reduce Repetition', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w700, fontSize: 15)),
                const Spacer(),
                const Text('1NF → 2NF → 3NF', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF00E5FF), size: 24),
          const SizedBox(height: 8),
          // Step 3: Structured Tables
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1F2C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.table_chart_outlined, color: Colors.white70, size: 20),
                const SizedBox(width: 16),
                const Text('Structured Tables', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(6)),
                  child: const Text('PK/FK', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(6)),
                  child: const Text('Atomic', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String trailingText;

  const _SectionHeader({required this.title, required this.trailingText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFF00E5FF),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.3,
          ),
        ),
        const Spacer(),
        Text(trailingText, style: const TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _TopicList extends StatelessWidget {
  const _TopicList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141824),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          _buildTopicRow('01', 'Why normalization is needed'),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          _buildTopicRow('02', 'Functional dependencies'),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          _buildTopicRow('03', 'Normal forms'),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          _buildTopicRow('04', 'Decomposition'),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.05)),
          _buildTopicRow('05', 'Practical examples'),
        ],
      ),
    );
  }

  Widget _buildTopicRow(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF00E5FF),
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  const _MetadataRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMetaCard(Icons.access_time_rounded, 'TIME', '25 min'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetaCard(Icons.bar_chart_rounded, 'LEVEL', 'Intermediate'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetaCard(Icons.layers_outlined, 'FORMAT', 'Concept + Ex'),
        ),
      ],
    );
  }

  Widget _buildMetaCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF161A25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF00E5FF), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StartLearningButton extends StatelessWidget {
  const _StartLearningButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.go('/learn/concept/experience');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4C51DF), // Deep Indigo / Purple
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          shadowColor: const Color(0xFF4C51DF).withValues(alpha: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Start Learning',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_rounded, size: 22, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
