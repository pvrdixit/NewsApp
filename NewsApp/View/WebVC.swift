//
//  WebVC.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import UIKit
import WebKit

class WebVC: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: URL?
    var titleName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
        title = titleName
        
        if let url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        else {
            displayAlert(alertMessage: "Not able to load page at this moment, Please try later") { _ in
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
    
    
    
    // MARK: WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // Handle error if webpage fails to load
    }
    
}
