import 'package:cimabe/app/core/models/item_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ItemEntity {
  static const String className = 'Item';

  ItemModel fromParse(ParseObject parseObject) {
    ItemModel itemModel = ItemModel(
      id: parseObject.objectId!,
      photo: parseObject.get('photo')?.get('url'),
      description: parseObject.get('description'),
      serie: parseObject.get('serie'),
      lote: parseObject.get('lote'),
      brand: parseObject.get('brand'),
      model: parseObject.get('model'),
      calibre: parseObject.get('calibre'),
      doc: parseObject.get('doc'),
      obsCaution: parseObject.get('obsCaution'),
      validate: parseObject.get<DateTime>('validate')?.toLocal(),
      groups: parseObject.get<List<dynamic>>('groups') != null
          ? parseObject
              .get<List<dynamic>>('groups')!
              .map((e) => e.toString())
              .toList()
          : [],
      isMunition: parseObject.get('isMunition'),
      isBlockedOperator: parseObject.get('isBlockedOperator'),
      isBlockedDoc: parseObject.get('isBlockedDoc'),
    );
    return itemModel;
  }

  Future<ParseObject> toParse(ItemModel itemModel) async {
    final profileParseObject = ParseObject(ItemEntity.className);
    profileParseObject.objectId = itemModel.id;
    if (itemModel.description != null) {
      profileParseObject.set('description', itemModel.description);
    }
    if (itemModel.serie != null) {
      profileParseObject.set('serie', itemModel.serie);
    }

    if (itemModel.lote != null) {
      profileParseObject.set('lote', itemModel.lote);
    }
    if (itemModel.brand != null) {
      profileParseObject.set('brand', itemModel.brand);
    }
    if (itemModel.model != null) {
      profileParseObject.set('model', itemModel.model);
    }
    if (itemModel.calibre != null) {
      profileParseObject.set('calibre', itemModel.calibre);
    }
    if (itemModel.doc != null) {
      profileParseObject.set('doc', itemModel.doc);
    }
    if (itemModel.obsCaution != null) {
      profileParseObject.set('obsCaution', itemModel.obsCaution);
    }
    if (itemModel.validate != null) {
      profileParseObject.set<DateTime?>('validate', itemModel.validate);
    }
    if (itemModel.isMunition != null) {
      profileParseObject.set('isMunition', itemModel.isMunition);
    }
    if (itemModel.isBlockedOperator != null) {
      profileParseObject.set('isBlockedOperator', itemModel.isBlockedOperator);
    }
    if (itemModel.isBlockedDoc != null) {
      profileParseObject.set('isBlockedDoc', itemModel.isBlockedDoc);
    }
    if (itemModel.groups != null) {
      profileParseObject.set('groups', itemModel.groups);
    }
    return profileParseObject;
  }
}
