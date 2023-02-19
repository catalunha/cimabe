import 'dart:convert';

import 'package:cimabe/app/core/models/item_model.dart';
import 'package:cimabe/app/core/models/user_profile_model.dart';

class CautionModel {
  final String? id;

  UserProfileModel? userProfileDeliver;
  final DateTime? deliverDt;

  ItemModel? itemModel;

  UserProfileModel? userProfileReceiver;
  // (item.isBlockedOperator=true)
  final bool?
      receiverAnalyzingItem; // Null: analisando item. False: item recusado. True: item aceito.
  final DateTime? receiverAnalyzedItemDt;

  final bool?
      receiverStartGiveback; // Null: ainda nao analisado. False: operador de posse do item recebido e aceito. True: iniciar devolução.
  final DateTime? receiverGivebackItemDt;
  final String? receiverGivebackDescription;

  UserProfileModel? userProfileGiveback;
  final bool?
      givebackAnalyzingItem; // Null: analisando item. False: item deve atualizar doc (item.isBlockedOperator=false,item.isBlockedDoc=true). T: item aceito (item.isBlockedOperator=false)
  final DateTime? givebackAnalyzedItemDt;
  final String? givebackAnalysisDescription;

  CautionModel({
    this.id,
    this.userProfileDeliver,
    this.deliverDt,
    this.itemModel,
    this.userProfileReceiver,
    this.receiverAnalyzingItem,
    this.receiverAnalyzedItemDt,
    this.receiverStartGiveback,
    this.receiverGivebackItemDt,
    this.receiverGivebackDescription,
    this.userProfileGiveback,
    this.givebackAnalyzingItem,
    this.givebackAnalyzedItemDt,
    this.givebackAnalysisDescription,
  });

