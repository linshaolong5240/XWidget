//
//  XWAnalogClockHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

fileprivate extension Date {
    var hourPercent: Double {
        var hour: Double = Double(Calendar.current.component(.hour, from: self))
        hour += self.minutePercent
        return hour / 12.0
    }
    var minutePercent: Double {
        var min = Double(Calendar.current.component(.minute, from: self))
        min += self.secondPercent
        return Double(min) / 60.0
    }
    var secondPercent: Double {
        let sec = Calendar.current.component(.second, from: self)
        return Double(sec) / 60.0
    }
}

@available(iOS 14.0, *)
enum ClockNeedleType {
    case hour
    case minute
    case second
    var name: String { String(describing: self) }
}

@available(iOS 14.0, *)
extension ClockNeedleType {
    func percent(date: Date) -> Double {
        switch self {
        case .hour: return date.hourPercent
        case .minute: return date.minutePercent
        case .second: return date.secondPercent
        }
    }
}

@available(iOS 14.0, *)
struct ClockNeedleView<NeedleView: View>: View {
    private let date: Date
    private let type: ClockNeedleType
    private let content: () -> NeedleView
    
    init (_ date: Date, for type: ClockNeedleType, @ViewBuilder content: @escaping () -> NeedleView) {
        self.date = date
        self.type = type
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let n: Double = type.percent(date: date)
            let minLength = min(geometry.size.width, geometry.size.height)
            let maxLength = max(geometry.size.width, geometry.size.height)
            let yOffset: CGFloat = (maxLength - minLength) / 2.0
            VStack {
                Spacer()
                content()
                Spacer()
                    .frame(height: minLength / 2.0)
            }
            .rotationEffect(Angle(degrees: n * 360))
            .frame(width: minLength, height: minLength, alignment: .center)
            .offset(y: yOffset)
        }
    }
}

@available(iOS 14.0, *)
struct ClockMarkViewStyleConfiguration<Mark: View> {
    let marks: Int
    let origin: Bool
    let content: (Int) -> Mark
}

@available(iOS 14.0, *)
protocol ColckMarkStyle {
    associatedtype Body : View
    associatedtype Mark: View
    @ViewBuilder func makeBody(configuration: Self.Configuration<Mark>) -> Self.Body
    typealias Configuration = ClockMarkViewStyleConfiguration
}

@available(iOS 14.0, *)
struct CircleColckMarkStyle<Mark: View>: ColckMarkStyle {
    func makeBody(configuration: Configuration<Mark>) -> some View {
        return GeometryReader { geometry in
            let marks: Int = configuration.marks
            let minLength = min(geometry.size.width, geometry.size.height)
            let maxLength = max(geometry.size.width, geometry.size.height)
            let yOffset: CGFloat = (maxLength - minLength) / 2.0
            ForEach(0..<marks) { n in
                VStack {
                    if configuration.origin {
                        configuration.content(n)
                            .rotationEffect(-Angle(degrees: Double(n) * 360 / Double(marks)))
                    }else {
                        configuration.content(n)
                    }
                    Spacer()
                }
                .rotationEffect(Angle(degrees: Double(n) * 360 / Double(marks)))
            }
            .frame(width: minLength, height: minLength, alignment: .center)
            .offset(y: yOffset)
        }
    }
}


@available(iOS 14.0, *)
struct ClockMarkView<Mark: View>: View {
    private let configuration: ClockMarkViewStyleConfiguration<Mark>
    
    init(_ marks: Int = 12,
         origin: Bool = false,
         @ViewBuilder content: @escaping (Int) -> Mark) {
        self.configuration = .init(marks: marks, origin: origin, content: content)
    }
    
    var body: some View {
        CircleColckMarkStyle().makeBody(configuration: configuration)
    }
    
    func clockMarkStyle<S: ColckMarkStyle>(_ style: S) -> some View where S.Mark == Mark {
        style.makeBody(configuration: configuration)
    }
}

@available(iOS 14.0, *)
struct ClockNeedleRotationModifier: ViewModifier {
    let date: Date
    let needleType: ClockNeedleType
    
    init(_ date: Date, for needleType: ClockNeedleType) {
        self.date = date
        self.needleType = needleType
    }
    
    func body(content: Content) -> some View {
        let n: Double = needleType.percent(date: date)
        content
            .rotationEffect(Angle(degrees: n * 360))
    }
}
