//
//  ContentView.swift
//  TossChartClone
//
//  Created by 민채호 on 2022/07/02.
//

import SwiftUI
import Charts

struct TossChart: View {
    @State private var selectedElement: Stock?
    @State private var selectedDateTextWidth: CGFloat = .zero
    @State private var yearMaxPriceTextWidth: CGFloat = .zero
    @State private var yearMaxPriceTextHeight: CGFloat = .zero
    @State private var yearMinPriceTextWidth: CGFloat = .zero
    @State private var yearMinPriceTextHeight: CGFloat = .zero
    private var maxPriceSortedData: [Stock] = samsungStock.sorted { $0.maxPrice > $1.maxPrice }
    private var minPriceSortedData: [Stock] = samsungStock.sorted { $0.minPrice < $1.minPrice }
    private var myStockAverage: Int = 70700
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            navigationBar
            chartHeader
            stockChart
                .padding(.vertical, 45)
                .frame(height: 240)
                .background {
                    VStack {
                        Spacer()
                        volumeChart
                    }
                }
            periodSegmentedControl
            Spacer()
        }
        .padding()
    }
}

// MARK: - ViewBuilder

private extension TossChart {
    @ViewBuilder var navigationBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "chevron.backward")
                .imageScale(.large)
            Spacer()
            Image(systemName: "bell.fill")
                .foregroundColor(.yellow)
                .imageScale(.large)
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .imageScale(.large)
        }
    }
    
    @ViewBuilder var chartHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("삼성전자")
                .font(.title2)
                .fontWeight(.semibold)
            Text("\(samsungStock.last?.finalPrice ?? 0)원")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
                Text("1년 전보다")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("\((samsungStock.last?.finalPrice ?? 0) - (samsungStock.first?.finalPrice ?? 0))원 (\(String(format: "%.1f", abs((Float(samsungStock.last?.finalPrice ?? 0) - Float(samsungStock.first?.finalPrice ?? 0)) / Float(samsungStock.first?.finalPrice ?? 0)) * 100))%)")
                    .font(.footnote)
                    .foregroundColor(((samsungStock.last?.finalPrice ?? 0) - (samsungStock.first?.finalPrice ?? 0)) > 0 ? .red : .blue)
            }
            .padding(.top, 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(selectedElement == nil ? 1 : 0)
        .overlay {
            if let selectedElement {
                VStack(spacing: 12) {
                    selectedHeaderPriceRow(firstLabel: "시작", firstPrice: selectedElement.startPrice, secondLabel: "마지막", secondPrice: selectedElement.finalPrice)
                    selectedHeaderPriceRow(firstLabel: "최고", firstPrice: selectedElement.maxPrice, secondLabel: "최저", secondPrice: selectedElement.minPrice)
                    selectedHeaderRateRow(volumeLabel: "거래량", volume: selectedElement.volume, rateLabel: "등락률", rate: selectedElement.rate)
                }
            }
        }
    }
    
    @ViewBuilder func selectedHeaderPriceRow(firstLabel: String, firstPrice: Int, secondLabel: String, secondPrice: Int) -> some View {
        HStack(spacing: 32) {
            HStack {
                Text(firstLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(firstPrice)원")
            }
            HStack {
                Text(secondLabel)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(secondPrice)원")
            }
        }
        .font(.footnote)
    }
    
    @ViewBuilder func selectedHeaderRateRow(volumeLabel: String, volume: Int, rateLabel: String, rate: Float) -> some View {
        HStack(spacing: 32) {
            HStack {
                Text(volumeLabel)
                    .foregroundColor(.gray)
                Spacer()
                if volume > 10000 {
                    Text("\(String(format: "%.1f", Float(volume / 10000)))억 주")
                } else if volume == 10000 {
                    Text("\(volume / 10000)억 주")
                } else {
                    Text("\(volume)만 주")
                }
            }
            HStack {
                Text(rateLabel)
                    .foregroundColor(.gray)
                Spacer()
                if rate != 0 {
                    Text("\(rate < 0 ? "" : "+")" + "\(String(format: "%.1f", rate))%")
                        .foregroundColor(rate < 0 ? .blue : .red)
                } else {
                    Text("0.0%")
                        .foregroundColor(.gray)
                }
            }
        }
        .font(.footnote)
    }
    
    @ViewBuilder var stockChart: some View {
        Chart(samsungStock) { stock in
            // 내 주식 평균
            RuleMark(
                y: .value("Average", myStockAverage)
            )
            .foregroundStyle(Color(UIColor.systemGray5))
            .lineStyle(StrokeStyle(lineWidth: 1))
            .blendMode(.darken)
            .annotation(alignment: .leading) {
                Text("내 주식 평균")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background {
                        ZStack {
                            Capsule().fill(Color(UIColor.systemBackground))
                            Capsule()
                                .stroke()
                                .foregroundColor(Color(UIColor.systemGray5))
                        }
                    }
                    .offset(y: 15)
                    .opacity(selectedElement == nil ? 1 : 0)
            }
            // 최대가격, 최저가격
            BarMark(
                x: .value("Day", stock.date),
                yStart: .value("Price", stock.minPrice),
                yEnd: .value("Price", stock.maxPrice),
                width: .fixed(0.5)
            )
            .foregroundStyle(Color.gray)
            // 시가, 종가
            if stock.startPrice != stock.finalPrice {
                BarMark(
                    x: .value("Day", stock.date),
                    yStart: .value("Price", stock.startPrice),
                    yEnd: .value("Price", stock.finalPrice),
                    width: .fixed(5)
                )
                .foregroundStyle(stock.startPrice < stock.finalPrice ? Color.red : Color.blue)
                .cornerRadius(1.5)
            } else { // 시가 == 종가
                RectangleMark(
                    x: .value("Day", stock.date),
                    y: .value("Price", stock.startPrice),
                    width: 5,
                    height: 0.5
                )
                .foregroundStyle(Color.gray)
            }
            // 1년중 최대, 최저
            if stock.date == maxPriceSortedData.first?.date ?? Date() {
                PointMark(
                    x: .value("Day", stock.date),
                    y: .value("MaxPrice", stock.maxPrice)
                )
                .foregroundStyle(Color.gray)
                .symbolSize(10)
                .opacity(selectedElement == nil ? 1 : 0)
            }
            if stock.date == minPriceSortedData.first?.date ?? Date() {
                PointMark(
                    x: .value("Day", stock.date),
                    y: .value("MinPrice", stock.minPrice)
                )
                .foregroundStyle(Color.gray)
                .symbolSize(10)
                .opacity(selectedElement == nil ? 1 : 0)
            }
        }
        .chartYScale(domain: minPriceSortedData[0].minPrice ... maxPriceSortedData[0].maxPrice)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartOverlay { proxy in
            GeometryReader { nthGeometryItem in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                selectedElement = findElement(location: value.location, proxy: proxy, geometry: nthGeometryItem)
                            }
                            .onEnded { _ in
                                selectedElement = nil
                            }
                    )
            }
        }
        .chartOverlay { proxy in
            ZStack {
                GeometryReader { nthGeoItem in
                    if let selectedElement {
                        let dateInterval = Calendar.current.dateInterval(of: .day, for: selectedElement.date)! // 현재 선택된 날짜의 dateInterval 값 저장
                        let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0 // 현재 선택된 날짜 간격의 시작 TimeInterval
                        let startPositionX2 = proxy.position(forX: dateInterval.end) ?? 0 // 현재 선택된 날짜 간격의 끝 TimeInterval
                        let midStartPositionX = (startPositionX1 + startPositionX2) / 2 // 현재 선택된 날짜 간격의 중앙

                        let lineX = midStartPositionX - 0.5 // 선이 놓일 X 좌표
                        let lineY = nthGeoItem[proxy.plotAreaFrame].midY // 선이 놓일 Y 좌표
                        
//                        let textOffset: CGFloat = 0 // GeometryReader의 특성상 좌상단에 정렬됨. 따라서 offset을 안 주면 맨 왼쪽에 붙음
//                        let textOffset: CGFloat = nthGeoItem.size.width - selectedDateTextWidth // 맨 오른쪽에 붙음
//                        let textOffset: CGFloat = lineX - selectedDateTextWidth / 2 // 컨텐츠 너비의 절반만큼 선의 x 좌표에서 offset을 주면 중앙 정렬됨
//                        let textOffset: CGFloat = min(nthGeoItem.size.width - selectedDateTextWidth, lineX - selectedDateTextWidth / 2) // 선의 중앙이 맨 오른쪽에 붙었을 때의 x좌표보다 멀리 갈 경우 오른쪽에 붙게 만듦
                        let textOffset = max(0, min(nthGeoItem.size.width - selectedDateTextWidth, lineX - selectedDateTextWidth / 2)) // 선의 중앙이 맨 왼쪽에 붙었을 떄의 x좌표보다 가까울 경우 왼쪽에 붙게 만듦
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1, height: proxy.plotAreaSize.height + 70)
                            .offset(y: 10)
                            .position(x: lineX, y: lineY)
                        
                        Text("\(dateConverting(date: selectedElement.date))")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .offset(x: textOffset, y: -45)
                            .readSize { size in
                                selectedDateTextWidth = size.width
                            }
                    }
                }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { chartFrame in
                let dateInterval = Calendar.current.dateInterval(of: .day, for: maxPriceSortedData.first?.date ?? Date())!
                let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
                let startPositionX2 = proxy.position(forX: dateInterval.end) ?? 0
                let midStartPositionX = (startPositionX1 + startPositionX2) / 2
                
                let textOffset = max(0, min(chartFrame.size.width - yearMaxPriceTextWidth, midStartPositionX - yearMaxPriceTextWidth / 2))
                
                Text("최고 \(maxPriceSortedData.first?.maxPrice ?? 0)원")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .opacity(selectedElement == nil ? 1 : 0)
                    .offset(x: textOffset, y: -yearMaxPriceTextHeight - 5)
                    .readSize { size in
                        yearMaxPriceTextWidth = size.width
                        yearMaxPriceTextHeight = size.height
                    }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { chartFrame in
                let dateInterval = Calendar.current.dateInterval(of: .day, for: minPriceSortedData.first?.date ?? Date())!
                let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
                let startPositionX2 = proxy.position(forX: dateInterval.end) ?? 0
                let midStartPositionX = (startPositionX1 + startPositionX2) / 2
                
                let textOffset = max(0, min(chartFrame.size.width - yearMaxPriceTextWidth, midStartPositionX - yearMaxPriceTextWidth / 2))
                let textVerticalOffset = chartFrame.size.height + 5
                
                Text("최저 \(minPriceSortedData.first?.minPrice ?? 0)원")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .opacity(selectedElement == nil ? 1 : 0)
                    .offset(x: textOffset, y: textVerticalOffset)
                    .readSize { size in
                        yearMinPriceTextWidth = size.width
                        yearMinPriceTextHeight = size.height
                    }
            }
        }
    }
    
    @ViewBuilder var volumeChart: some View {
        Chart(samsungStock) { stock in
            BarMark(
                x: .value("Date", stock.date),
                y: .value("Volume", stock.volume),
                width: .fixed(5)
            )
            .foregroundStyle(Color.gray.opacity(0.4))
            .cornerRadius(1.5)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(height: 20)
    }
    
    @ViewBuilder var periodSegmentedControl: some View {
        HStack {
            Text("1일")
                .foregroundColor(.gray)
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 12).fill(.white)
                        .opacity(0)
                }
            Text("1주")
                .foregroundColor(.gray)
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 12).fill(.white)
                        .opacity(0)
                }
            Text("3달")
                .foregroundColor(.gray)
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 12).fill(.white)
                        .opacity(0)
                }
            Text("1년")
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 12).fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 2, y: 2)
                }
            Text("5년")
                .foregroundColor(.gray)
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 12).fill(.white)
                        .opacity(0)
                }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.05))
        }
    }
}

