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



// ------------------------------------------------------------------------------
// NSObject Class Extension
// ------------------------------------------------------------------------------
extension NSObject {
	// クラス名の取得
	class var className: String {
		return String(describing: self)
	}

	var className: String {
		return type(of: self).className
	}
}
// ------------------------------------------------------------------------------
// UIView Class Extension
// ------------------------------------------------------------------------------
extension UIView {
	// 子Viewを全て削除
	func removeAllSubviews() {
		subviews.forEach {
			$0.removeFromSuperview()
		}
	}
	// UIViewのスクショを撮る
	func screenShot(width: CGFloat) -> UIImage? {
		let imageBounds = CGRect(x: 0, y: 0, width: width, height: bounds.size.height * (width / bounds.size.width))

		UIGraphicsBeginImageContextWithOptions(imageBounds.size, true, 0)

		drawHierarchy(in: imageBounds, afterScreenUpdates: true)

		var image: UIImage?
		let contextImage = UIGraphicsGetImageFromCurrentImageContext()

		if let contextImage = contextImage, let cgImage = contextImage.cgImage {
			image = UIImage(
				cgImage: cgImage,
				scale: UIScreen.main.scale,
				orientation: contextImage.imageOrientation
			)
		}

		UIGraphicsEndImageContext()

		return image
	}
}
// ------------------------------------------------------------------------------
// String Class Extension
// ------------------------------------------------------------------------------
extension String {
	// NSLocalizedStringを使いやすくする
	var localized: String {
		return NSLocalizedString(self, comment: self)
	}
	func localized(withTableName tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "") -> String {
		return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: self)
	}
	// 文字列からURLを作成
	var url: URL? {
		return URL(string: self)
	}
	// String型からNSDate型に変換
	func toDate(format:String, localeIdentifier:String = "ja_JP") -> NSDate? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = NSLocale(localeIdentifier: localeIdentifier) as Locale!
		let date = formatter.date(from: self)
		return date as NSDate?
	}
	// String型からDate型に変換
	func toDate(format:String, localeIdentifier:String = "ja_JP") -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = NSLocale(localeIdentifier: localeIdentifier) as Locale!
		let date = formatter.date(from: self)
		return date as Date?
	}
}
// ------------------------------------------------------------------------------
// UINavigationBar Class Extension
// ------------------------------------------------------------------------------
extension UINavigationBar {
	// ナビゲーションバーの下線を変更する
	func setBottomBorderColor(color: UIColor, height: CGFloat) {
		let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
		let bottomBorderView = UIView(frame: bottomBorderRect)
		bottomBorderView.backgroundColor = color
		addSubview(bottomBorderView)
	}
}
// ------------------------------------------------------------------------------
// Array Class Extension
// ------------------------------------------------------------------------------
extension Array where Element: Equatable {
	// 配列でオブジェクトのインスタンスを検索して削除
	@discardableResult
	mutating func remove(element: Element) -> Bool {
		guard let index = index(of: element) else { return false }
		remove(at: index)
		return true
	}
	mutating func remove(elements: [Element]) {
		for element in elements {
			remove(element: element)
		}
	}
}
// ------------------------------------------------------------------------------
// UIImage Class Extension
// ------------------------------------------------------------------------------
extension UIImage {
	// 色からイメージを生成
	static func fromColor(color: UIColor) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		context!.setFillColor(color.cgColor)
		context!.fill(rect)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return img!
	}
	// イメージサイズを変更
	func scaleImageToSize(newSize: CGSize) -> UIImage {
		var scaledImageRect = CGRect.zero

		let aspectWidth = newSize.width / self.size.width
		let aspectheight = newSize.height / self.size.height

		let aspectRatio = max(aspectWidth, aspectheight)

		scaledImageRect.size.width = size.width * aspectRatio;
		scaledImageRect.size.height = size.height * aspectRatio;
		scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
		scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;

		UIGraphicsBeginImageContext(newSize)
		draw(in: scaledImageRect)
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		return scaledImage!
	}
}
// ------------------------------------------------------------------------------
// Collection Class Extension
// ------------------------------------------------------------------------------
extension Collection {
	// Out of Rangeを防いで、要素を取得
	subscript(safe index: Index) -> _Element? {
		return index >= startIndex && index < endIndex ? self[index] : nil
	}
}
// ------------------------------------------------------------------------------
// Comparable Class Extension
// ------------------------------------------------------------------------------
extension Comparable {
	// 指定範囲内に値を収める
	func clamped(min: Self, max: Self) -> Self {
		if self < min {
			return min
		}
		if self > max {
			return max
		}
		return self
	}
}
// ------------------------------------------------------------------------------
// Date Class Extension
// ------------------------------------------------------------------------------
extension Date {
	func toString(format:String, localeIdentifier:String = "ja_JP") -> String? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = NSLocale(localeIdentifier: localeIdentifier) as Locale!
		let dateStr = formatter.string(from: self as Date)
		return dateStr
	}
}
// ------------------------------------------------------------------------------
// NSDate Class Extension
// ------------------------------------------------------------------------------
extension NSDate {
	func toString(format:String, localeIdentifier:String = "ja_JP") -> String? {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		formatter.locale = NSLocale(localeIdentifier: localeIdentifier) as Locale!
		let dateStr = formatter.string(from: self as Date)
		return dateStr
	}
}

