import 'package:flutter/material.dart';

class AddPrisonerSliverAppBar extends StatelessWidget {
  const AddPrisonerSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: Stack(alignment: Alignment.bottomRight, children: [
              const CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage(
                  'assets/avatar.png',
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('object');
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
