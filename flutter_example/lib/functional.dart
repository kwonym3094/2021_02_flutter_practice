String scream(int length) => 'A${'a' * length}h';

main() {

  final values = [1,5,10,20,50];
//   for (var length in values) {
//     print(scream(length));
//   }
  // 다음 처럼 바꾸기
  values.map(scream).forEach(print);

  // list, iterable은 다양한 api 지원
  // fold, where, join, skip
  values.skip(2).take(2).map(scream).forEach(print);
}