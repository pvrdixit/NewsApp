//
//  ViewControllerExtension.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import UIKit


//MARK:- Activity Indicator
fileprivate var activityView: UIView?

extension UIViewController {
    func showSpinner() {
        DispatchQueue.main.async {
            if activityView == nil {
                activityView = UIView(frame: self.view.bounds)
                activityView?.backgroundColor = .clear //UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.center = activityView!.center
                activityIndicator.startAnimating()
                activityView!.addSubview(activityIndicator)
                self.view.addSubview(activityView!)
                
                Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { (t) in
                    self.removeSpinner()
                }
            }
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            activityView?.removeFromSuperview()
            activityView = nil
        }
    }
    
    
    func displayAlert(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message:alertMessage , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func displayAlert(alertMessage: String, action: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message:alertMessage , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: action))
        self.present(alert, animated: true)
    }
}
