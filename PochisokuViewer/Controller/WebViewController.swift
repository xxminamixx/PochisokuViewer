//
//  WebViewController.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class WebViewController: UIViewController {
    
    static let id = "WebViewController"
    
    private var indicator: NVActivityIndicatorView?
    
    var webview: WKWebView?
    var request: URLRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ローディング中のインジケータ初期設定
        let rect = CGRect(origin: CGPoint(x: self.view.frame.size.width / 2 - 25, y: self.view.frame.size.height / 2 - 25), size: CGSize(width: 50, height: 50))
        indicator = NVActivityIndicatorView(frame: rect, type: .ballScaleRipple, color: ConstColor.iconPink, padding: 10)

        // WKWebViewの初期設定
        webview = WKWebView()
        
        // WKWebViewのデリゲート設定
        webview?.navigationDelegate = self
        
        // フレームサイズを画面サイズを同じに設定
        webview?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        self.view.addSubview(webview!)
        self.view.addSubview(indicator!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let request = request {
            // インジケータ表示
            indicator?.startAnimating()
            // webviewの表示
            webview?.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension WebViewController: WKNavigationDelegate {    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // インジケータ非表示
        indicator?.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // エラー発生
        indicator?.stopAnimating()
        // TODO: ポップアップを表示して再読み込みを促す
    }
}
