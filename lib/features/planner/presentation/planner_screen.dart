import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../domain/models/planner_models.dart';
import '../data/planner_demo_data.dart';
import 'dart:ui' as ui;

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  
  // To hold the currently selected date
  DateTime _selectedDate = DateTime(2024, 9, 24);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF06090F), // Deep navy Level 0
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _AdvancedGridPainter())),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: _buildHeader(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _FadeSlide(
                    animation: _animationController,
                    interval: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
                    child: _buildDateSelector(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        _FadeSlide(
                          animation: _animationController,
                          interval: const Interval(0.1, 0.5, curve: Curves.easeOutCubic),
                          child: _buildTodaysAllocation(),
                        ),
                        const SizedBox(height: 20),
                        _FadeSlide(
                          animation: _animationController,
                          interval: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
                          child: _NextUpCard(session: demoNextUpSession),
                        ),
                        const SizedBox(height: 40),
                        _FadeSlide(
                          animation: _animationController,
                          interval: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
                          child: _buildTodaysSchedule(),
                        ),
                        const SizedBox(height: 40),
                        _FadeSlide(
                          animation: _animationController,
                          interval: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
                          child: _buildWeeklyWorkload(),
                        ),
                        const SizedBox(height: 40),
                        _FadeSlide(
                          animation: _animationController,
                          interval: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
                          child: _buildComingUp(),
                        ),
                        const SizedBox(height: 48),
                        _FadeSlide(
                          animation: _animationController,
                          interval: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
                          child: _buildScheduleButton(),
                        ),
                        const SizedBox(height: 120), // Bottom padding for navbar
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

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Planner', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              const SizedBox(height: 6),
              const Text('Turn your study goals into a plan you can act...', 
                style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.3),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            _TactileButton(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF131824), // Level 1
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
                    BoxShadow(color: Colors.white.withValues(alpha: 0.02), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                  ]
                ),
                child: const Icon(Icons.grid_view_rounded, color: Colors.white70, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            _TactileButton(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF81D4FA),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF81D4FA).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
                  ]
                ),
                child: const Icon(Icons.person, color: Color(0xFF06090F), size: 24),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDateSelector() {
    final now = DateTime(2024, 9, 24); // Fake today
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
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
                      boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.5), blurRadius: 4)]
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('TODAY · ${DateFormat('EEEE, MMM d').format(now).toUpperCase()}', style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                ],
              ),
              _TactileButton(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131824), // Level 1
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
                    ]
                  ),
                  child: const Icon(Icons.add, color: Colors.white70, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 74,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = now.subtract(const Duration(days: 2)).add(Duration(days: index));
              final isToday = date.day == now.day && date.month == now.month;
              final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;
              
              return _DatePill(
                date: date,
                isSelected: isSelected,
                isToday: isToday,
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysAllocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("TODAY'S ALLOCATION", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '3', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' sessions · ', style: TextStyle(color: Colors.white54)),
                  const TextSpan(text: '2h 15m', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' planned', style: TextStyle(color: Colors.white54)),
                ]
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildModalityPill('Learn (2)', const Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            _buildModalityPill('Practice (1)', const Color(0xFF6366F1)), // Indigo for practice
            const SizedBox(width: 12),
            _buildModalityPill('Revision (1)', const Color(0xFF00E5FF)), // Cyan for revision
          ],
        ),
      ],
    );
  }

  Widget _buildModalityPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0B101A), // Level 1 inset
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color, 
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 4)]
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTodaysSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Today's Schedule", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF131824),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: const Text('3 blocks remaining', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 28),
        ...demoTodaysSchedule.asMap().entries.map((entry) {
          final isLast = entry.key == demoTodaysSchedule.length - 1;
          return _TimelineItem(session: entry.value, isLast: isLast);
        }),
      ],
    );
  }

  Widget _buildWeeklyWorkload() {
    return _NeumorphicSurface(
      padding: const EdgeInsets.all(24),
      borderRadius: 24,
      level: 2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("WEEKLY WORKLOAD HORIZON", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: '11h 15m', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
                    const TextSpan(text: ' cumulative', style: TextStyle(color: Colors.white54)),
                  ]
                ),
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: demoWorkload.map((day) {
              final isToday = day.isToday;
              final color = isToday ? const Color(0xFF00E5FF) : const Color(0xFF1E293B);
              final height = day.hours == 0 ? 12.0 : (day.hours / 3.0) * 48.0; 
              final labelTop = day.hours == 0 ? '—' : '${day.hours.toStringAsFixed(day.hours.truncateToDouble() == day.hours ? 0 : 1)}h';
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(labelTop, style: TextStyle(color: isToday ? const Color(0xFF00E5FF) : Colors.white54, fontSize: 11, fontWeight: isToday ? FontWeight.bold : FontWeight.w600)),
                  const SizedBox(height: 12),
                  Container(
                    width: 38,
                    height: height < 12 ? 12 : height,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                      gradient: isToday ? const LinearGradient(
                        colors: [Color(0xFF00E5FF), Color(0xFF0097A7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ) : null,
                      boxShadow: isToday ? [
                        BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4)),
                        BoxShadow(color: Colors.white.withValues(alpha: 0.3), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                      ] : [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(day.dayLabel, style: TextStyle(color: isToday ? const Color(0xFF00E5FF) : Colors.white70, fontSize: 13, fontWeight: isToday ? FontWeight.bold : FontWeight.w700)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComingUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Coming Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
            const Text("Upcoming 3 Days", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 20),
        ...demoComingUp.map((day) {
          return _TactileCard(
            margin: const EdgeInsets.only(bottom: 16),
            onTap: () {},
            child: Row(
              children: [
                Column(
                  children: [
                    Text(DateFormat('E').format(day.date).toUpperCase(), style: const TextStyle(color: Color(0xFF81D4FA), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
                    const SizedBox(height: 2),
                    Text('${day.date.day}', style: const TextStyle(color: Color(0xFF81D4FA), fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(width: 20),
                Container(width: 1.5, height: 36, color: Colors.white.withValues(alpha: 0.05)),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day.title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: -0.2), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      Text('${day.totalDuration}m · ${day.primaryModality.name.capitalize()} · ${day.details}', 
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildScheduleButton() {
    return Center(
      child: _TactileButton(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF131824), // Level 1
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4)),
              BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.1), blurRadius: 16, offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add_rounded, color: Color(0xFF81D4FA), size: 20),
              const SizedBox(width: 8),
              const Text('Schedule Focus Session', style: TextStyle(color: Color(0xFF81D4FA), fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// HERO CARD: Next Up
// ---------------------------------------------------------
class _NextUpCard extends StatefulWidget {
  final PlannerSession session;

  const _NextUpCard({required this.session});

  @override
  State<_NextUpCard> createState() => _NextUpCardState();
}

class _NextUpCardState extends State<_NextUpCard> with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Edge lighting glow behind the card
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _breathingController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.15 + 0.1 * _breathingController.value),
                      blurRadius: 30 + 10 * _breathingController.value,
                      spreadRadius: -5,
                    )
                  ]
                ),
              );
            },
          ),
        ),
        _NeumorphicSurface(
          padding: const EdgeInsets.all(28),
          borderRadius: 32,
          level: 4, // Hero depth
          gradient: LinearGradient(
            colors: [
              const Color(0xFF161F33), // Deeper elevated navy
              const Color(0xFF101626),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8, height: 8, 
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF), 
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.6), blurRadius: 6)]
                        )
                      ),
                      const SizedBox(width: 10),
                      Text('NEXT UP · ${DateFormat('h:mm a').format(widget.session.scheduledTime)} (IN 20 MINS)', 
                        style: const TextStyle(color: Color(0xFF81D4FA), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2)
                      ),
                    ],
                  ),
                  const Icon(Icons.more_horiz, color: Colors.white54, size: 24),
                ],
              ),
              const SizedBox(height: 28),
              Text('${widget.session.subject} · ${widget.session.chapter}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
              const SizedBox(height: 8),
              Text(widget.session.title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5, height: 1.2)),
              const SizedBox(height: 28),
              
              // Dynamic Learning Visual Block
              _buildDynamicGraphicBlock(),
              
              const SizedBox(height: 28),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B101A), // Inset
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          widget.session.modality == SessionModality.learn ? Icons.lightbulb_outline :
                          widget.session.modality == SessionModality.practice ? Icons.track_changes : Icons.replay,
                          color: const Color(0xFF3B82F6), size: 14
                        ),
                        const SizedBox(width: 8),
                        Text('${widget.session.modality.name.capitalize()} Modality', style: const TextStyle(color: Color(0xFF81D4FA), fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.timer_outlined, color: Colors.white54, size: 16),
                  const SizedBox(width: 6),
                  Text('${widget.session.durationMinutes} min focus interval', style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 32),
              
              // Primary CTA
              _TactileButton(
                onTap: () => context.push('/planner/focus-session'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF4F46E5)], // Blue to Indigo
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8)),
                      BoxShadow(color: Colors.white.withValues(alpha: 0.3), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          const Text('Start Session', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: -0.2)),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Ready now', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 6),
                          AnimatedBuilder(
                            animation: _breathingController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(3 * _breathingController.value, 0),
                                child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicGraphicBlock() {
    // Dynamic meaning: Plan -> Topic -> Focus based on session data
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF090D14), // Deep inset
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 12, offset: const Offset(0, 6), blurStyle: BlurStyle.inner),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildGraphicNode('PLAN', widget.session.subject, icon: Icons.map_outlined, active: true),
          _buildArrow(active: true),
          _buildGraphicNode('TOPIC', widget.session.chapter.isEmpty ? 'Interval' : widget.session.chapter, icon: Icons.auto_awesome, active: true, bright: true),
          _buildArrow(active: true, solid: true),
          _buildGraphicNode('FOCUS', '${widget.session.durationMinutes}m', icon: Icons.center_focus_strong_outlined, active: true, glow: true),
        ],
      ),
    );
  }

  Widget _buildGraphicNode(String title, String subtitle, {required IconData icon, bool active = false, bool bright = false, bool glow = false}) {
    final color = glow ? const Color(0xFF00E5FF) : (bright ? const Color(0xFF81D4FA) : (active ? Colors.white : Colors.white54));
    
    return Column(
      children: [
        AnimatedBuilder(
          animation: _breathingController,
          builder: (context, child) {
            final scale = glow ? 1.0 + (0.05 * _breathingController.value) : 1.0;
            return Transform.scale(
              scale: scale,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF131824),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                  boxShadow: glow ? [
                    BoxShadow(color: color.withValues(alpha: 0.3 * _breathingController.value), blurRadius: 12)
                  ] : [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))
                  ],
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            );
          }
        ),
        const SizedBox(height: 12),
        Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
        const SizedBox(height: 4),
        SizedBox(
          width: 60,
          child: Text(subtitle, 
            style: const TextStyle(color: Colors.white54, fontSize: 10, height: 1.2), 
            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis
          ),
        ),
      ],
    );
  }

  Widget _buildArrow({bool active = false, bool solid = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30), // align with boxes visually
      child: Row(
        children: [
          Container(
            width: 20,
            height: 1.5,
            color: active ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
          ),
          Icon(Icons.chevron_right, color: active ? const Color(0xFF3B82F6) : const Color(0xFF1E293B), size: 16),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// TIMELINE: Today's Schedule Item
// ---------------------------------------------------------
class _TimelineItem extends StatelessWidget {
  final PlannerSession session;
  final bool isLast;

  const _TimelineItem({required this.session, required this.isLast});

  @override
  Widget build(BuildContext context) {
    Color modalityColor;
    IconData modalityIcon;
    switch(session.modality) {
      case SessionModality.learn: 
        modalityColor = const Color(0xFF3B82F6); 
        modalityIcon = Icons.lightbulb_outline;
        break;
      case SessionModality.practice: 
        modalityColor = const Color(0xFF6366F1); // Indigo
        modalityIcon = Icons.track_changes;
        break;
      case SessionModality.revision: 
        modalityColor = const Color(0xFF00E5FF); 
        modalityIcon = Icons.replay;
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B101A),
                    shape: BoxShape.circle,
                    border: Border.all(color: modalityColor, width: 2),
                    boxShadow: [BoxShadow(color: modalityColor.withValues(alpha: 0.4), blurRadius: 8)],
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: modalityColor, shape: BoxShape.circle),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [modalityColor.withValues(alpha: 0.5), const Color(0xFF1E293B)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _TactileCard(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('hh:mm a').format(session.scheduledTime), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: modalityColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: modalityColor.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(modalityIcon, color: modalityColor, size: 12),
                              const SizedBox(width: 6),
                              Text('${session.modality.name.capitalize()} · ${session.durationMinutes}m', 
                                style: TextStyle(color: modalityColor, fontSize: 11, fontWeight: FontWeight.w600)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(session.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: -0.2)),
                    const SizedBox(height: 6),
                    Text('${session.subject} · ${session.chapter.isNotEmpty ? '${session.chapter} · ' : ''}${session.details}', 
                      style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: Date Pill
// ---------------------------------------------------------
class _DatePill extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const _DatePill({required this.date, required this.isSelected, required this.isToday, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _TactileButton(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 56,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A2639) : const Color(0xFF131824),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.03),
            width: isSelected ? 1.5 : 1.0,
          ),
          gradient: isSelected ? const LinearGradient(
            colors: [Color(0xFF1E2B45), Color(0xFF131824)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
          boxShadow: isSelected ? [
            BoxShadow(color: const Color(0xFF3B82F6).withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4)),
            BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
          ] : [
            BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('E').format(date).toUpperCase(), 
              style: TextStyle(
                color: isSelected ? const Color(0xFF81D4FA) : Colors.white54, 
                fontSize: 10, 
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                letterSpacing: 0.5
              )
            ),
            const SizedBox(height: 4),
            Text('${date.day}', 
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70, 
                fontSize: 18, 
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.bold
              )
            ),
            if (isToday) ...[
              const SizedBox(height: 6),
              Container(
                width: 4, height: 4, 
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF00E5FF) : Colors.white30, 
                  shape: BoxShape.circle,
                  boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00E5FF).withValues(alpha: 0.8), blurRadius: 4)] : []
                )
              ),
            ] else const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: Tactile Card
// ---------------------------------------------------------
class _TactileCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  const _TactileCard({required this.child, required this.onTap, this.margin = EdgeInsets.zero});

  @override
  State<_TactileCard> createState() => _TactileCardState();
}

class _TactileCardState extends State<_TactileCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        margin: widget.margin,
        transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF131824), // Level 2
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          boxShadow: _isPressed ? [
            BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 4, offset: const Offset(0, 2)),
          ] : [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6)),
            BoxShadow(color: Colors.white.withValues(alpha: 0.02), blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner),
          ],
        ),
        child: widget.child,
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
  final int level;
  final Gradient? gradient;

  const _NeumorphicSurface({
    required this.child,
    required this.padding,
    this.borderRadius = 20,
    this.level = 2,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic shadow based on level
    final double yOffset = level * 2.0;
    final double blur = level * 4.0;
    final double opacity = 0.2 + (level * 0.05);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? const Color(0xFF131824) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: opacity), blurRadius: blur, offset: Offset(0, yOffset)),
          BoxShadow(color: Colors.black.withValues(alpha: opacity * 0.5), blurRadius: blur * 0.5, offset: Offset(0, yOffset * 0.5)),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.03 + (level * 0.01)),
            blurRadius: 1, offset: const Offset(0, 1), blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: Tactile Button