// ------------------------------------------------------------------------------
// Other Useful Functions
// ------------------------------------------------------------------------------
// Cache Clear about WebKit
func clearCache() {
	if #available(iOS 9.0, *) {
		let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeLocalStorage, WKWebsiteDataTypeWebSQLDatabases, WKWebsiteDataTypeOfflineWebApplicationCache])
		let date = Date(timeIntervalSince1970: 0)
		WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{
			Log("cache removed.")
		})
	} else {
		var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
		libraryPath += "/Caches"
		do {
			try FileManager.default.removeItem(atPath: libraryPath)
		} catch {
			Log("error")
		}
		URLCache.shared.removeAllCachedResponses()
	}
}
// Getting App Directory Path Full
func getAppDirectryPath() -> Array<String> {
	let path1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as Array<String>
	Log(path1[0])
	return path1
}
// UILabel Class with Padding
class PaddingLabel: UILabel {
	let padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
	override func drawText(in rect: CGRect) {
		let newRect = UIEdgeInsetsInsetRect(rect, padding)
		super.drawText(in: newRect)
	}
	override var intrinsicContentSize : CGSize {
		var intrinsicContentSize = super.intrinsicContentSize
		intrinsicContentSize.height += padding.top + padding.bottom
		intrinsicContentSize.width += padding.left + padding.right
		return intrinsicContentSize
	}
}
// ------------------------------------------------------------------------------
// Loading JSON File
// ------------------------------------------------------------------------------
func loadJsonArray(forFilename fileName: String) -> Array<Any>? {
	if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
		do {
			let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
			do {
				let jsonResult: Array<Any> = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Array<Any>
				return jsonResult
			} catch {}
		} catch {}
	}
	return nil
}

