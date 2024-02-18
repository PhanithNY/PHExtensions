//
//  StringExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 1/3/21.
//  Copyright © 2021 Phanith Ny. All rights reserved.
//

import UIKit

public extension StringProtocol {
  
  var length: Int {
    return count
  }
  
  var masked: String {
    String(repeating: "*", count: Swift.max(0, count-3)) + suffix(3)
  }
  
  var maskedUsername: String {
    let headIndex = self.index(self.startIndex, offsetBy: 1)
    let headString = String(self[..<headIndex])
    let tailIndex = self.index(self.endIndex, offsetBy: -1)
    let tailString = String(self[tailIndex...])
    
    let bodyText = String(self[headIndex..<tailIndex])
    let replacedText = bodyText.map { _ in return "*" }.joined()
    let finalText = "\(headString)\(replacedText)\(tailString)"
    return finalText
  }
  
  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }
  
  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: Swift.max(0, Swift.min(length, r.lowerBound)),
                                        upper: Swift.min(length, Swift.max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }
  
  func substring(fromIndex: Int) -> String {
    return self[Swift.min(fromIndex, length) ..< length]
  }
  
  func substring(toIndex: Int) -> String {
    return self[0 ..< Swift.max(0, toIndex)]
  }
}

public extension String {
  
  enum RegularExpressions: String {
    case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    case number = "[0-9]"
  }
  
  var formattedPhoneNumber: String {
    applyPatternOnNumbers(pattern: "### ### ####", replacmentCharacter: "#")
  }
  
  var contentLanguage: String {
    if let languageCode = NSLinguisticTagger.dominantLanguage(for: self) {
      let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
      return detectedLanguage.orEmpty
    }
    return ""
  }
  
  var isURL: Bool {
    do {
      let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
      let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
      return matches.first?.url != nil
    } catch {
      return false
    }
  }
  
  static func buildAttributedString(from stringList: [String],
                                    font: UIFont,
                                    bullet: String = "\u{2022}",
                                    indentation: CGFloat = 12,
                                    lineSpacing: CGFloat = 1,
                                    paragraphSpacing: CGFloat = 5,
                                    textColor: UIColor = UIColor.label,
                                    bulletColor: UIColor = UIColor.label) -> NSAttributedString {
    
    let textAttributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: textColor]
    let bulletAttributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: bulletColor]
    
    let paragraphStyle = NSMutableParagraphStyle()
    let nonOptions = [NSTextTab.OptionKey: Any]()
    paragraphStyle.tabStops = [
      NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
    paragraphStyle.defaultTabInterval = indentation
    //paragraphStyle.firstLineHeadIndent = 0
    //paragraphStyle.headIndent = 20
    //paragraphStyle.tailIndent = 1
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.paragraphSpacing = paragraphSpacing
    paragraphStyle.headIndent = indentation
    
    let bulletList = NSMutableAttributedString()
    for (index, string) in stringList.enumerated() {
      let formattedString = index < stringList.count - 1 ? "\(bullet)\t\(string)\n" : "\(bullet)\t\(string)"
      let attributedString = NSMutableAttributedString(string: formattedString)
      attributedString.addAttributes([.paragraphStyle : paragraphStyle], range: NSMakeRange(0, attributedString.length))
      attributedString.addAttributes(textAttributes, range: NSMakeRange(0, attributedString.length))
      let string:NSString = NSString(string: formattedString)
      let rangeForBullet:NSRange = string.range(of: bullet)
      attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
      bulletList.append(attributedString)
    }
    
    return bulletList
  }
  
  func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
    var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    for index in 0 ..< pattern.count {
      guard index < pureNumber.count else { return pureNumber }
      let stringIndex = String.Index(utf16Offset: index, in: self)
      let patternCharacter = pattern[stringIndex]
      guard patternCharacter != replacmentCharacter else { continue }
      pureNumber.insert(patternCharacter, at: stringIndex)
    }
    return pureNumber
  }
  
  func isValid(regex: RegularExpressions) -> Bool {
    isValid(regex: regex.rawValue)
  }
  
  func isValid(regex: String) -> Bool {
    let matches = range(of: regex, options: .regularExpression)
    return matches != nil
  }
  
  func onlyDigits() -> String {
    let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
    return String(String.UnicodeScalarView(filtredUnicodeScalars))
  }
  
  func makeACall() {
    if isValid(regex: .phone) {
      if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10, *) {
          UIApplication.shared.open(url)
        } else {
          UIApplication.shared.openURL(url)
        }
      }
    }
  }
  
  func isValidEmail() -> Bool {
    let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
    "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
    "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
    "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
    "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
    "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    
    let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}
