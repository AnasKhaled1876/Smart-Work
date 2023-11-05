// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? description;
  DateTime? finishTime;
  bool isFinished;
  bool isImportant;
  bool isArchived;
  bool isDeleted;
  bool isNotified;
  int? categoryId;
  int? points;
  int? duration;
  DateTime? createdAt;
  DateTime? updatedAt;
  Task({
    this.id,
    this.title,
    this.description,
    this.finishTime,
    this.isFinished = false,
    this.isImportant = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.isNotified = false,
    this.categoryId,
    this.points,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? finishTime,
    bool? isFinished,
    bool? isImportant,
    bool? isArchived,
    bool? isDeleted,
    bool? isNotified,
    int? categoryId,
    int? points,
    int? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      finishTime: finishTime ?? this.finishTime,
      isFinished: isFinished ?? this.isFinished,
      isImportant: isImportant ?? this.isImportant,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      isNotified: isNotified ?? this.isNotified,
      categoryId: categoryId ?? this.categoryId,
      points: points ?? this.points,
      duration: duration ?? this.duration,
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
      'isDeleted': isDeleted,
      'isNotified': isNotified,
      'categoryId': categoryId,
      'points': points,
      'duration': duration,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      finishTime:
          map['finishTime'] != null ? DateTime.parse(map['finishTime']) : null,
      isFinished: map['isFinished'] != null ? map['isFinished'] as bool : false,
      isImportant:
          map['isImportant'] != null ? map['isImportant'] as bool : false,
      isArchived: map['isArchived'] != null ? map['isArchived'] as bool : false,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : false,
      isNotified: map['isNotified'] != null ? map['isNotified'] as bool : false,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      points: map['points'] != null ? map['points'] as int : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, finishTime: $finishTime, isFinished: $isFinished, isImportant: $isImportant, isArchived: $isArchived, isDeleted: $isDeleted, isNotified: $isNotified, categoryId: $categoryId, points: $points, duration: $duration, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.finishTime == finishTime &&
        other.isFinished == isFinished &&
        other.isImportant == isImportant &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        other.isNotified == isNotified &&
        other.categoryId == categoryId &&
        other.points == points &&
        other.duration == duration &&
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
        isDeleted.hashCode ^
        isNotified.hashCode ^
        categoryId.hashCode ^
        points.hashCode ^
        duration.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
