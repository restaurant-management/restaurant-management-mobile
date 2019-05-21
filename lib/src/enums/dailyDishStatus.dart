import 'baseEnum.dart';

class DailyDishStatus extends BaseEnum {
  static final DailyDishStatus inStock = DailyDishStatus('in-stock');
  static final DailyDishStatus outOfStock = DailyDishStatus('out-of-stock');

  DailyDishStatus(String value)
      : super(value, [
          'in-stock',
          'out-of-stock',
        ]);
}
