import 'package:flutter/material.dart';

final filters = [
  {'label': '기술 스택'},
  {'label': '잔여 포지션'},
  {'label': '활동 기간'},
];

final techChoices = [
  {
    'label': 'Flutter',
    'image':
        "https://engineering.linecorp.com/wp-content/uploads/2019/08/flutter1.png"
  },
  {
    'label': 'SpringBoot',
    'image':
        "https://images.g2crowd.com/uploads/product/image/social_landscape/social_landscape_9d63a0ed04b871d3dacc8647b7f0927d/spring-boot.png"
  },
  {
    'label': 'Django',
    'image':
        "https://blog.kakaocdn.net/dn/cVaSOX/btqD9jVw36X/jHpIEqn2EAk7xdKMMmpEP0/img.png"
  },
  {
    'label': 'React',
    'image':
        "https://images.velog.io/images/jkzombie/post/6d17a7a4-9c50-42b4-96a1-ad6bb3bb1b5a/1200px-React-icon.svg.png"
  },
  {
    'label': 'Swift',
    'image': "https://developer.apple.com/swift/images/swift-og.png"
  },
];

final positionChoices = [
  {'label': '백엔드'},
  {'label': '프론트엔드'},
  {'label': '디자이너'},
];

final periodChoices = [
  {'label': '1개월 미만'},
  {'label': '3개월 미만'},
  {'label': '6개월 미만'},
  {'label': '6개월 이상'},
];
