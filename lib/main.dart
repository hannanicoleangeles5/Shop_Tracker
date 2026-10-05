import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_shell.dart';
import 'state.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appState.load(); // restore saved trips from shared_preferences
  runApp(
    DevicePreview(
      // Phone frame + device/orientation toolbar. Set to false (or use
      // `!kReleaseMode`) to ship the plain app with no frame.
      enabled: true,
      builder: (context) => const SpendWiseApp(preview: true),
    ),
  );
}

class SpendWiseApp extends StatelessWidget {
  // preview: true connects the app to DevicePreview. Tests leave it false so
  // they can build the app directly, without the phone frame.
  const SpendWiseApp({super.key, this.preview = false});
  final bool preview;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spend Wise',
      debugShowCheckedModeBanner: false,
      locale: preview ? DevicePreview.locale(context) : null,
      builder: preview ? DevicePreview.appBuilder : null,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kBg,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomeShell(),
    );
  }
}