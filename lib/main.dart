import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_provider.dart';
import 'app/my_app.dart';
import 'core/getIt/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ...ApplicationProvider.instance.providers,
      ],
      child: MyApp(),
    ),
  );
}


