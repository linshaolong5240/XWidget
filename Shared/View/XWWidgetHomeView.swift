//
//  XWWidgetHomeView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetHomeView: View {
    @EnvironmentObject private var store: Store
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State private var family: WidgetFamily = .systemSmall
    @State private var showMyWidget: Bool = false
    @State private var showWidgetEdit: Bool = false
    @State private var selectedWidget: XWWidgetEntry = .clock_analog_plain
    
    var body: some View {
        ZStack {
            NavigationLink(isActive: $showMyWidget) {
                XWMyWidgetView(family: $family)
            } label: {
                EmptyView()
            }
            NavigationLink(isActive: $showWidgetEdit) {
                XWWidgetEditView(widget: $selectedWidget, family: family, saveMode: .save)
            } label: {
                EmptyView()
            }
            Color.background.ignoresSafeArea()
            VStack {
                XWWidgetFamilyPicker(selection: $family)
                    .overlay(
                        HStack {
                            Spacer()
                            Button {
                                showMyWidget.toggle()
                            } label: {
                                Text("My Widget")
                            }
                        }
                    )
                    .padding(.horizontal)
                ScrollView {
                    ForEach(XWWidgetCategory.allCases) { item in
                        VStack(alignment: .leading) {
                            Text(LocalizedStringKey(item.name))
                                .padding(.horizontal)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(item.getWidget(family: family)) { widget in
                                        XWWidgetInAppPreview(widget: widget, family: family, showName: true)
                                            .onTapGesture {
                                                selectedWidget = widget
                                                showWidgetEdit.toggle()
                                            }
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        #if os(iOS)
        .navigationBarHidden(true)
        #endif
    }
    
    func request() {
//        client.request(action: QWTopCititesAction()) { result in
//            switch result {
//            case .success(let response):
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

#if DEBUG
struct WidgetHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            XWWidgetHomeView()
                .environmentObject(Store.shared)
        }
    }
}
#endif
