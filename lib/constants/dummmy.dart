// {
// // print("the button is being pressed");
// final user = await authService.createUserWithEmailAndPassword(
// _emailController.text, _passwordController.text);
// // final String email = emailController.text.trim();
// // final String password = passwordController.text.trim();
// Navigator.pop(context);
// print(user!.uid);
// CollectionReference users =
// FirebaseFirestore.instance.collection('Users');
//
// return users
//     .doc(user.uid)
//     .set({'name':_nameController.text,'email': _emailController.text})
//     .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()))
//     .then((value) =>
// Fluttertoast.showToast(
// msg: "User Added Successfully!!",
// toastLength: Toast.LENGTH_SHORT,
// gravity: ToastGravity.BOTTOM));
//
// },
// ),
