import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: snackbar тоже надо бы показывать с текстом об успехе или неуспехе обновления
class MyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('My addresses',
    //           style: TextStyle(color: Colors.white, fontSize: 16)),
    //       elevation: 1,
    //       iconTheme: const IconThemeData(color: Colors.white),
    //       centerTitle: true,
    //     ),
    //     body: BlocProvider<MyProfileCubit>(
    //       create: (context) => MyProfileCubit(executorCubit),
    //       child: BlocBuilder<MyProfileCubit, CustomFormState>(
    //           builder: (context, state) {
    //         //print(state);
    //         if (state is FormGenericState) {
    //           return Column(children: <Widget>[
    //             Expanded(
    //                 child: ListView(children: <Widget>[
    //               Padding(
    //                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    //                 child: ProfileForm(
    //                     formKey: state.formKey, controllers: state.controllers),
    //               ),
    //             ])),
    //             //Expanded(child: Container()),
    //             Container(
    //                 //color: Colors.red,
    //                 height: 65,
    //                 child: SaveButton(function: () {
    //                   context.read<MyProfileCubit>().saveChanges();
    //                   Navigator.pop(context);
    //                 })),
    //           ]);
    //         } else {
    //           return Center(child: Text(ErrorMessages.errorGeneric));
    //         }
    //       }),
    //     ));
  }
}
