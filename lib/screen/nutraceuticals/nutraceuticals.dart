import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scan_and_get_images/screen/nutraceuticals/logic/nutraceuticals_cubit.dart';
import 'package:scan_and_get_images/src/core/component/dialog/alert_box.dart';
import 'package:scan_and_get_images/src/core/component/image_block/selected_image_block.dart';

class NutraceuticalScreen extends StatefulWidget {
  const NutraceuticalScreen({super.key});

  @override
  State<NutraceuticalScreen> createState() => _NutraceuticalScreenState();
}

class _NutraceuticalScreenState extends State<NutraceuticalScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocProvider(
      create: (context) => NutraceuticalsCubit()..initLocalList(),
      child: BlocConsumer<NutraceuticalsCubit, NutraceuticalsState>(
        listener: (context, state) {
          // TODO: implement listener
          print("here");
        },
        builder: (context, state) {
          NutraceuticalsCubit cubit =
              BlocProvider.of<NutraceuticalsCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("Nutraceuticals Screen"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: cubit.selectedImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertBoxDelete(
                                onTap: () async =>
                                    await cubit.deleteImageFromList(
                                  index: index,
                                  context: context,
                                ),
                              ),
                            );
                          },
                          child: SelectedImageBlock(
                            imagePath: cubit.selectedImages[index],
                          ));
                    },
                  ),
                )
              ],
            ),
            floatingActionButton: SpeedDial(
              activeIcon: Icons.close,
              activeForegroundColor: Colors.red,
              activeBackgroundColor: Colors.red,
              animationCurve: Curves.elasticInOut,
              icon: Icons.menu,
              // renderOverlay: false,
              spacing: 3,
              tooltip: 'Menu',
              children: [
                SpeedDialChild(
                  child: const Icon(CupertinoIcons.photo_on_rectangle),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  label: 'Add Document',
                  onTap: () async {
                    await cubit.addImageFromGallery(
                      context: context,
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(CupertinoIcons.camera),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  label: 'Scan Document',
                  onTap: () async =>
                      await cubit.addImageFromCamara(context: context),
                ),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }
}
