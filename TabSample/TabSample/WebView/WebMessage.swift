//
//  WebMessage.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/11/06.
//

import Foundation


struct WebMessage: Codable {
    let function: String
    let val: Bool
    let msg: String
    let timeStamp: Date
}
