# MBPasswordField
Password text field capable of showing plain text written in Swift 4.

Just add a Custom view and subclass it with MBPasswordField and you are done.

Add an custom show icon or use the default quick look icon
```swift
passField.showButtonImageName = "show.eps"
```
Programmatically show password in plain text
```swift
passField.viewPlainText = true
```
Get the password in plain text
```swift
print(passField.passwordString)
```
		
	
