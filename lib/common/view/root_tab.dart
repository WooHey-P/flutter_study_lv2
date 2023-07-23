import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_lv2/colors.dart';
import 'package:flutter_study_lv2/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        // 탭 바의 개수
        length: 4,
        // 탭 바의 상태를 알려주는 컨트롤러
        // 애니메이션 효과를 위해 vsync를 구현한 객체를 넣어준다.
        vsync: this,
        initialIndex: _selectedIndex
    );
    _tabController.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '딜리버리다 엌ㅋㅋ',
      // 탭 바의 뷰, 탭 바의 아이템을 클릭했을 때 보여줄 뷰
      child: TabBarView(
        // 스크롤을 하지 않도록 설정
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          Center(child: Text('홈')),
          Center(child: Text('음식')),
          Center(child: Text('주문')),
          Center(child: Text('프로필')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // 선택되었을 때의 색상
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          // 탭 바의 아이템을 클릭했을 때 호출되는 함수
          _tabController.animateTo(index);
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
