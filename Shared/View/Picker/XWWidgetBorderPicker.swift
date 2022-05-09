//
//  XWWidgetBorderPicker.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

extension XWWidgetBorder {
    static let item0: XWWidgetBorder = .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
    static let item1: XWWidgetBorder = .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    static let item2: XWWidgetBorder = .init([Color(#colorLiteral(red: 0.8498876691, green: 0.7586856484, blue: 0.9849614501, alpha: 1)), Color(#colorLiteral(red: 0.6282964945, green: 0.7861559987, blue: 0.9820603728, alpha: 1))])
    static let item3: XWWidgetBorder = .init([Color(#colorLiteral(red: 0.9137254902, green: 0.5607843137, blue: 0.6196078431, alpha: 1)), Color(#colorLiteral(red: 0.937254902, green: 0.6156862745, blue: 0.5647058824, alpha: 1))])
    static let item4: XWWidgetBorder = .init([Color(#colorLiteral(red: 0.3215686275, green: 0.7058823529, blue: 0.6862745098, alpha: 1)), Color(#colorLiteral(red: 0.2784313725, green: 0.5294117647, blue: 0.5647058824, alpha: 1))])
    static let item5: XWWidgetBorder = .init([Color(#colorLiteral(red: 0.5098039216, green: 1, blue: 0.9647058824, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.631372549, blue: 0.7803921569, alpha: 1))])
}

extension Array where Element == XWWidgetBorder {
    static var editItems: [XWWidgetBorder] { [.item0, .item1, .item2, .item3, .item4, .item5] }
}

struct XWWidgetBorderPicker: View {
    @Binding var selection: XWWidgetBorder?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Border")
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        selection = nil
                    }) {
                        Image(systemName: "circle.slash")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                    ForEach(Array(zip([XWWidgetBorder].editItems.indices, [XWWidgetBorder].editItems)), id: \.0) { index, item in
                        Button {
                            selection = item
                        } label: {
                            item.makeView(cornerRadius: 10)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    VStack {
                                        if index == 0 {
                                            RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 6).strokeBorder(Color.black).padding(5)
                                                )
                                        } else {
                                            EmptyView()
                                        }
                                    }
                                )
                                .overlay(
                                    VStack {
                                        if item == selection {
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
struct XWWidgetBorderPicker_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetBorderPicker(selection: .constant(nil))
    }
}
#endif
