import 'package:eisenhower_matrix/bloc/bloc.dart';
import 'package:eisenhower_matrix/models/ceil_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatrixCeilItem extends StatelessWidget {
  final CeilItem item;
  final bool inOneLine;

  void _itemDeleted(BuildContext context) => BlocProvider.of<MatrixBloc>(context).add(
        MatrixCeilItemDeleted(
          itemId: item.id,
        ),
      );

  const MatrixCeilItem({Key key, @required this.item, @required this.inOneLine})
      : assert(item != null && inOneLine != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
//        child: Icon(PlatformIcons(context).delete),
      ),
      onDismissed: (_) => _itemDeleted(context),
      child: Text(
        item.title,
        maxLines: inOneLine ? 1 : null,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}