import 'dart:io';

abstract class StorageService {
  Future<String> uploadAvatarFileImage(String userId, File imageFile);
}