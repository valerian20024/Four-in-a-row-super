import 'package:four_in_a_row_super/models/rules/rule.dart';

/*
  This Rule handles the size of the grid. It can be :
  (lines x cols)
  4 x 5
  5 x 6
  6 x 7
  7 x 8
  7 x 9
  7 x 10
  8 x 8
*/

class GridSizeRule extends Rule {
  int lines, columns;

  GridSizeRule({
    required super.name,
    required super.longDescription,
    required super.shortDescription,
    required this.lines,
    required this.columns,
  });

  @override
  String getType() {
    return 'Grid Size';
  }

  @override
  String getName() {
    return 'Grid Size ($lines x $columns)';
  }

  void setLinesAndColumns(int lines, int columns) {
    this.lines = lines;
    this.columns = columns;
  }
}
