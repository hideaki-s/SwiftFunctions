//
//  functions.swift
//  SwiftFunctions
//
//  Created by Suzuki Hideaki on 2016/08/24.
//  Copyright © 2016年 Suzuki Hideaki. All rights reserved.
//

import Foundation
import UIKit
import WebKit

// Cache Clear about WebKit
func clearCache() {
	if #available(iOS 9.0, *) {
		let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeLocalStorage, WKWebsiteDataTypeWebSQLDatabases, WKWebsiteDataTypeOfflineWebApplicationCache])
		let date = NSDate(timeIntervalSince1970: 0)
		WKWebsiteDataStore.defaultDataStore().removeDataOfTypes(websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{
			Log("cache removed.")
		})
	} else {
		var libraryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, false).first!
		libraryPath += "/Caches"
		do {
			try NSFileManager.defaultManager().removeItemAtPath(libraryPath)
		} catch {
			Log("error")
		}
		NSURLCache.sharedURLCache().removeAllCachedResponses()
	}
}

// Getting App Directory Path Full
func getAppDirectryPath() -> Array<String> {
	let path1 = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as Array<String>
	Log(path1[0])
	return path1
}

// UILabel Class with Padding
class PaddingLabel: UILabel {
	let padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
	override func drawTextInRect(rect: CGRect) {
		let newRect = UIEdgeInsetsInsetRect(rect, padding)
		super.drawTextInRect(newRect)
	}
	override func intrinsicContentSize() -> CGSize {
		var intrinsicContentSize = super.intrinsicContentSize()
		intrinsicContentSize.height += padding.top + padding.bottom
		intrinsicContentSize.width += padding.left + padding.right
		return intrinsicContentSize
	}
}

// 0000000 -> 0,000,000 *******************************************************
func numWithComma(input:Int) -> String{
	let formatter = NSNumberFormatter()
	formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
	formatter.groupingSeparator = ","
	formatter.groupingSize = 3
	return formatter.stringFromNumber(input)!
}

// Last Day of Month **********************************************************
// 月末の日付を取得
func getLastMonthOfDay() -> Int {
	let cal = NSCalendar.currentCalendar()
	let date = NSDate()
	let range = cal.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: date)
	let max = range.length
	return max
}

// Current Timestamp as String ************************************************
// 現在日時を取得
func getNowTimeStamp() -> String {
	let now = NSDate()
	let dateFormatter = NSDateFormatter()
	dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
	dateFormatter.timeStyle = .MediumStyle
	dateFormatter.dateStyle = .MediumStyle
	let now_time = dateFormatter.stringFromDate(now)
	return now_time
}

// Current Year ***************************************************************
// 現在の年を取得
func getCurrentYear() -> Int {
	var year:Int = 0
	let now = NSDate()
	let df = NSDateFormatter()
	df.timeStyle = .ShortStyle//ここを変更すると出力日付の情報量を変更可能
	df.dateStyle = .ShortStyle//ここを変更すると出力日付の情報量を変更可能
	df.locale = NSLocale(localeIdentifier: "ja_JP")
	df.dateFormat = "yyyy"
	year = Int(df.stringFromDate(now))!
	return year
}

// Last Year ******************************************************************
// 去年の年を取得
func getLastYear() -> Int {
	let now = NSDate() //現在時刻
	let df = NSDateFormatter()
	df.timeStyle = .ShortStyle
	df.dateStyle = .ShortStyle
	df.locale = NSLocale(localeIdentifier: "ja_JP")
	df.dateFormat = "yyyy"
	let lastYear:Int = Int(df.stringFromDate(now))! - 1
	return lastYear
}

// RandomColor  ***************************************************************
// ランダムな色を取得
func getRandomColor() -> UIColor{
	let randomRed:CGFloat = CGFloat(drand48())
	let randomGreen:CGFloat = CGFloat(drand48())
	let randomBlue:CGFloat = CGFloat(drand48())
	return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}

