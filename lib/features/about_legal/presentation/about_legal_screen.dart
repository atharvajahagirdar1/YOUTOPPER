import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

class AboutLegalScreen extends StatefulWidget {
  const AboutLegalScreen({super.key});

  @override
  State<AboutLegalScreen> createState() => _AboutLegalScreenState();
}

class _AboutLegalScreenState extends State<AboutLegalScreen> with SingleTickerProviderStateMixin {
  String _versionInfo = '';
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      setState(() {
        _versionInfo = 'Version ${info.version} (${info.buildNumber})';
      });
    } catch (e, st) {
      debugPrint('Error loading package info: $e');
      debugPrint('Stack trace: $st');
      setState(() {
        _versionInfo = 'Version info unavailable';
      });
    }
  }

  void _showUnavailable(BuildContext context, String documentName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131F33),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          documentName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This document is not yet available in the current preview build.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Close',
              style: TextStyle(
                color: Color(0xFF5BD6E8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'YOUTOPPER',
      applicationVersion: _versionInfo,
      applicationIcon: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1627),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.school_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      applicationLegalese: '© ${DateTime.now().year} YOUTOPPER. All rights reserved.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040914), // Deep premium navy
      body: Stack(
        children: [
          // Background subtle glowing texture
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF5BD6E8).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0F4C81).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: const Color(0xFF040914).withValues(alpha: 0.8),
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'About & Legal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () => context.push('/home/profile'),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8DE8F7),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8DE8F7).withValues(alpha: 0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF040914),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            // Neumorphic Logo Container
                            _buildNeumorphicLogo(),
                            const SizedBox(height: 32),
                            // Title
                            const Text(
                              'YOUTOPPER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Subtitle
                            Text(
                              'The learning workspace.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Version Pill
                            _buildVersionPill(),
                            const SizedBox(height: 48),
                            
                            // LEGAL DOCUMENTS Section
                            _buildSectionHeader('LEGAL DOCUMENTS', rightText: 'Updated Jan 2025'),
                            const SizedBox(height: 16),
                            _buildGlassCard(
                              title: 'Privacy Policy',
                              subtitle: 'How your information is handled',
                              icon: Icons.verified_user_outlined,
                              onTap: () => _showUnavailable(context, 'Privacy Policy'),
                              delay: 100,
                            ),
                            _buildGlassCard(
                              title: 'Terms of Use',
                              subtitle: 'Terms governing application use',
                              icon: Icons.description_outlined,
                              onTap: () => _showUnavailable(context, 'Terms of Use'),
                              delay: 200,
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // SOFTWARE NOTICES Section
                            _buildSectionHeader('SOFTWARE NOTICES', rightText: 'Open source'),
                            const SizedBox(height: 16),
                            _buildGlassCard(
                              title: 'Open-Source Licenses',
                              subtitle: 'Libraries and acknowledgements',
                              icon: Icons.integration_instructions_outlined,
                              onTap: () => _showLicenses(context),
                              delay: 300,
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // Local First Storage Info
                            _buildGlassCard(
                              title: 'Local-First Storage',
                              subtitle: 'Study telemetry remains strictly on your device.',
                              icon: Icons.lock_outline_rounded,
                              showChevron: false,
                              delay: 400,
                            ),
                            
                            const SizedBox(height: 48),
                            
                            // Footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSmallCyanDot(),
                                const SizedBox(width: 8),
                                const Text(
                                  'Designed with Intelligent Calm',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildSmallCyanDot(),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '© ${DateTime.now().year} YOUTOPPER. All rights reserved.',
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNeumorphicLogo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFF0A1121),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(8, 8), // Dark shadow bottom right
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: -2,
            offset: const Offset(-4, -4), // Light highlight top left
          ),
          // Subtle glow
          BoxShadow(
            color: const Color(0xFF5BD6E8).withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1.5,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF131D30),
            Color(0xFF0A1121),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFFB0E8F0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            child: const Icon(
              Icons.school_rounded,
              color: Colors.white,
              size: 56,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF5BD6E8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5BD6E8).withValues(alpha: 0.8),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF040914).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF5BD6E8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5BD6E8).withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _versionInfo.isEmpty ? 'Loading...' : _versionInfo,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontFamily: 'monospace',
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCyanDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xFF5BD6E8),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSectionHeader(String leftText, {String? rightText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: TextStyle(
              color: const Color(0xFF5BD6E8).withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          if (rightText != null)
            Text(
              rightText,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
    bool showChevron = true,
    required int delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF131D30).withValues(alpha: 0.6),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
          // Inner highlight effect
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.02),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              highlightColor: const Color(0xFF5BD6E8).withValues(alpha: 0.1),
              splashColor: const Color(0xFF5BD6E8).withValues(alpha: 0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 22.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A1121).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF5BD6E8).withValues(alpha: 0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5BD6E8).withValues(alpha: 0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        color: const Color(0xFF5BD6E8),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showChevron)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
