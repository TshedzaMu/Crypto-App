//
//  UIViewController+Extensions.swift
//  Cypto Life
//
//  Created by Tshedza Musandiwa on 2025/02/27.
//
import UIKit

let ACTIVITY_INDICATOR_TAG = 001
let LOADING_LABEL_TAG = 002

extension UIViewController {
       
  func startActivityIndicator() {
      let location = self.view.center
      let activityIndicator = UIActivityIndicatorView(style: .large)
      activityIndicator.tag = ACTIVITY_INDICATOR_TAG
      activityIndicator.center = location
      activityIndicator.hidesWhenStopped = true
            
      activityIndicator.startAnimating()
      self.view.addSubview(activityIndicator)
      
      let loadingLabel = UILabel()
      loadingLabel.tag = LOADING_LABEL_TAG
      loadingLabel.text = "Loading..."
      loadingLabel.textColor = .gray
      loadingLabel.font = UIFont.systemFont(ofSize: 14)
      loadingLabel.sizeToFit()
      loadingLabel.center = CGPoint(x: location.x, y: location.y + 30)
      self.view.addSubview(loadingLabel)
   }
        
   func stopActivityIndicator() {
      if let activityIndicator = self.view.subviews.filter({ $0.tag == ACTIVITY_INDICATOR_TAG }).first as? UIActivityIndicatorView {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
      }
      
      if let loadingLabel = self.view.subviews.filter({ $0.tag == LOADING_LABEL_TAG }).first as? UILabel {
        loadingLabel.removeFromSuperview()
      }
    }
}
