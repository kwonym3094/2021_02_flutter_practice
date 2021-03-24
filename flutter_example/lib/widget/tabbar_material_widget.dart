import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarMaterialWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;

  const TabBarMaterialWidget(
      {@required this.index, @required this.onChangedTab, Key key})
      : super(key: key);

  @override
  _TabBarMaterialWidgetState createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  @override
  Widget build(BuildContext context) {
    final placeholder = Opacity(
      opacity: 0,
      child: IconButton(
        icon: Icon(Icons.no_cell),
        onPressed: null,
      ),
    );

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem(index: 0, icon: Icon(Icons.list)),
          _buildTabItem(index: 1, icon: Icon(Icons.search)),
          placeholder,
          _buildTabItem(index: 2, icon: Icon(Icons.bar_chart)),
          _buildTabItem(index: 3, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget _buildTabItem({@required int index, @required Icon icon}) {

    final isSelected = index == widget.index;

    return IconTheme(
        data: IconThemeData(
          color: isSelected ? Colors.blue : Colors.grey
        ),
        child: IconButton(
            icon: icon, onPressed: () => widget.onChangedTab(index))
    );
  }
}
