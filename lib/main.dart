import 'package:colaboreapp/Screens/Login/login_screen.dart';
import 'package:colaboreapp/Screens/Welcome/Splash.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/Home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colabore APP',
      theme: ThemeData(
        primaryColor: kPrimaryColorGreen,
        scaffoldBackgroundColor: Colors.white,
      ),
      //home: Splash(),
      home: BlocProvider(
        create: (context) => AuthBloc(userRepository)..add(AppStartedEvent()),
        child: App(
          userRepository: userRepository,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return Splash();
        } else if (state is AuthenticatedState) {
          return HomeParent(
            user: state.user,
            userRepository: userRepository,
          );
        } else if (state is UnAuthenticatedState) {
          return LoginScreenParent(userRepository: userRepository);
        } else if (state is AuthenticatedErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.mensagem),
            ),
          );
        }
      },
    );
  }
}