// MARK: - Method

private extension TossChart {
    func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> Stock? {
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x // plotArea의 원점 대비 현재의 x 좌표
        if let date = proxy.value(atX: relativeXPosition) as Date? { // proxy를 이용하여 현재의 x좌표(atX 파라미터)의 x축 차트 데이터(시간)를 받아온다
            var minDistance: TimeInterval = .infinity // 초기값으로 무한대를 줘서 nthSalesDataDistance에 값이 들어오면 abs(nthSalesDataDistance) < minDistance가 무조건 true가 나오게 함
            var index: Int? = nil
            for stockDataIndex in samsungStock.indices { // samsungStock의 모든 인덱스에 대해 체크
                let nthSalesDataDistance = samsungStock[stockDataIndex].date.distance(to: date)
                if abs(nthSalesDataDistance) < minDistance {
                    minDistance = abs(nthSalesDataDistance) // 모든 인덱스에 대해 체크하여 가장 거리가 가까운 날짜를 찾는다.
                    index = stockDataIndex
                }
            }
            if let index = index {
                return samsungStock[index]
            }
        }
        return nil
    }
    
    func dateConverting(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.M.d"
        
        return dateFormatter.string(from: date)
    }
}

// MARK: - Preview

struct TossChart_Previews: PreviewProvider {
    static var previews: some View {
        TossChart()
    }
}
