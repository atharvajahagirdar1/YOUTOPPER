import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  static const Color _background = Color(0xFF040914);
  static const Color _surface = Color(0xFF0A1121);
  static const Color _surfaceElevated = Color(0xFF131F37);
  static const Color _border = Color(0xFF1D2E4D);
  static const Color _cyan = Color(0xFF5BD6E8);
  static const Color _primary = Color(0xFF4A65D6);
  static const Color _textPrimary = Color(0xFFF2F5FC);
  static const Color _textSecondary = Color(0xFF8B9BB4);
  static const Color _muted = Color(0xFF516483);

  String _selectedTheme = 'Dark';
  String _focusDuration = '25 minutes';
  String _breakDuration = '5 minutes';

  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
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
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _primary.withValues(alpha: 0.15),
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
                        child: _buildHeroCard(),
                      ),
                      const SizedBox(height: 36),
                      _animatedStagger(
                        index: 1,
                        child: _buildSectionHeading('APPEARANCE'),
                      ),
                      const SizedBox(height: 16),
                      _animatedStagger(
                        index: 2,
                        child: _buildAppearanceCard(),
                      ),
                      const SizedBox(height: 32),
                      _animatedStagger(
                        index: 3,
                        child: _buildSectionHeading('STUDY EXPERIENCE'),
                      ),
                      const SizedBox(height: 16),
                      _animatedStagger(
                        index: 4,
                        child: _buildStudyExperienceCard(),
                      ),
                      const SizedBox(height: 32),
                      _animatedStagger(
                        index: 5,
                        child: _buildSectionHeading('NOTIFICATIONS'),
                      ),
                      const SizedBox(height: 16),
                      _animatedStagger(
                        index: 6,
                        child: _buildNotificationsCard(context),
                      ),
                      const SizedBox(height: 32),
                      _animatedStagger(
                        index: 7,
                        child: _buildSectionHeading('PRIVACY & DATA'),
                      ),
                      const SizedBox(height: 16),
                      _animatedStagger(
                        index: 8,
                        child: _buildPrivacyCard(context),
                      ),
                      const SizedBox(height: 32),
                      _animatedStagger(
                        index: 9,
                        child: _buildSectionHeading('HELP & ABOUT'),
                      ),
                      const SizedBox(height: 16),
                      _animatedStagger(
                        index: 10,
                        child: _buildHelpCard(context),
                      ),
                      const SizedBox(height: 48),
                      _animatedStagger(
                        index: 11,
                        child: _buildFooter(),
                      ),
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
    return Row(
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
          'Settings',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(width: 46), // Balance center alignment
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF14223D),
            Color(0xFF0F1A30),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF23365A)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x115BD6E8),
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _cyan.withValues(alpha: 0.1),
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _cyan.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _cyan.withValues(alpha: 0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tune_rounded, color: _cyan, size: 12),
                        SizedBox(width: 6),
                        Text(
                          'PREFERENCES',
                          style: TextStyle(
                            color: _cyan,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2C4E),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF2C416C)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.manage_accounts_outlined, color: _cyan, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Make YOUTOPPER\nYours',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 26,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Adjust your experience to fit the way\nyou learn best.',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ],
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

  Widget _buildAppearanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Theme',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFF080D1A), // deep dark well
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF131F35)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  spreadRadius: -2, // Inset feel
                ),
              ],
            ),
            child: Row(
              children: [
                _buildThemeSegment('System', Icons.settings_brightness_rounded),
                _buildThemeSegment('Light', Icons.wb_sunny_rounded),
                _buildThemeSegment('Dark', Icons.nightlight_round),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSegment(String label, IconData icon) {
    final isSelected = _selectedTheme == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTheme = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1C2C4D) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: const Color(0xFF2F4673)) : Border.all(color: Colors.transparent),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  key: ValueKey<bool>(isSelected),
                  color: isSelected ? _cyan : _muted,
                  size: 20,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? _cyan : _textSecondary,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudyExperienceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Default focus duration',
            style: TextStyle(color: _textPrimary, fontSize: 14.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            'Choose how long your usual focus session should last.',
            style: TextStyle(color: _textSecondary, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildDurationSegment('25 min', _focusDuration, (val) => setState(() => _focusDuration = val)),
              const SizedBox(width: 8),
              _buildDurationSegment('45 min', _focusDuration, (val) => setState(() => _focusDuration = val)),
              const SizedBox(width: 8),
              _buildDurationSegment('60 min', _focusDuration, (val) => setState(() => _focusDuration = val)),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Default break duration',
            style: TextStyle(color: _textPrimary, fontSize: 14.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            'Set the break time between focused study sessions.',
            style: TextStyle(color: _textSecondary, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildDurationSegment('5 min', _breakDuration, (val) => setState(() => _breakDuration = val)),
              const SizedBox(width: 8),
              _buildDurationSegment('10 min', _breakDuration, (val) => setState(() => _breakDuration = val)),
              const SizedBox(width: 8),
              _buildDurationSegment('15 min', _breakDuration, (val) => setState(() => _breakDuration = val)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSegment(String label, String selectedValue, Function(String) onTap) {
    // Normalizing logic for visual simplicity in the segment texts (25 min vs 25 minutes)
    final labelValue = '${label.split(' ').first} minutes';
    final isSelected = selectedValue == labelValue;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(labelValue),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? _cyan.withValues(alpha: 0.1) : _surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _cyan.withValues(alpha: 0.5) : _border,
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: _cyan.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? _cyan : _textPrimary,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsCard(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: _listTile(
        context,
        icon: Icons.notifications_active_outlined,
        title: 'Manage Notifications',
        subtitle: 'Control your study reminders and alerts.',
        onTap: () {
          context.push('/home/notifications');
        },
      ),
    );
  }

  Widget _buildPrivacyCard(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _listTile(
            context,
            icon: Icons.shield_outlined,
            title: 'Privacy Policy',
            subtitle: 'Understand how your information is handled.',
            onTap: () => _showDemoMessage(context, 'Privacy Policy'),
          ),
          _rowDivider(),
          _listTile(
            context,
            icon: Icons.data_usage_rounded,
            title: 'Data & Storage',
            subtitle: 'Learn how YOUTOPPER handles app data.',
            onTap: () => _showDemoMessage(context, 'Data & Storage'),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _listTile(
            context,
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            subtitle: 'Find help with using YOUTOPPER.',
            onTap: () => context.push('/home/help-support'),
          ),
          _rowDivider(),
          _listTile(
            context,
            icon: Icons.info_outline_rounded,
            title: 'App Information',
            subtitle: 'Version and application information.',
            onTap: () => _showDemoMessage(context, 'App Information'),
          ),
        ],
      ),
    );
  }

  Widget _listTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        splashColor: _cyan.withValues(alpha: 0.1),
        highlightColor: _cyan.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _surfaceElevated.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _border.withValues(alpha: 0.5)),
                ),
                child: Icon(icon, color: _cyan, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _surfaceElevated,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_right_rounded, color: _muted, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0F1728),
              border: Border.all(color: const Color(0xFF1D2E4D)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x445BD6E8),
                  blurRadius: 24,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.all_inclusive_rounded, color: _cyan, size: 28),
          ),
          const SizedBox(height: 20),
          const Text(
            'YOUTOPPER',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'MASTERY ENGINE',
            style: TextStyle(
              color: _cyan,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '"Learn Smarter. Achieve More."',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Version 1.0.0 (Beta)',
            style: TextStyle(
              color: _muted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 18),
      child: Container(height: 1, color: _border.withValues(alpha: 0.5)),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: _border),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
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
}
