import 'dart:convert';

import 'package:flutter/foundation.dart';

class ItemModel {
  final String? id;
  final String? photo;
  final String? description;
  final String? serie;
  final String? lote;
  final String? brand;
  final String? model;
  final String? calibre;
  final String? doc;
  final String? obsCaution;
  final DateTime? validate;
  final bool? isMunition;
  final bool? isBlockedOperator;
  final bool? isBlockedDoc;
  final List<String>? groups;
  // final List<UserProfileModel>? operatorsExclusive;
  ItemModel({
    this.id,
    this.photo,
    this.description,
    this.serie,
    this.lote,
    this.brand,
    this.model,
    this.calibre,
    this.doc,
    this.obsCaution,
    this.validate,
    this.isMunition,
    this.isBlockedOperator,
    this.isBlockedDoc,
    this.groups,
  });

  ItemModel copyWith({
    String? id,
    String? photo,
    String? description,
    String? serie,
    String? lote,
    String? brand,
    String? model,
    String? calibre,
    String? doc,
    String? obsCaution,
    DateTime? validate,
    bool? isMunition,
    bool? isBlockedOperator,
    bool? isBlockedDoc,
    List<String>? groups,
  }) {
    return ItemModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      description: description ?? this.description,
      serie: serie ?? this.serie,
      lote: lote ?? this.lote,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      calibre: calibre ?? this.calibre,
      doc: doc ?? this.doc,
      obsCaution: obsCaution ?? this.obsCaution,
      validate: validate ?? this.validate,
      isMunition: isMunition ?? this.isMunition,
      isBlockedOperator: isBlockedOperator ?? this.isBlockedOperator,
      isBlockedDoc: isBlockedDoc ?? this.isBlockedDoc,
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
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
    if (doc != null) {
      result.addAll({'doc': doc});
    }
    if (obsCaution != null) {
      result.addAll({'obsCaution': obsCaution});
    }
    if (validate != null) {
      result.addAll({'validate': validate!.millisecondsSinceEpoch});
    }
    if (isMunition != null) {
      result.addAll({'isMunition': isMunition});
    }
    if (isBlockedOperator != null) {
      result.addAll({'isBlockedOperator': isBlockedOperator});
    }
    if (isBlockedDoc != null) {
      result.addAll({'isBlockedDoc': isBlockedDoc});
    }
    if (groups != null) {
      result.addAll({'groups': groups});
    }

    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      photo: map['photo'],
      description: map['description'],
      serie: map['serie'],
      lote: map['lote'],
      brand: map['brand'],
      model: map['model'],
      calibre: map['calibre'],
      doc: map['doc'],
      obsCaution: map['obsCaution'],
      validate: map['validate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['validate'])
          : null,
      isMunition: map['isMunition'],
      isBlockedOperator: map['isBlockedOperator'],
      isBlockedDoc: map['isBlockedDoc'],
      groups: List<String>.from(map['groups']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, photo: $photo, description: $description, serie: $serie, lote: $lote, brand: $brand, model: $model, calibre: $calibre, doc: $doc, obsCaution: $obsCaution, validate: $validate, isMunition: $isMunition, isBlockedOperator: $isBlockedOperator, isBlockedDoc: $isBlockedDoc, groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.photo == photo &&
        other.description == description &&
        other.serie == serie &&
        other.lote == lote &&
        other.brand == brand &&
        other.model == model &&
        other.calibre == calibre &&
        other.doc == doc &&
        other.obsCaution == obsCaution &&
        other.validate == validate &&
        other.isMunition == isMunition &&
        other.isBlockedOperator == isBlockedOperator &&
        other.isBlockedDoc == isBlockedDoc &&
        listEquals(other.groups, groups);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photo.hashCode ^
        description.hashCode ^
        serie.hashCode ^
        lote.hashCode ^
        brand.hashCode ^
        model.hashCode ^
        calibre.hashCode ^
        doc.hashCode ^
        obsCaution.hashCode ^
        validate.hashCode ^
        isMunition.hashCode ^
        isBlockedOperator.hashCode ^
        isBlockedDoc.hashCode ^
        groups.hashCode;
  }
}
