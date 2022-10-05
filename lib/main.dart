import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:fullstack_e_commerce_app/constants/global_variables.dart';
import 'package:fullstack_e_commerce_app/features/admin/screens/admin_screen.dart';
import 'package:fullstack_e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:fullstack_e_commerce_app/features/auth/services/auth_service.dart';
import 'package:fullstack_e_commerce_app/features/home/screens/home_screen.dart';
import 'package:fullstack_e_commerce_app/providers/user_provider.dart';
import 'package:fullstack_e_commerce_app/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E_COMMERCE_APP',
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            iconTheme: const IconThemeData(color: Colors.black)),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScreen()
            : const AuthScreen());
  }
}
