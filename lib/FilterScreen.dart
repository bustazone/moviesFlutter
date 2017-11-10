import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pelis_busta/DesignConstants.dart';
import 'package:pelis_busta/FilmModel.dart';
import 'package:pelis_busta/GearInnerIcon.dart';
import 'package:pelis_busta/ListScreen.dart';
import 'package:pelis_busta/MainFilter.dart';
import 'package:pelis_busta/MoreGenreFilter.dart';
import 'package:pelis_busta/PressingButton.dart';
import 'package:pelis_busta/TextFilter.dart';
import 'package:pelis_busta/Utils.dart';

enum FilterStates {
  FilterSelector,
  GenderFilter,
  MoreGenreFilter,
  TitleFilter,
  CastFilter,
  LocationFilter,
  DirectorFilter,
  None
}

class FilterScreen extends StatefulWidget {
  final String title;
  final FilterStates currentState;

  FilterScreen({Key key, this.title, this.currentState}) : super(key: key);

  factory FilterScreen.main({Key key, String title}) {
    return new FilterScreen(
      title: title,
      currentState: FilterStates.FilterSelector,
    );
  }

  @override
  State createState() => new FilterScreenState();
}

class FilterScreenState extends State<FilterScreen>
    with TickerProviderStateMixin {

  List<GearInnerIcon> listIcons = <GearInnerIcon>[];
  var iconsStack;
  var screenWidth;
  var screenHeight;
  var gearWidth;
  var gearHeight;

  Animation<double> animation;
  Animation<double> animationIcons;
  AnimationController controller;
  AnimationController controllerIcons;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Curve cur = new Cubic(.55, 1.02, .81, 1.07);
    final Animation curve = new CurvedAnimation(parent: controller, curve: cur);
    animation = new Tween(begin: 0.0, end: 10.0).animate(curve)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controllerIcons.forward();
        }
      });
    if (widget.currentState == FilterStates.FilterSelector) {
      controller.forward();
    }

    controllerIcons = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    if (widget.currentState != FilterStates.FilterSelector) {
      controllerIcons.forward();
    }
