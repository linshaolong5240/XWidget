//
//  XWWidgetBackgroundPicker.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit
import PhotosUI

extension XWWidgetBackground {
    static let item0: XWWidgetBackground = .init(.white)
    static let item1: XWWidgetBackground = .init(.black)
    static let item2: XWWidgetBackground = .init([Color(#colorLiteral(red: 0.8498876691, green: 0.7586856484, blue: 0.9849614501, alpha: 1)), Color(#colorLiteral(red: 0.6282964945, green: 0.7861559987, blue: 0.9820603728, alpha: 1))])
    static let item3: XWWidgetBackground = .init([Color(#colorLiteral(red: 0.9137254902, green: 0.5607843137, blue: 0.6196078431, alpha: 1)), Color(#colorLiteral(red: 0.937254902, green: 0.6156862745, blue: 0.5647058824, alpha: 1))])
    static let item4: XWWidgetBackground = .init([Color(#colorLiteral(red: 0.3215686275, green: 0.7058823529, blue: 0.6862745098, alpha: 1)), Color(#colorLiteral(red: 0.2784313725, green: 0.5294117647, blue: 0.5647058824, alpha: 1))])
    static let item5: XWWidgetBackground = .init([Color(#colorLiteral(red: 0.5098039216, green: 1, blue: 0.9647058824, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.631372549, blue: 0.7803921569, alpha: 1))])
}

extension Array where Element == XWWidgetBackground {
    static let editItems: [XWWidgetBackground] = [.item0, .item1, .item2, .item3, .item4, .item5]
}

extension XWWidgetBackground {
    func makeEditItemView(_ family: WidgetFamily) -> some View {
        makeView(family, colorScheme: .light)
            .frame(width: 44, height: 44)
            .mask(RoundedRectangle(cornerRadius: 10))
            .overlay(
                VStack {
                    if self == .item0 {
                        RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 2)
                    }else {
                        EmptyView()
                    }
                }
            )
    }
}

struct XWWidgetBackgroundPicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var uiImage: CrossImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false
    
    @State private var showTransparentBackgroundPicker: Bool = false
    @State private var showScreenShotSetting: Bool = false

    @Binding var selection: XWWidgetBackground
    let data: [XWWidgetBackground]
    let family: WidgetFamily
    
    var body: some View {
        ZStack {
#if canImport(UIKit)
            NavigationLink(isActive: $showScreenShotSetting) {
                XWWidgetTransparentSettingView()
            } label: {
                EmptyView()
            }
#endif
            VStack(alignment: .leading) {
                Text("Background")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            showImagePicker = true
                        }) {
                            VStack {
                                if let image = selection.imageURL?.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 44, height: 44)
                                        .mask(RoundedRectangle(cornerRadius: 10))
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                    //                            .aspectRatio(contentMode: .fit)
                                        .frame(width: 44, height: 44)
                                }
                            }
                        }
                        .onChange(of: uiImage) { newValue in
                            guard let image = newValue else { return }
                            let resizeImage = image.crop(ratio: family.ratio).resize(CGSize(width: family.miniSize.width * 0.5, height: family.miniSize.height * 0.5))
                            do {
                                if let imageURL = try FileManager.save(image: resizeImage) {
                                    selection = .init(imageURL: imageURL)
#if DEBUG
                                    print(imageURL)
#endif
                                }
                            }catch let error {
#if DEBUG
                                print(error)
#endif
                            }
                        }
                        
                        Button {
                            if Store.shared.appState.widget.widgetTransparentConfiguration.isEmpty {
                                showScreenShotSetting.toggle()
                            } else {
                                showTransparentBackgroundPicker.toggle()
                            }
                        } label: {
                            Text("Transparent Background")
                                .lineLimit(2)
                                .minimumScaleFactor(0.1)
                                .frame(width: 44, height: 44)
                                .background(Color.pink.cornerRadius(10))
                        }
                        
                        ForEach(Array(zip(data.indices, data)), id: \.0) { index, item in
                            Button(action: {
                                selection = item
                            }) {
                                item.makeEditItemView(.systemSmall)
                                    .overlay(
                                        VStack {
                                            if item == selection {
                                                Image(systemName: "checkmark")
                                            }else {
                                                EmptyView()
                                            }
                                        }
                                    )
                            }
                        }
                    }
                }
#if canImport(UIKit)
                if showTransparentBackgroundPicker {
                    ScrollView(.horizontal, showsIndicators: false) {
                        makeWidgetPositionItemsView(family: family)
                    }
                }
                #if false
                ForEach(getPostionItems(family: family)) { item in
                    ZStack {
                        if let imageName = Store.shared.appState.widget.widgetTransparentConfiguration.image(position: item, colorScheme: colorScheme) {
                            Image(uiImage: imageName)
                                .resizable()
                        }
                        Text(item.name)
                    }
                    .frame(width: family.size.width, height: family.size.height)
                }
                #endif
#endif
            }
            .alert(isPresented: $showAuthorization, content: { .photoLibraryAuthorization })
#if canImport(UIKit)
            .fullScreenCover(isPresented: $showImagePicker) {
                ImagePicker(uiimage: $uiImage)
            }
#endif
        }
    }
    
    func showPicker() {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        guard authorizationStatus != .denied && authorizationStatus != .restricted else {
            showAuthorization = true
            return
        }
        
        if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                showImagePicker = true
            }
        } else {
            showImagePicker = true
        }
    }
#if canImport(UIKit)
    func getPostionItems(family: WidgetFamily) -> [WidgetPosition] {
        switch family {
        case .systemSmall:
            return .smallItems
        case .systemMedium:
            return .mediumItems
        case .systemLarge:
            return .largeItems
        default:
            return []
        }
    }
    
    func makeWidgetPositionItemsView(family: WidgetFamily) -> some View {
        return HStack {
            let items = getPostionItems(family: family)
            Button {
                showScreenShotSetting.toggle()
            } label: {
                Text("Set Screen Shot")
            }

            ForEach(items) { item in
                VStack(alignment: .leading) {
                    if let lightImageURL = Store.shared.appState.widget.widgetTransparentConfiguration.lightWidgetPostionImageURLDict[item] {
                        if let uiImage = UIImage(contentsOfFile: lightImageURL.path) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 44)
                        }
                    }
                    Text(item.name)
                }
                .onTapGesture {
                    if let lightImageURL = Store.shared.appState.widget.widgetTransparentConfiguration.lightWidgetPostionImageURLDict[item] {
                        let darkImageURL = Store.shared.appState.widget.widgetTransparentConfiguration.darkWidgetPostionImageURLDict[item]
                        selection = XWWidgetBackground(transparent: (lightImageURL: lightImageURL, darkImageURL: darkImageURL ?? lightImageURL))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
#endif
}

#if DEBUG
struct XWWidgetBackgroundPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            XWWidgetBackgroundPicker(selection: .constant(.item0), data: .editItems, family: .systemSmall)
        }
        .environmentObject(Store.shared)
    }
}
#endif