// HEX Color web like hex color default white **********************************
func hexColor( hex:NSString, alpha:Float) -> UIColor {
	let hex = hex.stringByReplacingOccurrencesOfString("#", withString: "")
	let scanner = NSScanner(string: hex as String)
	var color: UInt32 = 0
	if ( scanner.scanHexInt(&color)) {
		return UIColor (
			red:CGFloat((color & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((color & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat((color & 0x0000FF)) / 255.0,
			alpha: CGFloat(alpha)
		)
	}
	else {
		return UIColor(white: 1, alpha: 1)
	}
}

// Preset Colors Without Alpha ************************************************
func tuquise() -> UIColor { return hexColor("#1abc9c", alpha: 1) }
func green_sea() -> UIColor { return hexColor("#16a085", alpha: 1) }
func emerald() -> UIColor { return hexColor("#2ecc71", alpha: 1) }
func nephritis() -> UIColor { return hexColor("#27ae60", alpha: 1) }
func peter_river() -> UIColor { return hexColor("#3498db", alpha: 1) }
func belize_hole() -> UIColor { return hexColor("#2980b9", alpha: 1) }
func amethyst() -> UIColor { return hexColor("#9b59b6", alpha: 1) }
func wisteria() -> UIColor { return hexColor("#8e44ad", alpha: 1) }
func wet_asphalt() -> UIColor { return hexColor("#34495e", alpha: 1) }
func midnight_blue() -> UIColor { return hexColor("#2c3e50", alpha: 1) }
func sun_flower() -> UIColor { return hexColor("#f1c40f", alpha: 1) }
func orange() -> UIColor { return hexColor("#EF953F", alpha: 1) }
func carrot() -> UIColor { return hexColor("#e67e22", alpha: 1) }
func pumpkin() -> UIColor { return hexColor("#d35400", alpha: 1) }
func alizarin() -> UIColor { return hexColor("#e74c3c", alpha: 1) }
func pomegranate() -> UIColor { return hexColor("#c0392b", alpha: 1) }
func clouds() -> UIColor { return hexColor("#ecf0f1", alpha: 1) }
func silver() -> UIColor { return hexColor("#bdc3c7", alpha: 1) }
func concrete() -> UIColor { return hexColor("#95a5a6", alpha: 1) }
func asbesto() -> UIColor { return hexColor("#7f8c8d", alpha: 1) }

// Preset Colors With Alpha ***************************************************
func tuquise(alpha:Float) -> UIColor { return hexColor("#1abc9c", alpha: alpha) }
func green_sea(alpha:Float) -> UIColor { return hexColor("#16a085", alpha: alpha) }
func emerald(alpha:Float) -> UIColor { return hexColor("#2ecc71", alpha: alpha) }
func nephritis(alpha:Float) -> UIColor { return hexColor("#27ae60", alpha: alpha) }
func peter_river(alpha:Float) -> UIColor { return hexColor("#3498db", alpha: alpha) }
func belize_hole(alpha:Float) -> UIColor { return hexColor("#2980b9", alpha: alpha) }
func amethyst(alpha:Float) -> UIColor { return hexColor("#9b59b6", alpha: alpha) }
func wisteria(alpha:Float) -> UIColor { return hexColor("#8e44ad", alpha: alpha) }
func wet_asphalt(alpha:Float) -> UIColor { return hexColor("#34495e", alpha: alpha) }
func midnight_blue(alpha:Float) -> UIColor { return hexColor("#2c3e50", alpha: alpha) }
func sun_flower(alpha:Float) -> UIColor { return hexColor("#f1c40f", alpha: alpha) }
func orange(alpha:Float) -> UIColor { return hexColor("#EF953F", alpha: alpha) }
func carrot(alpha:Float) -> UIColor { return hexColor("#e67e22", alpha: alpha) }
func pumpkin(alpha:Float) -> UIColor { return hexColor("#d35400", alpha: alpha) }
func alizarin(alpha:Float) -> UIColor { return hexColor("#e74c3c", alpha: alpha) }
func pomegranate(alpha:Float) -> UIColor { return hexColor("#c0392b", alpha: alpha) }
func clouds(alpha:Float) -> UIColor { return hexColor("#ecf0f1", alpha: alpha) }
func silver(alpha:Float) -> UIColor { return hexColor("#bdc3c7", alpha: alpha) }
func concrete(alpha:Float) -> UIColor { return hexColor("#95a5a6", alpha: alpha) }
func asbesto(alpha:Float) -> UIColor { return hexColor("#7f8c8d", alpha: alpha) }

// original log output ********************************************************
public func Log_method(function: String = #function, file: String = #file, line: Int = #line) {
	#if DEBUG
		let now = NSDate() // 現在日時の取得
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
		dateFormatter.timeStyle = .MediumStyle
		dateFormatter.dateStyle = .MediumStyle
		let now_time = dateFormatter.stringFromDate(now)
		print("[",now_time,"] \(file), Func: \(function), Line: \(line))")
	#endif
}

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

		print("[",now_time,"] \"\(message)\" \(file), Func: \(function), Line: \(line))")
	#endif
}
