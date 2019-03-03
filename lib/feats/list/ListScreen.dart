import 'package:flutter/material.dart';
import 'package:pelis_busta/components/dialogs/AddListDialog.dart';
import 'package:pelis_busta/components/loading_screen_component/LoadingScaffoldWrapperWidget.dart';
import 'package:pelis_busta/feats/list/ListRow.dart';
import 'package:pelis_busta/feats/list/ListScreenContainer.dart';

class ListScreen extends StatefulWidget {
  ListScreen(this.vm, {Key key}) : super(key: key);

  final ViewModel vm;

  @override
  State<ListScreen> createState() {
    return new ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {
  bool loadingData;

  initState() {
    super.initState();
    loadingData = widget.vm.loadingData;
    getList();
  }

  getList() {
    widget.vm.getList();
  }

  selectItem(id) {
    widget.vm.selectList(id);
  }

  Widget getFilmItem(index, list) {
    if (index == 0) {
      return new FirstRow();
    } else if (index == list.length - 1) {
      return new LastRow();
    } else {
      if (list[index] == null) {
        return new NoResultsRow();
      } else {
        return new ListRow(
            list[index], selectItem, widget.vm.shareList, widget.vm.deleteList);
      }
    }
  }

  goBack() {
    Navigator.of(context).pop();
  }

  Future<bool> _handleBack() async {
    goBack();
    return false;
  }

  _getBody() {
    loadingData = widget.vm.loadingData;
    var list = List.from(widget.vm.userLists);
    if (list.length == 0) {
      list.addAll([null, null, null]);
    } else {
      list = [null];
      list.addAll(widget.vm.userLists);
      list.add(null);
    }
    return new Container(
        color: const Color(0xFFCC9900),
        child: new Stack(
          children: <Widget>[
            new CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              slivers: <Widget>[
                new SliverList(
                  delegate: new SliverChildBuilderDelegate(
                    (context, index) => getFilmItem(index, list),
                    childCount: list.length,
                  ),
                ),
              ],
            ),
            new Positioned(
              child: new Container(
                  color: new Color(0x80CC9900),
                  width: MediaQuery.of(context).size.width,
                  height: new AppBar().preferredSize.height,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        child: new IconButton(
                            color: new Color(0xFF564C19),
                            icon: new Icon(Icons.arrow_back),
                            onPressed: () {
                              goBack();
                            }),
                      ),
                      new Expanded(child: new Container()),
                    ],
                  )),
              top: MediaQuery.of(context).padding.top,
            ),
          ],
        ));
  }

  _getfab() {
    return FloatingActionButton(
      onPressed: () {
        AddListDialogContainer.showAddListDialog(context,
            onSuccess: this.getList);
      },
      tooltip: 'Add',
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          _handleBack();
        },
        child: new LoadingScaffoldWrapperWidget(
            showLoader: widget.vm.showLoader, body: _getBody, fab: _getfab));
  }
}
