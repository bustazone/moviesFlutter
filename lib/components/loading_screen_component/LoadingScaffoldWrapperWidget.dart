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
      this.appBar,
      this.fab})
      : super(key: key);
  final bool showLoader;
  final Function() handlePush;
  final Function() handlePop;
  final Function() body;
  final AppBar appBar;
  final Function() fab;

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
    print("didPush Scaffold");
    if (widget.handlePush != null) widget.handlePush();
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPop Scaffold");
    if (widget.handlePop != null) widget.handlePop();
  }

  @override
  dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  _getMainWidget() {
    List<Widget> l = List<Widget>();
    l.add(Scaffold(
      appBar: widget.appBar,
      floatingActionButton: widget.fab == null ? null : widget.fab(),
      body: widget.body(),
    ));
    if (widget.showLoader) {
      l.add(Material(child: ProgressScreen()));
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _getMainWidget());
  }
}
