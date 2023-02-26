import 'package:flutter/material.dart';
import 'package:mycinema/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import './helpers/auth.dart';
import './screens/welcome_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.deepPurple.shade700,
        ),
        home: AuthScreen(),
        routes: {'/welcomePage': ((context) => WelcomeScreen())},
      ),
    );
  }
}
