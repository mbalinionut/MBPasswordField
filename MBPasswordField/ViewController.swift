//
//  ViewController.swift
//  MBPasswordField
//
//  Created by Alin Golumbeanu on 08/11/2017.
//  Copyright © 2017 MingleBit. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	
	@IBOutlet weak var MBPassField: MBPasswordField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		//MBPassField.showButtonImageName = "show.eps"
		
	}
	
	@IBAction func showpass(_ sender: Any) {
		
		print(MBPassField.passwordString)
		print(MBPassField.showButtonImageName)
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

