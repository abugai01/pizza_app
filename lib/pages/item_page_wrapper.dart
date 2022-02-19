import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/helpers/functions.dart';
import 'package:pizza_test/widgets/incrementor.dart';
import 'package:pizza_test/widgets/item_information_row.dart';
import 'package:pizza_test/cubits/cart_cubit.dart';
import 'package:pizza_test/widgets/bottom_bar.dart';
import 'package:pizza_test/cubits/item_cubit.dart';
import 'package:pizza_test/pages/item_page.dart';
import 'package:pizza_test/services/database.dart';

//todo: maybe it should be one page.. think about it
//todo: what if item is no longer available? should be in the query I think!
class ItemPageWrapper extends StatelessWidget {
  final String id;
  final String? name;

  ItemPageWrapper(this.id, {this.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCubit>(
        create: (context) =>
            ItemCubit(context.read<FirestoreDatabase>(), id: id),
        child: BlocBuilder<ItemCubit, ItemState>(builder: (context, state) {
          if (state is ItemLoadedState) {
            return ItemPage(state.item);
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  name ?? 'Oops',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                elevation: 1,
                centerTitle: true,
                backgroundColor: Colors.white,
                //centerTitle: true,
              ),
              body:
                  //todo padding?
                  Center(
                      child: (state is ItemErrorState)
                          ? Text(state.error)
                          : const SpinKitWave(color: themeLightGrey)),
            );
          }
        }));
  }
}
