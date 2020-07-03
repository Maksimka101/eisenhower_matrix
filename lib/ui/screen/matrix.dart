import 'package:eisenhower_matrix/bloc/cubit.dart';
import 'package:eisenhower_matrix/models/ceil.dart';
import 'package:eisenhower_matrix/ui/widget/matrix_ceil.dart';
import 'package:eisenhower_matrix/utils/io_platform_adapter.dart';
import 'package:eisenhower_matrix/utils/matrix_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MatrixScreen extends StatefulWidget {
  @override
  _MatrixScreenState createState() => _MatrixScreenState();
}

class _MatrixScreenState extends State<MatrixScreen> {
  Widget _unknownState(Object state, BuildContext context) => Center(
        child: Column(
          children: <Widget>[Icon(PlatformIcons(context).info), Text('Unknown state: $state')],
        ),
      );

  @override
  void initState() {
    context.cubit<MatrixCubit>().matrixFetchLatest();
    super.initState();
  }

  Widget _buildMatrix(
    double dividerSize,
    double paddingSize,
    EdgeInsets titlePadding,
    TextStyle titleTextStyle,
    bool withBorders,
  ) {
    final dividerColor = Colors.transparent;
    return PlatformScaffold(
      backgroundColor: getCeilTitleColor(context),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(paddingSize),
                  child: Text(
                    '',
                    style: titleTextStyle.copyWith(color: Colors.transparent),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      padding: titlePadding,
                      alignment: Alignment.center,
                      child: Text(
                        'Urgent',
                        style: titleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      padding: titlePadding,
                      alignment: Alignment.center,
                      child: Text(
                        'Not Urgent',
                        style: titleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: titlePadding,
                          alignment: Alignment.center,
                          child: Text(
                            'Important',
                            style: titleTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: titlePadding,
                          alignment: Alignment.center,
                          child: Text(
                            'Not Important',
                            style: titleTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                // UrgentImportant
                                child: CubitBuilder<MatrixCubit, MatrixState>(
                                  buildWhen: (previous, state) {
                                    if (state is MatrixInitial) {
                                      return true;
                                    }
                                    if (state is MatrixFetched && previous is MatrixFetched) {
                                      return state.matrix.urgentAndImportant !=
                                          previous.matrix.urgentAndImportant;
                                    } else {
                                      return true;
                                    }
                                  },
                                  builder: (context, urgentImportant) {
                                    final ceilType = CeilType.UrgentImportant;
                                    switch (urgentImportant.runtimeType) {
                                      case MatrixInitial:
                                        return MatrixCeilLoadingWidget(
                                          ceilType: ceilType,
                                        );
                                      case MatrixFetched:
                                        return MatrixCeilWidget(
                                          ceil: (urgentImportant as MatrixFetched)
                                              .matrix
                                              .urgentAndImportant,
                                        );
                                      default:
                                        return _unknownState(urgentImportant, context);
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: dividerSize,
                                color: dividerColor,
                              ),
                              Expanded(
                                // UrgentNotImportant
                                child: CubitBuilder<MatrixCubit, MatrixState>(
                                  buildWhen: (previous, state) {
                                    if (state is MatrixInitial) {
                                      return true;
                                    }
                                    if (state is MatrixFetched && previous is MatrixFetched) {
                                      return state.matrix.urgentAndNotImportant !=
                                          previous.matrix.urgentAndNotImportant;
                                    } else {
                                      return true;
                                    }
                                  },
                                  builder: (context, urgentImportant) {
                                    final ceilType = CeilType.UrgentNotImportant;
                                    switch (urgentImportant.runtimeType) {
                                      case MatrixInitial:
                                        return MatrixCeilLoadingWidget(
                                          ceilType: ceilType,
                                        );
                                      case MatrixFetched:
                                        return MatrixCeilWidget(
                                          ceil: (urgentImportant as MatrixFetched)
                                              .matrix
                                              .urgentAndNotImportant,
                                        );
                                      default:
                                        return _unknownState(urgentImportant, context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: dividerSize,
                          color: dividerColor,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                // UrgentImportant
                                child: CubitBuilder<MatrixCubit, MatrixState>(
                                  buildWhen: (previous, state) {
                                    if (state is MatrixInitial) {
                                      return true;
                                    }
                                    if (state is MatrixFetched && previous is MatrixFetched) {
                                      return state.matrix.notUrgentAndImportant !=
                                          previous.matrix.notUrgentAndImportant;
                                    } else {
                                      return true;
                                    }
                                  },
                                  builder: (context, urgentImportant) {
                                    final ceilType = CeilType.NotUrgentImportant;
                                    switch (urgentImportant.runtimeType) {
                                      case MatrixInitial:
                                        return MatrixCeilLoadingWidget(
                                          ceilType: ceilType,
                                        );
                                      case MatrixFetched:
                                        return MatrixCeilWidget(
                                          ceil: (urgentImportant as MatrixFetched)
                                              .matrix
                                              .notUrgentAndImportant,
                                        );
                                      default:
                                        return _unknownState(urgentImportant, context);
                                    }
                                  },
                                ),
                              ),
                              Container(
                                height: dividerSize,
                                color: dividerColor,
                              ),
                              Expanded(
                                // NotUrgentNotImportant
                                child: CubitBuilder<MatrixCubit, MatrixState>(
                                  buildWhen: (previous, state) {
                                    if (state is MatrixInitial) {
                                      return true;
                                    }
                                    if (state is MatrixFetched && previous is MatrixFetched) {
                                      return state.matrix.notUrgentAndNotImportant !=
                                          previous.matrix.notUrgentAndNotImportant;
                                    } else {
                                      return true;
                                    }
                                  },
                                  builder: (context, urgentImportant) {
                                    final ceilType = CeilType.NotUrgentNotImportant;
                                    switch (urgentImportant.runtimeType) {
                                      case MatrixInitial:
                                        return MatrixCeilLoadingWidget(
                                          ceilType: ceilType,
                                        );
                                      case MatrixFetched:
                                        return MatrixCeilWidget(
                                          ceil: (urgentImportant as MatrixFetched)
                                              .matrix
                                              .notUrgentAndNotImportant,
                                        );
                                      default:
                                        return _unknownState(urgentImportant, context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (withBorders)
                    Container(
                      padding: titlePadding,
                      child: Text(
                        '',
                        style: titleTextStyle.copyWith(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (withBorders)
              RotatedBox(
                quarterTurns: -1,
                child: Container(
                  padding: titlePadding,
                  child: Text(
                    '',
                    style: titleTextStyle.copyWith(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAndroid || isIOS) {
      final dividerSize = 3.0;
      const paddingSize = 1.5;
      const titlePadding = EdgeInsets.only(top: 0, bottom: paddingSize);
      final titleTextStyle = Theme.of(context).textTheme.subtitle2;
      return _buildMatrix(
        dividerSize,
        paddingSize,
        titlePadding,
        titleTextStyle,
        false,
      );
    } else {
      final queryData = MediaQuery.of(context);
      final textStyle = DefaultTextStyle.of(context).style;
      if (queryData.orientation == Orientation.portrait) {
        final dividerSize = 3.0;
        const paddingSize = 1.5;
        const titlePadding = EdgeInsets.only(top: 0, bottom: paddingSize);
        final titleTextStyle = Theme.of(context).textTheme.subtitle2;
        return _buildMatrix(
          dividerSize,
          paddingSize,
          titlePadding,
          titleTextStyle,
          false,
        );
      }
      if (queryData.size.height * 1.6 < queryData.size.width) {
        final dividerSize = 15.0;
        const paddingSize = 40.0;
        const titlePadding = EdgeInsets.only(top: paddingSize, bottom: paddingSize * 0.25);
        final titleTextStyle =
            Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600);
        return DefaultTextStyle(
          style: textStyle.copyWith(fontSize: textStyle.fontSize + 2),
          child: _buildMatrix(
            dividerSize,
            paddingSize,
            titlePadding,
            titleTextStyle,
            true,
          ),
        );
      } else {
        final dividerSize = 12.0;
        const paddingSize = 20.0;
        const titlePadding = EdgeInsets.only(top: paddingSize, bottom: paddingSize * 0.4);
        final titleTextStyle =
            Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600);
        return DefaultTextStyle(
          style: textStyle.copyWith(fontSize: textStyle.fontSize + 2),
          child: _buildMatrix(
            dividerSize,
            paddingSize,
            titlePadding,
            titleTextStyle,
            true,
          ),
        );
      }
    }
  }
}
