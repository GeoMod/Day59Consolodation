//
//  DetailViewController.swift
//  Day59Consolodation
//
//  Created by Daniel O'Leary on 4/2/19.
//  Copyright © 2019 Impulse Coupled Dev. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: AircraftData?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.title)
        Overview:
        \(detailItem.snippet)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    
    
}
