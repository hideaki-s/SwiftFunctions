//
//  ViewController.swift
//  SwiftFunctions
//
//  Created by Suzuki Hideaki on 2016/08/24.
//  Copyright © 2016年 Suzuki Hideaki. All rights reserved.
//

import UIKit
import SafariServices

var urlString:String = "https://google.com"

class ViewController: UIViewController, SFSafariViewControllerDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()

		Log_method()
		let button = UIButton(frame: CGRect(x: 10, y: 10, width: 160, height: 50))
		button.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
		button.setTitle("OpenSafari", for: UIControlState())
		button.addTarget(self, action: #selector(self.openSafari), for: .touchUpInside)
		button.setTitleColor(UIColor.black, for: UIControlState())
		button.backgroundColor = UIColor.lightGray
		button.layer.cornerRadius = 9
		self.view.addSubview(button)

		getShareFiles()
	}

	func getShareFiles() {
		let path_s = NSHomeDirectory() + "/Documents"
		let fm:NSArray = try! FileManager().contentsOfDirectory(atPath: path_s) as NSArray

		for i in 0..<fm.count {
			let data:Data = try! NSData(contentsOfFile: "\(path_s)/\(fm[i])") as Data
			Log("\(path_s)/\(fm[i])")

			if ( data.count == 0 ) {
				Log("no data")
			}
			else {
				if let str = NSString(data:data , encoding:String.Encoding.utf8.rawValue) {
					Log("\(data.count):\(str)")
				}
			}
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		Log_method()
		super.viewWillAppear(animated)
	}

	override func viewDidAppear(_ animated: Bool) {
		Log_method()
		super.viewDidAppear(animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		Log_method()
		super.viewWillDisappear(animated)
	}

	override func viewDidDisappear(_ animated: Bool) {
		Log_method()
		super.viewDidDisappear(animated)
	}

	override func didReceiveMemoryWarning() {
		Log_method()
		super.didReceiveMemoryWarning()
	}

	func openSafari() {
		Log_method()
		if #available(iOS 9.0, *) {
			let _url:URL = URL(string: urlString)!
			let _brow = SFSafariViewController(url: _url, entersReaderIfAvailable: true)
			present(_brow, animated: true, completion: nil)
			_brow.delegate = self
		} else {
			// Fallback on earlier versions
			let _alert = UIAlertView()
			_alert.title = "SFSafariViewController is iOS9 over."
			_alert.addButton(withTitle: "OK")
			_alert.show()
		}
	}

	// SafariViewController Delegate Method
	@available(iOS 9.0, *)
	func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
		Log_method()
	}

	@available(iOS 9.0, *)
	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		Log_method()
	}
}

