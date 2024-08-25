import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/bloc/details_bloc/details_bloc.dart';
import 'package:social_media/bloc/list_bloc/list_bloc.dart';
import 'package:social_media/bloc/login_bloc/login_bloc.dart';
import 'package:social_media/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:social_media/constants/themes.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/pages/login_page.dart';
import 'package:social_media/pages/main_page.dart';
import 'package:social_media/services/auth/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthServices().currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignUpBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ListBloc()),
        BlocProvider(create: (_) => DetailsBloc()),
      ],
      child: MaterialApp(
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        home: (currentUser == null) ? const LoginPage() : const MainPage(),
      ),
    );
  }
}
