import 'package:flutter/material.dart';

import 'list_item_modal.dart';

class BottomModal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 1.0,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          child: ListaItems( scrollController ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )
          ),
        );
      },
    );
  }
}