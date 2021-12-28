import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/appdata/appdata.dart';
import '/services/firebase_auth.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  AuthService _authService = AuthService();
  RxBool isLogged = false.obs;
  Rx<User?> user = Rx<User?>(null);

  RxBool codeSend = false.obs;
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

  void authChecker(bool isLoggedIn) {
    isLoggedIn ? Get.offAllNamed(homeRoute) : Get.offAllNamed(welcomeRoute);
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

  void signUpDispose() {
    currentPage.value = 0;

    fieldControllers.forEach((key, controller) {
      controller.clear();
    });
  }

  Future<void> signUp() async {
    await _authService.verifyPhone(
      number: fieldControllers['phoneController']!.text,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  Future<void> signIn() async {
    //todo: implemet sing in
  }

  Future<void> signOut() async {
    await _authService.signOut();
    // todo: handle exceptions
  }

  // phone verification callbacks
  void _verificationCompleted(PhoneAuthCredential credential) async {
    //todo: implement sms auto retrival actions
  }

  void _verificationFailed(FirebaseAuthException exception) async {
    // todo: implement exception catch
  }

  void _codeSent(String verificationId, int? resendingToken) async {
    // todo: implement code sent actions
  }

  void _codeAutoRetrievalTimeout(String verificationId) async {}

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
