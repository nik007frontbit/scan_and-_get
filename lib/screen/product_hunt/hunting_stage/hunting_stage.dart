import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scan_and_get_images/screen/product_hunt/hunting_stage/logic/hunting_stage_cubit.dart';
import 'package:scan_and_get_images/src/core/utils/snackbar.dart';

// class HuntingStage extends StatelessWidget {
//   HuntingStage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HuntingStageCubit()..setImageList(),
//       child: BlocConsumer<HuntingStageCubit, HuntingStageState>(
//         listener: (context, state) {
//           if (state is HuntingStageErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(state.error),
//               backgroundColor: Colors.red,
//             ));
//           }
//         },
//         builder: (context, state) {
//           HuntingStageCubit cubit = BlocProvider.of<HuntingStageCubit>(context);
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//               title: const Text("Product Hunt Phase"),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(10),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           const BoxShadow(
//                               color: Colors.black12,
//                               offset: Offset(5, 5),
//                               blurRadius: 5)
//                         ]),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Product Pacaging is box?",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: RadioListTile(
//                                 value: true,
//                                 groupValue: cubit.isBox,
//                                 title: const Text("Yes"),
//                                 onChanged: (value) =>
//                                     cubit.changeValueOfBox(value!),
//                               ),
//                             ),
//                             Expanded(
//                               child: RadioListTile(
//                                 value: false,
//                                 groupValue: cubit.isBox,
//                                 title: const Text("No"),
//                                 onChanged: (value) =>
//                                     cubit.changeValueOfBox(value!),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   cubit.isBox
//                       ? Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 cubit.huntListIsBox['title'],
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                 ),
//                               ),
//                             ),
//                             Wrap(
//                               runSpacing: 10,
//                               spacing: 10,
//                               alignment: WrapAlignment.spaceBetween,
//                               children: List.generate(
//                                 cubit.huntListIsBox['sides'].length,
//                                 (i) {
//                                   var side = cubit.huntListIsBox['sides'][i];
//                                   return Container(
//                                     width:
//                                         (MediaQuery.sizeOf(context).width / 2) -
//                                             20,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: Colors.white,
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.black12,
//                                           blurRadius: 5,
//                                           offset: Offset(5, 5),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         side["image"] != ""
//                                             ? Image.file(
//                                                 height: 150,
//                                                 File(side["image"]),
//                                                 fit: BoxFit.cover,
//                                               )
//                                             : Container(
//                                                 height: 150,
//                                                 alignment: Alignment.center,
//                                                 child: Text(side["sideName"]),
//                                               ),
//                                         Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               side["image"] == ""
//                                                   ? IconButton(
//                                                       onPressed: () async =>
//                                                           await cubit.addImage(
//                                                             context: context,
//                                                             path: side['image'],
//                                                           ),
//                                                       icon: const Icon(
//                                                           Icons.upload))
//                                                   : IconButton(
//                                                       onPressed: () async => photoView(
//                                                           context: context,
//                                                           image: side["image"],
//                                                           onDelete: () =>
//                                                               cubit.deleteImage(
//                                                                   context:
//                                                                       context,
//                                                                   path: side['image'])),
//                                                       icon: const Icon(Icons
//                                                           .remove_red_eye)),
//                                               IconButton(
//                                                   onPressed: () {},
//                                                   icon: const Icon(Icons.info))
//                                             ]),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           ],
//                         )
//                       : Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 cubit.huntListIsNotBox['title'],
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                 ),
//                               ),
//                             ),
//                             Wrap(
//                               runSpacing: 10,
//                               spacing: 10,
//                               alignment: WrapAlignment.spaceBetween,
//                               children: List.generate(
//                                 cubit.huntListIsNotBox['sides'].length,
//                                 (i) {
//                                   var side = cubit.huntListIsNotBox['sides'][i];
//                                   return Container(
//                                     width:
//                                         (MediaQuery.sizeOf(context).width / 2) -
//                                             20,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: Colors.white,
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.black12,
//                                           blurRadius: 5,
//                                           offset: Offset(5, 5),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         side["image"] != ""
//                                             ? Image.file(
//                                                 height: 150,
//                                                 File(side["image"]),
//                                                 fit: BoxFit.cover,
//                                               )
//                                             : Container(
//                                                 height: 150,
//                                                 alignment: Alignment.center,
//                                                 child: Text(side["sideName"]),
//                                               ),
//                                         Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               side["image"] == ""
//                                                   ? IconButton(
//                                                       onPressed: () async =>
//                                                           await cubit.addImage(
//                                                             context: context,
//                                                             path: side['image'],
//                                                           ),
//                                                       icon: const Icon(
//                                                           Icons.upload))
//                                                   : IconButton(
//                                                       onPressed: () async => photoView(
//                                                           context: context,
//                                                           image: side["image"],
//                                                           onDelete: () =>
//                                                               cubit.deleteImage(
//                                                                   context:
//                                                                       context,
//                                                                   path: side[ 'image'])),
//                                                       icon: const Icon(Icons
//                                                           .remove_red_eye)),
//                                               IconButton(
//                                                   onPressed: () {},
//                                                   icon: const Icon(Icons.info))
//                                             ]),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//
//                   cubit.isBox
//                       ? Container(
//                           margin: const EdgeInsets.all(10),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 const BoxShadow(
//                                     color: Colors.black12,
//                                     offset: Offset(5, 5),
//                                     blurRadius: 5)
//                               ]),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "What is Inside the box?",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: RadioListTile(
//                                       value: true,
//                                       groupValue: cubit.isStrip,
//                                       title: const Text("Strip"),
//                                       onChanged: (value) =>
//                                           cubit.changeValueOfStrip(value!),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: RadioListTile(
//                                       value: false,
//                                       groupValue: cubit.isStrip,
//                                       title: const Text("Other"),
//                                       onChanged: (value) =>
//                                           cubit.changeValueOfStrip(value!),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                   cubit.isBox
//                       ? cubit.isStrip
//                           ? Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     cubit.insideBoxHuntIsStripList['title'],
//                                     style: const TextStyle(
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                 ),
//                                 Wrap(
//                                   runSpacing: 10,
//                                   spacing: 10,
//                                   alignment: WrapAlignment.spaceBetween,
//                                   children: List.generate(
//                                     cubit.insideBoxHuntIsStripList['sides']
//                                         .length,
//                                     (i) {
//                                       var side = cubit
//                                           .insideBoxHuntIsStripList['sides'][i];
//                                       return Container(
//                                         width:
//                                             (MediaQuery.sizeOf(context).width /
//                                                     2) -
//                                                 20,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: Colors.white,
//                                           boxShadow: const [
//                                             BoxShadow(
//                                               color: Colors.black12,
//                                               blurRadius: 5,
//                                               offset: Offset(5, 5),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             side["image"] != ""
//                                                 ? Image.file(
//                                                     height: 150,
//                                                     File(side["image"]),
//                                                     fit: BoxFit.cover,
//                                                   )
//                                                 : Container(
//                                                     height: 150,
//                                                     alignment: Alignment.center,
//                                                     child:
//                                                         Text(side["sideName"]),
//                                                   ),
//                                             Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   side["image"] == ""
//                                                       ? IconButton(
//                                                           onPressed: () async =>
//                                                               await cubit
//                                                                   .addImage(
//                                                                 context:
//                                                                     context,
//                                                                 path: side[
//                                                                     'image'],
//                                                               ),
//                                                           icon: const Icon(
//                                                               Icons.upload))
//                                                       : IconButton(
//                                                           onPressed: () async => photoView(
//                                                               context: context,
//                                                               image:
//                                                                   side["image"],
//                                                               onDelete: () => cubit
//                                                                   .deleteImage(
//                                                                       context:
//                                                                           context,
//                                                                       path: side[
//                                                                           'image'])),
//                                                           icon: const Icon(Icons
//                                                               .remove_red_eye)),
//                                                   IconButton(
//                                                       onPressed: () {},
//                                                       icon: const Icon(
//                                                           Icons.info))
//                                                 ]),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 )
//                               ],
//                             )
//                           : Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     cubit.insideBoxHuntIsNotStripList['title'],
//                                     style: const TextStyle(
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                 ),
//                                 Wrap(
//                                   runSpacing: 10,
//                                   spacing: 10,
//                                   alignment: WrapAlignment.spaceBetween,
//                                   children: List.generate(
//                                     cubit.insideBoxHuntIsNotStripList['sides']
//                                         .length,
//                                     (i) {
//                                       var side =
//                                           cubit.insideBoxHuntIsNotStripList[
//                                               'sides'][i];
//                                       return Container(
//                                         width:
//                                             (MediaQuery.sizeOf(context).width /
//                                                     2) -
//                                                 20,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: Colors.white,
//                                           boxShadow: const [
//                                             BoxShadow(
//                                               color: Colors.black12,
//                                               blurRadius: 5,
//                                               offset: Offset(5, 5),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             side["image"] != ""
//                                                 ? Image.file(
//                                                     height: 150,
//                                                     File(side["image"]),
//                                                     fit: BoxFit.cover,
//                                                   )
//                                                 : Container(
//                                                     height: 150,
//                                                     alignment: Alignment.center,
//                                                     child:
//                                                         Text(side["sideName"]),
//                                                   ),
//                                             Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   side["image"] == ""
//                                                       ? IconButton(
//                                                           onPressed: () async =>
//                                                               await cubit
//                                                                   .addImage(
//                                                                 context:
//                                                                     context,
//                                                                 path: side[
//                                                                     'image'],
//                                                               ),
//                                                           icon: const Icon(
//                                                               Icons.upload))
//                                                       : IconButton(
//                                                           onPressed: () async => photoView(
//                                                               context: context,
//                                                               image:
//                                                                   side["image"],
//                                                               onDelete: () => cubit
//                                                                   .deleteImage(
//                                                                       context:
//                                                                           context,
//                                                                       path: side[
//                                                                           'image'])),
//                                                           icon: const Icon(Icons
//                                                               .remove_red_eye)),
//                                                   IconButton(
//                                                       onPressed: () {},
//                                                       icon: const Icon(
//                                                           Icons.info))
//                                                 ]),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 )
//                               ],
//                             )
//                       : SizedBox(),
//                   // ListView.builder(
//                   //   physics: const NeverScrollableScrollPhysics(),
//                   //   padding:
//                   //   const EdgeInsetsDirectional.symmetric(horizontal: 10),
//                   //   shrinkWrap: true,
//                   //   itemCount: cubit.huntList.length,
//                   //   itemBuilder: (context, index) {
//                   //     var data = cubit.huntList[index];
//                   //     return Column(
//                   //       mainAxisSize: MainAxisSize.min,
//                   //       children: [
//                   //         ListTile(
//                   //           title: Text(
//                   //             data['title'],
//                   //             style: const TextStyle(
//                   //               fontSize: 22,
//                   //             ),
//                   //           ),
//                   //         ),
//                   //         Wrap(
//                   //           runSpacing: 10,
//                   //           spacing: 10,
//                   //           alignment: WrapAlignment.spaceBetween,
//                   //           children: List.generate(
//                   //             data['sides'].length,
//                   //                 (i) {
//                   //               var side = data['sides'][i];
//                   //               return Container(
//                   //                 width:
//                   //                 (MediaQuery
//                   //                     .sizeOf(context)
//                   //                     .width / 2) -
//                   //                     20,
//                   //                 decoration: BoxDecoration(
//                   //                   borderRadius: BorderRadius.circular(15),
//                   //                   color: Colors.white,
//                   //                   boxShadow: const [
//                   //                     BoxShadow(
//                   //                       color: Colors.black12,
//                   //                       blurRadius: 5,
//                   //                       offset: Offset(5, 5),
//                   //                     ),
//                   //                   ],
//                   //                 ),
//                   //                 child: Column(
//                   //                   mainAxisSize: MainAxisSize.min,
//                   //                   children: [
//                   //                     side["image"] != ""
//                   //                         ? Image.file(
//                   //                       height: 150,
//                   //                       File(side["image"]),
//                   //                       fit: BoxFit.cover,
//                   //                     )
//                   //                         : Container(
//                   //                       height: 150,
//                   //                       alignment: Alignment.center,
//                   //                       child: Text(side["sideName"]),
//                   //                     ),
//                   //                     Row(
//                   //                         mainAxisSize: MainAxisSize.min,
//                   //                         children: [
//                   //                           side["image"] == ""
//                   //                               ? IconButton(
//                   //                               onPressed: () async =>
//                   //                               await cubit.addImage(
//                   //                                   context: context,
//                   //                                   hunListIndex: index,
//                   //                                   productIndex: i),
//                   //                               icon:
//                   //                               const Icon(
//                   //                                   Icons.upload))
//                   //                               : IconButton(
//                   //                               onPressed: () async =>
//                   //                                   photoView(
//                   //                                       context: context,
//                   //                                       image:
//                   //                                       side["image"],
//                   //                                       onDelete: () =>
//                   //                                           cubit
//                   //                                               .deleteImage(
//                   //                                               context:
//                   //                                               context,
//                   //                                               hunListIndex:
//                   //                                               index,
//                   //                                               productIndex:
//                   //                                               i)),
//                   //                               icon: const Icon(
//                   //                                   Icons.remove_red_eye)),
//                   //                           IconButton(
//                   //                               onPressed: () {},
//                   //                               icon: const Icon(Icons.info))
//                   //                         ]),
//                   //                   ],
//                   //                 ),
//                   //               );
//                   //             },
//                   //           ),
//                   //         )
//                   //       ],
//                   //     );
//                   //   },
//                   // ),
//                   ElevatedButton(
//                       onPressed: () => cubit.submitImages(context: context),
//                       child: const Text("Submit"))
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   photoView({
//     required BuildContext context,
//     required String image,
//     required Function() onDelete,
//   }) {
//     return showDialog(
//       context: context,
//       builder: (context) => Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(
//               CupertinoIcons.back,
//               color: Colors.black,
//             ),
//             style: const ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(Colors.white)),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: IconButton(
//                 onPressed: onDelete,
//                 icon: const Icon(
//                   CupertinoIcons.delete,
//                   color: Colors.black,
//                 ),
//                 style: const ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(Colors.white)),
//               ),
//             )
//           ],
//           backgroundColor: Colors.transparent,
//           foregroundColor: Colors.white,
//         ),
//         backgroundColor: Colors.transparent,
//         body: PhotoView(
//           backgroundDecoration: const BoxDecoration(
//             color: Colors.transparent,
//           ),
//           imageProvider: FileImage(File(image)),
//           heroAttributes: const PhotoViewHeroAttributes(tag: "hero"),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void clear() {
//     print('Clearing cache!');
//     clear();
//   }
// }
class HuntingStageScreen extends StatelessWidget {
  Map<String, dynamic> map;

  HuntingStageScreen({required this.map});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HuntingStageCubit()..setImageList(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Hunting Stage')),
          body: BlocConsumer<HuntingStageCubit, HuntingStageState>(
            builder: (context, state) {
              HuntingStageCubit cubit =
                  BlocProvider.of<HuntingStageCubit>(context);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text(
                        'Is Box',
                      ),
                      value: cubit.isBox,
                      onChanged: (value) {
                        cubit.changeValueOfBox(value);
                      },
                    ),
                    cubit.isBox
                        ? SwitchListTile(
                            title: const Text('Is Strip'),
                            value: cubit.isStrip,
                            onChanged: (value) {
                              cubit.changeValueOfStrip(value);
                            },
                          )
                        : const SizedBox(),
                    SwitchListTile(
                      title: const Text('Is Cartoon'),
                      value: cubit.isCartoon,
                      onChanged: (value) {
                        cubit.changeValueOfCartoon(value);
                      },
                    ),
                    Column(
                      children: List.generate(
                        cubit.huntList.length,
                        (index) {
                          var sides = context
                              .read<HuntingStageCubit>()
                              .huntList[index]['sides'];
                          return Column(
                            children: [
                              Container(
                                height: 1,
                                color: Colors.deepPurple,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                  top: 15,
                                ),
                              ),
                              ListTile(
                                title: Text(context
                                    .read<HuntingStageCubit>()
                                    .huntList[index]['title']),
                              ),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                alignment: WrapAlignment.spaceBetween,
                                children: List.generate(
                                  sides.length,
                                  (i) {
                                    var side = sides[i];
                                    return Container(
                                      width: (MediaQuery.sizeOf(context).width /
                                              2) -
                                          20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            offset: Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          side["image"] != ""
                                              ? ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              15)),
                                                  child: Image.file(
                                                    height: 150,
                                                    width: double.infinity,
                                                    File(side["image"]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Container(
                                                  height: 150,
                                                  alignment: Alignment.center,
                                                  child: Text(side["sideName"]),
                                                ),
                                          Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                side["image"] == ""
                                                    ? IconButton(
                                                        onPressed: () async =>
                                                            await cubit
                                                                .addImage(
                                                              context: context,
                                                              sideName: side[
                                                                  'sideName'],
                                                            ),
                                                        icon: const Icon(
                                                            Icons.upload))
                                                    : IconButton(
                                                        onPressed: () async => photoView(
                                                            context: context,
                                                            image:
                                                                side["image"],
                                                            onDelete: () => cubit
                                                                .deleteImage(
                                                                    context:
                                                                        context,
                                                                    sideName: side[
                                                                        'sideName'])),
                                                        icon: const Icon(Icons
                                                            .remove_red_eye)),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                            "Correct Side of Image",
                                                          ),
                                                          content: const Text(
                                                            "Image of product with side view",
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                child: const Text(
                                                                    "Got it"))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(Icons.info))
                                              ]),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // ListView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: cubit.huntList.length,
                    //   itemBuilder: (context, index) {
                    //     final item = cubit.huntList[index];
                    //     return ExpansionTile(
                    //       title: Text(item['title']),
                    //       children: item['sides'].map<Widget>((side) {
                    //         return ListTile(
                    //           title: Text(side['sideName']),
                    //           leading: side['image'].isEmpty
                    //               ? const Icon(Icons.image)
                    //               : Image.file(File(side['image'])),
                    //           trailing: side['image'].isEmpty
                    //               ? IconButton(
                    //                   icon: const Icon(Icons.camera_alt),
                    //                   onPressed: () {
                    //                     context
                    //                         .read<HuntingStageCubit>()
                    //                         .addImage(
                    //                           context: context,
                    //                           sideName: side['sideName'],
                    //                         );
                    //                   },
                    //                 )
                    //               : IconButton(
                    //                   icon: const Icon(Icons.delete),
                    //                   onPressed: () {
                    //                     context
                    //                         .read<HuntingStageCubit>()
                    //                         .deleteImage(
                    //                           context: context,
                    //                           sideName: side['sideName'],
                    //                         );
                    //                   },
                    //                 ),
                    //         );
                    //       }).toList(),
                    //     );
                    //   },
                    // ),
                    cubit.extraImages.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                              color: Colors.deepPurple,
                            ))),
                            child: const Text('Extra Images',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          )
                        : const SizedBox(),
                    cubit.extraImages.isNotEmpty
                        ? Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            alignment: WrapAlignment.spaceBetween,
                            children: List.generate(
                              cubit.extraImages.length,
                              (i) {
                                var side = cubit.extraImages[i];
                                return Container(
                                  width:
                                      (MediaQuery.sizeOf(context).width / 2) -
                                          20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                        child: Image.file(
                                          height: 150,
                                          width: double.infinity,
                                          File(side["image"]!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () async => photoView(
                                                    context: context,
                                                    image: side["image"]!,
                                                    onDelete: () async =>
                                                        await cubit
                                                            .deleteExtraImage(
                                                                i, context)),
                                                icon: const Icon(
                                                    Icons.remove_red_eye)),
                                          ]),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        // ListView.builder(
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: cubit.extraImages.length,
                        //         itemBuilder: (context, index) {
                        //           final extraImage = context
                        //               .read<HuntingStageCubit>()
                        //               .extraImages[index];
                        //           return ListTile(
                        //             leading: extraImage['image'] == null
                        //                 ? const Icon(Icons.image)
                        //                 : Image.file(File(extraImage['image']!)),
                        //             title: Text("Extra Image ${index + 1}"),
                        //             trailing: IconButton(
                        //               icon: const Icon(Icons.delete),
                        //               onPressed: () {
                        //                 cubit.deleteExtraImage(index);
                        //               },
                        //             ),
                        //           );
                        //         },
                        //       )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.addExtraImage(context: context);
                      },
                      child: const Text('Add Extra Image'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<HuntingStageCubit>()
                            .submitImages(context: context, map: map);
                      },
                      child: const Text('Submit Images'),
                    ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state is HuntingStageErrorState) {
                showSnackBar(context, state.error, isError: true);
              }
            },
          )),
    );
  }

  photoView({
    required BuildContext context,
    required String image,
    required Function() onDelete,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            ),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                ),
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        body: PhotoView(
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          imageProvider: FileImage(File(image)),
          heroAttributes: const PhotoViewHeroAttributes(tag: "hero"),
        ),
      ),
    );
  }

  @override
  Future<void> clear() async {
    clear();
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }
}
