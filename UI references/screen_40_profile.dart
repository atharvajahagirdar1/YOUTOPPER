import 'package:flutter/material.dart';

/// YOUTOPPER — Screen 40: Profile
///
/// UI-only screen with deterministic demo content.
/// Routing, app-shell integration, backend, and persistence are intentionally
/// left to the existing project integration step.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _background = Color(0xFF080F20);
  static const Color _surface = Color(0xFF111C31);
  static const Color _border = Color(0xFF263653);
  static const Color _primary = Color(0xFF7197FF);
  static const Color _cyan = Color(0xFF5BD6E8);
  static const Color _textPrimary = Color(0xFFF2F5FC);
  static const Color _textSecondary = Color(0xFF9AAAC4);
  static const Color _muted = Color(0xFF6F809D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildProfileHero(),
                  const SizedBox(height: 26),
                  _buildSectionHeading(
                    'Academic profile',
                    'Your learning context',
                    trailing: const Icon(Icons.edit_outlined,
                        color: _primary, size: 19),
                  ),
                  const SizedBox(height: 13),
                  _buildAcademicCard(),
                  const SizedBox(height: 25),
                  _buildSectionHeading(
                    'Learning preferences',
                    'Make your workspace feel right',
                  ),
                  const SizedBox(height: 13),
                  _buildPreferencesCard(),
                  const SizedBox(height: 25),
                  _buildSectionHeading(
                    'Your learning journey',
                    'A quick look at your setup',
                  ),
                  const SizedBox(height: 13),
                  _buildJourneyCard(),
                  const SizedBox(height: 25),
                  _buildSectionHeading(
                    'Account',
                    'Personal details and access',
                  ),
                  const SizedBox(height: 13),
                  _buildAccountCard(context),
                  const SizedBox(height: 24),
                  _buildFooter(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _headerButton(Icons.arrow_back_rounded),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 23,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Your space, your learning journey.',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        _headerButton(Icons.more_horiz_rounded),
      ],
    );
  }

  Widget _headerButton(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _border),
      ),
      child: Icon(icon, color: _textPrimary, size: 22),
    );
  }

  Widget _buildProfileHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A2D50),
            Color(0xFF14213A),
            Color(0xFF101A2E),
          ],
        ),
        border: Border.all(color: const Color(0xFF30466B)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x331D4F9A),
            blurRadius: 26,
            offset: Offset(0, 12),
          ),
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -5,
            top: -18,
            child: Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0x225BD6E8),
                  width: 1.2,
                ),
              ),
              child: Center(
                child: Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0x1F7197FF)),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_cyan, _primary, Color(0xFF6374E8)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x447197FF),
                          blurRadius: 20,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'AJ',
                        style: TextStyle(
                          color: Color(0xFF071326),
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atharva Jahagirdar',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 19,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Student · Member since 2026',
                          style: TextStyle(
                            color: Color(0xFFB2C1DB),
                            fontSize: 11.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.verified_rounded,
                                color: _cyan, size: 15),
                            SizedBox(width: 5),
                            Text(
                              'Learning profile',
                              style: TextStyle(
                                color: _cyan,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(height: 1, color: const Color(0x263F5A80)),
              const SizedBox(height: 17),
              Row(
                children: [
                  const Icon(Icons.school_outlined, color: _cyan, size: 18),
                  const SizedBox(width: 9),
                  const Expanded(
                    child: Text(
                      'Computer Science & IT',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0x1F7197FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0x447197FF)),
                    ),
                    child: const Text(
                      'B.Tech',
                      style: TextStyle(
                        color: Color(0xFFBBD0FF),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(
    String title,
    String subtitle, {
    Widget? trailing,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.25,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: _border),
            ),
            child: trailing,
          ),
      ],
    );
  }

  Widget _buildAcademicCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _detailRow(Icons.account_balance_outlined, 'University',
              'RGPV, Bhopal'),
          _rowDivider(),
          _detailRow(
              Icons.location_city_outlined, 'College', 'IPS Academy, Indore'),
          _rowDivider(),
          _detailRow(
              Icons.menu_book_rounded, 'Branch', 'Computer Science & IT'),
          _rowDivider(),
          _detailRow(Icons.layers_outlined, 'Current semester', 'Semester 5',
              showChevron: true),
        ],
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String label,
    String value, {
    bool showChevron = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          _iconTile(icon, size: 38),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: _textSecondary, fontSize: 11)),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          if (showChevron)
            const Icon(Icons.chevron_right_rounded,
                color: _muted, size: 20),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _preferenceRow(
            Icons.schedule_rounded,
            'Preferred study time',
            'Evening · 6:00 PM – 9:00 PM',
            accent: _cyan,
          ),
          _preferenceDivider(),
          _preferenceRow(
            Icons.hourglass_bottom_rounded,
            'Daily study goal',
            '2 hours per day',
          ),
          _preferenceDivider(),
          _preferenceRow(
            Icons.auto_awesome_outlined,
            'Learning approach',
            'Understand · Practice · Revise',
            accent: _cyan,
          ),
        ],
      ),
    );
  }

  Widget _preferenceRow(
    IconData icon,
    String title,
    String subtitle, {
    Color accent = _primary,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          _iconTile(icon, size: 42, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _textSecondary,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: _muted, size: 20),
        ],
      ),
    );
  }

  Widget _buildJourneyCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _journeyStat(
                  Icons.menu_book_rounded,
                  '5',
                  'Subjects',
                  _primary,
                ),
              ),
              Container(width: 1, height: 44, color: _border),
              Expanded(
                child: _journeyStat(
                  Icons.bolt_rounded,
                  '2h',
                  'Daily goal',
                  _cyan,
                ),
              ),
              Container(width: 1, height: 44, color: _border),
              Expanded(
                child: _journeyStat(
                  Icons.track_changes_rounded,
                  '2026',
                  'Started',
                  const Color(0xFFB9A3FF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D172A),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFF233550)),
            ),
            child: const Row(
              children: [
                Icon(Icons.tips_and_updates_outlined, color: _cyan, size: 19),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Your profile helps keep your learning workspace organized around your goals.',
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 11,
                      height: 1.45,
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

  Widget _journeyStat(
      IconData icon, String value, String label, Color accent) {
    return Column(
      children: [
        Icon(icon, color: accent, size: 19),
        const SizedBox(height: 9),
        Text(
          value,
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _textSecondary, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _accountRow(
            context,
            Icons.person_outline_rounded,
            'Personal information',
            'Name and basic details',
          ),
          _rowDivider(),
          _accountRow(
            context,
            Icons.school_outlined,
            'Academic details',
            'Course, college and semester',
          ),
          _rowDivider(),
          _accountRow(
            context,
            Icons.lock_outline_rounded,
            'Account and privacy',
            'Manage your account preferences',
          ),
        ],
      ),
    );
  }

  Widget _accountRow(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showDemoMessage(context, title),
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            children: [
              _iconTile(icon, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: _muted, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.all_inclusive_rounded, color: _primary, size: 18),
            SizedBox(width: 7),
            Text(
              'YOUTOPPER',
              style: TextStyle(
                color: _textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 7),
        Text(
          'Your learning journey, in one place.',
          textAlign: TextAlign.center,
          style: TextStyle(color: _muted, fontSize: 10.5),
        ),
      ],
    );
  }

  Widget _iconTile(
    IconData icon, {
    double size = 40,
    Color color = _primary,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF192843),
        borderRadius: BorderRadius.circular(size * 0.32),
        border: Border.all(color: const Color(0xFF2B3E5D)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 7,
            offset: Offset(2, 3),
          ),
          BoxShadow(
            color: Color(0x0FFFFFFF),
            blurRadius: 4,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: size * 0.48),
    );
  }

  Widget _rowDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Container(height: 1, color: _border),
    );
  }

  Widget _preferenceDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(height: 1, color: _border),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(21),
      border: Border.all(color: _border, width: 0.8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 15,
          offset: Offset(0, 7),
        ),
        BoxShadow(
          color: Color(0x0EFFFFFF),
          blurRadius: 5,
          offset: Offset(-1, -1),
        ),
      ],
    );
  }

  void _showDemoMessage(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$section · UI demo'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF17243D),
        duration: const Duration(milliseconds: 1300),
      ),
    );
  }
}
