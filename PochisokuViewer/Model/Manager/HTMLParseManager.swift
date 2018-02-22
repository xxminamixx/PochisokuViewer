//
//  HTMLParseManager.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import Ji

class HTMLParseManager {
    
    // 現在表示しているページのURLを管理
    static var currentPageURL = ConstText.pochisokuURL
    
    /// 関連記事のEntityListを作成し返却
    ///
    /// - Returns: ArticleEntity配列を返却
    static func relatedArticleEntityList(_ completion: () -> Void) -> [ArticleEntity] {
        // ページのリクエスト
        let pochisokuJi = Ji(htmlURL: URL(string: ConstText.pochisokuURL)!)
        // 関連記事のURLを含むタグ情報(これからhref値を抜き取りたい)
        let kanrenURL = pochisokuJi?.xPath("//div[@id='st-magazine']/div/div/dl/a")
        // 関連記事のタイトルを含む情報(これからh3を抜き取りたい)
        let title = pochisokuJi?.xPath("//div[@id='st-magazine']/div/div/dl/dd/div/div/h3")
        // 関連記事のサムネイルURLを含む情報(これからsrc値を抜き取りたい)
        let image = pochisokuJi?.xPath("//div[@id='st-magazine']/div/div/dl/dt/img")
        
        var articleList: [ArticleEntity] = []
        for i in 0 ..< kanrenURL!.count {
            
            // タイトルに改行文字が含まれていたので削除
            var h3 = title![i].content!
            h3 = h3.replacingOccurrences(of: "\t", with: "")
            h3 = h3.replacingOccurrences(of: "\n", with: "")
            
            let article = ArticleEntity(_url: kanrenURL![i].attributes["href"]!, _title: h3, _image: image![i].attributes["src"]!, _date: Date())
            
            articleList.append(article)
        }
        
        completion()
        return articleList
    }
    
    static func addRelatedArticleEntityList() -> [ArticleEntity] {
        let currentpageJi = Ji(htmlURL: URL(string: currentPageURL)!)
        let nextPage = currentpageJi?.xPath("//a[@class='next page-numbers']")
        let nextPageURL = nextPage![0].attributes["href"] ?? ""
        let nextPageJi = Ji(htmlURL: URL(string: nextPageURL)!)
        
        // 次の更に読みでどんどん次のページを読み込めるように更新
        currentPageURL = nextPageURL
        
        // 関連記事のURLを含むタグ情報(これからhref値を抜き取りたい)
        let kanrenURL = nextPageJi?.xPath("//div[@id='st-magazine']/div/div/dl/a")
        // 関連記事のタイトルを含む情報(これからh3を抜き取りたい)
        let title = nextPageJi?.xPath("//div[@id='st-magazine']/div/div/dl/dd/div/div/h3")
        // 関連記事のサムネイルURLを含む情報(これからsrc値を抜き取りたい)
        let image = nextPageJi?.xPath("//div[@id='st-magazine']/div/div/dl/dt/img")
        
        var articleList: [ArticleEntity] = []
        for i in 0 ..< kanrenURL!.count {
            
            // タイトルに改行文字が含まれていたので削除
            var h3 = title![i].content!
            h3 = h3.replacingOccurrences(of: "\t", with: "")
            h3 = h3.replacingOccurrences(of: "\n", with: "")
            
            let article = ArticleEntity(_url: kanrenURL![i].attributes["href"]!, _title: h3, _image: image![i].attributes["src"]!, _date: Date())
            
            articleList.append(article)
        }
        
        return articleList
    }
    
}
