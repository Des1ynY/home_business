import 'package:flutter/material.dart';

import '/appdata/consts.dart';
import '/models/app_user.dart';
import '/services/firebase_auth.dart';
import '/services/firebase_db.dart';
import '/services/shared_prefs.dart';

class AppUserSettings extends StatefulWidget {
  const AppUserSettings({Key? key}) : super(key: key);

  @override
  _AppUserSettingsState createState() => _AppUserSettingsState();
}

class _AppUserSettingsState extends State<AppUserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EdittingSettingsField(
                  label: 'Имя',
                  value: AppUser.name,
                  editingField: 'name',
                  hintText: 'Имя',
                  errorText: 'Представьтесь',
                ),
                EdittingSettingsField(
                  label: 'Фамилия',
                  value: AppUser.surname,
                  editingField: 'surname',
                  hintText: 'Фамилия',
                  errorText: 'Представьтесь',
                ),
                EdittingSettingsField(
                  label: 'Аватар',
                  value: AppUser.imageUrl,
                  editingField: 'imageUrl',
                  hintText: 'Ссылка на фото',
                  errorText: 'Вставьте ссылку',
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
                  child: RawMaterialButton(
                    onPressed: () async {
                      await Auth.signOut();
                      await LocalDataStorage.deleteUserData();
                      Navigator.pop(context);
                    },
                    elevation: 0,
                    child: const Text(
                      'Выйти из аккаунта',
                      style: TextStyle(
                        color: Color(0xFFF96060),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EdittingSettingsField extends StatefulWidget {
  const EdittingSettingsField({
    required this.label,
    required this.value,
    required this.editingField,
    this.hintText = '',
    this.errorText = '',
    Key? key,
  }) : super(key: key);

  final String label, value, editingField, hintText, errorText;

  @override
  _EdittingSettingsFieldState createState() => _EdittingSettingsFieldState();
}

class _EdittingSettingsFieldState extends State<EdittingSettingsField> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: textTheme.headline2,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    disabledBorder: InputBorder.none,
                  ),
                  autofocus: true,
                  enabled: _editing,
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) =>
                      value!.isNotEmpty ? null : widget.errorText,
                  onFieldSubmitted: (_) => _submit(),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => _submit(),
            child: _editing
                ? const Icon(
                    Icons.done,
                    color: primaryColor,
                    size: 30,
                  )
                : const Icon(
                    Icons.edit,
                    color: primaryColor,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_editing) {
      bool formIsValid = _formKey.currentState?.validate() ?? false;

      if (formIsValid) {
        Map<String, dynamic> userData = AppUser.toJson();
        userData[widget.editingField] = _controller.text.trim();

        await UsersDatabase.updateUser(AppUser.uid, userData);
        AppUser.setUser(userData);

        setState(() {
          _editing == false;
        });
      }
    } else {
      setState(() {
        _editing = true;
      });
    }
  }
}
