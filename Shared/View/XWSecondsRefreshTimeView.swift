//
//  XWSecondsRefreshTimeView.swift
//  XWidget
//
//  Created by teenloong on 2022/5/30.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct XWSecondsRefreshTimeView: View {
    private let date: Date
    
    public init(_ date: Date) {
        self.date = date
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            if let hour = Calendar.current.dateComponents(in: .current, from: date).hour {
                if hour == 0 {
                    Text("00:")
                }
                if hour > 0 && hour < 10 {
                    Text("0")
                }
            }
            Text(Calendar.current.generateSecondsRefreshTimerDate(date: date), style: .timer)
//                .multilineTextAlignment(.center)
        }
    }
    
}

#if DEBUG
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct XWSecondsRefreshTimeView_Previews: PreviewProvider {
    static var previews: some View {
        XWSecondsRefreshTimeView(Date())
            .font(.system(size: 40, weight: .bold).monospacedDigit())
    }
}
#endif
