import 'package:cab_zing/Bloc/Login/login_bloc.dart';
import 'package:cab_zing/Bloc/invoices/invoices_bloc.dart';
import 'package:cab_zing/core/injector.dart';
import 'package:cab_zing/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => InvoicesBloc()),
      ],
      child: AppWindow(),
    ),
  );
}

class AppWindow extends StatelessWidget {
  const AppWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
