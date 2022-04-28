//
//  UIView.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 27.04.2022.
//

import Foundation
import UIKit
extension UIView {
  func dropShadow(scale: Bool = true) {
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 10
    layer.masksToBounds = true
    layer.borderWidth = 1.5
    layer.borderColor = UIColor.white.cgColor
    layer.cornerRadius = 10
  }
}
