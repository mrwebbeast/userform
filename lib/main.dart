import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mrwebbeast/app.dart";
import "package:mrwebbeast/features/home/controller/dashboard_controller.dart";

import "package:mrwebbeast/services/database/local_database.dart";

import "package:provider/provider.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.initialize();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardController()),
      ],
      child: const MyApp(),
    ),
  );
}
