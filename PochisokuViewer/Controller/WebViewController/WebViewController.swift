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
import PopupDialog

class WebViewController: UIViewController {
    
    static let id = "WebViewController"
    
    private var indicator: NVActivityIndicatorView?
    
    var webview: WKWebView?
    var request: URLRequest?
    var articleEntity: ArticleEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ローディング中のインジケータ初期設定
        let rect = CGRect(origin: CGPoint(x: self.view.frame.size.width / 2 - 25, y: self.view.frame.size.height / 2 - 25), size: CGSize(width: 50, height: 50))
        indicator = NVActivityIndicatorView(frame: rect, type: .ballScaleRipple, color: ConstColor.iconPink, padding: 10)
        
        // お気に入りボタン追加
        let rightFavoriteButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(WebViewController.favorite))
        let rightShareButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebViewController.share))
        self.navigationItem.setRightBarButtonItems([rightFavoriteButtonItem, rightShareButtonItem], animated: true)
        
        // TODO: お気に入り判定をして、お気に入りボタンの色を変更する!
        if let isFavorite = self.articleEntity?.isFavorite {
            if isFavorite {
                // お気に入りされていたら
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.yellow
            } else {
                // お気に入りされていなかったら
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            }
        }


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
        // インジケータ表示
        indicator?.startAnimating()
        
        guard let urlString = articleEntity?.url ,let url = URL(string: urlString) else {
            // URLが空だったらエラーポップアップを表示したい
            return
        }
        // webviewの表示
        webview?.load(URLRequest(url: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// NavigationBarのブックマークボタン押下時呼ばれる
    @objc func favorite() {
        // TODO: お気に入りボタン押下時の処理
        
        if (self.articleEntity?.isFavorite)! {
            // お気に入りされている
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
            DispatchQueue.main.async {
                RealmStoreManager.save {
                    self.articleEntity?.isFavorite = false
                }
            }
        } else {
            // お気に入りされていない
            DispatchQueue.main.async {
                RealmStoreManager.save {
                    self.articleEntity?.isFavorite = true
                }
            }
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.yellow
        }
    }
    
    /// NavigationBarのシェアボタン押下時に呼ばれる
    @objc func share() {
        let shareText = articleEntity?.title
        // TODO: 強制アンラップを修正
        let shareWebSite = URL(string: (articleEntity?.url)!)
        let activityItems = [shareText, shareWebSite] as [Any]
        /// ActivityViewController初期化
        let activityViewController = UIActivityViewController.init(activityItems: activityItems, applicationActivities: nil)
        /// ActivityViewController表示
        self.present(activityViewController, animated: true, completion: nil)
    }

}


extension WebViewController: WKNavigationDelegate {    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // インジケータ非表示
        indicator?.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // エラー発生
        indicator?.stopAnimating()
        // TODO: ポップアップを表示して再読み込みを促す
        
        let popup = PopupDialog(title: ConstText.loadFailedTitle, message: ConstText.loadFailedMessage)
        
        let reloadButton = DefaultButton(title: ConstText.reload, dismissOnTap: true) {
            // 再度通信開始
            webView.load(self.request!)
        }
        
        let cancelButton = CancelButton(title: ConstText.close) {
            // ダイアログを閉じるだけなので特に処理なし
        }
        
        popup.addButtons([reloadButton, cancelButton])
        self.present(popup, animated: true, completion: nil)
    }
}
