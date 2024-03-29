class Users {
  final String? userid;
  final String? username;
  final String? useremail;
  final String? userpassword;

  Users({required this.userid, required this.username, required this.useremail, required this.userpassword});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userid: json['userid'],
      username: json['username'],
      useremail: json['useremail'],
      userpassword: json['userpassword'],
    );
  }
}