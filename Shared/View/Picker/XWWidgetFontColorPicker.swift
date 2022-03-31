//
//  XWWidgetFontColorPicker.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

extension XWWidgetColor {
    static let item0: XWWidgetColor = .init(Color(#colorLiteral(red: 0.9523916841, green: 0.9490478635, blue: 0.9488548636, alpha: 1)))
    static let item1: XWWidgetColor = .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    static let item2: XWWidgetColor = .init(Color(#colorLiteral(red: 1, green: 0.8584260941, blue: 0.3759346902, alpha: 1)))
    static let item3: XWWidgetColor = .init(Color(#colorLiteral(red: 1, green: 0.5847858787, blue: 0.5910910964, alpha: 1)))
    static let item4: XWWidgetColor = .init(Color(#colorLiteral(red: 0.6862745098, green: 0.612534523, blue: 0.9985938668, alpha: 1)))
    static let item5: XWWidgetColor = .init(Color(#colorLiteral(red: 1, green: 0.5937828422, blue: 0.4326036572, alpha: 1)))
}

extension Array where Element == XWWidgetColor {
    static let editItems: [XWWidgetColor] = [.item0, .item1, .item2, .item3, .item4, .item5]
}

struct XWWidgetFontColorPicker: View {
    @Binding var selection: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Font Color")
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ColorPicker("Color Picker", selection: $selection)
                        .labelsHidden()
                        .frame(width: 44, height: 44)
                    ForEach(Array(zip([XWWidgetColor].editItems.indices, [XWWidgetColor].editItems)), id: \.0) { index, item in
                        Button {
                            selection = item.color
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(item.color)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black.opacity(index == 0 ? 1 : 0))
                                )
                                .overlay(
                                    VStack {
                                        if item.color == selection {
                                            Image(systemName: "checkmark")
                                        } else {
                                            EmptyView()
                                        }
                                    }
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#if DEBUG
struct XWWidgetFontColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetFontColorPicker(selection: .constant(.orange))
    }
}
#endif
