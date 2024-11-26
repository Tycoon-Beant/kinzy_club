import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinzy_club/repository/auth_repository.dart';
import 'package:kinzy_club/repository/local_storage_repository.dart';
import 'package:kinzy_club/screens/auth/cubit/login_cubit.dart';
import 'package:kinzy_club/screens/auth/cubit/register_cubit.dart';
import 'package:kinzy_club/screens/auth/login_screen.dart';
import 'package:kinzy_club/screens/todo/cubit/todolist_cubit.dart';
import 'package:kinzy_club/screens/todo/todo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LocalStorageRepository(sharedPrefs),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(context.read<LocalStorageRepository>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => TodolistCubit(context.read<LocalStorageRepository>()),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(context.read<AuthRepository>()),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff6c5ce7),
        ),
      ),
      home: const TodoScreen(),
    );
  }
}
