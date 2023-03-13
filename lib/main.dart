import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mycinema/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import './helpers/auth.dart';
import './screens/welcome_screen.dart';
import './Bloc/cinema_bloc.dart';

void main(List<String> args)  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cinemaBloc = CinemaBloc();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        Provider<CinemaBloc>(
          create: (_) => CinemaBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.purple.shade300,
        ),
        home: AuthScreen(),
        routes: {'/welcomePage': ((context) => WelcomeScreen())},
      ),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple.shade300, Colors.pink.shade100],
            ),
          ),
          child: child,
        );
      },
    );
  }
}