//    Curve curIcons = new Cubic(.87, .75, .88, 1.6);
//    final Animation curveIcons =
//    new CurvedAnimation(parent: controllerIcons, curve: curIcons);
//    animationIcons = new Tween(begin: 0.0, end: 1.0).animate(curveIcons);
  }

  Widget _buildFiltersMain(animation, gearWidth, gearHeight, context, vsync) {
    List<Widget> createGenderIconsList() {
      List<Widget> listIconsp = <Widget>[];
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/cast.png',
        'assets/filterIcons/cast_selected.png',
        31.0,
        72.0,
        gearWidth,
        controllerIcons,
        () {
          goToTextFilter("CAST", FilterStates.CastFilter, context);
        },
        !isNullOrEmpty(new MainFilter().filter.casts),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/director.png',
        'assets/filterIcons/director_selected.png',
        72.0,
        30.0,
        gearWidth,
        controllerIcons,
        () {
          goToTextFilter("DIRECTOR", FilterStates.DirectorFilter, context);
        },
        !isNullOrEmpty(new MainFilter().filter.director),
      ));

      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/gender.png',
        'assets/filterIcons/gender_selected.png',
        79.0,
        100.0,
        gearWidth,
        controllerIcons,
        () {
          goToGenderFilter(context);
        },
        !isNullOrEmpty(new MainFilter().filter.generos),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/title.png',
        'assets/filterIcons/title_selected.png',
        128.0,
        15.0,
        gearWidth,
        controllerIcons,
        () {
          goToTextFilter("TITLE", FilterStates.TitleFilter, context);
        },
        !isNullOrEmpty(new MainFilter().filter.tituloFilter),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/languages.png',
        'assets/filterIcons/languages_selected.png',
        128.0,
        72.0,
        gearWidth,
        controllerIcons,
        () {
          Dialog sb = new Dialog(child: new Text("Tapped LANGUAGES!!!"));
          showDialog(context: context, child: sb);
        },
        false,
      ));
      listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/filterIcons/reset.png',
        'assets/filterIcons/reset.png',
        128.0,
        240.0,
        gearWidth,
        controllerIcons,
        (selected) {
          new MainFilter().resetFilter();
          setState((){});
        },
        false,
      ));
      listIconsp.add(new GearInnerIcon.selectableIcon(
        'assets/filterIcons/series.png',
        'assets/filterIcons/series_selected.png',
        177.0,
        100.0,
        gearWidth,
        controllerIcons,
        (selected) {
          setState(() {
            new MainFilter().filter.serie = selected;
          });
//          Dialog sb = new Dialog(child: new Text("Tapped SERIES!!!"));
//          showDialog(context: context, child: sb);
        },
        new MainFilter().filter.serie,
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/location.png',
        'assets/filterIcons/location_selected.png',
        184.0,
        30.0,
        gearWidth,
        controllerIcons,
        () {
          goToTextFilter("LOCATION", FilterStates.LocationFilter, context);
        },
        !isNullOrEmpty(new MainFilter().filter.location),
      ));
      listIconsp.add(new GearInnerIcon.mainButton(
        'assets/filterIcons/year.png',
        'assets/filterIcons/year_selected.png',
        225.0,
        72.0,
        gearWidth,
        controllerIcons,
        () {
          Dialog sb = new Dialog(child: new Text("Tapped YEAR!!!"));
          showDialog(context: context, child: sb);
        },
        false,
      ));
      return listIconsp;
    }

    return new Container(
        //color: const Color(0xFFFF0000),
        width: gearWidth,
        height: gearWidth,
        child: new Stack(
          alignment: const FractionalOffset(0.5, 0.5),
          overflow: Overflow.visible,
          children: createGenderIconsList(),
        ));
  }

  Future goToGenderFilter(context) async {
//    Navigator
//        .of(context)
//        .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
//      return new FilterScreen(
//          title: widget.title, currentState: FilterStates.GenderFilter);
//    }));

    await Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new FilterScreen(
              title: widget.title, currentState: FilterStates.GenderFilter);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: child,
          );
        }));

//    print("baaaaaaaaack!!!!!");
//    Curve curIcons = new Cubic(.87, .75, .88, 1.6);
//    final Animation curveIcons =
//    new CurvedAnimation(parent: controllerIcons, curve: curIcons);
//    animationIcons = new Tween(begin: 0.0, end: 1.0).animate(curveIcons);
    //controller.forward();
    setState(() {});
    controllerIcons.forward();
  }

  Future goToTextFilter(title, filterState, context) async {
//    Navigator
//        .of(context)
//        .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
//      return new FilterScreen(
//          title: widget.title, currentState: FilterStates.GenderFilter);
//    }));

    await Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new FilterScreen(title: title, currentState: filterState);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: child,
          );
        }));

//    print("baaaaaaaaack!!!!!");
//    Curve curIcons = new Cubic(.87, .75, .88, 1.6);
//    final Animation curveIcons =
//    new CurvedAnimation(parent: controllerIcons, curve: curIcons);
//    animationIcons = new Tween(begin: 0.0, end: 1.0).animate(curveIcons);
    //controller.forward();
    setState(() {});
    controllerIcons.forward();
  }

  Future ssssssss111(context) async {
//    Navigator
//        .of(context)
//        .push(new MaterialPageRoute<Null>(builder: (BuildContext context) {
//      return new FilterScreen(
//          title: widget.title, currentState: FilterStates.GenderFilter);
//    }));

    await Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new FilterScreen(
              title: widget.title, currentState: FilterStates.MoreGenreFilter);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: child,
          );
        }));