  CautionModel copyWith({
    String? id,
    UserProfileModel? userProfileDeliver,
    DateTime? deliverDt,
    ItemModel? itemModel,
    UserProfileModel? userProfileReceiver,
    bool? receiverAnalyzingItem,
    DateTime? receiverAnalyzedItemDt,
    bool? receiverStartGiveback,
    DateTime? receiverGivebackItemDt,
    String? receiverGivebackDescription,
    UserProfileModel? userProfileGiveback,
    bool? givebackAnalyzingItem,
    DateTime? givebackAnalyzedItemDt,
    String? givebackAnalysisDescription,
  }) {
    return CautionModel(
      id: id ?? this.id,
      userProfileDeliver: userProfileDeliver ?? this.userProfileDeliver,
      deliverDt: deliverDt ?? this.deliverDt,
      itemModel: itemModel ?? this.itemModel,
      userProfileReceiver: userProfileReceiver ?? this.userProfileReceiver,
      receiverAnalyzingItem:
          receiverAnalyzingItem ?? this.receiverAnalyzingItem,
      receiverAnalyzedItemDt:
          receiverAnalyzedItemDt ?? this.receiverAnalyzedItemDt,
      receiverStartGiveback:
          receiverStartGiveback ?? this.receiverStartGiveback,
      receiverGivebackItemDt:
          receiverGivebackItemDt ?? this.receiverGivebackItemDt,
      receiverGivebackDescription:
          receiverGivebackDescription ?? this.receiverGivebackDescription,
      userProfileGiveback: userProfileGiveback ?? this.userProfileGiveback,
      givebackAnalyzingItem:
          givebackAnalyzingItem ?? this.givebackAnalyzingItem,
      givebackAnalyzedItemDt:
          givebackAnalyzedItemDt ?? this.givebackAnalyzedItemDt,
      givebackAnalysisDescription:
          givebackAnalysisDescription ?? this.givebackAnalysisDescription,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (userProfileDeliver != null) {
      result.addAll({'userProfileDeliver': userProfileDeliver!.toMap()});
    }
    if (deliverDt != null) {
      result.addAll({'deliverDt': deliverDt!.millisecondsSinceEpoch});
    }
    if (itemModel != null) {
      result.addAll({'itemModel': itemModel!.toMap()});
    }
    if (userProfileReceiver != null) {
      result.addAll({'userProfileReceiver': userProfileReceiver!.toMap()});
    }
    if (receiverAnalyzingItem != null) {
      result.addAll({'receiverAnalyzingItem': receiverAnalyzingItem});
    }
    if (receiverAnalyzedItemDt != null) {
      result.addAll({
        'receiverAnalyzedItemDt': receiverAnalyzedItemDt!.millisecondsSinceEpoch
      });
    }
    if (receiverStartGiveback != null) {
      result.addAll({'receiverStartGiveback': receiverStartGiveback});
    }
    if (receiverGivebackItemDt != null) {
      result.addAll({
        'receiverGivebackItemDt': receiverGivebackItemDt!.millisecondsSinceEpoch
      });
    }
    if (receiverGivebackDescription != null) {
      result
          .addAll({'receiverGivebackDescription': receiverGivebackDescription});
    }
    if (userProfileGiveback != null) {
      result.addAll({'userProfileGiveback': userProfileGiveback!.toMap()});
    }
    if (givebackAnalyzingItem != null) {
      result.addAll({'givebackAnalyzingItem': givebackAnalyzingItem});
    }
    if (givebackAnalyzedItemDt != null) {
      result.addAll({
        'givebackAnalyzedItemDt': givebackAnalyzedItemDt!.millisecondsSinceEpoch
      });
    }
    if (givebackAnalysisDescription != null) {
      result
          .addAll({'givebackAnalysisDescription': givebackAnalysisDescription});
    }

    return result;
  }

  factory CautionModel.fromMap(Map<String, dynamic> map) {
    return CautionModel(
      id: map['id'],
      userProfileDeliver: map['userProfileDeliver'] != null
          ? UserProfileModel.fromMap(map['userProfileDeliver'])
          : null,
      deliverDt: map['deliverDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deliverDt'])
          : null,
      itemModel:
          map['itemModel'] != null ? ItemModel.fromMap(map['itemModel']) : null,
      userProfileReceiver: map['userProfileReceiver'] != null
          ? UserProfileModel.fromMap(map['userProfileReceiver'])
          : null,
      receiverAnalyzingItem: map['receiverAnalyzingItem'],
      receiverAnalyzedItemDt: map['receiverAnalyzedItemDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['receiverAnalyzedItemDt'])
          : null,
      receiverStartGiveback: map['receiverStartGiveback'],
      receiverGivebackItemDt: map['receiverGivebackItemDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['receiverGivebackItemDt'])
          : null,
      receiverGivebackDescription: map['receiverGivebackDescription'],
      userProfileGiveback: map['userProfileGiveback'] != null
          ? UserProfileModel.fromMap(map['userProfileGiveback'])
          : null,
      givebackAnalyzingItem: map['givebackAnalyzingItem'],
      givebackAnalyzedItemDt: map['givebackAnalyzedItemDt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['givebackAnalyzedItemDt'])
          : null,
      givebackAnalysisDescription: map['givebackAnalysisDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CautionModel.fromJson(String source) =>
      CautionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CautionModel(id: $id, userProfileDeliver: $userProfileDeliver, deliverDt: $deliverDt, itemModel: $itemModel, userProfileReceiver: $userProfileReceiver, receiverAnalyzingItem: $receiverAnalyzingItem, receiverAnalyzedItemDt: $receiverAnalyzedItemDt, receiverStartGiveback: $receiverStartGiveback, receiverGivebackItemDt: $receiverGivebackItemDt, receiverGivebackDescription: $receiverGivebackDescription, userProfileGiveback: $userProfileGiveback, givebackAnalyzingItem: $givebackAnalyzingItem, givebackAnalyzedItemDt: $givebackAnalyzedItemDt, givebackAnalysisDescription: $givebackAnalysisDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CautionModel &&
        other.id == id &&
        other.userProfileDeliver == userProfileDeliver &&
        other.deliverDt == deliverDt &&
        other.itemModel == itemModel &&
        other.userProfileReceiver == userProfileReceiver &&
        other.receiverAnalyzingItem == receiverAnalyzingItem &&
        other.receiverAnalyzedItemDt == receiverAnalyzedItemDt &&
        other.receiverStartGiveback == receiverStartGiveback &&
        other.receiverGivebackItemDt == receiverGivebackItemDt &&
        other.receiverGivebackDescription == receiverGivebackDescription &&
        other.userProfileGiveback == userProfileGiveback &&
        other.givebackAnalyzingItem == givebackAnalyzingItem &&
        other.givebackAnalyzedItemDt == givebackAnalyzedItemDt &&
        other.givebackAnalysisDescription == givebackAnalysisDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userProfileDeliver.hashCode ^
        deliverDt.hashCode ^
        itemModel.hashCode ^
        userProfileReceiver.hashCode ^
        receiverAnalyzingItem.hashCode ^
        receiverAnalyzedItemDt.hashCode ^
        receiverStartGiveback.hashCode ^
        receiverGivebackItemDt.hashCode ^
        receiverGivebackDescription.hashCode ^
        userProfileGiveback.hashCode ^
        givebackAnalyzingItem.hashCode ^
        givebackAnalyzedItemDt.hashCode ^
        givebackAnalysisDescription.hashCode;
  }
}
