//
//  MBPasswordField.swift
//  MBPasswordField
//
//  Created by Alin Golumbeanu on 08/11/2017.
//  Copyright © 2017 MingleBit. All rights reserved.
//

import Cocoa

class MBPasswordField: NSView {
	
	public var passwordString: String {
		get{
			return secureTextField.stringValue
		}
		set{
			secureTextField.stringValue = newValue
		}
	}
	
	public var showButtonImageName: String {
		get{
			guard (btnShowPassword.image?.name()) != nil else {
				return ""
			}
			return (btnShowPassword.image?.name())!.rawValue
		}
		set{ // If the given image is nill display quickLookTemplate
			if NSImage(named: NSImage.Name(rawValue: newValue)) != nil {
				btnShowPassword.image = NSImage(named: NSImage.Name(rawValue: newValue))
			}else{
				btnShowPassword.image = NSImage(named: NSImage.Name.quickLookTemplate)
			}
		}
	}
	
	@IBInspectable var imageWidth: CGFloat = 22
	
	@IBInspectable var fontSize: CGFloat = 12.0 {
		didSet {
			textField.needsDisplay = true
			secureTextField.needsDisplay = true
		}
	}
	
	@IBInspectable var backColor: NSColor = NSColor.clear {
		didSet {
			self.layer?.backgroundColor = backColor.cgColor
		}
	}
	
	@IBInspectable var borderWidth: CGFloat = 1 {
		didSet {
			self.layer?.borderWidth = borderWidth
		}
	}
	
	@IBInspectable var borderColor: NSColor = NSColor.lightGray {
		didSet {
			self.layer?.borderColor = borderColor.cgColor
		}
	}
	
	@IBInspectable var cornerRadius: CGFloat = 3 {
		didSet {
			self.layer?.cornerRadius = cornerRadius
		}
	}
	
	private var secureTextField = NSSecureTextField()
	private var textField = NSTextField()
	private var btnShowPassword = NSButton()
	private var secureTextIsShown = true
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.layer?.borderWidth = borderWidth
		self.layer?.borderColor = borderColor.cgColor
		self.layer?.cornerRadius = cornerRadius
		self.layer?.backgroundColor = backColor.cgColor

    }
	
	override func awakeFromNib() {
		drawShowPasswordButton()
		drawTextField()
		drawSecureTextField()
		showSecureTextField()
	}
	
	func drawShowPasswordButton(){
		let rectForShowPassBtn = NSRect(x: Int(self.frame.width - imageWidth - 5), y: Int((self.frame.height - imageWidth)/2), width: Int(imageWidth), height:Int(imageWidth))
		btnShowPassword = NSButton(frame: rectForShowPassBtn)
		btnShowPassword.isBordered = false
		btnShowPassword.setButtonType(.momentaryChange)
		btnShowPassword.imagePosition = .imageOnly
		
		// If an image name is missing then add the quickLookTemplate as image
		if showButtonImageName == "" {
			btnShowPassword.image = NSImage(named: NSImage.Name.quickLookTemplate)
		}
		
		btnShowPassword.imageScaling = .scaleProportionallyDown
		btnShowPassword.target = self
		btnShowPassword.action = #selector(showFieldForMouseAction)
		btnShowPassword.sendAction(on: [.leftMouseUp , .leftMouseDown])
		self.addSubview(btnShowPassword)
	}
	
	@objc func showFieldForMouseAction(){
		textField.stringValue = secureTextField.stringValue
		if secureTextIsShown == true {
			showTextField()
		}else{
			showSecureTextField()
		}
	}
	
	func showTextField(){
		secureTextField.isHidden = true
		textField.isHidden = false
		secureTextIsShown = false
	}
	
	func showSecureTextField(){
		secureTextField.isHidden = false
		textField.isHidden = true
		secureTextIsShown = true
	}
	
	func drawTextField(){
		let rectForSecureTextField = NSRect(x: 0, y: 0, width: self.frame.width - imageWidth, height: self.frame.height - 2)
		secureTextField = NSSecureTextField(frame: rectForSecureTextField)
		secureTextField.font = NSFont(name: (secureTextField.font?.fontName)!, size: fontSize)
		secureTextField.focusRingType = .none
		secureTextField.backgroundColor = NSColor.clear
		secureTextField.isBordered = false
		self.addSubview(secureTextField)
	}
	
	func drawSecureTextField() {
		let rectForTextField = NSRect(x: 0, y: 0, width: self.frame.width - imageWidth, height: self.frame.height - 2)
		textField = NSTextField(frame: rectForTextField)
		textField.font = NSFont(name: (textField.font?.fontName)!, size: fontSize)
		textField.focusRingType = .none
		textField.backgroundColor = NSColor.clear
		textField.isBordered = false
		self.addSubview(textField)
	}
	
	override func mouseExited(with event: NSEvent) {
		secureTextField.isHidden = false
		textField.isHidden = true
		secureTextIsShown = true
	}

	var trackingArea:NSTrackingArea!
	override func updateTrackingAreas() {
		if trackingArea != nil {
			self.removeTrackingArea(trackingArea)
		}
		trackingArea = NSTrackingArea(rect: self.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
		self.btnShowPassword.addTrackingArea(trackingArea)

		let mouseLocation = self.window?.mouseLocationOutsideOfEventStream
		if mouseLocation != nil {
			let loc = self.convert(mouseLocation!, from: nil)
			if NSPointInRect(loc, self.bounds) {
				self.mouseEntered(with: NSEvent())
			} else {
				self.mouseExited(with: NSEvent())
			}
		}
	}
	
}
