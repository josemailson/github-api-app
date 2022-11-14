import 'dart:convert';

class HomeModel {
  final String login;
  final int id;
  final String avatar_url;
  final String html_url;
  final String name;
  final String blog;
  final String location;
  final int public_repos;
  final int public_gists;
  final int followers;
  final int following;
  HomeModel({
    required this.login,
    required this.id,
    required this.avatar_url,
    required this.html_url,
    required this.name,
    required this.blog,
    required this.location,
    required this.public_repos,
    required this.public_gists,
    required this.followers,
    required this.following,
  });

  HomeModel copyWith({
    String? login,
    int? id,
    String? avatar_url,
    String? html_url,
    String? name,
    String? blog,
    String? location,
    int? public_repos,
    int? public_gists,
    int? followers,
    int? following,
  }) {
    return HomeModel(
      login: login ?? this.login,
      id: id ?? this.id,
      avatar_url: avatar_url ?? this.avatar_url,
      html_url: html_url ?? this.html_url,
      name: name ?? this.name,
      blog: blog ?? this.blog,
      location: location ?? this.location,
      public_repos: public_repos ?? this.public_repos,
      public_gists: public_gists ?? this.public_gists,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'login': login,
      'id': id,
      'avatar_url': avatar_url,
      'html_url': html_url,
      'name': name,
      'blog': blog,
      'location': location,
      'public_repos': public_repos,
      'public_gists': public_gists,
      'followers': followers,
      'following': following,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      login: map['login'] as String,
      id: map['id'].toInt() as int,
      avatar_url: map['avatar_url'] as String,
      html_url: map['html_url'] as String,
      name: map['name'] as String,
      blog: map['blog'] as String,
      location: map['location'] as String,
      public_repos: map['public_repos'].toInt() as int,
      public_gists: map['public_gists'].toInt() as int,
      followers: map['followers'].toInt() as int,
      following: map['following'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeModel(login: $login, id: $id, avatar_url: $avatar_url, html_url: $html_url, name: $name, blog: $blog, location: $location, public_repos: $public_repos, public_gists: $public_gists, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant HomeModel other) {
    if (identical(this, other)) return true;

    return other.login == login &&
        other.id == id &&
        other.avatar_url == avatar_url &&
        other.html_url == html_url &&
        other.name == name &&
        other.blog == blog &&
        other.location == location &&
        other.public_repos == public_repos &&
        other.public_gists == public_gists &&
        other.followers == followers &&
        other.following == following;
  }

  @override
  int get hashCode {
    return login.hashCode ^
        id.hashCode ^
        avatar_url.hashCode ^
        html_url.hashCode ^
        name.hashCode ^
        blog.hashCode ^
        location.hashCode ^
        public_repos.hashCode ^
        public_gists.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
