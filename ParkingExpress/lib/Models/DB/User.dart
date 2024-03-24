class LoggedUser {
  static int User = 1;
  static int Admin = 2;

  var uid, name, mobile, email, type, nic;

  LoggedUser(
      {this.uid, this.name, this.email, this.type, this.nic, this.mobile});
}
