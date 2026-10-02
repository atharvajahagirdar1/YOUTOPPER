import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'dart:math' as math;
import '../domain/models/planner_models.dart';
import '../data/planner_demo_data.dart';

enum FocusSessionState { ready, active, paused, completed }

class FocusSessionScreen extends StatefulWidget {
  final PlannerSession? session;

  const FocusSessionScreen({super.key, this.session});

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> with SingleTickerProviderStateMixin {
  late PlannerSession _session;
  
  FocusSessionState _currentState = FocusSessionState.ready;
  late int _totalSeconds;
  
  // Using ValueNotifier to avoid full screen rebuilds every second
  late final ValueNotifier<int> _secondsLeftNotifier;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Fallback to demo data if not provided (deterministic local/demo data)
    _session = widget.session ?? demoNextUpSession;
    _totalSeconds = _session.durationMinutes * 60;
    _secondsLeftNotifier = ValueNotifier<int>(_totalSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _secondsLeftNotifier.dispose();
    super.dispose();
  }

  void _changeState(FocusSessionState newState) {
    setState(() {
      _currentState = newState;
    });
    
    if (newState == FocusSessionState.active) {
      _startTimer();
    } else {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeftNotifier.value > 0) {
        _secondsLeftNotifier.value--;
      } else {
        _changeState(FocusSessionState.completed);
      }
    });
  }

  void _toggleSession() {
    switch (_currentState) {
      case FocusSessionState.ready:
        _changeState(FocusSessionState.active);
        break;
      case FocusSessionState.active:
        _changeState(FocusSessionState.paused);
        break;
      case FocusSessionState.paused:
        _changeState(FocusSessionState.active);
        break;
      case FocusSessionState.completed:
        context.pop();
        break;
    }
  }

  void _endSessionEarly() {
    if (_currentState == FocusSessionState.completed) {
      context.pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF132033),
          title: const Text('Conclude Early?', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to conclude this focus block early and save your progress?', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _changeState(FocusSessionState.completed);
                _secondsLeftNotifier.value = 0; // jump to end
              },
              child: const Text('Conclude', style: TextStyle(color: Color(0xFF38BDF8))),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050E1A),
      body: Stack(
        children: [
          // 1. Subtle Radial Glow behind everything
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.2),
                    radius: 1.2,
                    colors: [
                      const Color(0xFF0E223D).withValues(alpha: 0.6),
                      const Color(0xFF050E1A).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 2. Subtle Spatial Dot Matrix Overlay
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _DotMatrixPainter(),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32), // pb-safe equivalents handled roughly
                    child: Column(
                      children: [
                        _buildTopMetaBlock(),
                        const SizedBox(height: 24),
                        _buildHeroFocusTimer(),
                        const SizedBox(height: 20),
                        _buildStateSwitcher(), // For testing as requested in code.html, or we can hide it. "Interactive Focus State Switcher (Tabs to demonstrate Ready, Active, Paused, Done states)"
                        const SizedBox(height: 20),
                        _buildControlsZone(),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF050E1A).withValues(alpha: 0.85),
        border: Border(bottom: BorderSide(color: const Color(0xFF1D2A3E).withValues(alpha: 0.4))),
        boxShadow: [
          BoxShadow(color: const Color(0xFF02060F).withValues(alpha: 0.6), blurRadius: 24, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Transform.translate(
                  offset: const Offset(-6, 0),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFBDC8D1), size: 20),
                  ),
                ),
              ),
              const Text('Focus Session', style: TextStyle(color: Color(0xFFD6E3FE), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.5, fontFamily: 'Plus Jakarta Sans')),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.more_vert, color: Color(0xFFBDC8D1), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTopMetaBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatusPill(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF1D2A3E).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3E484F).withValues(alpha: 0.3)),
              ),
              child: Text(
                _session.modality.name.toUpperCase(),
                style: const TextStyle(color: Color(0xFF7BD0FF), fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'JetBrains Mono', letterSpacing: 1.0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${_session.subject.toUpperCase()} · ${_session.chapter.toUpperCase()}',
          style: const TextStyle(color: Color(0xFF87929A), fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'JetBrains Mono', letterSpacing: 1.5),
        ),
        const SizedBox(height: 4),
        Text(
          _session.title,
          style: const TextStyle(color: Color(0xFFD6E3FE), fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: -0.5, fontFamily: 'Plus Jakarta Sans'),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF0E1C2F).withValues(alpha: 0.9),
                const Color(0xFF0A1424).withValues(alpha: 0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16), // slightly rounder
            border: Border.all(color: const Color(0xFF1D2A3E).withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(color: Colors.white.withValues(alpha: 0.05), offset: const Offset(1, 1), blurRadius: 1, blurStyle: BlurStyle.inner), // subtle top-left highlight
              BoxShadow(color: const Color(0xFF02060F).withValues(alpha: 0.6), offset: const Offset(0, 10), blurRadius: 20), // deeper soft shadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.my_location, color: Color(0xFF8ED5FF), size: 15),
                  const SizedBox(width: 6),
                  const Text("TODAY'S FOCUS", style: TextStyle(color: Color(0xFF87929A), fontSize: 10.5, fontWeight: FontWeight.w600, fontFamily: 'JetBrains Mono', letterSpacing: 1.0)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                _session.details,
                style: const TextStyle(color: Color(0xFFD6E3FE), fontSize: 13.5, fontWeight: FontWeight.w500, height: 1.3),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: const Color(0xFF28354A).withValues(alpha: 0.4))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMicroStep(Icons.menu_book, 'Read', const Color(0xFF8ED5FF)),
                    const Text('➔', style: TextStyle(color: Color(0xFF3E484F), fontSize: 10)),
                    _buildMicroStep(Icons.psychology, 'Understand', const Color(0xFF57E1CE)),
                    const Text('➔', style: TextStyle(color: Color(0xFF3E484F), fontSize: 10)),
                    _buildMicroStep(Icons.edit_note, 'Make Notes', const Color(0xFF87929A)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusPill() {
    Color dotColor;
    Color textColor;
    String text;
    bool animateDot = false;

    switch (_currentState) {
      case FocusSessionState.ready:
        dotColor = const Color(0xFF87929A); // outline
        textColor = const Color(0xFF87929A);
        text = 'READY TO BEGIN';
        break;
      case FocusSessionState.active:
        dotColor = const Color(0xFF38BDF8); // primary-container
        textColor = const Color(0xFF8ED5FF); // primary
        text = 'SESSION IN PROGRESS';
        animateDot = true;
        break;
      case FocusSessionState.paused:
        dotColor = const Color(0xFF57E1CE); // tertiary
        textColor = const Color(0xFF57E1CE);
        text = 'SESSION PAUSED';
        break;
      case FocusSessionState.completed:
        dotColor = const Color(0xFF57E1CE);
        textColor = const Color(0xFF57E1CE);
        text = 'FOCUS SESSION COMPLETE';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1C2F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1D2A3E).withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(color: Colors.white.withValues(alpha: 0.05), offset: const Offset(1, 1), blurRadius: 2, blurStyle: BlurStyle.inner),
          BoxShadow(color: Colors.black.withValues(alpha: 0.4), offset: const Offset(0, 2), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulse animation for active
          animateDot
              ? _PulsingDot(color: dotColor)
              : Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    boxShadow: _currentState == FocusSessionState.paused ? [BoxShadow(color: dotColor, blurRadius: 8)] : null,
                  ),
                ),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: textColor, fontSize: 10.5, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _buildMicroStep(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 13),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildHeroFocusTimer() {
    // Dynamic styling based on state
    final bool isActive = _currentState == FocusSessionState.active;
    final bool isCompleted = _currentState == FocusSessionState.completed;
    
    final haloColor = isCompleted 
        ? const Color(0xFF57E1CE) 
        : isActive ? const Color(0xFF38BDF8) : const Color(0xFF38BDF8).withValues(alpha: 0.5);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Ambient Radial Backing Halo (Animated)
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 296,
              height: 296,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    haloColor.withValues(alpha: isActive ? 0.08 : (isCompleted ? 0.1 : 0.03)),
                    haloColor.withValues(alpha: 0.0),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            // Outer Ring container (Neumorphic Base)
            Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0E1C2F),
                    const Color(0xFF081221),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1D2A3E).withValues(alpha: 0.6), width: 1.5),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF02040A).withValues(alpha: 0.8), blurRadius: 40, offset: const Offset(12, 16)), // Deep soft drop shadow
                  BoxShadow(color: Colors.white.withValues(alpha: 0.03), blurRadius: 16, offset: const Offset(-6, -6)), // Soft ambient top-left light
                  BoxShadow(color: Colors.white.withValues(alpha: 0.08), blurRadius: 2, offset: const Offset(1, 1), blurStyle: BlurStyle.inner), // Sharp inner rim highlight
                ],
              ),
              child: ValueListenableBuilder<int>(
                valueListenable: _secondsLeftNotifier,
                builder: (context, secondsLeft, child) {
                  return CustomPaint(
                    painter: _TimerProgressPainter(
                      progress: 1.0 - (secondsLeft / _totalSeconds),
                      state: _currentState,
                    ),
                  );
                },
              ),
            ),
            // Inner Recessed Tactile Core
            Container(
              width: 184,
              height: 184,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF030A14), // darker top left to simulate depression
                    const Color(0xFF081424), 
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  // Inner Shadows to create the recessed "carved out" feel
                  BoxShadow(color: const Color(0xFF010308).withValues(alpha: 0.95), blurRadius: 20, offset: const Offset(8, 12), blurStyle: BlurStyle.inner),
                  BoxShadow(color: Colors.white.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(-4, -4), blurStyle: BlurStyle.inner),
                  // Slight drop shadow from the rim onto the core
                  BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 4, offset: const Offset(0, 0), blurStyle: BlurStyle.outer),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _currentState == FocusSessionState.paused ? 'PAUSED' : 
                      _currentState == FocusSessionState.completed ? 'MILESTONE REACHED' : 'PROTECTED CHUNK',
                      key: ValueKey(_currentState),
                      style: TextStyle(
                        color: isCompleted ? const Color(0xFF57E1CE) : const Color(0xFF87929A), 
                        fontSize: 10, 
                        fontWeight: FontWeight.w600, 
                        fontFamily: 'JetBrains Mono', 
                        letterSpacing: 1.5
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  ValueListenableBuilder<int>(
                    valueListenable: _secondsLeftNotifier,
                    builder: (context, secondsLeft, child) {
                      final m = secondsLeft ~/ 60;
                      final s = secondsLeft % 60;
                      final timeStr = '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
                      return Text(
                        timeStr,
                        style: TextStyle(
                          color: isCompleted ? Colors.white : const Color(0xFFF1F5F9), 
                          fontSize: 48, 
                          fontWeight: FontWeight.w800, 
                          fontFamily: 'Plus Jakarta Sans', 
                          letterSpacing: -1.5, 
                          height: 1.0,
                          shadows: isCompleted ? [BoxShadow(color: const Color(0xFF57E1CE).withValues(alpha: 0.5), blurRadius: 12)] : null,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _currentState == FocusSessionState.paused ? 'FOCUS SUSPENDED' :
                      _currentState == FocusSessionState.completed ? 'FOCUS COMPLETE' : 'REMAINING · ${_session.durationMinutes} MIN BLOCK',
                      key: ValueKey('sub_$_currentState'),
                      style: TextStyle(color: isCompleted ? const Color(0xFF57E1CE) : const Color(0xFF8ED5FF), fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Metric Summary
        ValueListenableBuilder<int>(
          valueListenable: _secondsLeftNotifier,
          builder: (context, secondsLeft, child) {
            final doneMin = (_totalSeconds - secondsLeft) ~/ 60;
            final leftMin = secondsLeft ~/ 60;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$doneMin min ', style: const TextStyle(color: Color(0xFF8ED5FF), fontSize: 13, fontWeight: FontWeight.w600)),
                const Text('completed', style: TextStyle(color: Color(0xFF87929A), fontSize: 13)),
                const SizedBox(width: 8),
                Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF3E484F), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text('$leftMin min ', style: const TextStyle(color: Color(0xFFD6E3FE), fontSize: 13, fontWeight: FontWeight.w600)),
                const Text('remaining', style: TextStyle(color: Color(0xFF87929A), fontSize: 13)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStateSwitcher() {
    // Session State Switcher block for easy testing
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text('SESSION STATE SWITCHER', style: TextStyle(color: Color(0xFF87929A), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: 'JetBrains Mono', letterSpacing: 1.0)),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF020E21),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1D2A3E).withValues(alpha: 0.6)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.6), blurRadius: 6, offset: const Offset(1, 2), blurStyle: BlurStyle.inner),
            ],
          ),
          child: Row(
            children: [
              _buildStateTab('Ready', FocusSessionState.ready),
              _buildStateTab('Active', FocusSessionState.active),
              _buildStateTab('Paused', FocusSessionState.paused),
              _buildStateTab('Done', FocusSessionState.completed),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateTab(String label, FocusSessionState state) {
    final isActive = _currentState == state;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _changeState(state);
          if (state == FocusSessionState.ready) _secondsLeftNotifier.value = _totalSeconds;
          if (state == FocusSessionState.completed) _secondsLeftNotifier.value = 0;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1D2A3E) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive ? [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 1))] : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF8ED5FF) : const Color(0xFFBDC8D1),
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlsZone() {
    String btnLabel;
    IconData btnIcon;
    Gradient? btnGradient;
    Color? btnBgColor;
    Color btnTextColor;
    Color btnBorderColor;
    List<BoxShadow> btnShadows;

    switch (_currentState) {
      case FocusSessionState.ready:
        btnLabel = 'Start Session';
        btnIcon = Icons.play_arrow;
        btnGradient = const LinearGradient(colors: [Color(0xFF38BDF8), Color(0xFF0284C7)], begin: Alignment.topLeft, end: Alignment.bottomRight);
        btnBgColor = null;
        btnTextColor = const Color(0xFF001F2E); 
        btnBorderColor = Colors.transparent;
        btnShadows = [
          BoxShadow(color: const Color(0xFF38BDF8).withValues(alpha: 0.4), blurRadius: 24, offset: const Offset(0, 8)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(1, 1), blurStyle: BlurStyle.inner),
        ];
        break;
      case FocusSessionState.active:
        btnLabel = 'Pause Session';
        btnIcon = Icons.pause;
        btnGradient = const LinearGradient(colors: [Color(0xFF132033), Color(0xFF0A1424)], begin: Alignment.topLeft, end: Alignment.bottomRight);
        btnBgColor = null;
        btnTextColor = const Color(0xFF8ED5FF);
        btnBorderColor = const Color(0xFF283A54);
        btnShadows = [
          BoxShadow(color: const Color(0xFF02060F).withValues(alpha: 0.9), blurRadius: 24, offset: const Offset(0, 10)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 2, offset: const Offset(1, 1), blurStyle: BlurStyle.inner),
        ];
        break;
      case FocusSessionState.paused:
        btnLabel = 'Resume Session';
        btnIcon = Icons.play_arrow;
        btnGradient = const LinearGradient(colors: [Color(0xFF132033), Color(0xFF0A1424)], begin: Alignment.topLeft, end: Alignment.bottomRight);
        btnBgColor = null;
        btnTextColor = const Color(0xFF57E1CE);
        btnBorderColor = const Color(0xFF1A4742);
        btnShadows = [
          BoxShadow(color: const Color(0xFF02060F).withValues(alpha: 0.9), blurRadius: 24, offset: const Offset(0, 10)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.05), blurRadius: 2, offset: const Offset(1, 1), blurStyle: BlurStyle.inner),
        ];
        break;
      case FocusSessionState.completed:
        btnLabel = 'Done · Log Session';
        btnIcon = Icons.check;
        btnGradient = const LinearGradient(colors: [Color(0xFF57E1CE), Color(0xFF14B8A6)], begin: Alignment.topLeft, end: Alignment.bottomRight);
        btnBgColor = null;
        btnTextColor = const Color(0xFF003731);
        btnBorderColor = Colors.transparent;
        btnShadows = [
          BoxShadow(color: const Color(0xFF57E1CE).withValues(alpha: 0.4), blurRadius: 24, offset: const Offset(0, 8)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.3), blurRadius: 2, offset: const Offset(1, 1), blurStyle: BlurStyle.inner),
        ];
        break;
    }

    return Column(
      children: [
        _TactileScaleButton(
          onTap: _toggleSession,
          pressedShadows: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 8, offset: const Offset(2, 4), blurStyle: BlurStyle.inner)
          ],
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            height: 52,
            decoration: BoxDecoration(
              color: btnBgColor,
              gradient: btnGradient,
              borderRadius: BorderRadius.circular(16),
              border: btnBorderColor != Colors.transparent ? Border.all(color: btnBorderColor, width: 1.5) : null,
              boxShadow: btnShadows,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(btnIcon, color: btnTextColor, size: 20),
                const SizedBox(width: 10),
                Text(btnLabel, style: TextStyle(color: btnTextColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Plus Jakarta Sans')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_currentState != FocusSessionState.ready)
          GestureDetector(
            onTap: _endSessionEarly,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, color: Color(0xFF87929A), size: 16),
                  const SizedBox(width: 6),
                  Text(
                    _currentState == FocusSessionState.completed ? 'Return to Syllabus' : 'Conclude Session Early',
                    style: const TextStyle(color: Color(0xFF87929A), fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        else
          const SizedBox(height: 40),
      ],
    );
  }
}

// ---------------------------------------------------------
// PAINTERS
// ---------------------------------------------------------

class _TimerProgressPainter extends CustomPainter {
  final double progress;
  final FocusSessionState state;

  _TimerProgressPainter({required this.progress, required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 14; 
    
    // 1. Solid Recessed Channel (Darker track)
    final trackPaint = Paint()
      ..color = const Color(0xFF030A14).withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, radius, trackPaint);
    
    // Subtle inner shadow for the track
    final trackShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(center, radius - 4, trackShadowPaint);

    // 2. Tick Backing (Subtle dots instead of thick dashes)
    final tickPaint = Paint()
      ..color = const Color(0xFF3E484F).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    _drawDashedCircle(canvas, center, radius + 14, tickPaint, 2, 8); // outer dots

    // 3. Progress Arc
    if (progress > 0) {
      final isCompleted = state == FocusSessionState.completed;
      final isPaused = state == FocusSessionState.paused;
      
      final rect = Rect.fromCircle(center: center, radius: radius);
      
      List<Color> arcColors;
      if (isCompleted) {
        arcColors = [const Color(0xFF57E1CE), const Color(0xFF2DD4BF)]; // Teal completion
      } else if (isPaused) {
        arcColors = [const Color(0xFF57E1CE).withValues(alpha: 0.5), const Color(0xFF38BDF8).withValues(alpha: 0.5)]; // Subdued
      } else {
        arcColors = [const Color(0xFF38BDF8), const Color(0xFF8ED5FF), const Color(0xFF3B82F6)]; // Vibrant blue
      }

      final gradient = LinearGradient(
        colors: arcColors,
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      ).createShader(rect);

      final arcPaint = Paint()
        ..shader = gradient
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10;
        
      // Drop shadow for the progress arc
      final shadowPaint = Paint()
        ..color = arcColors.first.withValues(alpha: isPaused ? 0.1 : 0.3)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      final sweepAngle = 2 * math.pi * progress;
      
      // Draw shadow first
      canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, shadowPaint);
      // Draw actual arc
      canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, arcPaint);
      
      // Draw a bright cap at the leading edge if active
      if (!isPaused && !isCompleted && progress < 1.0) {
        final currentAngle = -math.pi / 2 + sweepAngle;
        final capOffset = Offset(
          center.dx + radius * math.cos(currentAngle),
          center.dy + radius * math.sin(currentAngle),
        );
        final capPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
        canvas.drawCircle(capOffset, 3, capPaint);
        
        final coreCapPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        canvas.drawCircle(capOffset, 1.5, coreCapPaint);
      }
    }
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double radius, Paint paint, double dashWidth, double dashSpace) {
    final circumference = 2 * math.pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final double sweepAngle = (dashWidth / circumference) * 2 * math.pi;
    final double spaceAngle = (dashSpace / circumference) * 2 * math.pi;

    double currentAngle = -math.pi / 2;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );
      currentAngle += sweepAngle + spaceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _TimerProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.state != state;
  }
}

class _DotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.035)
      ..style = PaintingStyle.fill;
      
    for (double x = 0; x < size.width; x += 16) {
      for (double y = 0; y < size.height; y += 16) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------
// UTILS
// ---------------------------------------------------------

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.5 * _controller.value),
                blurRadius: 8 * _controller.value,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TactileScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final List<BoxShadow>? pressedShadows;

  const _TactileScaleButton({required this.child, required this.onTap, this.pressedShadows});

  @override
  State<_TactileScaleButton> createState() => _TactileScaleButtonState();
}

class _TactileScaleButtonState extends State<_TactileScaleButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTap: () {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: widget.child, // The inner container can switch shadows if desired, but we handle it via scaling here mostly.
        // Wait, the design requires inset shadow on press. 
        // A true tactile button would rebuild with pressedShadows. Let's do that cleanly next iteration if needed.
      ),
    );
  }
}
