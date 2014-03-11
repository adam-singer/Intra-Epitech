library user;

class User {
  String login;
  String firstname;
  String lastname;
  String email;
  
  String location;
  
  int promo;
  int studentyear;
  int semester;
  
  String coursecode;
 
  User(this.login, this.firstname, this.lastname, this.email, this.location, this.promo, this.studentyear, this.semester, this.coursecode);
  User.fromJson(String json) {
    
  }
  
  Map toJson() {
    Map data = <String, dynamic>{};
    data["login"] = login;
    data["firstname"] = firstname;
    data["lastname"] = lastname;
    data["email"] = email;
    data["location"] = location;
    data["promo"] = promo;
    data["studentyear"] = studentyear;
    data["semester"] = semester;
    data["coursecode"] = coursecode;
    return (data);
  }
}