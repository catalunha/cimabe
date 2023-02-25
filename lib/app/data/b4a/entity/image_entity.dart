import 'package:cimabe/app/core/models/image_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ImageEntity {
  static const String className = 'Image';

  ImageModel fromParse(ParseObject parseObject) {
    ImageModel itemModel = ImageModel(
      id: parseObject.objectId!,
      url: parseObject.get('image')?.get('url'),
      keywords: parseObject.get<List<dynamic>>('groups') != null
          ? parseObject
              .get<List<dynamic>>('groups')!
              .map((e) => e.toString())
              .toList()
          : [],
    );
    return itemModel;
  }

  Future<ParseObject> toParse(ImageModel itemModel) async {
    final profileParseObject = ParseObject(ImageEntity.className);
    profileParseObject.objectId = itemModel.id;

    if (itemModel.keywords != null) {
      profileParseObject.set('keywords', itemModel.keywords);
    }
    return profileParseObject;
  }
}
