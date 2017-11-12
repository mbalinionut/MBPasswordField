# MBPasswordField
Password text field capable of showing plain text
```swift
var passField: MBPasswordField!
```
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
		
	
