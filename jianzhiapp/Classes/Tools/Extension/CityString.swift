//
//  CityString.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/1.
//  Copyright © 2020 殷义军. All rights reserved.
//

import Foundation
extension String {
    
    func transformToPinYin() -> String {
        
        let mutableString = NSMutableString(string: self)
        //把汉字转为拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //去掉拼音的音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)

        let string = String(mutableString)
        //去掉空格
        return string.replacingOccurrences(of: " ", with: "")
    }
}
