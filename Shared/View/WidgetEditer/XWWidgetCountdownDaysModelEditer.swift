//
//  XWWidgetCountdownDaysModelEditer.swift
//  XWidget
//
//  Created by teenloong on 2022/5/11.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

struct XWWidgetCountdownDaysModelEditer: View {
    @Binding var countdownDaysModel: XWCountdownDaysModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title")
                TextField("Title", text: $countdownDaysModel.title)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .foregroundColor(.textFieldBackground)
                    )
            }
            HStack {
                DatePicker(selection: $countdownDaysModel.targetDate, displayedComponents: [.date], label: { Text("Target Date") })
            }
        }
    }
}

#if DEBUG
struct XWWidgetCountdownDaysModelEditerDemo: View {
    @State private var countdownDaysModel: XWCountdownDaysModel = .memorialDay
    var body: some View {
        XWWidgetCountdownDaysModelEditer(countdownDaysModel: $countdownDaysModel)
    }
}
struct CWWidgetCountdownModelEditer_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetCountdownDaysModelEditerDemo()
    }
}
#endif
    
