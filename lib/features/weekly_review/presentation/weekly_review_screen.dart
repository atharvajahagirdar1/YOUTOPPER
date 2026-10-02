import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';

class _Day { final String day; final double hours; const _Day(this.day, this.hours); }
class _Metric { final String label, sub, value, tag; final IconData icon; final Color accent; const _Metric(this.label,this.sub,this.value,this.icon,this.accent,this.tag); }
class _Win { final String subject,tag,title,body; const _Win({required this.subject,required this.tag,required this.title,required this.body}); }
class _Carry { final String subject,tag,title,body; const _Carry({required this.subject,required this.tag,required this.title,required this.body}); }

const _kRange = 'Sep 21 - Sep 27, 2025';
const _kDays = <_Day>[
  _Day('Mon', 1.75),   // 1h 45m
  _Day('Tue', 2.1667), // 2h 10m
  _Day('Wed', 3.25),   // 3h 15m
  _Day('Thu', 2.00),   // 2h 00m
  _Day('Fri', 2.50),   // 2h 30m
  _Day('Sat', 1.50),   // 1h 30m
  _Day('Sun', 1.5833), // 1h 35m
];
const _kMetrics = <_Metric>[
  _Metric('Study Sessions','Completed across week','12',Icons.calendar_today_outlined,Color(0xFF5B8FDB),'Target Met'),
  _Metric('Topics Mastered','Core topics completed','8',Icons.check_circle_outline,Color(0xFF27AE8A),'Core Work'),
  _Metric('Revisions','Memory refresh rounds','5',Icons.refresh_outlined,Color(0xFFE6B450),'Retention'),
  _Metric('Total Focus','Recorded study time','14h 45m',Icons.access_time_outlined,Color(0xFF7C6FD9),'Logged'),
];
const _kWins = <_Win>[
  _Win(subject:'DBMS - Mastered',tag:'Completed',title:'Completed Database Normalization',body:'Successfully grasped 1NF, 2NF, and 3NF functional dependency breakdowns without ambiguity.'),
  _Win(subject:'Technique - Active Recall',tag:'Milestone Verified',title:'Active Recall Milestone',body:'Completed 5 revision sessions without consulting reference notes upfront, reinforcing neural pathways.'),
  _Win(subject:'OS - Rebalanced',tag:'Aligned',title:'OS Pacing Restored',body:'Logged 2 focused sessions on CPU Scheduling, closing last week subject pacing gap cleanly.'),
];
const _kCarry = <_Carry>[
  _Carry(subject:'DBMS - Chapter 3',tag:'Queued',title:'Lossless Decomposition Practice',body:'2 remaining multi-attribute schema questions deferred for quiet weekend consolidation.'),
  _Carry(subject:'Data Structures',tag:'Scheduled',title:'Binary Search Tree Balancing',body:'Planned 30m practice set ready for early Monday without pressure.'),
];

