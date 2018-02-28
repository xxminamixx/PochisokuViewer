//
//  HTMLParseManager.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import Ji
import Reachability
import PopupDialog

class HTMLParseManager {
    
    // 現在表示しているページのURLを管理
    static var currentPageURL = ConstText.pochisokuURL
    
    /// 関連記事のEntityListを作成し返却
    ///
    /// - Returns: ArticleEntity配列を返却
    static func relatedArticleEntityList(_ completion: @escaping (Bool) -> Void) -> [ArticleEntity] {
        // 通信がない場合ダイアログを表示してreturn
        guard isreachable() else {
            completion(false)
            return []
        }
        completion(true)
        return HTMLParseManager.articleList(url: ConstText.pochisokuURL)
        
    }
    
    
    /// 皿読み時に次のページの記事を返す
    ///
    /// - Returns: 次のページのArticleEntity配列
    static func addRelatedArticleEntityList(_ completion: (Bool) -> Void) -> [ArticleEntity] {
        
        guard isreachable() else {
            completion(false)
            return []
        }
        
        let currentpageJi = Ji(htmlURL: URL(string: currentPageURL)!)
        let nextPage = currentpageJi?.xPath("//a[@class='next page-numbers']")
        let nextPageURL = nextPage?.first?.attributes["href"] ?? ""
        
        // 次の更に読みでどんどん次のページを読み込めるように更新
        currentPageURL = nextPageURL
        
        completion(true)
        return HTMLParseManager.articleList(url: nextPageURL)
    }
    
    
    /// ポチ速URLから記事URL,タイトル,画像を取得しEntity配列をして返す
    ///
    /// - Parameter url: スクレイピングを開始するURL
    /// - Returns: ArticleEntity配列
    private static func articleList(url: String) -> [ArticleEntity] {
        // ページのリクエスト
        guard let _url = URL(string: url) else {
            return []
        }
        
        let pochisokuJi = Ji(htmlURL: _url)
        // 関連記事のURLを含むタグ情報(これからhref値を抜き取りたい)
        let kanrenURL = pochisokuJi?.xPath(ConstText.kanrenURLXPath)
        // 関連記事のタイトルを含む情報(これからh3を抜き取りたい)
        let title = pochisokuJi?.xPath(ConstText.kanrenTitleXPath)
        // 関連記事のサムネイルURLを含む情報(これからsrc値を抜き取りたい)
        let image = pochisokuJi?.xPath(ConstText.kanrenImageXPath)
        
        var articleList: [ArticleEntity] = []
        
        if let url = kanrenURL {
            for i in 0 ..< url.count {
                
                // タイトルに改行文字が含まれていたので削除
                var h3 = title![i].content!
                h3 = h3.replacingOccurrences(of: "\t", with: "")
                h3 = h3.replacingOccurrences(of: "\n", with: "")
                
                let article = ArticleEntity(_url: kanrenURL![i].attributes["href"]!, _title: h3, _image: image![i].attributes["src"]!, _date: Date())
                
                articleList.append(article)
            }
        }
        
        return articleList
    }
    
    
    /// 現状の通信状態をBoolで返す
    ///
    /// - Returns: wifi及び携帯回線の場合true, 通信がない場合false
    private static func isreachable() -> Bool {
        let reachability = Reachability()!
        switch reachability.connection {
        case .wifi, .cellular:
            return true
        case .none:
            return false
        }
    }
    
}
