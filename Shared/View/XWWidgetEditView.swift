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

class WidgetEditViewModel: ObservableObject {
    @Published var entry: XWWidgetEntry
    @Published var family: WidgetFamily
    
    //Edit Items
    @Published var background: XWWidgetBackground
    @Published var border: XWWidgetBorder?
    @Published var fontColor: Color
    
    //Photo Edit
    var showPhotoEdit: Bool = false
    @Published var photoImageURL: URL?
    @Published var photoFrameImageURL: URL?

    init(entry: XWWidgetEntry, family: WidgetFamily) {
        self.entry = entry
        self.family = family
        self.background = entry.theme.background
        self.border = entry.theme.boarder
        self.fontColor = entry.theme.fontColor.color
        
        if entry.kind == .photo {
            self.showPhotoEdit = true
            self.photoImageURL = entry.photoModel?.photoImageURL
            self.photoFrameImageURL = entry.photoModel?.photoFrameImageURL
        }
    }
    
    func set(background: XWWidgetBackground) {
        entry.theme.background = background
    }
    
    func set(border: XWWidgetBorder?) {
        entry.theme.boarder = border
    }
    
    func setFontColor(color: Color) {
        entry.theme.fontColor = .init(color)
    }
    
    func setPhotoImageURL(url: URL?) {
        entry.photoModel = .init(photoImageURL: url, photoFrameImageURL: photoFrameImageURL)
    }
    
    func setPhotoFrameImageURL(url: URL?) {
        entry.photoModel = .init(photoImageURL: photoImageURL, photoFrameImageURL: url)
    }
    
    func saveWidget() {
        Store.shared.dispatch(.saveWidget(configuration: entry, family: family))
    }
    
    func updateWidget() {
        Store.shared.dispatch(.updateWidget(configuration: entry, family: family))
    }
    
    func deleteWidget() {
        Store.shared.dispatch(.deleteWidget(configuration: entry, family: family))
    }
}

struct WidgetEditView: View {
    enum SaveMode {
        case save
        case update
    }
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @ObservedObject private var viewModel: WidgetEditViewModel
    private let saveMode: SaveMode
    
    init(configuration: XWWidgetEntry, family: WidgetFamily, saveMode: SaveMode) {
        self.viewModel = WidgetEditViewModel(entry: configuration, family: family)
        self.saveMode = saveMode
    }

    var body: some View {
        VStack {
            XWWidgetEntryParseView(entry: viewModel.entry, family: viewModel.family)
                .modifier(WidgetPreviewModifier(family: viewModel.family))
            ScrollView {
                XWWidgetFontColorPicker(selection: $viewModel.fontColor)
                    .onChange(of: viewModel.fontColor) { newValue in
                        viewModel.setFontColor(color: newValue)
                    }
                XWWidgetBackgroundPicker(selection: $viewModel.background, data: .editItems, family: viewModel.family)
                .onChange(of: viewModel.background) { newValue in
                    viewModel.set(background: newValue)
                }
                
                XWWidgetBorderPicker(selection: $viewModel.border)
                    .onChange(of: viewModel.border) { newValue in
                        viewModel.set(border: newValue)
                    }
                
                if viewModel.showPhotoEdit {
                    XWWidgetPhotoPicker(selection: $viewModel.photoImageURL, family: viewModel.family)
                        .onChange(of: viewModel.photoImageURL, perform: { newValue in
                            viewModel.setPhotoImageURL(url: newValue)
                        })
                }
            }
            Button {
                switch saveMode {
                case .save:
                    viewModel.saveWidget()
                case .update:
                    viewModel.updateWidget()
                }
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
        .navigationTitle(LocalizedStringKey(viewModel.entry.kind.name))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WidgetEditView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEditView(configuration: .photo_plain, family: .systemSmall, saveMode: .save)
    }
}
