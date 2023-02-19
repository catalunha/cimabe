import 'dart:convert';

import 'package:flutter/foundation.dart';

// Perfil de usuario ou pessoa
class UserProfileModel {
  final String id;
  final String email;
  final String? name;
  final String? nickname;
  final String? phone;
  final String? address;
  final String? cep;
  final String? photo;
  final String? cpf;
  final String? register; //numero de pm
  final String? description;
  final List<String>? routes;
  final List<String>? restrictions; // constar ItemModel.infos ou serie ou lote,
  final bool? isActive;
  UserProfileModel({
    required this.id,
    required this.email,
    this.name,
    this.nickname,
    this.phone,
    this.address,
    this.cep,
    this.photo,
    this.cpf,
    this.register,
    this.description,
    this.routes,
    this.restrictions,
    this.isActive,
  });

  UserProfileModel copyWith({
    String? id,
    String? email,
    String? name,
    String? nickname,
    String? phone,
    String? address,
    String? cep,
    String? photo,
    String? cpf,
    String? register,
    String? description,
    List<String>? routes,
    List<String>? restrictions,
    bool? isActive,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cep: cep ?? this.cep,
      photo: photo ?? this.photo,
      cpf: cpf ?? this.cpf,
      register: register ?? this.register,
      description: description ?? this.description,
      routes: routes ?? this.routes,
      restrictions: restrictions ?? this.restrictions,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    if (name != null) {
      result.addAll({'name': name});
    }
    if (nickname != null) {
      result.addAll({'nickname': nickname});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (cep != null) {
      result.addAll({'cep': cep});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (register != null) {
      result.addAll({'register': register});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (routes != null) {
      result.addAll({'routes': routes});
    }
    if (restrictions != null) {
      result.addAll({'restrictions': restrictions});
    }
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      nickname: map['nickname'],
      phone: map['phone'],
      address: map['address'],
      cep: map['cep'],
      photo: map['photo'],
      cpf: map['cpf'],
      register: map['register'],
      description: map['description'],
      routes: List<String>.from(map['routes']),
      restrictions: List<String>.from(map['restrictions']),
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, email: $email, name: $name, nickname: $nickname, phone: $phone, address: $address, cep: $cep, photo: $photo, cpf: $cpf, register: $register, description: $description, routes: $routes, restrictions: $restrictions, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.nickname == nickname &&
        other.phone == phone &&
        other.address == address &&
        other.cep == cep &&
        other.photo == photo &&
        other.cpf == cpf &&
        other.register == register &&
        other.description == description &&
        listEquals(other.routes, routes) &&
        listEquals(other.restrictions, restrictions) &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        nickname.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        cep.hashCode ^
        photo.hashCode ^
        cpf.hashCode ^
        register.hashCode ^
        description.hashCode ^
        routes.hashCode ^
        restrictions.hashCode ^
        isActive.hashCode;
  }
}
