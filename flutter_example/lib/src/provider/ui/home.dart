import 'package:flutter/material.dart';
import 'package:flutter_example/src/provider/provider/bottom_navigation_provider.dart';
import 'package:flutter_example/src/provider/provider/count_provider.dart';
import 'package:flutter_example/src/provider/components/view_count_widget.dart';
import 'package:provider/provider.dart';

import 'count_home_widget.dart';
import 'movie_list_widget.dart';

// provider 를 사용하면 stateful widget으로 사용해야할 일이 거의 없다
// 허나 setState 로 사용해야할 경우도 생기니 주의

// provider 패턴으로 정보를 가져갈려면 provider 로 감싸줘야함

class Home extends StatelessWidget {
  BottomNavigationProvider _bottomNavigationProvider;

  // 아래 해당 2개는 동시에 update 를 받아야하는 것이기 때문에 굳이 consumer를 두번 사용하지 않고 밑의 provider에서 listen:true 로 바꿔주면 됨
  Widget _navigationBody() {
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return CountHomeWidget();
        break;
      case 1:
        return MovieListWidget();
        break;
    }
    return Container();
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie"),
      ],
      currentIndex: _bottomNavigationProvider.currentPage,
      selectedItemColor: Colors.red,
      onTap: (index) {
        // provider navigation state ;
        _bottomNavigationProvider.updateCurrentPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
