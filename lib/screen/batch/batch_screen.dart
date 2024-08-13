import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_and_get_images/screen/batch_reader/logic/batch_reader_cubit.dart';
import 'package:scan_and_get_images/screen/batch_reader/logic/batch_reader_cubit.dart';
import 'package:scan_and_get_images/screen/nutraceuticals/logic/nutraceuticals_cubit.dart';

class BatchScreen extends StatelessWidget {
  const BatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext cont) {
    return BlocProvider(
      create: (context) => NutraceuticalsCubit()..initLocalList(),
      child: BlocConsumer<NutraceuticalsCubit, NutraceuticalsState>(
        listener: (context, state) {
          // TODO: implement listener
          print("object");
        },
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}
