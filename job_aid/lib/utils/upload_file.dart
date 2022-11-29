import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class UploadFiles {
  Future<String> uploadFile(String folderName,File filePath) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(FirebaseAuth.instance.currentUser!.uid +
            '_' +
            p.basename(filePath.path))
        .putFile(File(filePath.path)).catchError((e){
          print(e.toString());
        });
    return taskSnapshot.ref.getDownloadURL();
  }
}
