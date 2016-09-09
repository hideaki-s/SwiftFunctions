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

		let button = UIButton(frame: CGRect(x: 10, y: 10, width: 160, height: 50))
		button.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
		button.setTitle("OpenSafari", forState: .Normal)
		button.addTarget(self, action: #selector(self.openSafari), forControlEvents: .TouchUpInside)
		button.setTitleColor(UIColor.blackColor(), forState: .Normal)
		button.backgroundColor = UIColor.lightGrayColor()
		button.layer.cornerRadius = 9
		self.view.addSubview(button)

	}

	override func viewWillAppear(animated: Bool) {
		Log_method()
		super.viewWillAppear(animated)
	}

	override func viewDidAppear(animated: Bool) {
		Log_method()
		super.viewDidAppear(animated)
	}

	override func viewWillDisappear(animated: Bool) {
		Log_method()
		super.viewWillDisappear(animated)
	}

	override func viewDidDisappear(animated: Bool) {
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
			let _url:NSURL = NSURL(string: urlString)!
			let _brow = SFSafariViewController(URL: _url, entersReaderIfAvailable: true)
			presentViewController(_brow, animated: true, completion: nil)
			_brow.delegate = self
		} else {
			// Fallback on earlier versions
			let _alert = UIAlertView()
			_alert.title = "SFSafariViewController is iOS9 over."
			_alert.addButtonWithTitle("OK")
			_alert.show()
		}
	}

	// SafariViewController Delegate Method
	@available(iOS 9.0, *)
	func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
		Log_method()
	}

	@available(iOS 9.0, *)
	func safariViewControllerDidFinish(controller: SFSafariViewController) {
		Log_method()
	}
}

