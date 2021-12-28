import 'package:flutter/material.dart';

import '/appdata/theme.dart';
import '/appdata/funcs.dart';
import '/models/app_user.dart';
import '/services/firebase_auth.dart';
import '/services/firebase_db.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: getScaffoldHeightWithoutAppbar(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EdittingSettingsField(
                label: 'Аватар',
                value: AppUser.imageUrl,
                editingField: 'imageUrl',
                hintText: 'Ссылка на фото',
                errorText: 'Вставьте ссылку',
              ),
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
                label: 'Био',
                value: AppUser.bio,
                editingField: 'bio',
                hintText: 'Расскажите о себе',
                errorText: null,
                enableMultiline: true,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: CustomTheme.borderColor),
                  ),
                ),
                child: RawMaterialButton(
                  onPressed: () async {
                    await Auth.signOut();
                    Navigator.pop(context);
                  },
                  elevation: 0,
                  child: const Text(
                    'Выйти из аккаунта',
                    style: TextStyle(
                      color: CustomTheme.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    this.enableMultiline = false,
    Key? key,
  }) : super(key: key);

  final String label, value, editingField;
  final String? hintText, errorText;
  final bool enableMultiline;

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
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CustomTheme.borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: textTheme.headline2,
              ),
              Form(
                key: _formKey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      disabledBorder: InputBorder.none,
                    ),
                    textCapitalization: widget.enableMultiline
                        ? TextCapitalization.sentences
                        : TextCapitalization.words,
                    enabled: _editing,
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    minLines: widget.enableMultiline ? 1 : null,
                    maxLines: widget.enableMultiline ? 5 : 1,
                    maxLength: widget.enableMultiline ? 140 : null,
                    validator: (value) =>
                        value!.isNotEmpty ? null : widget.errorText,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _submit(),
            child: _editing
                ? const Icon(
                    Icons.done,
                    color: CustomTheme.primaryColor,
                    size: 25,
                  )
                : const Icon(
                    Icons.edit,
                    color: CustomTheme.primaryColor,
                    size: 25,
                  ),
          ),
        ],
      ),
    );
  }

  _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_editing) {
      bool formIsValid = _formKey.currentState?.validate() ?? false;

      if (formIsValid) {
        Map<String, dynamic> userData = AppUser.toJson();
        userData[widget.editingField] = _controller.text.trim();

        await UsersDatabase.updateUser(AppUser.uid, userData);
        AppUser.setUser(userData);

        setState(() {
          _editing = false;
        });
      }
    } else {
      setState(() {
        _editing = true;
      });
    }
  }
}