// ---------------------------------------------------------
class _TactileButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _TactileButton({required this.child, required this.onTap});

  @override
  State<_TactileButton> createState() => _TactileButtonState();
}

class _TactileButtonState extends State<_TactileButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

// ---------------------------------------------------------
// COMPONENT: FadeSlide Animation
// ---------------------------------------------------------
class _FadeSlide extends StatelessWidget {
  final Animation<double> animation;
  final Interval interval;
  final Widget child;

  const _FadeSlide({required this.animation, required this.interval, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = interval.transform(animation.value);
        return Opacity(
          opacity: t,
          child: Transform.translate(offset: Offset(0, 20 * (1 - t)), child: child),
        );
      },
      child: child,
    );
  }
}

// ---------------------------------------------------------
// PAINTER: Advanced Ambient Texture
// ---------------------------------------------------------
class _AdvancedGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Deep atmospheric background
    final rect = Offset.zero & size;
    final bgGradient = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, size.height),
      [const Color(0xFF06090F), const Color(0xFF090D14)],
    );
    canvas.drawRect(rect, Paint()..shader = bgGradient);

    // Subtle planning grid
    final Paint linePaint = Paint()
      ..color = const Color(0xFFffffff).withValues(alpha: 0.015)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
      
    const double spacing = 40.0;
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    
    // Ambient light orbs for depth
    _drawOrb(canvas, size, const Offset(0.5, -0.1), const Color(0xFF00E5FF).withValues(alpha: 0.04), 350);
    _drawOrb(canvas, size, const Offset(1.0, 0.4), const Color(0xFF3B82F6).withValues(alpha: 0.03), 400);
    _drawOrb(canvas, size, const Offset(-0.2, 0.8), const Color(0xFF4F46E5).withValues(alpha: 0.03), 300);
  }
  
  void _drawOrb(Canvas canvas, Size size, Offset relativePos, Color color, double radius) {
    final center = Offset(size.width * relativePos.dx, size.height * relativePos.dy);
    final paint = Paint()
      ..shader = RadialGradient(colors: [color, color.withValues(alpha: 0)]).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
