import 'package:mobx/mobx.dart';
import '../models/item.dart';
part 'items.g.dart';

class Items = _Items with _$Items;

abstract class _Items with Store {
  @observable
  List<Item> _items = [
    Item(
      'p1',
      'Reds Shirt',
      'A red shirt - it is pretty red!',
      29.99,
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Item(
      'p2',
      'Trousers',
      'A nice pair of trousers.',
      59.99,
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Item(
      'p3',
      'Yellow Scarf',
      'Warm and cozy - exactly what you need for the winter.',
      19.99,
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Item(
      'p4',
      'A Pan',
      'Prepare any meal you want.',
      49.99,
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Item> get getItems {
    return _items;
  }
}
