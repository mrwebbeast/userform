import "package:flutter/material.dart";
import "package:go_router/go_router.dart";


Future loadingDialog({
  required BuildContext context,
  required Future future,
  String? message,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => FutureProgressDialog(
      future,
      message: message != null ? Text("$message...") : null,
    ),
  );
}

class FutureProgressDialog extends StatefulWidget {
  /// Dialog will be closed when [future] task is finished.
  @required
  final Future future;

  /// [BoxDecoration] of [FutureProgressDialog].
  final BoxDecoration? decoration;

  /// opacity of [FutureProgressDialog]
  final double opacity;

  /// If you want to use custom progress widget set [progress].
  final Widget? progress;

  /// If you want to use message widget set [message].
  final Widget? message;
  final Widget? child;

  const FutureProgressDialog(
    this.future, {
    super.key,
    this.decoration,
    this.opacity = 1.0,
    this.progress,
    this.message,
    this.child,
  });

  @override
  FutureProgressDialogState createState() => FutureProgressDialogState();
}

class FutureProgressDialogState extends State<FutureProgressDialog> {
  @override
  Future<void> initState() async {
    super.initState();
    widget.future.then((val) {
      context.pop(val);
    }).catchError((e) {
      context.pop();
      throw e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (status) async {},
      child: _buildDialog(context),
    );
  }

  Widget _buildDialog(BuildContext context) {
    Widget content;
    if (widget.message == null) {
      content = Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          decoration: widget.decoration ?? _defaultDecoration,
          child: widget.progress ?? const CircularProgressIndicator(),
        ),
      );
    } else {
      content = Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        decoration: widget.decoration ?? _defaultDecoration,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          widget.progress ?? const CircularProgressIndicator(),
          const SizedBox(width: 20),
          _buildText(context)
        ]),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: widget.child != null ? EdgeInsets.zero : null,
      elevation: 0,
      child: Opacity(
        opacity: widget.opacity,
        child: widget.child ?? content,
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    if (widget.message == null) {
      return const SizedBox.shrink();
    }
    return Expanded(
      flex: 1,
      child: widget.message!,
    );
  }
}



const _defaultDecoration = BoxDecoration(
  color: Colors.white,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);
