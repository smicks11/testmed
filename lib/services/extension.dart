extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(this);
  }

  bool isValidUsername() {
    return RegExp(r'^([a-zA-Z]).{8,}$').hasMatch(this);
  }

  bool isNumeric(){
    return RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(this);
  }
}
