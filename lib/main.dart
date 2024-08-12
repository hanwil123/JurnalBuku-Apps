import 'package:flutter/material.dart';
import 'package:jurnalbukuapps/core/theme/theme.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/Startup_Screen/LauncherScreen_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  String supabaseApiUrl = "https://kxrdsnwgaaazhixpwomw.supabase.co";
  String supabaseApiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt4cmRzbndnYWFhemhpeHB3b213Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY0NDAxOTksImV4cCI6MjAzMjAxNjE5OX0.LCa980WWb_hmkA5LhrBB3IPILAIRiMEz7PiAZ7FHflY";
  await Supabase.initialize(url: supabaseApiUrl, anonKey: supabaseApiKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jurnal Buku',
      theme: AppTheme.darkThemeMode,
      home: LauncherScreenView()
          );
  }
}
