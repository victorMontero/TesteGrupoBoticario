import 'dart:async';

enum NavBarItem {FEED, NEWS}

class BottomNavBarBloc {

  final StreamController<NavBarItem> _navBarController =
  StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.FEED;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i){
    switch(i){
      case 0:
        _navBarController.sink.add(NavBarItem.FEED);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.NEWS);
        break;

    }
  }

  close(){
    _navBarController?.close();
  }
}