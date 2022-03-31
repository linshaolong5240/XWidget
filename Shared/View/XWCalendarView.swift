//
//  XWCalendarView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct CalendarWeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let hSpacing: CGFloat?
    let content: (Date) -> DateView

    init(week: Date,
         hSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.hSpacing = hSpacing
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack(spacing: hSpacing) {
            ForEach(days, id: \.self) { date in
                if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                    self.content(date)
                } else {
                    self.content(date).hidden()
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct CalendarMonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let hSpacing: CGFloat?
    let vSpacing: CGFloat?
    let content: (Date) -> DateView

    init(
        month: Date,
        hSpacing: CGFloat? = nil,
        vSpacing: CGFloat? = nil,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.hSpacing = hSpacing
        self.vSpacing = vSpacing
        self.content = content
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    var body: some View {
        VStack(spacing: vSpacing) {
            ForEach(weeks, id: \.self) { week in
                CalendarWeekView(week: week, hSpacing: hSpacing, content: self.content)
            }
        }
    }
}

@available(iOS 14.0, *)
struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    CalendarMonthView(month: month, content: self.content)
                }
            }
        }
    }
}

#if DEBUG
@available(iOS 14.0, *)
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarMonthView(month: Date()) { date in
            Text(String(Calendar.current.component(.day, from: date)))
                //            .frame(width: 40, height: 40, alignment: .center)
                .frame(minWidth: 20, idealWidth: 40, maxWidth: 40, minHeight: 20, idealHeight: 40, maxHeight: 40, alignment: .center)
                .background(
                    Circle()
                        .fill(Calendar.current.isDateInToday(date) ? Color.pink : Color.blue)
                )
                .padding(.vertical, 4)
        }
//        CalendarView(interval: Calendar.current.dateInterval(of: .year, for: Date())!) { date in
//          Text(String(Calendar.current.component(.day, from: date)))
////            .frame(width: 40, height: 40, alignment: .center)
//            .frame(minWidth: 20, idealWidth: 40, maxWidth: 40, minHeight: 20, idealHeight: 40, maxHeight: 40, alignment: .center)
//            .background(Color.blue)
//            .clipShape(Circle())
//            .padding(.vertical, 4)
//        }
    }
}
#endif
