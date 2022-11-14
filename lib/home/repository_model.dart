import 'dart:convert';

class RepositoryModel {
  final String name;
  final String full_name;
  final String html_url;
  RepositoryModel({
    required this.name,
    required this.full_name,
    required this.html_url,
  });

  RepositoryModel copyWith({
    String? name,
    String? full_name,
    String? html_url,
  }) {
    return RepositoryModel(
      name: name ?? this.name,
      full_name: full_name ?? this.full_name,
      html_url: html_url ?? this.html_url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'full_name': full_name,
      'html_url': html_url,
    };
  }

  factory RepositoryModel.fromMap(Map<String, dynamic> map) {
    return RepositoryModel(
      name: map['name'] as String,
      full_name: map['full_name'] as String,
      html_url: map['html_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RepositoryModel.fromJson(String source) =>
      RepositoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RepositoryModel(name: $name, full_name: $full_name, html_url: $html_url)';

  @override
  bool operator ==(covariant RepositoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.full_name == full_name &&
        other.html_url == html_url;
  }

  @override
  int get hashCode => name.hashCode ^ full_name.hashCode ^ html_url.hashCode;
}
