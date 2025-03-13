// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase Initialized');
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: "medicaapp");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetMaterialApp(
        title: 'Medica App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        // themeMode: ThemeMode.system,
        themeMode: ThemeMode.light,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
