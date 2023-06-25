// Provider which will be used to fetch data from the API and store it in the app and notify the UI about the changes.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Insta {
  late final String username;
  final String fullName;
  final String profilePicUrl;
  final String followers;
  final String following;
  final String website;
  final String posts;
  final String isPrivate;
  final String linkes;

  Insta({
    required this.username,
    required this.fullName,
    required this.profilePicUrl,
    required this.followers,
    required this.following,
    required this.website,
    required this.posts,
    required this.isPrivate,
    required this.linkes,
  });

  factory Insta.fromJson(Map<String, dynamic> json) {
    return Insta(
      username: json['username'],
      fullName: json['full_name'],
      profilePicUrl: json['profile_pic_url'],
      followers: json['edge_followed_by']['count'].toString(),
      following: json['edge_follow']['count'].toString(),
      website: json['external_url'],
      posts: json['edge_owner_to_timeline_media']['count'].toString(),
      isPrivate: json['is_private'].toString(),
      linkes: json['edge_liked_by']['count'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "full_name": fullName,
        "profile_pic_url": profilePicUrl,
        "edge_followed_by": followers,
        "edge_follow": following,
        "external_url": website,
        "edge_owner_to_timeline_media": posts,
        "is_private": isPrivate,
        "edge_liked_by": linkes,
      };

  @override
  String toString() {
    return 'Insta{username: $username, fullName: $fullName, profilePicUrl: $profilePicUrl, followers: $followers, following: $following, website: $website, posts: $posts, isPrivate: $isPrivate, linkes: $linkes}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Insta &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          fullName == other.fullName &&
          profilePicUrl == other.profilePicUrl &&
          followers == other.followers &&
          following == other.following &&
          website == other.website &&
          posts == other.posts &&
          isPrivate == other.isPrivate &&
          linkes == other.linkes;

  @override
  int get hashCode =>
      username.hashCode ^
      fullName.hashCode ^
      profilePicUrl.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      website.hashCode ^
      posts.hashCode ^
      isPrivate.hashCode ^
      linkes.hashCode;

  Insta copyWith({
    String? username,
    String? fullName,
    String? profilePicUrl,
    String? followers,
    String? following,
    String? website,
    String? posts,
    String? isPrivate,
    String? linkes,
  }) {
    return Insta(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      website: website ?? this.website,
      posts: posts ?? this.posts,
      isPrivate: isPrivate ?? this.isPrivate,
      linkes: linkes ?? this.linkes,
    );
  }
}

class InstaUsers with ChangeNotifier {
  bool isLoading = false;

  getData() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 5));
    await fetchInstaUsers('{user-id}');
    isLoading = false;
    notifyListeners();
  }

  static Future<Insta> fetchInstaUsers(String username) async {
    final response = await http.get(
      Uri.parse('https://www.instagram.com/$username/?__a=1'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Insta instaUsers = Insta.fromJson(jsonDecode(response.body));
      return instaUsers;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load insta users');
    }
  }
}
