import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutterhole/constants/icons.dart';
import 'package:flutterhole/widgets/layout/animations.dart';
import 'package:flutterhole/widgets/layout/dialogs.dart';
import 'package:flutterhole/widgets/layout/loading_indicator.dart';

class DashboardCardHeader extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Object? error;

  const DashboardCardHeader({
    Key? key,
    required this.title,
    required this.isLoading,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      mouseCursor: SystemMouseCursors.click,
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
              overflow: TextOverflow.visible,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
      trailing: AnimatedFader(
        child: isLoading
            ? IconButton(
                onPressed: null,
                enableFeedback: false,
                mouseCursor: SystemMouseCursors.click,
                icon: LoadingIndicator(
                  size: Theme.of(context).textTheme.subtitle1?.fontSize,
                ),
              )
            : AnimatedFader(
                child: error != null
                    ? IconButton(
                        iconSize:
                            Theme.of(context).textTheme.subtitle1?.fontSize ??
                                24.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showModal(
                              context: context,
                              builder: (context) => ErrorDialog(
                                    title: title,
                                    error: error!,
                                  ));
                        },
                        icon: Icon(
                          KIcons.error,
                          color: Theme.of(context).colorScheme.error,
                        ))
                    : Text(''),
              ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key,
    required this.header,
    required this.content,
    this.onTap,
    this.cardColor,
  }) : super(key: key);

  final Widget header;
  final Widget content;
  final VoidCallback? onTap;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: cardColor,
        child: InkWell(
          onTap: onTap,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header,
              content,
            ],
          ),
        ));
  }
}

class DashboardFittedTile extends StatelessWidget {
  const DashboardFittedTile({
    Key? key,
    required this.title,
    required this.isLoading,
    this.text,
    this.onTap,
    this.cardColor,
    this.error,
  }) : super(key: key);

  final String title;
  final String? text;
  final bool isLoading;
  final VoidCallback? onTap;
  final Color? cardColor;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      header:
          DashboardCardHeader(title: title, isLoading: isLoading, error: error),
      onTap: onTap,
      cardColor: cardColor,
      content: Expanded(
          child: Padding(
        padding:
            const EdgeInsets.all(8.0).subtract(const EdgeInsets.only(top: 8.0)),
        child: FittedText(text: text ?? '-'),
      )),
      // content: const Expanded(child: Center(child: Text('TODO'))),
    );
  }
}

class FittedText extends StatelessWidget {
  const FittedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
