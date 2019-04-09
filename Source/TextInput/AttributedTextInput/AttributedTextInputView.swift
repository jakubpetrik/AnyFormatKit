//
//  AttributedTextInputView.swift
//  TextInput
//
//  Created by BRANDERSTUDIO on 25.10.2017.
//  Copyright © 2017 BRANDERSTUDIO. All rights reserved.
//

import UIKit

/// Subclass of UITextView, that work always with attributedText even when you use text
open class AttributedTextInputView: UITextView {
  // MARK: - Fields
  /// Overriden text, that set text with attributes to attributedText property
  override open var text: String! {
    set {
      if !typingAttributes.isEmpty {
        super.attributedText = stringBuilder.buildAttributedString(
          from: newValue, with: typingAttributes)
      } else {
        super.text = newValue
      }
    }
    get {
      if typingAttributes.isEmpty {
        return super.attributedText?.string
      } else {
        return super.text
      }
    }
  }
  
  /// Common attributes for all string during typing
  private var commonAttributes = [NSAttributedString.Key : Any]()
  override open var typingAttributes: [NSAttributedString.Key : Any] {
    set { commonAttributes = newValue }
    get { return commonAttributes }
  }
  
  /// String constructor, that contain dictionaries of attributes, that will apply for input text
  private let stringBuilder = AttributedStringBuilder()
  
  // MARK: - open
  
  /**
   Add attributes for range
   
   - Parameters:
     - newAttributes: Dictionary of attributes with values
     - range: Range in string, that will format will attributes
   */
  open func addAttributes(_ newAttributes: [NSAttributedString.Key: Any], range: NSRange) {
    stringBuilder.addAttributes(newAttributes, range: range)
  }
  
  /**
   Remove attribute for range
   
   - Parameters:
     - attribute: Attribute, that will remove
     - range: Range, that was set with attribute, range is a key for remove
   */
  open func removeAttribute(_ attribute: NSAttributedString.Key, range: NSRange) {
    stringBuilder.removeAttribute(attribute, range: range)
  }
  
  /// Remove all attributes
  open func removeAllAttributes() {
    stringBuilder.removeAllAttributes()
  }
}
