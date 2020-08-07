// ignore_for_file: avoid_as

import 'dart:convert';

class GithubIssue {
  GithubIssue({
    this.htmlUrl,
    this.number,
    this.title,
    this.user,
    this.state,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.body,
  });

  factory GithubIssue.fromRawJson(String str) => GithubIssue.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory GithubIssue.fromJson(Map<String, dynamic> json) => GithubIssue(
        htmlUrl: json['html_url'] as String,
        number: json['number'] as int,
        title: json['title'] as String,
        user: User.fromJson(json['user'] as Map<String, dynamic>),
        state: json['state'] as String,
        comments: json['comments'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        body: json['body'] as String,
      );
  final String htmlUrl;
  final int number;
  final String title;
  final User user;
  final String state;
  final int comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  Map<String, dynamic> toJson() => {
        'html_url': htmlUrl,
        'number': number,
        'title': title,
        'user': user.toJson(),
        'state': state,
        'comments': comments,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'body': body,
      };
}

class User {
  User({
    this.login,
    this.id,
    this.avatarUrl,
    this.gravatarId,
  });

  factory User.fromRawJson(String str) => User.fromJson(
        json.decode(str) as Map<String, dynamic>,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        login: json['login'] as String,
        id: json['id'] as int,
        avatarUrl: json['avatar_url'] as String,
        gravatarId: json['gravatar_id'] as String,
      );

  String toRawJson() => json.encode(toJson());

  final String login;
  final int id;
  final String avatarUrl;
  final String gravatarId;

  Map<String, dynamic> toJson() => {
        'login': login,
        'id': id,
        'avatar_url': avatarUrl,
        'gravatar_id': gravatarId,
      };
}
