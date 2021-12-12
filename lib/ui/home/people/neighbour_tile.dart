import 'package:flutter/material.dart';

import '/ui/home/people/neighbour_profile.dart';
import '/models/neighbour_model.dart';
import '/appdata/consts.dart';

class NeigbourProfileTile extends StatefulWidget {
  const NeigbourProfileTile({
    required this.neighbour,
    Key? key,
  }) : super(key: key);

  final Neighbour neighbour;

  @override
  State<NeigbourProfileTile> createState() => _NeigbourProfileTileState();
}

class _NeigbourProfileTileState extends State<NeigbourProfileTile> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NeighbourProfile(neighbour: widget.neighbour),
          ),
        );
      },
      elevation: 0,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Hero(
                tag: widget.neighbour.uid,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('assets/default_ava.png'),
                  foregroundImage: widget.neighbour.imageUrl == 'unknown'
                      ? null
                      : NetworkImage(widget.neighbour.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(
                            "${widget.neighbour.name} ${widget.neighbour.surname}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        'кв. ${widget.neighbour.apartment}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: hintTextColor,
                        ),
                      ),
                    ],
                  ),
                  widget.neighbour.bio == ''
                      ? Container()
                      : Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: RichText(
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'О себе: ',
                                style: const TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  color: primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.neighbour.bio,
                                    style: const TextStyle(
                                      fontFamily: 'AvenirNextCyr',
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
