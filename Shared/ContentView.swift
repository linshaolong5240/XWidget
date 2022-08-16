//
//  ContentView.swift
//  Shared
//
//  Created by teenloong on 2022/3/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            XWWidgetHomeView()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
