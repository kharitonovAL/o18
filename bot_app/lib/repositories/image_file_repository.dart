import 'dart:io';
import 'package:bot_app/models/image_file.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ImageFileRepository {
  ImageFileRepository();

  static const int queryLimit = 1000000;

  Future<void> loadImage({
    required File file,
    required String requestId,
  }) async {
    final parseFile = ParseFile(File(file.path));

    final _file = ImageFile();
    _file.set(ImageFile.keyRequestId, requestId);
    _file.set(ImageFile.keyFile, parseFile);
    await _file.save().then((value) => print(value.success));
  }
}