//    print("baaaaaaaaack!!!!!");
//    Curve curIcons = new Cubic(.87, .75, .88, 1.6);
//    final Animation curveIcons =
//    new CurvedAnimation(parent: controllerIcons, curve: curIcons);
//    animationIcons = new Tween(begin: 0.0, end: 1.0).animate(curveIcons);
    //controller.forward();
    setState(() {});
    controllerIcons.forward();
  }

  Widget _buildGenderFilter(animation, gearWidth, gearHeight, context, vsync) {
    List<GearInnerIcon> createGenderIconsList() {
      List<GearInnerIcon> listIconsp = <GearInnerIcon>[];
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/romance.png',
          'assets/imgs/romance_selected.png',
          15.0,
          128.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_ROMANCE_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_ROMANCE_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/drama.png',
          'assets/imgs/drama_selected.png',
          30.0,
          72.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_DRAMA_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_DRAMA_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/suspense.png',
          'assets/imgs/suspense_selected.png',
          30.0,
          184.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_SUSPENSE_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_SUSPENSE_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/horror.png',
          'assets/imgs/horror_selected.png',
          72.0,
          30.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_HORROR_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_HORROR_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/musical.png',
          'assets/imgs/musical_selected.png',
          72.0,
          225.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_MUSICAL_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_MUSICAL_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/comedy.png',
          'assets/imgs/comedy_selected.png',
          79.0,
          100.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_COMEDY_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_COMEDY_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/thriller.png',
          'assets/imgs/thriller_selected.png',
          79.0,
          156.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_THRILLER_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_THRILLER_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/scifi.png',
          'assets/imgs/scifi_selected.png',
          128.0,
          15.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_SCIFI_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_SCIFI_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/animation.png',
          'assets/imgs/animation_selected.png',
          128.0,
          72.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_ANIMATION_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_ANIMATION_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/noir.png',
          'assets/imgs/noir_selected.png',
          128.0,
          184.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_NOIR_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_NOIR_CODE)));
      listIconsp.add(new GearInnerIcon.mainButton(
          'assets/imgs/more.png',
          'assets/imgs/more_selected.png',
          128.0,
          240.0,
          gearWidth,
          controllerIcons, () {
        ssssssss111(context);
      }, false));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/kids.png',
          'assets/imgs/kids_selected.png',
          177.0,
          100.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_KIDS_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_KIDS_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/western.png',
          'assets/imgs/western_selected.png',
          177.0,
          156.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_WESTERN_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_WESTERN_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/fantastic.png',
          'assets/imgs/fantastic_selected.png',
          184.0,
          30.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_FANTASTIC_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_FANTASTIC_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/docu.png',
          'assets/imgs/docu_selected.png',
          184.0,
          225.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_DOCU_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_DOCU_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/adventure.png',
          'assets/imgs/adventure_selected.png',
          225.0,
          72.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_ADVENTURE_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_ADVENTURE_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/action.png',
          'assets/imgs/action_selected.png',
          225.0,
          184.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_ACTION_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_ACTION_CODE)));
      listIconsp.add(new GearInnerIcon.selectableIcon(
          'assets/imgs/belic.png',
          'assets/imgs/belic_selected.png',
          241.0,
          128.0,
          gearWidth,
          controllerIcons, (selected) {
        setState(() {
          updateFilterGenders(selected, codigo: Gender.GENDER_BELIC_CODE);
        });
      }, checkFilterGenders(codigo: Gender.GENDER_BELIC_CODE)));
      return listIconsp;
    }

//    var controllerScale = new AnimationController(
//        duration: const Duration(milliseconds: 1000), vsync: vsync);

//    runAfterDelay(0, vsync, () {
//      controllerScale.forward();
//    });

