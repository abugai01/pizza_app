import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_test/pages/home_page.dart';
import 'package:pizza_test/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pizza_test/cubits/cart_cubit.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/cubits/menu_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //TODO: delete this bs
  final String uid = 'qmjOrRjxxAaPXeqlHbDhN4zb1lz1';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<FirestoreDatabase>(
      create: (_) => FirestoreDatabase(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MenuCubit>(
              create: (context) =>
                  MenuCubit(context.read<FirestoreDatabase>())),
          BlocProvider<CartCubit>(
              create: (context) =>
                  CartCubit(context.read<FirestoreDatabase>())),
        ],
        child: MaterialApp(
          title: 'Pizza Test',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
            primarySwatch: themePink,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
