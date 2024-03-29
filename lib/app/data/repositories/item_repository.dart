import 'package:cimabe/app/core/models/item_model.dart';
import 'package:cimabe/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class ItemRepository {
  Future<List<ItemModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  );
  Future<ItemModel> update(ItemModel itemModel);
  Future<ItemModel?> readById(String id);
  Future<ItemModel?> getBySerie(String value);
  Future<List<ItemModel>> getByLote(String value);
}