//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controllerScale.forward();
//      }
//    });

    return new Container(
        //color: const Color(0xFFFF0000),
        width: gearWidth,
        height: gearWidth,
        child: new Stack(
          alignment: const FractionalOffset(0.5, 0.5),
          overflow: Overflow.visible,
          children: createGenderIconsList(),
        ));
  }

  void updateFilterGenders(bool selected, {int codigo, String nombre}) {
    if (selected) {
      new MainFilter()
          .filter
          .generos
          .add(new Gender(id: codigo, nombre: nombre));
    } else {
      new MainFilter()
          .filter
          .generos
          .removeByValues(new Gender(id: codigo, nombre: nombre));
    }
  }

  bool checkFilterGenders({int codigo, String nombre}) {
    return new MainFilter()
        .filter
        .generos
        .hasByValues(new Gender(id: codigo, nombre: nombre));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    gearWidth = MediaQuery.of(context).size.width * 0.9;
    gearHeight =
        DesignConstants.gearHeight * (gearWidth / DesignConstants.gearWidth);

    Widget getReturnButton() {
      if (widget.currentState != FilterStates.FilterSelector) {
        return new Positioned(
          child: new PressingButton(
              'assets/imgs/return.png',
              'assets/imgs/return_selected.png',
              30.0 * (gearWidth / DesignConstants.gearWidth),
              30.0 * (gearWidth / DesignConstants.gearWidth), () {

            Navigator.of(context).pop();
          }),
          left: (gearWidth / 2.0) -
              15.0 * (gearWidth / DesignConstants.gearWidth),
          top: (gearWidth / 2.0) -
              15.0 * (gearWidth / DesignConstants.gearWidth),
        );
      } else {
        return new Container(
          width: 0.0,
          height: 0.0,
        );
      }
    }






    Widget getMainButtons() {
      switch (widget.currentState) {
        case FilterStates.FilterSelector:
          return _buildFiltersMain(
              animation, gearWidth, gearHeight, context, this);
        case FilterStates.GenderFilter:
          return _buildGenderFilter(
              animation, gearWidth, gearHeight, context, this);
        case FilterStates.TitleFilter:
        case FilterStates.CastFilter:
        case FilterStates.DirectorFilter:
        case FilterStates.LocationFilter:
          return new TextFilter(gearWidth, title: widget.title ,currentState: widget.currentState);
        case FilterStates.MoreGenreFilter:
          return new MoreGenresFilter(gearWidth, "SUB-GENRES");
        default:
          return new Container(
            width: 0.0,
            height: 0.0,
          );
      }
    }

    Widget getMainGear() {
      return new Stack(alignment: const FractionalOffset(0.0, 0.5), children: [
        new Positioned(
          child: new PressingButton(
              'assets/imgs/search.png',
              'assets/imgs/search_selected.png',
              124.0 * (gearWidth / DesignConstants.gearWidth),
              //75.0 * (gearWidth / DesignConstants.gearWidth)
              null, () {
            Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new ListScreen(new MainFilter().filter, true);
            }));
          }),
          left: screenWidth / 2.0,
          top: (screenHeight / 2.0) +
              (gearWidth / 2.0) -
              (35 * (gearWidth / DesignConstants.gearWidth)),
        ),
        new Positioned(
          child: new PressingButton(
              'assets/imgs/random.png',
              'assets/imgs/random_selected.png',
              124.0 * (gearWidth / DesignConstants.gearWidth),
              //75.0 * (gearWidth / DesignConstants.gearWidth)
              null, () {
            var filmFilter = new FilmFilter();
            filmFilter.randomFilm = true;
            Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new ListScreen(filmFilter, false);
            }));
          }),
          left: (screenWidth / 2.0) -
              (124.0 * (gearWidth / DesignConstants.gearWidth)),
          top: (screenHeight / 2.0) +
              (gearWidth / 2.0) -
              (35 * (gearWidth / DesignConstants.gearWidth)),
        ),
        new Positioned(
          child: new Stack(
            alignment: const FractionalOffset(0.0, 0.5),
            children: [
              new Transform.rotate(
                angle: PI * animation.value,
                origin: new Offset(0.0, 0.0),
                child: _buildGear(animation, gearWidth),
              ),
              getReturnButton(),
              getMainButtons(),
            ],
          ),
          left: screenWidth * 0.05,
          top: (screenHeight - gearWidth) / 2.0,
        ),
      ]);
    }

    return new Scaffold(
        body: new Container(
      color: const Color(0xFFEAEAEA),
      child: new Center(
        child: getMainGear(),
      ),
    ));
  }

  @override
  dispose() {
    controller.dispose();
    controllerIcons.dispose();
    super.dispose();
  }
}

Widget _buildGear(animation, gearWidth) {
  return new Image.asset(
    'assets/imgs/gear.png',
    width: gearWidth,
    height: gearWidth,
  );
}
