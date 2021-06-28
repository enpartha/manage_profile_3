import 'package:flutter/material.dart';
import 'package:manage_profile_3/providers/user_data.dart';
import 'package:provider/provider.dart';

import './screens/view_profile.dart';
import 'screens/manage_profile.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserData()),
      ],
      child: MaterialApp(
        home: ViewProfile(),
        routes: {
          ManageProfilePage.routeName: (ctx) => ManageProfilePage(),
        },
      ),
    );
  }
}