class WeeklyReviewScreen extends StatefulWidget {
  const WeeklyReviewScreen({super.key});
  @override
  State<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends State<WeeklyReviewScreen> with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late TextEditingController _reflect;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..forward();
    _reflect = TextEditingController(text: 'Breaking normalization down into dependency arrows before memorizing formulas made 3NF click immediately.');
  }

  @override
  void dispose() { _anim.dispose(); _reflect.dispose(); super.dispose(); }

  Widget _reveal({required double start, required double end, required Widget child}) {
    final c = Interval(start, end, curve: Curves.easeOutCubic);
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(CurvedAnimation(parent: _anim, curve: c)),
      child: FadeTransition(opacity: CurvedAnimation(parent: _anim, curve: c), child: child),
    );
  }

  BoxDecoration _neu({double r = 20}) => BoxDecoration(
    color: AppColors.surfaceElevated,
    borderRadius: BorderRadius.circular(r),
    border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
    boxShadow: [
      BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 6, offset: const Offset(0, 3)),
      BoxShadow(color: Colors.white.withValues(alpha: 0.03), blurRadius: 1, offset: const Offset(0, -1)),
    ],
  );

  Widget _tag(String t, Color c, {bool s = false}) => Container(
    padding: EdgeInsets.symmetric(horizontal: s ? 6 : 9, vertical: s ? 2 : 4),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    child: Text(t, style: TextStyle(color: c, fontSize: s ? 9 : 10, fontWeight: FontWeight.w700, letterSpacing: s ? 0 : 0.4)),
  );

  Widget _dot(Color c) => Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle));

  Widget _accent(Color c, double sz, double op) => IgnorePointer(
    child: Container(
      width: sz, height: sz,
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [c.withValues(alpha: op), Colors.transparent])),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(top: -80, right: -80, child: _accent(AppColors.primary, 280, 0.12)),
          Positioned(bottom: -120, left: -120, child: _accent(AppColors.info, 340, 0.08)),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent, elevation: 0, scrolledUnderElevation: 0, leadingWidth: 44,
                  leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18), onPressed: () => context.pop()),
                  title: const Text('Weekly Review', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
                  centerTitle: true,
                  actions: [
                    IconButton(icon: Icon(Icons.calendar_month_outlined, color: Colors.white.withValues(alpha: 0.7), size: 20), onPressed: () {}),
                    IconButton(icon: Icon(Icons.more_vert, color: Colors.white.withValues(alpha: 0.7), size: 20), onPressed: () {}),
                    const SizedBox(width: 4),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _reveal(start: 0.00, end: 0.30, child: _weekNav()),
                        const SizedBox(height: 20),
                        _reveal(start: 0.05, end: 0.35, child: _hero()),
                        const SizedBox(height: 24),
                        _reveal(start: 0.10, end: 0.40, child: _synthCard()),
                        const SizedBox(height: 24),
                        _reveal(start: 0.15, end: 0.45, child: _glance()),
                        const SizedBox(height: 24),
                        _reveal(start: 0.20, end: 0.50, child: _rhythmCard()),
                        const SizedBox(height: 24),
                        _reveal(start: 0.25, end: 0.55, child: _mindsetCard()),
                        const SizedBox(height: 28),
                        _reveal(start: 0.30, end: 0.60, child: _secHdr('Your Learning Wins', 'Small steps deserve to be noticed.')),
                        const SizedBox(height: 12),
                        _reveal(start: 0.35, end: 0.65, child: _winsSection()),
                        const SizedBox(height: 28),
                        _reveal(start: 0.40, end: 0.70, child: _secHdr('Carry Forward', 'A few things to smoothly continue into next week.')),
                        const SizedBox(height: 12),
                        _reveal(start: 0.45, end: 0.75, child: _carrySection()),
                        const SizedBox(height: 8),
                        _reveal(start: 0.48, end: 0.78, child: _carryNote()),
                        const SizedBox(height: 28),
                        _reveal(start: 0.55, end: 0.85, child: _reflectionCard()),
                        const SizedBox(height: 28),
                        _reveal(start: 0.65, end: 1.00, child: _ctaSection(context)),
                        const SizedBox(height: 80),
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

  Widget _weekNav() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _navBtn(Icons.chevron_left),
      const SizedBox(width: 12),
      Text(_kRange, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(width: 12),
      _navBtn(Icons.chevron_right),
    ],
  );

  Widget _navBtn(IconData icon) => GestureDetector(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: AppColors.surfaceElevated, shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.08))),
      child: Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 16),
    ),
  );

  Widget _hero() => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(7, (i) {
          final isPast = i < 5;
          final isToday = i == 5;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isPast ? 20 : (isToday ? 28 : 8),
            height: 4,
            decoration: BoxDecoration(
              color: isPast ? AppColors.primary : (isToday ? const Color(0xFF67B4E0) : Colors.white.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(4),
              boxShadow: isPast || isToday ? [
                BoxShadow(color: (isToday ? const Color(0xFF67B4E0) : AppColors.primary).withValues(alpha: 0.4), blurRadius: 4, spreadRadius: 0.5)
              ] : null,
            ),
          );
        }),
      ),
      const SizedBox(height: 24),
      const Text('Your Week in Review', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5, height: 1.1)),
      const SizedBox(height: 10),
      Text('Take a moment to pause and see how far you have come.', textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5)),
    ],
  );

  Widget _synthCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: _neu(r: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          _tag('WEEKLY SYNTHESIS', AppColors.info),
          const Spacer(),
          _dot(const Color(0xFF5B8FDB)),
          const SizedBox(width: 6),
          Text('Continuous Flow', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ]),
        const SizedBox(height: 14),
        const Text('A week of steady progress', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text('You showed up consistently across multiple subjects. Here is a clear reflection of your study effort and completed work.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.45)),
        const SizedBox(height: 20),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOutCubic,
          builder: (ctx, v, child) => ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: v,
              child: child,
            ),
          ),
          child: SizedBox(height: 60, width: double.infinity, child: CustomPaint(painter: _LinePainter(days: _kDays))),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _kDays.map((d) => Text(d.day,
              style: TextStyle(color: d.day == 'Wed' ? Colors.white : AppColors.textSecondary, fontSize: 11,
                  fontWeight: d.day == 'Wed' ? FontWeight.bold : FontWeight.normal))).toList(),
        ),
      ],
    ),
  );

  Widget _glance() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Your Week at a Glance', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text('Key markers of completed study engagement.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      const SizedBox(height: 14),
      GridView.count(
        crossAxisCount: 2, physics: const NeverScrollableScrollPhysics(), shrinkWrap: true,
        crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.25,
        children: _kMetrics.map((m) => Container(
          padding: const EdgeInsets.all(16),
          decoration: _neu(r: 16).copyWith(
            border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: m.accent.withValues(alpha: 0.15), shape: BoxShape.circle),
                    child: Icon(m.icon, color: m.accent, size: 16),
                  ),
                  const Spacer(),
                  _tag(m.tag, m.accent, s: true)
                ],
              ),
              const SizedBox(height: 4),
              Text(m.value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(m.sub, style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
              ]),
            ],
          ),
        )).toList(),
      ),
    ],
  );

  Widget _rhythmCard() {
    const double maxH = 4.0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF171A21),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Weekly Rhythm', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
                    const SizedBox(height: 4),
                    Text('How study activity was distributed\nacross 7 days.', style: TextStyle(color: Color(0xFFA0A5B0), fontSize: 13, height: 1.3)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF222731),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Avg 2h\n06m/day', style: TextStyle(color: Color(0xFFB0B5C0), fontSize: 11, height: 1.3, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _kDays.map((d) {
                final isWed = d.day == 'Wed';
                final isSun = d.day == 'Sun';
                final m = ((d.hours - d.hours.floor()) * 60).round();
                final lbl = m == 0 ? '${d.hours.toInt()}h 00m' : '${d.hours.floor()}h ${m.toString().padLeft(2, '0')}m';
                
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(lbl, textAlign: TextAlign.center,
                          style: TextStyle(
                              color: isWed || isSun ? const Color(0xFF67B4E0) : const Color(0xFFA0A5B0),
                              fontSize: 9,
                              fontWeight: isWed || isSun ? FontWeight.bold : FontWeight.w600)),
                      if (isWed)
                        const Text('^', style: TextStyle(color: Color(0xFF67B4E0), fontSize: 16, height: 0.8, fontWeight: FontWeight.w800))
                      else
                        const SizedBox(height: 12),
                      
                      // Bar background
                      Container(
                        width: 26,
                        height: 85,
                        margin: const EdgeInsets.only(top: 2, bottom: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C1017),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: d.hours / maxH),
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeOutCubic,
                          builder: (ctx, v, _) {
                            final fillHeight = 85 * v;
                            return Container(
                              height: fillHeight,
                              width: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: isWed
                                    ? const LinearGradient(
                                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                        colors: [Color(0xFF7CB8FF), Color(0xFF5A6BFF)])
                                    : null,
                                color: !isWed ? (isSun ? const Color(0xFF62C2E8) : const Color(0xFFB5B2FA)) : null,
                                boxShadow: isWed ? [
                                  BoxShadow(color: const Color(0xFF5A6BFF).withValues(alpha: 0.4), blurRadius: 10, spreadRadius: 1)
                                ] : null,
                              ),
                            );
                          },
                        ),
                      ),
                      
                      Text(d.day, textAlign: TextAlign.center,
                          style: TextStyle(
                              color: isWed || isSun ? const Color(0xFF67B4E0) : Colors.white,
                              fontSize: 12,
                              fontWeight: isWed || isSun ? FontWeight.bold : FontWeight.w600)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF13171F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.trending_up, color: Color(0xFF67B4E0), size: 18),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Solid midweek momentum with balanced\nrevision cadence on the weekend.',
                      style: TextStyle(color: Color(0xFFB0B5C0), fontSize: 12, height: 1.4, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mindsetCard() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary.withValues(alpha: 0.25), AppColors.secondary.withValues(alpha: 0.15)],
        begin: Alignment.topLeft, end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.4))),
          child: const Icon(Icons.anchor, color: AppColors.primary, size: 26),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _tag('MINDSET ANCHOR', AppColors.primary),
          const SizedBox(height: 6),
          const Text('Quiet consistency wins', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Depth comes from showing up repeatedly without fanfare.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4)),
        ])),
      ],
    ),
  );

  Widget _secHdr(String title, String sub) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
      const SizedBox(height: 6),
      Text(sub, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
    ],
  );

  Widget _winsSection() => Column(
    children: _kWins.map((w) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _neu(r: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2, right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF27AE8A).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star_rounded, color: Color(0xFF27AE8A), size: 18),
            ),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(w.subject, style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600))),
                  _tag(w.tag, const Color(0xFF27AE8A), s: true),
                ]),
                const SizedBox(height: 6),
                Text(w.title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(w.body, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.45)),
              ]),
            ),
          ],
        ),
      ),
    )).toList(),
  );

  Widget _carrySection() => Column(
    children: _kCarry.map((c) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _neu(r: 16),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
             margin: const EdgeInsets.only(top: 2, right: 16),
             padding: const EdgeInsets.all(8),
             decoration: BoxDecoration(
               color: AppColors.warning.withValues(alpha: 0.1),
               borderRadius: BorderRadius.circular(10),
             ),
             child: const Icon(Icons.next_plan_outlined, color: AppColors.warning, size: 18),
          ),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(c.subject, style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600))),
              _tag(c.tag, AppColors.warning, s: true),
            ]),
            const SizedBox(height: 6),
            Text(c.title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(c.body, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.45)),
          ])),
        ]),
      ),
    )).toList(),
  );

  Widget _carryNote() => Row(children: [
    const Icon(Icons.radio_button_unchecked, size: 14, color: AppColors.textSecondary),
    const SizedBox(width: 8),
    Expanded(child: Text('Carrying work forward is a normal part of disciplined study.',
        style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4))),
  ]);

  Widget _reflectionCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: _neu(r: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('A Moment to Reflect', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Capture a quick thought on what worked.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ])),
        Icon(Icons.edit_note, color: AppColors.info.withValues(alpha: 0.7), size: 22),
      ]),
      const SizedBox(height: 12),
      Text('What helped you learn most effectively this week?',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontStyle: FontStyle.italic)),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: TextField(
          controller: _reflect, maxLines: 4, minLines: 3,
          style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write your reflection here...',
            hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5), fontSize: 13),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Row(children: [
        Text('16 words - Saved locally', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        const Spacer(),
        Icon(Icons.check_circle, color: AppColors.success, size: 14),
        const SizedBox(width: 4),
        Text('Updated', style: TextStyle(color: AppColors.success, fontSize: 11)),
      ]),
    ]),
  );

  Widget _ctaSection(BuildContext context) => Column(children: [
    const Text('Ready for a fresh week?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
    const SizedBox(height: 8),
    Text('Carry forward what worked. Take the next step at your own pace.',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.45)),
    const SizedBox(height: 24),
    SizedBox(
      width: double.infinity, height: 56,
      child: ElevatedButton(
        onPressed: () => context.go('/planner'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text('Review Next Week Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_rounded, size: 20),
        ]),
      ),
    ),
    const SizedBox(height: 16),
    Text('YOUTOPPER - INTELLIGENT CALM',
        style: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.4), fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w600)),
  ]);
}

