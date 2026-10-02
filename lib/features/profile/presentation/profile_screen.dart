import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// YOUTOPPER — Screen 40: Profile
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color _background = Color(0xFF080F20);
  static const Color _surface = Color(0xFF111C31);
  static const Color _border = Color(0xFF263653);
  static const Color _primary = Color(0xFF7197FF);
  static const Color _cyan = Color(0xFF5BD6E8);
  static const Color _textPrimary = Color(0xFFF2F5FC);
  static const Color _textSecondary = Color(0xFF9AAAC4);
  static const Color _muted = Color(0xFF6F809D);

  String _name = 'Atharva Jahagirdar';
  String _status = 'Student · Member since 2026';

  String _university = 'RGPV, Bhopal';
  String _college = 'IPS Academy, Indore';
  String _branch = 'Computer Science & IT';
  String _semester = 'Semester 5';

  String _studyTime = 'Evening · 6:00 PM – 9:00 PM';
  String _dailyGoal = '2 hours per day';
  String _approach = 'Understand · Practice · Revise';

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
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildProfileHero(),
                  const SizedBox(height: 26),
                  _buildSectionHeading(
                    'Academic profile',
                    'Your learning context',
                    trailing: InkWell(
                      onTap: _showEditAcademicSheet,
                      borderRadius: BorderRadius.circular(13),
                      child: const Icon(Icons.edit_outlined, color: _primary, size: 19),
                    ),
                  ),
                  const SizedBox(height: 13),
                  _buildAcademicCard(),
                  const SizedBox(height: 25),
                  _buildSectionHeading(
                    'Learning preferences',
                    'Make your workspace feel right',
                    trailing: InkWell(
                      onTap: _showEditPreferencesSheet,
                      borderRadius: BorderRadius.circular(13),
                      child: const Icon(Icons.edit_outlined, color: _primary, size: 19),
                    ),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: _headerButton(Icons.arrow_back_rounded),
        ),
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
                    child: Center(
                      child: Text(
                        _name.isNotEmpty ? _name[0].toUpperCase() : 'A',
                        style: const TextStyle(
                          color: Color(0xFF071326),
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 19,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          _status,
                          style: const TextStyle(
                            color: Color(0xFFB2C1DB),
                            fontSize: 11.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.verified_rounded, color: _cyan, size: 15),
                            SizedBox(width: 5),
                            Text(
                              'Verified Student',
                              style: TextStyle(
                                color: _cyan,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _showEditProfileSheet,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E335E),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF2F4673)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit_note_rounded, color: _primary, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: _textPrimary,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title, String subtitle, {Widget? trailing}) {
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
            child: Center(child: trailing),
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
          _detailRow(Icons.account_balance_outlined, 'University', _university),
          _rowDivider(),
          _detailRow(Icons.location_city_outlined, 'College', _college),
          _rowDivider(),
          _detailRow(Icons.menu_book_rounded, 'Branch', _branch),
          _rowDivider(),
          _detailRow(Icons.layers_outlined, 'Current semester', _semester, showChevron: true),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value, {bool showChevron = false}) {
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
                Text(label, style: const TextStyle(color: _textSecondary, fontSize: 11)),
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
          if (showChevron) const Icon(Icons.chevron_right_rounded, color: _muted, size: 20),
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
          _preferenceRow(Icons.schedule_rounded, 'Preferred study time', _studyTime, accent: _cyan),
          _preferenceDivider(),
          _preferenceRow(Icons.hourglass_bottom_rounded, 'Daily study goal', _dailyGoal),
          _preferenceDivider(),
          _preferenceRow(Icons.auto_awesome_outlined, 'Learning approach', _approach, accent: _cyan),
        ],
      ),
    );
  }

  Widget _preferenceRow(IconData icon, String title, String value, {Color accent = _primary}) {
    return Row(
      children: [
        Icon(icon, color: accent, size: 20),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(value, style: const TextStyle(color: _textSecondary, fontSize: 11)),
            ],
          ),
        ),
      ],
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
                child: _journeyStat(Icons.menu_book_rounded, '5', 'Subjects', _primary),
              ),
              Container(width: 1, height: 44, color: _border),
              Expanded(
                child: _journeyStat(Icons.bolt_rounded, '2h', 'Daily goal', _cyan),
              ),
              Container(width: 1, height: 44, color: _border),
              Expanded(
                child: _journeyStat(Icons.track_changes_rounded, '2026', 'Started', const Color(0xFFB9A3FF)),
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

  Widget _journeyStat(IconData icon, String value, String label, Color accent) {
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
          _accountRow(context, Icons.person_outline_rounded, 'Personal information', 'Name and basic details', onTap: _showEditProfileSheet),
          _rowDivider(),
          _accountRow(context, Icons.school_outlined, 'Academic details', 'Course, college and semester', onTap: _showEditAcademicSheet),
          _rowDivider(),
          _accountRow(context, Icons.lock_outline_rounded, 'Account and privacy', 'Manage your account preferences', onTap: () => _showDemoMessage(context, 'Account and privacy')),
        ],
      ),
    );
  }

  Widget _accountRow(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => _showDemoMessage(context, title),
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
              const Icon(Icons.chevron_right_rounded, color: _muted, size: 20),
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

  Widget _iconTile(IconData icon, {double size = 40, Color color = _primary}) {
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

  // --- EDITING LOGIC ---

  void _showEditProfileSheet() {
    final nameController = TextEditingController(text: _name);
    final statusController = TextEditingController(text: _status);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: _buildBottomSheetWrapper(
            title: 'Edit Profile',
            children: [
              _buildTextField(nameController, 'Name'),
              const SizedBox(height: 16),
              _buildTextField(statusController, 'Status'),
            ],
            onSave: () {
              if (nameController.text.trim().isEmpty) return;
              setState(() {
                _name = nameController.text.trim();
                _status = statusController.text.trim();
              });
              Navigator.pop(ctx);
            },
          ),
        );
      },
    );
  }

  void _showEditAcademicSheet() {
    final uniController = TextEditingController(text: _university);
    final collegeController = TextEditingController(text: _college);
    final branchController = TextEditingController(text: _branch);
    final semController = TextEditingController(text: _semester);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: _buildBottomSheetWrapper(
            title: 'Edit Academic Details',
            children: [
              _buildTextField(uniController, 'University'),
              const SizedBox(height: 16),
              _buildTextField(collegeController, 'College'),
              const SizedBox(height: 16),
              _buildTextField(branchController, 'Branch'),
              const SizedBox(height: 16),
              _buildTextField(semController, 'Semester'),
            ],
            onSave: () {
              setState(() {
                _university = uniController.text.trim();
                _college = collegeController.text.trim();
                _branch = branchController.text.trim();
                _semester = semController.text.trim();
              });
              Navigator.pop(ctx);
            },
          ),
        );
      },
    );
  }

  void _showEditPreferencesSheet() {
    final timeController = TextEditingController(text: _studyTime);
    final goalController = TextEditingController(text: _dailyGoal);
    final approachController = TextEditingController(text: _approach);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: _buildBottomSheetWrapper(
            title: 'Edit Preferences',
            children: [
              _buildTextField(timeController, 'Preferred study time'),
              const SizedBox(height: 16),
              _buildTextField(goalController, 'Daily study goal'),
              const SizedBox(height: 16),
              _buildTextField(approachController, 'Learning approach'),
            ],
            onSave: () {
              setState(() {
                _studyTime = timeController.text.trim();
                _dailyGoal = goalController.text.trim();
                _approach = approachController.text.trim();
              });
              Navigator.pop(ctx);
            },
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetWrapper({
    required String title,
    required List<Widget> children,
    required VoidCallback onSave,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded, color: _textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...children,
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: const Color(0xFF071326),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: _textPrimary, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF162440),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
