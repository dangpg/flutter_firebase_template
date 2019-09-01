import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_template/core/services/storage_service.dart';

class StorageServiceImpl extends StorageService {
  final StorageReference _storageReference = FirebaseStorage().ref();

  static const String avatarFilename = 'avatar';

  @override
  Future<String> uploadAvatarFileImage(String userId, File imageFile) async {
    String ext = imageFile.path.substring(imageFile.path.lastIndexOf('.'));
    String fileName = '$avatarFilename$ext';
    final StorageUploadTask task = _storageReference.child(userId).child(fileName).putFile(imageFile);
    final StorageTaskSnapshot snapshot = await task.onComplete;
    final url = await snapshot.ref.getDownloadURL() as String;
    return url;
  }
}