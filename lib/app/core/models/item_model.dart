import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cimabe/app/core/models/user_profile_model.dart';

class ItemModel {
  final String? id;
  final String? description;
  final String? serie;
  final List<String>? infos;
  final String? lote;
  final DateTime? validate;
  final String? obsCaution;
  final bool? isBlockedOperator;
  final bool? isBlockedDoc;
  final String? doc;
  final List<UserProfileModel>? operatorsExclusive;
  ItemModel({
    this.id,
    this.serie,
    this.infos,
    this.description,
    this.obsCaution,
    this.lote,
    this.validate,
    this.isBlockedOperator,
    this.isBlockedDoc,
    this.operatorsExclusive,
    this.doc,
  });

  ItemModel copyWith({
    String? id,
    String? serie,
    List<String>? infos,
    String? description,
    String? obsCaution,
    String? lote,
    DateTime? validate,
    bool? isBlockedOperator,
    bool? isBlockedDoc,
    List<UserProfileModel>? operatorsExclusive,
    String? doc,
  }) {
    return ItemModel(
      id: id ?? this.id,
      serie: serie ?? this.serie,
      infos: infos ?? this.infos,
      description: description ?? this.description,
      obsCaution: obsCaution ?? this.obsCaution,
      lote: lote ?? this.lote,
      validate: validate ?? this.validate,
      isBlockedOperator: isBlockedOperator ?? this.isBlockedOperator,
      isBlockedDoc: isBlockedDoc ?? this.isBlockedDoc,
      operatorsExclusive: operatorsExclusive ?? this.operatorsExclusive,
      doc: doc ?? this.doc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (serie != null) {
      result.addAll({'serie': serie});
    }
    if (infos != null) {
      result.addAll({'infos': infos});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (obsCaution != null) {
      result.addAll({'obsCaution': obsCaution});
    }
    if (lote != null) {
      result.addAll({'lote': lote});
    }
    if (validate != null) {
      result.addAll({'validate': validate!.millisecondsSinceEpoch});
    }
    if (isBlockedOperator != null) {
      result.addAll({'isBlockedOperator': isBlockedOperator});
    }
    if (isBlockedDoc != null) {
      result.addAll({'isBlockedDoc': isBlockedDoc});
    }
    if (operatorsExclusive != null) {
      result.addAll({
        'operatorsExclusive': operatorsExclusive!.map((x) => x.toMap()).toList()
      });
    }
    if (doc != null) {
      result.addAll({'doc': doc});
    }

    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      serie: map['serie'],
      infos: List<String>.from(map['infos']),
      description: map['description'],
      obsCaution: map['obsCaution'],
      lote: map['lote'],
      validate: map['validate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['validate'])
          : null,
      isBlockedOperator: map['isBlockedOperator'],
      isBlockedDoc: map['isBlockedDoc'],
      operatorsExclusive: map['operatorsExclusive'] != null
          ? List<UserProfileModel>.from(map['operatorsExclusive']
              ?.map((x) => UserProfileModel.fromMap(x)))
          : null,
      doc: map['doc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, serie: $serie, infos: $infos, description: $description, obsCaution: $obsCaution, lote: $lote, validate: $validate, isBlockedOperator: $isBlockedOperator, isBlockedDoc: $isBlockedDoc, operatorsExclusive: $operatorsExclusive, doc: $doc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.serie == serie &&
        listEquals(other.infos, infos) &&
        other.description == description &&
        other.obsCaution == obsCaution &&
        other.lote == lote &&
        other.validate == validate &&
        other.isBlockedOperator == isBlockedOperator &&
        other.isBlockedDoc == isBlockedDoc &&
        listEquals(other.operatorsExclusive, operatorsExclusive) &&
        other.doc == doc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serie.hashCode ^
        infos.hashCode ^
        description.hashCode ^
        obsCaution.hashCode ^
        lote.hashCode ^
        validate.hashCode ^
        isBlockedOperator.hashCode ^
        isBlockedDoc.hashCode ^
        operatorsExclusive.hashCode ^
        doc.hashCode;
  }
}
