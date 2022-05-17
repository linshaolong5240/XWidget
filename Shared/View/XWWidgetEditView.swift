//
//  XWWidgetEditView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import Combine
import WidgetKit

enum XWWidgetEditSaveMode {
    case save
    case update
}

class XWWidgetEditViewModel: ObservableObject {
    @Published var widget: XWWidgetEntry
    @Published var family: WidgetFamily
    private let saveMode: XWWidgetEditSaveMode

    init(entry: XWWidgetEntry, family: WidgetFamily, saveMode: XWWidgetEditSaveMode) {
        self.widget = entry
        self.family = family
        self.saveMode = saveMode
    }
    
    func save() {
        switch saveMode {
        case .save:
            saveWidget()
        case .update:
            updateWidget()
        }
    }
    
    func saveWidget() {
        Store.shared.dispatch(.saveWidget(widget: widget, family: family))
    }
    
    func updateWidget() {
        Store.shared.dispatch(.updateWidget(widget: widget, family: family))
    }
}

struct XWWidgetEditView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel: XWWidgetEditViewModel
    
    init(widget: Binding<XWWidgetEntry>, family: WidgetFamily, saveMode: XWWidgetEditSaveMode) {
        self.viewModel = XWWidgetEditViewModel(entry: widget.wrappedValue, family: family, saveMode: saveMode)
    }

    var body: some View {
        VStack {
            XWAnyWidgeView(entry: $viewModel.widget, family: viewModel.family, isEditing: true)
                .modifier(WidgetPreviewModifier(family: viewModel.family))
            ScrollView {
                XWWidgetModelEditer(widget: $viewModel.widget, family: viewModel.family)
                XWWidgetThemeEditer(theme: $viewModel.widget.theme, family: viewModel.family)
            }
            Button {
                viewModel.save()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Capsule()
                    .frame(height: 44)
                    .padding()
                    .overlay(
                        Text("Save")
                            .foregroundColor(.white)
                    )
            }
        }
        .navigationTitle(LocalizedStringKey(viewModel.widget.kind.name))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
struct XWWidgetEditViewDemo: View {
    @State private var widget: XWWidgetEntry = .checkin_plain
    var body: some View {
        XWWidgetEditView(widget: $widget, family: .systemSmall, saveMode: .save)
    }
}

struct XWWidgetEditView_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetEditViewDemo()
    }
}
#endif
