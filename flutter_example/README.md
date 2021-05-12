## Functional Programming을 통한 Error handling

- dartz 패키지 참고


- Either<failure, success> : 에러값과 결과값을 가질 수 있는 객체. ~.fold(left case, right case) 를 통해 코드가 더욱 robust 해짐
- Task : dart의 Future은 FP-frendly 하지 않기 때문에, 이를 대신해주는 객체.