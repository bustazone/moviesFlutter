import 'package:flutter/material.dart';
import 'package:pelis_busta/support/custom_widgets/ProgressScreen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class LoadingScaffoldWrapperWidget extends StatefulWidget {
  LoadingScaffoldWrapperWidget(
      {Key key,
      this.body,
      this.showLoader,
      this.handlePush,
      this.handlePop,
      this.appBar})
      : super(key: key);
  final Function() body;
  final bool showLoader;
  final Function() handlePush;
  final Function() handlePop;
  final AppBar appBar;

  @override
  State createState() => new LoadingScaffoldWrapperWidgetState();
}

class LoadingScaffoldWrapperWidgetState
    extends State<LoadingScaffoldWrapperWidget>
    with TickerProviderStateMixin, RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush");
    if (widget.handlePush != null) widget.handlePush();
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPop");
    if (widget.handlePop != null) widget.handlePop();
  }

  @override
  dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Widget _getMainWidget() {
    if (widget.showLoader) {
      return Material(child: ProgressScreen());
    } else {
      return new Scaffold(
        appBar: widget.appBar,
        body: widget.body(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getMainWidget();
  }
}
