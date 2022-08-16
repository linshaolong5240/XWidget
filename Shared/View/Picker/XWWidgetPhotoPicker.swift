//
//  XWWidgetPhotoPicker.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetPhotoPicker: View {
    @Binding var selection: URL?
    let family: WidgetFamily
    
    @State private var uiImage: CrossImage?
    @State private var showImagePicker: Bool = false
    @State private var showAuthorization: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Photo")
            HStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let image = selection?.image {
                        Image(crossImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .mask(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .alert(isPresented: $showAuthorization, content: { .photoLibraryAuthorization })
#if canImport(UIKit)
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(uiimage: $uiImage)
        }
#endif
        .onChange(of: uiImage) { newValue in
            guard let image = newValue else { return }
            guard let resizeImage = image.crop(ratio: family.ratio)?.resize(to: CGSize(width: family.miniSize.width * 0.5, height: family.miniSize.height * 0.5)) else {
                return
            }
            do {
                if let imageURL = try FileManager.save(image: resizeImage) {
                    selection = imageURL
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
    }
}

#if DEBUG
struct XWWidgetPhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetPhotoPicker(selection: .constant(nil), family: .systemSmall)
    }
}
#endif
