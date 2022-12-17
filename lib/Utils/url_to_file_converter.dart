// //-------------url to File
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'dart:math';

// //-------------url to File
// final client = Dio();
// //--------------------------------Url to File
// Future<File> urlToFile(dynamic imageUrl) async {
//   print("url to file image---1-----");
// // generate random number.
//   var rng = new Random();
// // get temporary directory of device.
//   Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//   String tempPath = tempDir.path;
//   print("url to file image------2--");
// // create a new file in temporary path with random file name.
//   File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
//   print("url to file image------3--");
//   print(file);
//   //[https://s3.amazonaws.com/cdn.carbucks.com/a0286829-8018-47f1-af1c-d9192037fd38.jpg
// // call http.get method and pass imageUrl into it to get response.
//   // http.Response response = await http.get(Uri.parse(imageUrl));
//   Response response = await client.get(imageUrl);
//   //http.get(imageUrl);
//   print("url to file image------4--");
//   print(response);
// // write bodyBytes received in response to file.
//   await file.writeAsBytes(response.bodyBytes);
//   // await file.writeAsBytes(response.bodyBytes);

//   print("url to file image------5--");
//   print(file);
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//   return file;
// }
