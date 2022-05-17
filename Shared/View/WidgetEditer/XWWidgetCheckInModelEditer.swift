//
//  XWWidgetCheckInModelEditer.swift
//  XWidget
//
//  Created by teenloong on 2022/5/17.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

struct XWWidgetCheckInModelEditer: View {
    @Binding var checkInModel: XWCheckInModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            let grayColor: Color = .uicontrolGray
            let tintColor: Color = .secondaryTint
            Text("Check In Name")
            Capsule().fill(grayColor)
                .frame(height: 32)
                .overlay(
                    TextField("", text: $checkInModel.title)
                        .padding(.horizontal)
                )
            Group {
                HStack {
                    Text("Target number")
                    Spacer()
                    Button(action: {
                        guard checkInModel.targetNumber > 1 else {
                            return
                        }
                        
                        guard checkInModel.targetNumber > checkInModel.currentNumber else {
                            return
                        }
                        
                        checkInModel.targetNumber -= 1
                    }) {
                        makeButtonBackgorund(color: grayColor)
                            .overlay(
                                Image(systemName: "minus")
                                    .foregroundColor(Color.black)
                            )
                    }
                    Text("\(checkInModel.targetNumber)")
                    Button(action: {
                        checkInModel.targetNumber += 1
                    }) {
                        makeButtonBackgorund(color: tintColor)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
                HStack {
                    Text("Current number")
                    Spacer()
                    Button(action: {
                        guard checkInModel.currentNumber > 0 else {
                            return
                        }
                        checkInModel.currentNumber -= 1
                    }) {
                        makeButtonBackgorund(color: grayColor)
                            .overlay(
                                Image(systemName: "minus")
                                    .foregroundColor(Color.black)
                            )
                    }
                    Text("\(checkInModel.currentNumber)")
                    Button(action: {
                        guard checkInModel.currentNumber < checkInModel.targetNumber else {
                            return
                        }
                        checkInModel.currentNumber += 1
                    }) {
                        makeButtonBackgorund(color: tintColor)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)
                            )
                    }
                }
            }
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.mainText)
        }
    }
    
    func makeButtonBackgorund(color: Color) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(color)
            .frame(width: 24, height: 24)
    }
}

#if DEBUG
struct XWWidgetCheckInModelEditerDemo: View {
    @State private var checkInModel: XWCheckInModel = .drinkWater
    var body: some View {
        XWWidgetCheckInModelEditer(checkInModel: $checkInModel)
    }
}

struct XWWidgetCheckInModelEditer_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetCheckInModelEditerDemo()
    }
}
#endif
