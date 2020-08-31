import 'package:colaboreapp/Screens/Welcome/Splash.dart';
import 'package:colaboreapp/bloc/auth/auth_bloc.dart';
import 'package:colaboreapp/constants.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/Home/home.dart';
import 'Screens/Login/login.dart';
import 'Screens/Login/loginForm.dart';
import 'bloc/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp().whenComplete(() {
    print('complete');
  });
  Bloc.observer = MyBlocObserver();
  final UserRepository userRepository = UserRepository();

  runApp(BlocProvider(
    create: (context) => AuthBloc(userRepository)..add(AuthSplash()),
    child: MyApp(userRepository: userRepository),
  ));
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
  UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is UnAuthState || state is AuthErrorState) {
            return Login(
              userRepository: widget._userRepository,
            );
          }
          if (state is AuthSucessState) {
            //widget._userRepository.singOut();
            return Home(usuario: state.user);
          }
          if (state is AuthSplashState) {
            return Splash();
          }

          return Splash();
        },
      ),
    );
  }
}

// class App extends StatelessWidget {
//   final UserRepository userRepository;

//   const App({Key key, this.userRepository}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthInitial) {
//           return Splash();
//         } else if (state is AuthenticatedState) {
//           return HomeParent(
//             user: state.user,
//             userRepository: userRepository,
//           );
//         } else if (state is UnAuthenticatedState) {
//           return null;
//         } else if (state is AuthenticatedErrorState) {
//           return Scaffold(
//             body: Center(
//               child: Text(state.mensagem),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
