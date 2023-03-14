import 'package:flutter/material.dart';

final List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.teal
];

// 외부에서 위젯을 받아서 빌드해줌
class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // 최대높이
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  // covariant : 상속된 클래스도 사용가능하도록 해준다는 뜻
  // 빌드가 다시 되었을때 이전 delegate
  // 새로운 delegate는 this로 지정
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class SliverListScreen extends StatelessWidget {
  final List<Container> con = List.generate(
    10,
    (index) => Container(
      height: 200,
      color: colors[index % 5],
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );

  SliverListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // sliver 앱바 구현
          renderSliverAppbar(),
          // 리스트 사이사이 헤더 넣기
          renderSliverHeader(),
          // 리스트 한번에 빌드하기
          sliverChildListDelegate(),

          renderSliverHeader(),
          // 리스트 보이는 부분만 빌드하기
          sliverChildBuilderDelegate(),
        ],
      ),
    );
  }

  renderSliverHeader() {
    return SliverPersistentHeader(
      // 스크롤 내려가면 상단에 고정시키기
      pinned: true,
      // delegate를 직접 구현해줘야함
      delegate: _SliverFixedHeaderDelegate(
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Text(
                'header~~~~~~~~',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          maxHeight: 150,
          minHeight: 50),
    );
  }

  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 스크롤올리면 앱바도 같이 올라감
      floating: true,

      // 앱바 무조건 고정
      // pinned: true,

      // 자석효과, 앱바가 완전히 나오거나 스크롤 되서 올라가거나 중간에 걸치는거 없음
      // floating : true에만 사용가능
      snap: true,

      // 맨 위에서 스크로 더 땡겼을 때 앱바색상이 같이 내려와서 배경가려줌
      stretch: true,

      // 앱바 높이 지정, 기본높이보다 크게만 설정 가능
      expandedHeight: 200,

      // 앱바가 스크롤되어 올라가기 시작하는 높이 지정
      collapsedHeight: 150,

      // 배경사진넣고 스크롤하면 사라지는 앱바 구현
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://cdn.inflearn.com/public/courses/328073/cover/c5cb036f-b0e5-4c82-9807-89052dc68286/328073-eng.png',
          fit: BoxFit.cover,
        ),
        title: const Text('Flexible Space'),
      ),

      title: const Text('sliver appbar'),
    );
  }

  sliverChildListDelegate() {
    return SliverList(
      // list의 모든 위젯을 한번에 다 그림
      delegate: SliverChildListDelegate(con),
    );
  }

  sliverChildBuilderDelegate() {
    return SliverList(
      // 스크롤을 내리면 화면에 보이는 위젯만 그리는 방식
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            height: 200,
            color: colors[index % 5],
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
