//
//  XWAppError.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

extension Error {
    func asAppError() -> XWAppError {
        self as? XWAppError ?? XWAppError.error(self)
    }
}

enum XWAppError: Error, Identifiable {
    var id: String { localizedDescription }
    case error(Error)
}

extension XWAppError {
    var localizedDescription: String {
        switch self {
        case .error(let error): return "\(error.localizedDescription)"
        }
    }
}



