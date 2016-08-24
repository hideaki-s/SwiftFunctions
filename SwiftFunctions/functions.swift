//
//  functions.swift
//  SwiftFunctions
//
//  Created by Suzuki Hideaki on 2016/08/24.
//  Copyright © 2016年 Suzuki Hideaki. All rights reserved.
//

import Foundation
import UIKit

// print customize
public func print(value:Any){
	#if DEBUG
		var message = ""
		for element in value {
			var eachMessage = "\(element)"
			let pattern = "Optional\\((.+)\\)"
			eachMessage = eachMessage
				.stringByReplacingOccurrencesOfString(pattern,
				                                      withString:"$1",
				                                      options:.RegularExpressionSearch,
				                                      range: nil)
			message += eachMessage
		}
		Swift.print(message)
	#endif
}

// original log output
public func Log(message: String,
                function: String = #function,
                file: String = #file,
                line: Int = #line) {
	#if DEBUG
		let now = NSDate() // 現在日時の取得
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
		dateFormatter.timeStyle = .MediumStyle
		dateFormatter.dateStyle = .MediumStyle
		let now_time = dateFormatter.stringFromDate(now)

		print("[",now_time,"] \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
	#endif
}
