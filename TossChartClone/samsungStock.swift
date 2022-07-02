//
//  samsungStock.swift
//  TossChartClone
//
//  Created by 민채호 on 2022/07/02.
//

import Foundation

struct Stock: Identifiable {
    let date: Date
    let startPrice: Int
    let finalPrice: Int
    let maxPrice: Int
    let minPrice: Int
    let volume: Int
    
    var rate: Float { ((Float(finalPrice) - Float(startPrice)) / Float(startPrice)) * 100 }
    var id: Date { date }
}

func date(year: Int, month: Int, day: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

let samsungStock: [Stock] = [
    .init(date: date(year: 2021, month: 7, day: 2), startPrice: 81700, finalPrice: 80000, maxPrice: 82100, minPrice: 79900, volume: 6274),
    .init(date: date(year: 2021, month: 7, day: 9), startPrice: 80100, finalPrice: 79400, maxPrice: 81300, minPrice: 79000, volume: 7583),
    .init(date: date(year: 2021, month: 7, day: 16), startPrice: 79900, finalPrice: 79800, maxPrice: 79900, minPrice: 78400, volume: 5968),
    .init(date: date(year: 2021, month: 7, day: 23), startPrice: 79100, finalPrice: 79300, maxPrice: 79900, minPrice: 78400, volume: 5968),
    .init(date: date(year: 2021, month: 7, day: 30), startPrice: 79400, finalPrice: 78500, maxPrice: 79500, minPrice: 78100, volume: 6239),
    .init(date: date(year: 2021, month: 8, day: 6), startPrice: 79200, finalPrice: 81500, maxPrice: 83300, minPrice: 78700, volume: 9354),
    .init(date: date(year: 2021, month: 8, day: 13), startPrice: 81500, finalPrice: 74400, maxPrice: 82400, minPrice: 74100, volume: 10000),
    .init(date: date(year: 2021, month: 8, day: 20), startPrice: 74000, finalPrice: 72700, maxPrice: 75100, minPrice: 72500, volume: 10000),
    .init(date: date(year: 2021, month: 8, day: 27), startPrice: 73300, finalPrice: 74300, maxPrice: 76600, minPrice: 73000, volume: 9456),
    .init(date: date(year: 2021, month: 9, day: 3), startPrice: 75400, finalPrice: 76600, maxPrice: 77100, minPrice: 74200, volume: 8087),
    .init(date: date(year: 2021, month: 9, day: 10), startPrice: 76800, finalPrice: 75300, maxPrice: 77600, minPrice: 74800, volume: 6560),
    .init(date: date(year: 2021, month: 9, day: 17), startPrice: 75200, finalPrice: 77200, maxPrice: 77700, minPrice: 75100, volume: 7175),
    .init(date: date(year: 2021, month: 9, day: 24), startPrice: 77500, finalPrice: 77300, maxPrice: 77700, minPrice: 76800, volume: 2930),
    .init(date: date(year: 2021, month: 10, day: 1), startPrice: 77300, finalPrice: 73200, maxPrice: 77800, minPrice: 72900, volume: 8682),
    .init(date: date(year: 2021, month: 10, day: 8), startPrice: 73000, finalPrice: 71500, maxPrice: 73000, minPrice: 71200, volume: 7069),
    .init(date: date(year: 2021, month: 10, day: 15), startPrice: 70700, finalPrice: 70100, maxPrice: 71000, minPrice: 68300, volume: 9274),
    .init(date: date(year: 2021, month: 10, day: 22), startPrice: 70200, finalPrice: 70400, maxPrice: 71000, minPrice: 69200, volume: 5243),
    .init(date: date(year: 2021, month: 10, day: 29), startPrice: 69900, finalPrice: 69800, maxPrice: 72200, minPrice: 69500, volume: 6851),
    .init(date: date(year: 2021, month: 11, day: 5), startPrice: 70200, finalPrice: 70200, maxPrice: 72200, minPrice: 69900, volume: 6557),
    .init(date: date(year: 2021, month: 11, day: 12), startPrice: 70400, finalPrice: 70600, maxPrice: 71000, minPrice: 69600, volume: 5328),
    .init(date: date(year: 2021, month: 11, day: 19), startPrice: 71700, finalPrice: 71200, maxPrice: 72000, minPrice: 70100, volume: 5646),
    .init(date: date(year: 2021, month: 11, day: 26), startPrice: 73300, finalPrice: 72300, maxPrice: 76200, minPrice: 72000, volume: 9074),
    .init(date: date(year: 2021, month: 12, day: 3), startPrice: 71700, finalPrice: 75600, maxPrice: 76000, minPrice: 70500, volume: 10000),
    .init(date: date(year: 2021, month: 12, day: 10), startPrice: 75100, finalPrice: 76900, maxPrice: 78600, minPrice: 74900, volume: 8794),
    .init(date: date(year: 2021, month: 12, day: 17), startPrice: 77200, finalPrice: 78000, maxPrice: 78500, minPrice: 76200, volume: 6070),
    .init(date: date(year: 2021, month: 12, day: 24), startPrice: 77600, finalPrice: 80500, maxPrice: 80800, minPrice: 76800, volume: 6827),
    .init(date: date(year: 2021, month: 12, day: 30), startPrice: 80600, finalPrice: 78300, maxPrice: 80600, minPrice: 78100, volume: 6304),
    .init(date: date(year: 2022, month: 1, day: 7), startPrice: 79400, finalPrice: 78300, maxPrice: 79800, minPrice: 76400, volume: 7949),
    .init(date: date(year: 2022, month: 1, day: 14), startPrice: 78100, finalPrice: 77300, maxPrice: 79600, minPrice: 77100, volume: 5815),
    .init(date: date(year: 2022, month: 1, day: 21), startPrice: 77600, finalPrice: 75600, maxPrice: 77800, minPrice: 74700, volume: 5445),
    .init(date: date(year: 2022, month: 1, day: 28), startPrice: 75400, finalPrice: 73300, maxPrice: 75800, minPrice: 71200, volume: 8807),
    .init(date: date(year: 2022, month: 2, day: 4), startPrice: 74900, finalPrice: 74000, maxPrice: 74900, minPrice: 73300, volume: 3047),
    .init(date: date(year: 2022, month: 2, day: 11), startPrice: 73500, finalPrice: 74900, maxPrice: 75800, minPrice: 72400, volume: 6562),
    .init(date: date(year: 2022, month: 2, day: 18), startPrice: 74400, finalPrice: 74300, maxPrice: 75600, minPrice: 73100, volume: 5780),
    .init(date: date(year: 2022, month: 2, day: 25), startPrice: 73200, finalPrice: 71900, maxPrice: 74300, minPrice: 71300, volume: 6150),
    .init(date: date(year: 2022, month: 3, day: 4), startPrice: 71100, finalPrice: 71500, maxPrice: 73100, minPrice: 71000, volume: 5690),
    .init(date: date(year: 2022, month: 3, day: 11), startPrice: 70000, finalPrice: 70000, maxPrice: 71200, minPrice: 68700, volume: 7139),
    .init(date: date(year: 2022, month: 3, day: 18), startPrice: 70000, finalPrice: 70700, maxPrice: 71800, minPrice: 69500, volume: 6153),
    .init(date: date(year: 2022, month: 3, day: 25), startPrice: 70900, finalPrice: 69800, maxPrice: 71200, minPrice: 69600, volume: 8389),
    .init(date: date(year: 2022, month: 4, day: 1), startPrice: 69500, finalPrice: 69100, maxPrice: 70500, minPrice: 69000, volume: 6740),
    .init(date: date(year: 2022, month: 4, day: 8), startPrice: 68900, finalPrice: 67800, maxPrice: 69600, minPrice: 67700, volume: 7122),
    .init(date: date(year: 2022, month: 4, day: 15), startPrice: 67800, finalPrice: 66600, maxPrice: 69000, minPrice: 66500, volume: 7315),
    .init(date: date(year: 2022, month: 4, day: 22), startPrice: 66500, finalPrice: 67000, maxPrice: 68300, minPrice: 66100, volume: 6441),
    .init(date: date(year: 2022, month: 4, day: 29), startPrice: 66500, finalPrice: 67400, maxPrice: 67600, minPrice: 64500, volume: 8517),
    .init(date: date(year: 2022, month: 5, day: 6), startPrice: 66600, finalPrice: 66500, maxPrice: 68400, minPrice: 66500, volume: 5413),
    .init(date: date(year: 2022, month: 5, day: 13), startPrice: 66300, finalPrice: 66500, maxPrice: 66900, minPrice: 64900, volume: 7239),
    .init(date: date(year: 2022, month: 5, day: 20), startPrice: 67100, finalPrice: 68000, maxPrice: 68700, minPrice: 66100, volume: 7328),
    .init(date: date(year: 2022, month: 5, day: 27), startPrice: 68800, finalPrice: 66500, maxPrice: 68800, minPrice: 65500, volume: 7169),
    .init(date: date(year: 2022, month: 6, day: 3), startPrice: 67500, finalPrice: 66800, maxPrice: 67800, minPrice: 66400, volume: 6180),
    .init(date: date(year: 2022, month: 6, day: 10), startPrice: 66200, finalPrice: 63800, maxPrice: 66400, minPrice: 63800, volume: 7982),
    .init(date: date(year: 2022, month: 6, day: 17), startPrice: 62400, finalPrice: 59800, maxPrice: 62800, minPrice: 59400, volume: 10000),
    .init(date: date(year: 2022, month: 6, day: 24), startPrice: 59800, finalPrice: 58400, maxPrice: 59900, minPrice: 56800, volume: 10000),
    .init(date: date(year: 2022, month: 7, day: 1), startPrice: 59000, finalPrice: 56200, maxPrice: 59900, minPrice: 55900, volume: 8995),
]
