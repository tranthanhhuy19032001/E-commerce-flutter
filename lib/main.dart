import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/CartModel.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Define your provider(s) here, including the CartModel provider
        ChangeNotifierProvider<CartModel>(
          create: (context) =>
              CartModel(), // Initialize your CartModel provider
        ),
        // Other providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Flutter Way - Template',
        theme: AppTheme.lightTheme(context),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
