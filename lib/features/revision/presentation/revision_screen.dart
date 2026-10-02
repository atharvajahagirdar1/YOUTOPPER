import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import '../domain/models/revision_models.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  String _selectedFilter = 'Today';

  final RevisionData _mockData = const RevisionData(
    primaryTask: PrimaryRevisionTask(
      priorityText: 'PRIORITY 01 · IMMEDIATE ANCHOR',
      intervalText: 'Interval #3',
      subject: 'DBMS · Chapter 3',
      estimatedTime: '~15 min',
      title: 'Database Normalization',
      description: '1NF, 2NF, 3NF, and BCNF loss-less decompositions with dependency preservation.',
      retentionPercentage: '91% estimated retention',
      cadenceSteps: [
        CadenceStep(label: '10d ago', isCompleted: true),
        CadenceStep(label: '4d ago', isCompleted: true),
        CadenceStep(label: 'Today', isCurrent: true),
        CadenceStep(label: 'Lock', isFuture: true),
      ],
      tags: [
        RevisionTag(icon: Icons.psychology_alt_outlined, label: 'Active Reconstruction'),
        RevisionTag(icon: Icons.visibility_off_outlined, label: 'Closed-Book Prompt'),
      ],
    ),
    alsoDue: [
      SecondaryRevisionTask(
        title: 'Data Structures — Trees',
        subtitle: 'Ch 5 · AVL Balances & Trave...',
        timeInfo: 'Last 5d ago  •  ⏱ 15 min',
        iconData: Icons.account_tree_outlined,
        iconColor: Color(0xFF00BFA5),
      ),
      SecondaryRevisionTask(
        title: 'OS — Process Scheduling',
        subtitle: 'Ch 4 · Preemptive & Round R...',
        timeInfo: 'Last 6d ago  •  ⏱ 20 min',
        iconData: Icons.memory_outlined,
        iconColor: Color(0xFFB388FF),
      ),
    ],
    upcoming: [
      SecondaryRevisionTask(
        title: 'Operating Systems — Deadlocks',
        subtitle: "Banker's Algorithm & Detection · 10 min",
        dayText: 'Tomorrow',
      ),
      SecondaryRevisionTask(
        title: 'Computer Networks — TCP 3-Way',
        subtitle: 'SYN, SYN-ACK, Flow Control · 15 min',
        dayText: 'In 2 days',
      ),
      SecondaryRevisionTask(
        title: 'DBMS — ACID Properties',
        subtitle: 'Serializability & Two-Phase Locking · 20 min',
        dayText: 'Friday',
      ),
    ],
    history: [
      SecondaryRevisionTask(
        title: 'Binary Search Trees Traversal',
        subtitle: 'Revised earlier today · 12 min',
      ),
      SecondaryRevisionTask(
        title: 'Functional Dependencies & Keys',
        subtitle: 'Revised yesterday · 8 min',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s20,
            vertical: AppSpacing.s24,
          ),
          children: [
            const _RevisionHeader(),
            const SizedBox(height: 24),
            const _ActiveQueueCard(),
            const SizedBox(height: 24),
            _buildFilters(),
            const SizedBox(height: 24),
            _buildAllContent(),
            const SizedBox(height: 100), // padding for navigation
          ],
        ),
      ),
        ],
      ),
    );
  }

  Widget _buildAllContent() {
    return Column(
      children: [
        // TODAY SECTION
        _PressableCard(child: _PrimaryRevisionCard(task: _mockData.primaryTask)),
        const SizedBox(height: 32),
        _buildSectionTitle('Also Due Today', '${_mockData.alsoDue.length} remaining'),
        const SizedBox(height: 16),
        ..._mockData.alsoDue.map((task) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _PressableCard(
            child: _AlsoDueCard(
              iconData: task.iconData ?? Icons.book,
              iconColor: task.iconColor ?? Colors.grey,
              title: task.title,
              subtitle: task.subtitle,
              timeInfo: task.timeInfo ?? '',
            ),
          ),
        )),
        
        const SizedBox(height: 36),
        
        // UPCOMING SECTION
        _buildSectionTitle('Upcoming Horizon', 'Scheduled Repetitions'),
        const SizedBox(height: 16),
        ..._mockData.upcoming.map((task) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _PressableCard(
            child: _UpcomingCard(
              title: task.title,
              subtitle: task.subtitle,
              dayText: task.dayText ?? '',
            ),
          ),
        )),

        const SizedBox(height: 36),
        
        // HISTORY SECTION
        _buildSectionTitle('Recently Completed', 'This Week'),
        const SizedBox(height: 16),
        ..._mockData.history.map((task) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _PressableCard(
            child: _HistoryCard(
              title: task.title,
              subtitle: task.subtitle,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'Today (3)',
            isSelected: _selectedFilter == 'Today',
            onTap: () => setState(() => _selectedFilter = 'Today'),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Upcoming (3)',
            isSelected: _selectedFilter == 'Upcoming',
            onTap: () => setState(() => _selectedFilter = 'Upcoming'),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'History (2)',
            isSelected: _selectedFilter == 'History',
            onTap: () => setState(() => _selectedFilter = 'History'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class _RevisionHeader extends StatelessWidget {
  const _RevisionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          icon: Icons.arrow_back,
          onTap: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Revision', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              const SizedBox(height: 2),
              Text("Keep what you've learned fresh.", style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14)),
            ],
          ),
        ),
        _CircleButton(icon: Icons.tune, onTap: () {}),
        const SizedBox(width: 8),
        _CircleButton(icon: Icons.more_vert, onTap: () {}),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}

class _ActiveQueueCard extends StatelessWidget {
  const _ActiveQueueCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: const Color(0xFF00BFA5).withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00BFA5).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'YOUR ACTIVE QUEUE',
                style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00BFA5).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00BFA5),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0xFF00BFA5), blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Optimal Retention',
                      style: TextStyle(color: Color(0xFF80CBC4), fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '3 topics due today',
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          Text(
            'A few focused, closed-book retrievals lock mental models into long-term memory.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14, height: 1.5),
          ),
        ],
      ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3A7CFF) : Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? const Color(0xFF3A7CFF) : Colors.white.withValues(alpha: 0.1),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))
                    ]
                  : null,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryRevisionCard extends StatelessWidget {
  final PrimaryRevisionTask task;
  const _PrimaryRevisionCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.priorityText,
              style: TextStyle(color: Color(0xFF3A7CFF), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0),
            ),
            Text(
              task.intervalText,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151926),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              // Subtle top cyan glow
              BoxShadow(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _MemoryNodesPainter()),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top glowing border indicator
              Container(
                height: 3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [Color(0xFF00E5FF), Color(0xFF3A7CFF)],
                  ),
                  boxShadow: [
                    BoxShadow(color: Color(0xFF00E5FF), blurRadius: 4, offset: Offset(0, 1)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task.subject,
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, color: Color(0xFF00E5FF), size: 14),
                            const SizedBox(width: 4),
                            Text(
                              task.estimatedTime,
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      task.title,
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.description,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    _buildMemoryCadence(context, task),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: task.tags.map((tag) => _buildTag(tag.icon, tag.label)).toList(),
                    ),
                    const SizedBox(height: 24),
                    _PressableCard(
                      onTap: () => context.go('/home/revision/session'),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3A7CFF), Color(0xFF1E5EE6)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3A7CFF).withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Start Revision Session', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildMemoryCadence(BuildContext context, PrimaryRevisionTask task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F121A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Memory Cadence', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              Text(task.retentionPercentage, style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              // Progress Line
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(child: Container(height: 2, color: Colors.white.withValues(alpha: 0.3))), // 10d to 4d
                    Expanded(child: Container(height: 2, color: Colors.white.withValues(alpha: 0.3))), // 4d to Today
                    Expanded(child: Container(height: 2, color: Colors.white.withValues(alpha: 0.1))), // Today to Lock
                  ],
                ),
              ),
              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...task.cadenceSteps.map((step) => _buildCadenceDot(
                    step.label,
                    isCompleted: step.isCompleted,
                    isCurrent: step.isCurrent,
                    isFuture: step.isFuture,
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCadenceDot(String label, {bool isCompleted = false, bool isCurrent = false, bool isFuture = false}) {
    return Column(
      children: [
        if (isCompleted)
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          )
        else if (isCurrent)
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: const Color(0xFF3A7CFF),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0xFF3A7CFF).withValues(alpha: 0.5), blurRadius: 6)],
            ),
            child: Center(
              child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
            ),
          )
        else
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.white.withValues(alpha: 0.3)), shape: BoxShape.circle),
            child: const Icon(Icons.lock_outline, color: Colors.white54, size: 12),
          ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isCurrent ? const Color(0xFF3A7CFF) : Colors.white.withValues(alpha: 0.6),
            fontSize: 11,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _AlsoDueCard extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String timeInfo;

  const _AlsoDueCard({
    required this.iconData,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.timeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
                const SizedBox(height: 4),
                Text(timeInfo, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2435),
              foregroundColor: const Color(0xFFD4E1FF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              minimumSize: const Size(0, 36),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Review', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dayText;

  const _UpcomingCard({required this.title, required this.subtitle, required this.dayText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(dayText, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HistoryCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151926),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF004D40), // Teal dark
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Color(0xFF00BFA5), size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF004D40).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Consolidated', style: TextStyle(color: Color(0xFF80CBC4), fontSize: 11, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
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


class _MemoryNodesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw a subtle constellation pattern
    final points = [
      Offset(size.width * 0.8, size.height * 0.1),
      Offset(size.width * 0.95, size.height * 0.4),
      Offset(size.width * 0.7, size.height * 0.6),
      Offset(size.width * 0.85, size.height * 0.8),
    ];

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
    canvas.drawLine(points[0], points[2], paint);

    for (final p in points) {
      canvas.drawCircle(p, 3.0, dotPaint);
      canvas.drawCircle(p, 8.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
