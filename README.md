# TossChartClone

WWDC 스터디 [WWHIGH](https://github.com/WWHigh/WWDC-STUDY)에서 [[WWDC22]Swift Charts: Raise the bar](https://developer.apple.com/videos/play/wwdc2022/10137/) 영상에 대한 발표를 하기 위해 토스증권의 1년 주식 차트를 iOS 16부터 사용 가능한 Swift Charts 프레임워크를 사용하여 클론코딩해봤습니다.

- [WWDC22] Swift Charts: Raise the bar [(Issue)](https://github.com/WWHigh/WWDC-STUDY/issues/20) | [(Keynote)](https://github.com/Chaeho-Min/Keynote_Collection/blob/main/WWHigh_%233_Swift%20Charts%20-%20Raise%20the%20bar.key), [(PDF)](https://github.com/Chaeho-Min/Keynote_Collection/blob/main/WWHigh_%233_Swift%20Charts%20-%20Raise%20the%20bar(PDF).pdf)

<img src="https://img.shields.io/badge/Swift 5.7-f96e32?style=flat-square&logo=swift&logoColor=white"/> <img src="https://img.shields.io/badge/Xcode 14.0 beta 2-70a6e0?style=flat-square&logo=xcode&logoColor=white"/>

|토스원본|클론|
|:---:|:---:|
|<img width="250" src="https://user-images.githubusercontent.com/75792767/176997846-492c5032-f4d1-40a4-b711-7befffc0e808.png">|<img width="250" src="https://user-images.githubusercontent.com/75792767/177091966-2ecc643d-53d9-40c1-956d-cf66ce60b87e.png">|
|<img width="250" src="https://user-images.githubusercontent.com/75792767/176998033-fedbe479-3b62-4845-9818-187fdbf225aa.jpeg">|<img width="250" src="https://user-images.githubusercontent.com/75792767/177091536-80855d1c-8307-471b-91c2-e0759612ca22.gif">|

---

# Swift Charts Customization

'Swift Charts로 어디까지 커스텀이 될까?'라는 궁금증이 들어서 한 번 조금 복잡한 차트를 클론코딩해보기로 하여 진행하게 됐습니다.

## Marks

<img src="https://user-images.githubusercontent.com/75792767/188383689-58ade229-807b-416a-a905-100d9d09755a.png">

Swift Charts에서는 그래프의 데이터를 나타내는 부분을 Marks라고 부릅니다.

<img src="https://user-images.githubusercontent.com/75792767/188384042-d5eacef9-2c62-4d76-8769-d86b0de3ce1f.png">

그리고 Swift Charts는 위와 같은 종류의 Marks를 지원합니다.
그렇다면 이 Marks는 얼마나 커스텀이 될까요?

### Types

<img src="https://user-images.githubusercontent.com/75792767/188384291-d6214ebe-6b66-46fb-a59a-0928e2d9fc58.png">

토스증권 차트를 도식화하면 위와 같습니다.
여기서 각 부분을 표현하는데 어떤 종류의 Marks가 사용됐는지 알아보겠습니다.

<img src="https://user-images.githubusercontent.com/75792767/188384492-c67fb8a5-602a-46fd-aa15-ad3b31612a15.png">

<img src="https://user-images.githubusercontent.com/75792767/188384522-a4628338-6aed-4987-99f7-263cf248b663.png">

<img src="https://user-images.githubusercontent.com/75792767/188384538-a5afb6ca-b856-475a-a3b1-fa520b66800e.png">

<img src="https://user-images.githubusercontent.com/75792767/188384560-c2a23ff1-a06f-4eac-aeb1-9d7a32386bac.png">

### Custom

<img src="https://user-images.githubusercontent.com/75792767/188385717-bd4a88c8-7346-49ef-ad8a-c3fa3de9d46c.png">

Bar Marks가 사용된 부분을 보면, 위와 같은 커스텀이 이루어졌습니다.
코드로 각 커스텀을 어떻게 적용했는지 하나하나 살펴봅시다.

<img src="https://user-images.githubusercontent.com/75792767/188385733-de39b9f1-fa90-4bf1-a1fc-7c170baa8fbf.png">

이렇게 BarMark의 yStart와 yEnd 매개변수를 이용하여 그래프상에서 시가부터 종가까지만 BarMark가 표시되도록 했습니다.

<img src="https://user-images.githubusercontent.com/75792767/188385748-83d73b5b-30fa-4bd8-8cc8-19cdbd963b0d.png">

BarMark의 너비또한 매개변수로 지정해줄 수 있습니다.
위에서는 .fixed를 이용하여 너비를 고정값으로 지정해줬는데, .ratio를 이용하면 비율로도 지정할 수 있습니다.

<img src="https://user-images.githubusercontent.com/75792767/188385756-8a8687df-7a7c-4b4b-86ef-63b11c38153c.png">

Swift Charts에서는 색상을 바꿀 때 .foregroundStyle 수식어를 사용합니다.

<img src="https://user-images.githubusercontent.com/75792767/188385765-c5531b52-bef1-411d-9811-c20cfda30ea1.png">

막대의 코너를 둥글게 하기 위해 SwiftUI에서 자주 사용되는 .cornerRadius 수식어를 사용했습니다. 이처럼 Swift Charts에는 SwiftUI View에 사용되던 많은 수식어가 지원됩니다.
'이 수식어는 차트에도 적용될거 같은데?'라는 생각이 들면 적용해보세요! 웬만하면 될 것입니다.

<img src="https://user-images.githubusercontent.com/75792767/188391145-f2909bba-538a-4d0b-b605-402ce47943cb.png">

토스차트를 만드는 데 쓰이진 않았지만, 한 차트에 두 가지 데이터를 표시할 경우, .position 수식어로 두 데이터를 서로 다른 줄로 표시할 수 있습니다.
BarMark의 경우 기본적으로는 두 데이터가 한 막대로 표시됩니다.

<img src="https://user-images.githubusercontent.com/75792767/188391236-0ee6cd04-a5f8-4aef-8f61-9821a5a335d4.png">

이제 PointMark로 넘어와봅시다.
.symbolSize 수식어를 이용하면 PointMark의 심볼 크기를 변경할 수 있습니다.

<img src="https://user-images.githubusercontent.com/75792767/188391811-3b101e97-2cfc-45ce-a95b-72d5955dbb98.png">

PointMark에서 가장 궁금한 것은 심볼 모양을 직접 만들 수 있는지 여부일 것입니다.
위와 같이 ChartSymbolShape 프로토콜을 준수하는 커스텀 타입을 만들면 가능합니다.

<img src="https://user-images.githubusercontent.com/75792767/188391827-ab0f23ba-b68b-4695-a090-43b75b83558c.png">

커스텀 심볼을 .symbol 수식어에 넣으면, 위와 같이 PointMark의 심볼을 직접 만든 심볼로 변경할 수 있습니다.

<img src="https://user-images.githubusercontent.com/75792767/188392309-01e66f06-6269-4ff4-a8f3-07f55b0edea0.png">

마지막으로, '내 주식 평균'과 최고가, 최저가를 나타내는 텍스트를 표시하는 데에는 .annotation 수식어를 사용했습니다.

<img src="https://user-images.githubusercontent.com/75792767/188392337-af98c199-7c48-482f-92b6-fad627055b78.png">

이렇게 .annotation 수식어 안에는 텍스트 뿐만 아니라 뷰를 넣을 수 있습니다.

## Axes

Swift Charts에서는 축도 커스텀 할 수 있습니다.

<img src="https://user-images.githubusercontent.com/75792767/188393478-11a6a2e1-8b75-4ef0-a58f-e43231eb3fec.png">

왼쪽의 기본 차트와 달리 토스차트는 축이 보이질 않는데, .chartXAxis 수식어에서 .hidden을 사용하여 축을 보이지 않게 만들었기 때문입니다.

<img src="https://user-images.githubusercontent.com/75792767/188393522-d9f1432a-2d5f-48a8-ad3e-9015d578b150.png">

또한 .chartYScale을 이용하여 Y축 스케일을 최소값을 최저가로, 최고값을 최고가로 고정했습니다.

<img src="https://user-images.githubusercontent.com/75792767/188393938-af168b5a-6c1c-47ec-a6f3-73badabeb659.png">
<img src="https://user-images.githubusercontent.com/75792767/188393951-78246a8b-4135-4215-bfc0-cc14d86c2821.png">
<img src="https://user-images.githubusercontent.com/75792767/188393962-5da2a87b-1094-4919-a7f2-a3c70a5c87a7.png">

이외에도 위 세 가지를 조건에 따라 표시하거나 표시하지 않는 등의 다양한 커스텀을 할 수 있습니다.

---

# Chart Proxy

<img src="https://user-images.githubusercontent.com/75792767/188394510-10684d7d-fd86-44fc-b844-a70048428a3b.png">

Swift Charts는 ChartProxy를 제공합니다.
차트의 특정 데이터의 좌표나 크기를 알려줍니다.

<img src="https://user-images.githubusercontent.com/75792767/188394527-7bfcfc6b-48e9-4131-9887-1d7fa72d321f.png">

위와 같이 .chartOverlay나 .chartBackground 수식어에서 proxy를 사용할 수 있으며, 이 안에 적힌 코드는 SwiftUI의 .overlay나 .background와 동일하게, 차트의 위나 아래에 그려지게 됩니다.

<img src="https://user-images.githubusercontent.com/75792767/188394577-ae7bbbad-879f-47cf-8a6b-1a8b7ec2a4c0.png">

토스차트의 드래그 제스처를 구현하기 위해 이 기능을 이용했으며, 코드는 위와 같습니다.

# Reference
- [[WWDC22] Swift Charts: Raise the bar](https://developer.apple.com/videos/play/wwdc2022/10137/)
- [Read Size Extension](https://www.fivestars.blog/articles/swiftui-share-layout-information/)
