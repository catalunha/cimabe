import 'package:cimabe/app/core/models/caution_model.dart';
import 'package:cimabe/app/data/b4a/entity/item_entity.dart';
import 'package:cimabe/app/data/b4a/entity/user_profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CautionEntity {
  static const String className = 'Caution';

  CautionModel fromParse(ParseObject parseObject) {
    CautionModel profileModel = CautionModel(
      id: parseObject.objectId!,
      userProfileDeliver: parseObject.get('userProfileDeliver') != null
          ? UserProfileEntity().fromParse(parseObject.get('userProfileDeliver'))
          : null,
      deliverDt: parseObject.get<DateTime>('deliverDt')?.toLocal(),
      item: parseObject.get('item') != null
          ? ItemEntity().fromParse(parseObject.get('item'))
          : null,
      userProfileReceiver: parseObject.get('userProfileReceiver') != null
          ? UserProfileEntity()
              .fromParse(parseObject.get('userProfileReceiver'))
          : null,
      receiverAnalyzingItem: parseObject.get('receiverAnalyzingItem'),
      receiverAnalyzedItemDt:
          parseObject.get<DateTime>('receiverAnalyzedItemDt')?.toLocal(),
      receiverIsPermanentItem: parseObject.get('receiverIsPermanentItem'),
      receiverStartGiveback: parseObject.get('receiverStartGiveback'),
      receiverGivebackItemDt:
          parseObject.get<DateTime>('receiverGivebackItemDt')?.toLocal(),
      receiverGivebackDescription:
          parseObject.get('receiverGivebackDescription'),
      userProfileGiveback: parseObject.get('userProfileGiveback') != null
          ? UserProfileEntity()
              .fromParse(parseObject.get('userProfileGiveback'))
          : null,
      givebackAnalyzingItem: parseObject.get('givebackAnalyzingItem'),
      givebackAnalyzedItemDt:
          parseObject.get<DateTime>('givebackAnalyzedItemDt')?.toLocal(),
      givebackAnalysisDescription:
          parseObject.get('givebackAnalysisDescription'),
    );
    return profileModel;
  }

  Future<ParseObject> toParse(CautionModel cautionModel) async {
    final cautionParseObject = ParseObject(CautionEntity.className);
    cautionParseObject.objectId = cautionModel.id;

    if (cautionModel.userProfileDeliver != null) {
      cautionParseObject.set(
          'userProfileDeliver',
          (ParseObject(UserProfileEntity.className)
                ..objectId = cautionModel.userProfileDeliver!.id)
              .toPointer());
    }
    if (cautionModel.deliverDt != null) {
      cautionParseObject.set<DateTime?>('deliverDt', cautionModel.deliverDt);
    }
    if (cautionModel.item != null) {
      cautionParseObject.set(
          'item',
          (ParseObject(ItemEntity.className)..objectId = cautionModel.item!.id)
              .toPointer());
    }
    if (cautionModel.userProfileReceiver != null) {
      cautionParseObject.set(
          'userProfileReceiver',
          (ParseObject(UserProfileEntity.className)
                ..objectId = cautionModel.userProfileReceiver!.id)
              .toPointer());
    }
    if (cautionModel.receiverAnalyzingItem != null) {
      cautionParseObject.set(
          'receiverAnalyzingItem', cautionModel.receiverAnalyzingItem);
    }
    if (cautionModel.receiverAnalyzedItemDt != null) {
      cautionParseObject.set<DateTime?>(
          'receiverAnalyzedItemDt', cautionModel.receiverAnalyzedItemDt);
    }
    if (cautionModel.receiverIsPermanentItem != null) {
      cautionParseObject.set(
          'receiverIsPermanentItem', cautionModel.receiverIsPermanentItem);
    }
    if (cautionModel.receiverStartGiveback != null) {
      cautionParseObject.set(
          'receiverStartGiveback', cautionModel.receiverStartGiveback);
    }
    if (cautionModel.receiverGivebackItemDt != null) {
      cautionParseObject.set<DateTime?>(
          'receiverGivebackItemDt', cautionModel.receiverGivebackItemDt);
    }
    if (cautionModel.receiverGivebackDescription != null) {
      cautionParseObject.set('receiverGivebackDescription',
          cautionModel.receiverGivebackDescription);
    }

    if (cautionModel.userProfileGiveback != null) {
      cautionParseObject.set(
          'userProfileGiveback',
          (ParseObject(UserProfileEntity.className)
                ..objectId = cautionModel.userProfileGiveback!.id)
              .toPointer());
    }
    if (cautionModel.givebackAnalyzingItem != null) {
      cautionParseObject.set(
          'givebackAnalyzingItem', cautionModel.givebackAnalyzingItem);
    }
    if (cautionModel.givebackAnalyzedItemDt != null) {
      cautionParseObject.set<DateTime?>(
          'givebackAnalyzedItemDt', cautionModel.givebackAnalyzedItemDt);
    }
    if (cautionModel.givebackAnalysisDescription != null) {
      cautionParseObject.set('givebackAnalysisDescription',
          cautionModel.givebackAnalysisDescription);
    }
    return cautionParseObject;
  }
}
