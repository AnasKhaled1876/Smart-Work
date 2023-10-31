// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:smart_work/domain/models/task.dart';

import 'note.dart';

class UserProfile {
  int? id;
  String? email;
  String? password;
  String? name;
  int? age;
  String? gender;

  List<Task>? tasks;
  List<Note>? notes;
  UserProfile({
    this.id,
    this.email,
    this.password,
    this.name,
    this.age,
    this.gender,
    this.tasks,
    this.notes,
  });

  UserProfile copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    int? age,
    String? gender,
    List<Task>? tasks,
    List<Note>? notes,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      tasks: tasks ?? this.tasks,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'gender': gender,
      'tasks': tasks?.map((x) => x.toMap()).toList(),
      'notes': notes?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      tasks: map['tasks'] != null
          ? List<Task>.from(
              (map['tasks'] ).map<Task?>(
                (x) => Task.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      notes: map['notes'] != null
          ? List<Note>.from(
              (map['notes'] ).map<Note?>(
                (x) => Note.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, password: $password, name: $name, age: $age, gender: $gender, tasks: $tasks, notes: $notes)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.age == age &&
        other.gender == gender &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.notes, notes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        password.hashCode ^
        name.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        tasks.hashCode ^
        notes.hashCode;
  }
}
