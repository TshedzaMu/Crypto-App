//
//  UIViewController+Extensions.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//
import UIKit

let ACTIVITY_INDICATOR_TAG = 001

extension UIViewController {
       
  func startActivityIndicator() {
      let loc =  self.view.center
      let activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.tag = ACTIVITY_INDICATOR_TAG
      activityIndicator.center = loc
      activityIndicator.hidesWhenStopped = true
            
      activityIndicator.startAnimating()
      self.view.addSubview(activityIndicator)
   }
        
   func stopActivityIndicator() {
      if let activityIndicator = self.view.subviews.filter(
      { $0.tag == ACTIVITY_INDICATOR_TAG}).first as? UIActivityIndicatorView {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
      }
    }
}

