import 'package:flutter/material.dart';
import 'package:pelis_busta/feats/filter/FilterScreenContainer.dart';
import 'package:pelis_busta/feats/filter/components/GearInnerIcon.dart';
import 'package:pelis_busta/feats/navigation/OnNavigateRouteCustom/CustomNavigator.dart';
import 'package:pelis_busta/support/utils/Utils.dart';

class MainFilter extends StatefulWidget {
  final Animation<double> animation;
  final AnimationController controllerIcons;
  final double gearWidth;
  final double gearHeight;
  final ViewModel vm;

  MainFilter(this.animation, this.controllerIcons, this.gearWidth,
      this.gearHeight, this.vm,
      {Key key})
      : super(key: key);

  @override
  State createState() => new MainFilterState();
}

class MainFilterState extends State<MainFilter> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Widget> createGenderIconsList() {
      List<Widget> listIconsp = <Widget>[];
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/cast.png',
        'assets/filterIcons/cast_selected.png',
        31.0,
        72.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterCastRouteName);
        },
        !isNullOrEmpty(widget.vm.cast),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/director.png',
        'assets/filterIcons/director_selected.png',
        72.0,
        30.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterDirectorRouteName);
        },
        !isNullOrEmpty(widget.vm.director),
      ));

      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/gender.png',
        'assets/filterIcons/gender_selected.png',
        79.0,
        100.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterGenreRouteName);
        },
        !isNullOrEmpty(widget.vm.genres),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/title.png',
        'assets/filterIcons/title_selected.png',
        128.0,
        15.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterTitleRouteName);
        },
        !isNullOrEmpty(widget.vm.title),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/languages.png',
        'assets/filterIcons/languages_selected.png',
        128.0,
        72.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterLangRouteName);
        },
        false,
      ));
      listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/filterIcons/series.png',
        'assets/filterIcons/series_selected.png',
        177.0,
        100.0,
        widget.gearWidth,
        widget.controllerIcons,
        (selected) {
          widget.vm.setSeries(selected);
        },
        widget.vm.series,
      ));

      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/location.png',
        'assets/filterIcons/location_selected.png',
        184.0,
        30.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterLocationRouteName);
        },
        !isNullOrEmpty(widget.vm.location),
      ));

      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/year.png',
        'assets/filterIcons/year_selected.png',
        225.0,
        72.0,
        widget.gearWidth,
        widget.controllerIcons,
        () {
          Navigator.of(context).pushNamed(FilterYearRouteName);
        },
        ((widget.vm.year != null) ||
            (widget.vm.minYear != null && widget.vm.maxYear != null)),
      ));

      listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/filterIcons/reset.png',
        'assets/filterIcons/reset.png',
        128.0,
        240.0,
        widget.gearWidth,
        widget.controllerIcons,
        (selected) {
          widget.vm.resetFilter();
        },
        false,
      ));

      return listIconsp;
    }

    return new Container(
        //color: const Color(0xFFFF0000),
        width: widget.gearWidth,
        height: widget.gearWidth,
        child: new Stack(
          alignment: const FractionalOffset(0.5, 0.5),
          overflow: Overflow.visible,
          children: createGenderIconsList(),
        ));
  }
}
