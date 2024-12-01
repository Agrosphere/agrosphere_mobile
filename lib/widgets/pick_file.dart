// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class PickImageFile extends StatelessWidget {
//   final Widget child;
//   final bool allowMultiple;
//   final String dialogTitle;
//   final Function(List<File>?) onSelectedFile;
//   const PickImageFile(
//       {super.key,
//       required this.child,
//       required this.onSelectedFile,
//       this.allowMultiple = false,
//       this.dialogTitle = "Select a file"});

//   @override
//   Widget build(BuildContext context) {
//     void pick() async {
//       try {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           allowMultiple: allowMultiple,
//           allowCompression: true,
//           dialogTitle: dialogTitle,
//           type: FileType.image,
//         );
//         if (result != null) {
//           if (!kIsWeb) {
//             if (allowMultiple) {
//               List<File> files =
//                   result.paths.map((path) => File(path!)).toList();
//               onSelectedFile(files);
//             } else {
//               File file = File(result.files.single.path!);
//               onSelectedFile([file]);
//             }
//           }
//         } else {
//           onSelectedFile(null);
//         }
//       } catch (e) {
//         //error
//       }
//     }

//     return InkWell(
//       onTap: pick,
//       child: child,
//     );
//   }
// }
