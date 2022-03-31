//
//  XWCryptoHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import CryptoKit

extension Data {
    func md5() -> String {
        if #available(iOS 13.0, *) {
            let digest = Insecure.MD5.hash(data: self)
            return digest.map { String(format: "%02hhx", $0) }.joined()
        } else {
            return ""
        }
    }
}

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
