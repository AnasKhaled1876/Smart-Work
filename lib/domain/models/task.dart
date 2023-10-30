// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  String? id;
  String? title;
  String? description;
  DateTime? finishTime;
  bool? isFinished;
  bool? isDeleted;
  bool? isNotified;
  int? categoryId;
  int? points;
  Task({
    this.id,
    this.title,
    this.description,
    this.finishTime,
    this.isFinished,
    this.isDeleted,
    this.isNotified,
    this.categoryId,
    this.points,
  });
  

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? finishTime,
    bool? isFinished,
    bool? isDeleted,
    bool? isNotified,
    int? categoryId,
    int? points,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      finishTime: finishTime ?? this.finishTime,
      isFinished: isFinished ?? this.isFinished,
      isDeleted: isDeleted ?? this.isDeleted,
      isNotified: isNotified ?? this.isNotified,
      categoryId: categoryId ?? this.categoryId,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'finishTime': finishTime?.millisecondsSinceEpoch,
      'isFinished': isFinished,
      'isDeleted': isDeleted,
      'isNotified': isNotified,
      'categoryId': categoryId,
      'points': points,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      finishTime: map['finishTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['finishTime'] as int) : null,
      isFinished: map['isFinished'] != null ? map['isFinished'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      isNotified: map['isNotified'] != null ? map['isNotified'] as bool : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      points: map['points'] != null ? map['points'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, finishTime: $finishTime, isFinished: $isFinished, isDeleted: $isDeleted, isNotified: $isNotified, categoryId: $categoryId, points: $points)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.finishTime == finishTime &&
      other.isFinished == isFinished &&
      other.isDeleted == isDeleted &&
      other.isNotified == isNotified &&
      other.categoryId == categoryId &&
      other.points == points;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      finishTime.hashCode ^
      isFinished.hashCode ^
      isDeleted.hashCode ^
      isNotified.hashCode ^
      categoryId.hashCode ^
      points.hashCode;
  }
}
