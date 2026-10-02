import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

class YouTopperApp extends StatelessWidget {
  const YouTopperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Top-level providers go here when needed
        Provider(create: (_) => 'Placeholder Provider'),
      ],
      child: MaterialApp.router(
        title: 'YOUTOPPER',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
