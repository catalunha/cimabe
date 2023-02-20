import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cimabe/app/core/models/user_profile_model.dart';

class ItemModel {
  final String? id;
  final String? description;
  final String? serie;
  final String? lote;
  final String? brand;
  final String? model;
  final String? calibre;
  final DateTime? validate;
  final List<String>? groups;
  final String? obsCaution;
  final bool? isBlockedOperator;
  final bool? isBlockedDoc;
  final String? doc;
  final List<UserProfileModel>? operatorsExclusive;
  ItemModel({
    this.id,
    this.description,
    this.serie,
    this.lote,
    this.brand,
    this.model,
    this.calibre,
    this.validate,
    this.groups,
    this.obsCaution,
    this.isBlockedOperator,
    this.isBlockedDoc,
    this.doc,
    this.operatorsExclusive,
  });

  ItemModel copyWith({
    String? id,
    String? description,
    String? serie,
    String? lote,
    String? brand,
    String? model,
    String? calibre,
    DateTime? validate,
    List<String>? groups,
    String? obsCaution,
    bool? isBlockedOperator,
    bool? isBlockedDoc,
    String? doc,
    List<UserProfileModel>? operatorsExclusive,
  }) {
    return ItemModel(
      id: id ?? this.id,
      description: description ?? this.description,
      serie: serie ?? this.serie,
      lote: lote ?? this.lote,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      calibre: calibre ?? this.calibre,
      validate: validate ?? this.validate,
      groups: groups ?? this.groups,
      obsCaution: obsCaution ?? this.obsCaution,
      isBlockedOperator: isBlockedOperator ?? this.isBlockedOperator,
      isBlockedDoc: isBlockedDoc ?? this.isBlockedDoc,
      doc: doc ?? this.doc,
      operatorsExclusive: operatorsExclusive ?? this.operatorsExclusive,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (serie != null) {
      result.addAll({'serie': serie});
    }
    if (lote != null) {
      result.addAll({'lote': lote});
    }
    if (brand != null) {
      result.addAll({'brand': brand});
    }
    if (model != null) {
      result.addAll({'model': model});
    }
    if (calibre != null) {
      result.addAll({'calibre': calibre});
    }
    if (validate != null) {
      result.addAll({'validate': validate!.millisecondsSinceEpoch});
    }
    if (groups != null) {
      result.addAll({'groups': groups});
    }
    if (obsCaution != null) {
      result.addAll({'obsCaution': obsCaution});
    }
    if (isBlockedOperator != null) {
      result.addAll({'isBlockedOperator': isBlockedOperator});
    }
    if (isBlockedDoc != null) {
      result.addAll({'isBlockedDoc': isBlockedDoc});
    }
    if (doc != null) {
      result.addAll({'doc': doc});
    }
    if (operatorsExclusive != null) {
      result.addAll({
        'operatorsExclusive': operatorsExclusive!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      description: map['description'],
      serie: map['serie'],
      lote: map['lote'],
      brand: map['brand'],
      model: map['model'],
      calibre: map['calibre'],
      validate: map['validate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['validate'])
          : null,
      groups: List<String>.from(map['groups']),
      obsCaution: map['obsCaution'],
      isBlockedOperator: map['isBlockedOperator'],
      isBlockedDoc: map['isBlockedDoc'],
      doc: map['doc'],
      operatorsExclusive: map['operatorsExclusive'] != null
          ? List<UserProfileModel>.from(map['operatorsExclusive']
              ?.map((x) => UserProfileModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, description: $description, serie: $serie, lote: $lote, brand: $brand, model: $model, calibre: $calibre, validate: $validate, groups: $groups, obsCaution: $obsCaution, isBlockedOperator: $isBlockedOperator, isBlockedDoc: $isBlockedDoc, doc: $doc, operatorsExclusive: $operatorsExclusive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.description == description &&
        other.serie == serie &&
        other.lote == lote &&
        other.brand == brand &&
        other.model == model &&
        other.calibre == calibre &&
        other.validate == validate &&
        listEquals(other.groups, groups) &&
        other.obsCaution == obsCaution &&
        other.isBlockedOperator == isBlockedOperator &&
        other.isBlockedDoc == isBlockedDoc &&
        other.doc == doc &&
        listEquals(other.operatorsExclusive, operatorsExclusive);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        serie.hashCode ^
        lote.hashCode ^
        brand.hashCode ^
        model.hashCode ^
        calibre.hashCode ^
        validate.hashCode ^
        groups.hashCode ^
        obsCaution.hashCode ^
        isBlockedOperator.hashCode ^
        isBlockedDoc.hashCode ^
        doc.hashCode ^
        operatorsExclusive.hashCode;
  }
}
