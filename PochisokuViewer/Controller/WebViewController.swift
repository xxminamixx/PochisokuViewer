//
//  WebViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    static let id = "WebViewController"
    
    var webview: WKWebView?
    var request: URLRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        // WKWebViewの初期設定
        webview = WKWebView()
        // フレームサイズを画面サイズを同じに設定
        webview?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.view.addSubview(webview!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let request = request {
            // webviewの表示
            webview?.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
