import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/appdata/appdata.dart';
import '/services/firebase_auth.dart';
import '/services/firebase_db.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  AuthService _authService = AuthService();
  late String _verificationId;
  RxBool isLogged = false.obs;
  Rx<User?> user = Rx<User?>(null);

  RxBool codeSend = false.obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 0.obs;
  PageController pageController = PageController();
  Map<String, TextEditingController> fieldControllers = {
    FormFieldControllers.phone: TextEditingController(),
    FormFieldControllers.otp: TextEditingController(),
    // adress fields
    FormFieldControllers.city: TextEditingController(),
    FormFieldControllers.street: TextEditingController(),
    FormFieldControllers.building: TextEditingController(),
    FormFieldControllers.approach: TextEditingController(),
    FormFieldControllers.appartment: TextEditingController(),
    // user info fields
    FormFieldControllers.name: TextEditingController(),
    FormFieldControllers.surname: TextEditingController(),
    FormFieldControllers.bio: TextEditingController(),
  };

  @override
  void onInit() {
    user.value = _authService.currentUser;
    isLogged.value = user.value != null;

    ever(isLogged, authChecker);

    _authService.userStream.listen((user) {
      this.user.value = user;
      this.isLogged.value = user != null;
    });

    super.onInit();
  }

  String authChecker(bool isLoggedIn) {
    return isLoggedIn ? homeRoute : welcomeRoute;
  }

  void nextPage() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    currentPage.value++;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void prevPage() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    currentPage.value--;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void changeNumber() {
    codeSend.value = false;
    _verificationId = '';
  }

  // authentication methods
  void signUp() => _sendOTP(true);

  void signIn() => _sendOTP(false);

  void signUpWithOtp() => _signUpCompleted(
        _authService.getPhoneAuthCredential(
          _verificationId,
          fieldControllers[FormFieldControllers.otp]!.text.trim(),
        ),
      );

  void signInWithOtp() => _signInCompleted(
        _authService.getPhoneAuthCredential(
          _verificationId,
          fieldControllers[FormFieldControllers.otp]!.text.trim(),
        ),
      );

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } on FirebaseAuthException {
      Get.showSnackbar(GetSnackBar(
        message: 'Не удалось выйти из аккаунта',
        backgroundColor: CustomTheme.red,
      ));
    }
  }

  Future<void> _sendOTP(bool signinUp) async {
    isLoading.value = true;
    await _authService.verifyPhone(
      number: makePhoneValid(fieldControllers['phoneController']!.text),
      verificationCompleted: signinUp ? _signUpCompleted : _signInCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  // phone verification callbacks
  void _signUpCompleted(PhoneAuthCredential credential) async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await _authService.signInWithPhoneAuthCredential(credential);

      if (!await UsersDatabase.checkUser(userCredential.user!.uid)) {
        await UsersDatabase.setUser(
          userCredential.user!.uid,
          getControllersData(),
        );
        Get.offNamedUntil(successRoute, (route) => false);
      } else {
        changeNumber();
        Get.showSnackbar(GetSnackBar(
          message: 'Аккаунт с таким номером уже существует',
        ));
      }
    } on FirebaseAuthException {
      isLoading.value = false;
      Get.showSnackbar(GetSnackBar(
        message: 'Произошла ошибка',
      ));
    }
  }

  void _signInCompleted(PhoneAuthCredential credential) async {
    isLoading.value = true;
    try {
      UserCredential userCredential =
          await _authService.signInWithPhoneAuthCredential(credential);

      if (await UsersDatabase.checkUser(userCredential.user!.uid)) {
        await UsersDatabase.getUser(userCredential.user!.uid);
        Get.offNamedUntil(homeRoute, (route) => false);
      } else {
        changeNumber();
        Get.showSnackbar(
          GetSnackBar(
            message: 'Аккаунта с таким номером не существует',
          ),
        );
      }
    } on FirebaseAuthException {
      isLoading.value = false;
      Get.showSnackbar(
        GetSnackBar(
          message: 'Произошла ошибка',
        ),
      );
    }
  }

  void _verificationFailed(FirebaseAuthException exception) async {
    isLoading.value = false;
    Get.showSnackbar(GetSnackBar(
      message: 'Произошла ошибка',
    ));
  }

  void _codeSent(String verificationId, int? resendingToken) async {
    codeSend.value = true;
    isLoading.value = false;
    _verificationId = verificationId;
  }

  void _codeAutoRetrievalTimeout(String verificationId) async {}

  Map<String, dynamic> getControllersData() {
    return {
      'phone': makePhoneValid(
          fieldControllers[FormFieldControllers.phone]!.text.trim()),
      'city': fieldControllers[FormFieldControllers.city]!.text.trim(),
      'street': fieldControllers[FormFieldControllers.street]!.text.trim(),
      'building': int.parse(
          fieldControllers[FormFieldControllers.building]!.text.trim()),
      'approach': int.parse(
          fieldControllers[FormFieldControllers.approach]!.text.trim()),
      'appartment': int.parse(
          fieldControllers[FormFieldControllers.appartment]!.text.trim()),
      'name': fieldControllers[FormFieldControllers.name]!.text.trim(),
      'surname': fieldControllers[FormFieldControllers.surname]!.text.trim(),
      'bio': fieldControllers[FormFieldControllers.bio]!.text.trim(),
    };
  }

  void signUpDispose() {
    currentPage.value = 0;

    fieldControllers.forEach((key, controller) {
      controller.clear();
    });
  }

  @override
  void onClose() {
    fieldControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.onClose();
  }
}

class FormFieldControllers {
  static const phone = 'phoneController';
  static const otp = 'otpController';
  static const city = 'cityController';
  static const street = 'streetController';
  static const building = 'buildingController';
  static const approach = 'approachController';
  static const appartment = 'appartmentController';
  static const name = 'nameController';
  static const surname = 'surnameController';
  static const bio = 'bioController';
}