func loadJsonDuctionary(forFilename fileName: String) -> NSDictionary? {
	if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
		do {
			let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
			do {
				let jsonResult:NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
				return jsonResult
			} catch {}
		} catch {}
	}
	return nil
}
// 0000000 -> 0,000,000 *******************************************************
func numWithComma(_ input:Int) -> String{
	let formatter = NumberFormatter()
	formatter.numberStyle = NumberFormatter.Style.decimal
	formatter.groupingSeparator = ","
	formatter.groupingSize = 3
	let str = formatter.string(from: input as NSNumber)!
	return str
}
// Last Day of Month **********************************************************
// 月末の日付を取得
func getLastMonthOfDay() -> Int {
	let cal = Calendar.current
	let date = Date()
	let range = (cal as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
	let max = range.length
	return max
}
// Current Timestamp as String ************************************************
// 現在日時を取得
func getToday() -> Date {
	let formatter = DateFormatter()
	formatter.locale = NSLocale.system
	formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
	let str:String = formatter.string(from: NSDate() as Date)
	let d:Date = formatter.date(from: str)!
	return d
}
func getNowTimeStamp() -> String {
	let now = Date()
	let dateFormatter = DateFormatter()
	dateFormatter.locale = Locale(identifier: "ja_JP")
	dateFormatter.timeStyle = .medium
	dateFormatter.dateStyle = .medium
	let now_time = dateFormatter.string(from: now)
	return now_time
}
// Current Year ***************************************************************
// 現在の年を取得
func getCurrentYear() -> Int {
	var year:Int = 0
	let now = Date()
	let df = DateFormatter()
	df.timeStyle = .short//ここを変更すると出力日付の情報量を変更可能
	df.dateStyle = .short//ここを変更すると出力日付の情報量を変更可能
	df.locale = Locale(identifier: "ja_JP")
	df.dateFormat = "yyyy"
	year = Int(df.string(from: now))!
	return year
}
// Last Year ******************************************************************
// 去年の年を取得
func getLastYear() -> Int {
	let now = Date() //現在時刻
	let df = DateFormatter()
	df.timeStyle = .short
	df.dateStyle = .short
	df.locale = Locale(identifier: "ja_JP")
	df.dateFormat = "yyyy"
	let lastYear:Int = Int(df.string(from: now))! - 1
	return lastYear
}
// ------------------------------------------------------------------------------
// Image Management
// ------------------------------------------------------------------------------
func saveImage (image: UIImage, path: String ) -> Bool{
	// 画像の保存
	let pngImageData = UIImagePNGRepresentation(image)! as NSData
	let result = pngImageData.write(to: URL(string:path)!.absoluteURL, atomically: true)
	return result
}
func getDocumentsURL() -> NSURL {
	// ドキュメントディレクトリの取得
	let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
	return documentsURL as NSURL
}
func fileInDocumentsDirectory(filename: String) -> String {
	// ファイルパスの生成
	let fileURL = getDocumentsURL().appendingPathComponent(filename)
	return fileURL!.path
}
func loadImageFromPath(path: String) -> UIImage? {
	// 画像の読込
	let image = UIImage(contentsOfFile: path)
	if image == nil {
		Log("missing image at: \(path)")
	}
		Log("Loading image from path: \(path)")
	return image
}

// ------------------------------------------------------------------------------
// RandomColor
// ------------------------------------------------------------------------------
// ランダムな色を取得
func getRandomColor() -> UIColor{
	let randomRed:CGFloat = CGFloat(drand48())
	let randomGreen:CGFloat = CGFloat(drand48())
	let randomBlue:CGFloat = CGFloat(drand48())
	return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}

// ------------------------------------------------------------------------------
// HEX Color web like hex color default white
// ------------------------------------------------------------------------------
func hexColor( _ hex:NSString, alpha:Float) -> UIColor {
	let hex = hex.replacingOccurrences(of: "#", with: "")
	let scanner = Scanner(string: hex as String)
	var color: UInt32 = 0
	if ( scanner.scanHexInt32(&color)) {
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
// ------------------------------------------------------------------------------
// Preset Colors Without Alpha
// ------------------------------------------------------------------------------
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
// ------------------------------------------------------------------------------
// Preset Colors With Alpha
// ------------------------------------------------------------------------------
func tuquise(_ alpha:Float) -> UIColor { return hexColor("#1abc9c", alpha: alpha) }
func green_sea(_ alpha:Float) -> UIColor { return hexColor("#16a085", alpha: alpha) }
func emerald(_ alpha:Float) -> UIColor { return hexColor("#2ecc71", alpha: alpha) }
func nephritis(_ alpha:Float) -> UIColor { return hexColor("#27ae60", alpha: alpha) }
func peter_river(_ alpha:Float) -> UIColor { return hexColor("#3498db", alpha: alpha) }
func belize_hole(_ alpha:Float) -> UIColor { return hexColor("#2980b9", alpha: alpha) }
func amethyst(_ alpha:Float) -> UIColor { return hexColor("#9b59b6", alpha: alpha) }
func wisteria(_ alpha:Float) -> UIColor { return hexColor("#8e44ad", alpha: alpha) }
func wet_asphalt(_ alpha:Float) -> UIColor { return hexColor("#34495e", alpha: alpha) }
func midnight_blue(_ alpha:Float) -> UIColor { return hexColor("#2c3e50", alpha: alpha) }
func sun_flower(_ alpha:Float) -> UIColor { return hexColor("#f1c40f", alpha: alpha) }
func orange(_ alpha:Float) -> UIColor { return hexColor("#EF953F", alpha: alpha) }
func carrot(_ alpha:Float) -> UIColor { return hexColor("#e67e22", alpha: alpha) }
func pumpkin(_ alpha:Float) -> UIColor { return hexColor("#d35400", alpha: alpha) }
func alizarin(_ alpha:Float) -> UIColor { return hexColor("#e74c3c", alpha: alpha) }
func pomegranate(_ alpha:Float) -> UIColor { return hexColor("#c0392b", alpha: alpha) }
func clouds(_ alpha:Float) -> UIColor { return hexColor("#ecf0f1", alpha: alpha) }
func silver(_ alpha:Float) -> UIColor { return hexColor("#bdc3c7", alpha: alpha) }
func concrete(_ alpha:Float) -> UIColor { return hexColor("#95a5a6", alpha: alpha) }
func asbesto(_ alpha:Float) -> UIColor { return hexColor("#7f8c8d", alpha: alpha) }
// ------------------------------------------------------------------------------
// original log output
// ------------------------------------------------------------------------------
public func Log_method(_ function: String = #function, file: String = #file, line: Int = #line) {
	#if DEBUG
		let now = NSDate() // 現在日時の取得
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "ja_JP") as Locale!
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .medium
		let now_time = dateFormatter.string(from: now as Date)
		let path:NSString = file as NSString
		print("[\(now_time)] \(path.lastPathComponent), line: \(line) func: \(function)")
	#endif
}
public func Log(_ message: Any?,
                function: String = #function,
                file: String = #file,
                line: Int = #line) {
	#if DEBUG
		let now = NSDate() // 現在日時の取得
		let dateFormatter = DateFormatter()

		let path:NSString = file as NSString


		dateFormatter.locale = Locale(identifier: "ja_JP") as Locale!
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .medium
		let now_time = dateFormatter.string(from: now as Date)

		print("[\(now_time)] \(path.lastPathComponent), line: \(line) func: \(function) : \"\(message.debugDescription)\" ")
	#endif
}
