//
//  AttributedStringConstructor.swift
//  LightTextInput
//
//  Created by BRANDERSTUDIO on 30.10.2017.
//

import Foundation

class AttributedStringBuilder {
  // MARK: - Fields
  /// Dictionary of attributes with ranges, separate attributes apply to relevant range
  private var attributesWithRange = [NSRange: [NSAttributedString.Key: Any]]()
  
  /**
   Create string with attributes, that contains attributes from dictionaries
   
   - Parameters:
     - newValue: New string, that will set
   
   - Returns: String with attributes, that contains in attributes dictionaries
   */
  func buildAttributedString(from value: String?, with attributes: [NSAttributedString.Key: Any]?) -> NSAttributedString? {
    guard let newValue = value else { return nil }
    var newAttributedValue = NSMutableAttributedString(
      string: newValue,
      attributes: attributes
    )
    appendAttributesWithRange(toString: &newAttributedValue, newValue: newValue)
    return newAttributedValue
  }
  
  /**
   Add attributes for range
   
   - Parameters:
     - newAttributes: Dictionary of attributes with values
     - range: Range in string, that will format will attributes
  */
  open func addAttributes(_ newAttributes: [NSAttributedString.Key: Any], range: NSRange) {
    for (attributedKey, value) in newAttributes {
      if attributesWithRange[range] != nil {
        attributesWithRange[range]?[attributedKey] = value
      } else {
        attributesWithRange[range] = [attributedKey: value]
      }
    }
  }
  
  /**
   Remove attribute for range
   
   - Parameters:
     - attribute: Attribute, that will remove
     - range: Range, that was set with attribute, range is a key for remove
  */
  open func removeAttribute(_ attribute: NSAttributedString.Key, range: NSRange) {
    if attributesWithRange[range] != nil {
      attributesWithRange[range]?.removeValue(forKey: attribute)
    } else {
      attributesWithRange.removeValue(forKey: range)
    }
  }
  
  /// Remove all attributes
  open func removeAllAttributes() {
    attributesWithRange.removeAll()
  }
}

// MARK: - Private
private extension AttributedStringBuilder {
  /**
   Append attributesWithRange to string, that get in parameters
   
   - Parameters:
     - toString: Inout mutable attributed string, that will modified
     - newValue: New string, that will set to changable string
   */
  func appendAttributesWithRange(toString: inout NSMutableAttributedString,
                                 newValue: String) {
    for (range, attributes) in attributesWithRange {
      if range.location <= newValue.count {
        let limitedRangeLength = range.upperBound > newValue.count ?
          newValue.count - range.location : range.length
        let limitedRange = NSRange(location: range.location, length: limitedRangeLength)
        toString.addAttributes(attributes, range: limitedRange)
      }
    }
  }
}
