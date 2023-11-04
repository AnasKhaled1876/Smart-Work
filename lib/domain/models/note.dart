// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  int? id;
  String? title;
  String? description;
  DateTime? finishTime;
  bool? isFinished;
  bool? isImportant;
  bool? isArchived;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Note({
    this.id,
    this.title,
    this.description,
    this.finishTime,
    this.isFinished,
    this.isImportant,
    this.isArchived,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? finishTime,
    bool? isFinished,
    bool? isImportant,
    bool? isArchived,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      finishTime: finishTime ?? this.finishTime,
      isFinished: isFinished ?? this.isFinished,
      isImportant: isImportant ?? this.isImportant,
      isArchived: isArchived ?? this.isArchived,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'finishTime': finishTime?.toIso8601String(),
      'isFinished': isFinished,
      'isImportant': isImportant,
      'isArchived': isArchived,
      'categoryId': categoryId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      finishTime:
          map['finishTime'] != null ? DateTime.parse(map['finishTime']) : null,
      isFinished: map['isFinished'] != null ? map['isFinished'] as bool : null,
      isImportant:
          map['isImportant'] != null ? map['isImportant'] as bool : null,
      isArchived: map['isArchived'] != null ? map['isArchived'] as bool : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, finishTime: $finishTime, isFinished: $isFinished, isImportant: $isImportant, isArchived: $isArchived, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.finishTime == finishTime &&
        other.isFinished == isFinished &&
        other.isImportant == isImportant &&
        other.isArchived == isArchived &&
        other.categoryId == categoryId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        finishTime.hashCode ^
        isFinished.hashCode ^
        isImportant.hashCode ^
        isArchived.hashCode ^
        categoryId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
