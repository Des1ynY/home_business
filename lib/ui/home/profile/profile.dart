import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_business/models/neighbour_model.dart';

import '/services/firebase_db.dart';
import '/ui/home/orders/user_orders.dart';
import '/ui/ui_components.dart';
import '/models/app_user.dart';
import '/services/router.dart';
import '/appdata/consts.dart';

class AppUserProfile extends StatefulWidget {
  const AppUserProfile({
    Key? key,
  }) : super(key: key);

  @override
  _AppUserProfileState createState() => _AppUserProfileState();
}

class _AppUserProfileState extends State<AppUserProfile> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _yourOrdersStream;
  final TextEditingController _controller = TextEditingController();
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller.text = AppUser.bio;
    _yourOrdersStream = OrdersDatabase.getUserOrders(AppUser.uid);
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getProfileData(context),
                const Divider(color: darkGrey, indent: 20, endIndent: 20),
                _getServicesData(context),
              ],
            )
          : const LoadingIndicator(),
    );
  }

  Widget _getProfileData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: const AssetImage('assets/default_ava.png'),
              foregroundImage: AppUser.imageUrl == 'unknown'
                  ? null
                  : NetworkImage(AppUser.imageUrl),
            ),
          ),
          Text(
            '${AppUser.name} ${AppUser.surname}',
            style: Theme.of(context).textTheme.headline2,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              '????. ${AppUser.street}, ${AppUser.building}-${AppUser.apartment}, ?????????????? ???${AppUser.approach}',
              maxLines: 2,
              style: const TextStyle(color: darkGrey),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: TextField(
              decoration: InputDecoration(
                label: const Text(
                  '?? ????????',
                  style: TextStyle(
                    color: darkGrey,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: darkGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              minLines: 1,
              maxLines: 5,
              controller: _controller,
              readOnly: true,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            height: buttonHeight,
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(
                BorderSide(color: darkGrey),
              ),
              borderRadius: BorderRadius.circular(buttonBorderRadius),
            ),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, userSettingsRoute);
              },
              elevation: 0,
              child: const Text(
                '?????????????????? ??????????????',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getServicesData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            '????????????',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        _isLoaded
            ? UserOrders(
                stream: _yourOrdersStream,
                author: Neighbour.fromJson(AppUser.toJson()),
                shrinkWrap: true,
                missingWidget: const SizedBox(
                  height: 200,
                  child: MissingText(
                    text: '???? ???????????????????????????? ??????????',
                  ),
                ),
              )
            : const LoadingIndicator(),
      ],
    );
  }
}
