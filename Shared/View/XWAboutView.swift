//
//  XWAboutView.swift
//  XWidget
//
//  Created by teenloong on 2022/5/21.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

struct XWAboutView: View {
    var body: some View {
            Image(uiImage: UIImage(named: "AppIcon60x60") ?? UIImage())
                .cornerRadius(10)
    }
}

#if DEBUG
struct XWAboutView_Previews: PreviewProvider {
    static var previews: some View {
        XWAboutView()
    }
}
#endif
