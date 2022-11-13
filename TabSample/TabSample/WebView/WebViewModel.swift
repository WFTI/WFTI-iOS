//
//  WebViewModel.swift
//  WebViewSample
//
//  Created by yeongbin ro on 2022/10/31.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
    var url: String = ""
}