class _LinePainter extends CustomPainter {
  final List<_Day> days;
  const _LinePainter({required this.days});

  @override
  void paint(Canvas canvas, Size size) {
    if (days.isEmpty) return;
    const double maxH = 5.0;
    final n = days.length;
    final pts = List.generate(n, (i) => Offset(i / (n - 1) * size.width, size.height - (days[i].hours / maxH) * size.height));

    final fill = Path()..moveTo(pts.first.dx, size.height);
    for (final p in pts) { fill.lineTo(p.dx, p.dy); }
    fill.lineTo(pts.last.dx, size.height);
    fill.close();
    canvas.drawPath(fill, Paint()
      ..shader = const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0x590F4C81), Color(0x050F4C81)]).createShader(Rect.fromLTWH(0, 0, 999, 999)));

    final stroke = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < n; i++) { stroke.lineTo(pts[i].dx, pts[i].dy); }
    canvas.drawPath(stroke, Paint()..color = const Color(0xCC0F4C81)..strokeWidth = 2..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);

    for (int i = 0; i < n; i++) {
      final isWed = days[i].day == 'Wed';
      canvas.drawCircle(pts[i], isWed ? 5 : 3.5, Paint()..color = const Color(0xFF0F4C81));
      canvas.drawCircle(pts[i], isWed ? 3 : 2, Paint()..color = Colors.white);
    }

    final wi = days.indexWhere((d) => d.day == 'Wed');
    if (wi >= 0) {
      final tp = TextPainter(
        text: const TextSpan(text: '(Peak)', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(pts[wi].dx - tp.width / 2, pts[wi].dy - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
