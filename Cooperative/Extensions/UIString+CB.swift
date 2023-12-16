//
//  UIString+Cb.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 16/12/2023.
//

import UIKit

extension String {
    func attributedStringWithColorAndBold(_ colorizeWords: [String], color: UIColor, characterSpacing: UInt? = nil, boldWords: [String] = []) -> NSAttributedString {
        // Create a mutable attributed string based on the original string.
        let attributedString = NSMutableAttributedString(string: self)

        // Apply color and bold attributes to the specified words.
        colorizeWords.forEach { word in
            let range = (self as NSString).range(of: word)

            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

            if boldWords.contains(word) {
                // Make the specified words bold.
                attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.CBFont.bold.font(16), range: range)
            }
        }

        // Apply character spacing if specified.
        guard let characterSpacing = characterSpacing else {
            return attributedString
        }

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
