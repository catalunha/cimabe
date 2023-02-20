import 'dart:developer';

import 'package:cimabe/app/core/models/item_model.dart';
import 'package:cimabe/app/data/b4a/entity/item_entity.dart';
import 'package:cimabe/app/data/b4a/table/item/item_repository_exception.dart';
import 'package:cimabe/app/data/b4a/utils/parse_error_code.dart';
import 'package:cimabe/app/data/repositories/item_repository.dart';
import 'package:cimabe/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ItemRepositoryB4a implements ItemRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<ItemModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  ) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<ItemModel> listTemp = <ItemModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ItemEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ItemModel?> readById(String id) async {
    log('+++', name: 'ItemRepositoryB4a.readById');
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));
    query.whereEqualTo('objectId', id);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return ItemEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(ItemModel profileModel) async {
    final userProfileParse = await ItemEntity().toParse(profileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
