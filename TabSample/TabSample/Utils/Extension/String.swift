//
//  String.swift
//  TabSample
//
//  Created by yeongbin ro on 2022/10/29.
//

import Foundation


extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func subString(from: Int, to: Int ) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        let toIndex = self.index(self.startIndex, offsetBy: to)
        let range = fromIndex..<toIndex
        
        return String(self[range])
    }
}
