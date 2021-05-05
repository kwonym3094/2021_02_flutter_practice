class Weather {
  final String cityName;
  final double temperatureCelsius;

  Weather({required this.cityName, required this.temperatureCelsius});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    // 값 뿐만 아니라, 같은 메모리상 주소를 가지는 완전 동일 인스턴스를 체크

    return o is Weather &&
        o.cityName == cityName &&
        o.temperatureCelsius ==
            temperatureCelsius; // 나와 같은 타입의 오브젝트인지 확인 후 value 값이 같은지 확인
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;
}
