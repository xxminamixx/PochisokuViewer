//
//  ImageFetcher.swift
//  PochisokuViewer
//
//  Created by kyohei.minami on 2018/02/17.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageFetcher {
    
    static func articleImage(cell: ArticleTableViewCell, url: String) {
        Alamofire.request(url).validate().responseImage(completionHandler: { response in
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    return
                }
                
                // セルにサムネイル画像をセット
                cell.thumbnail.image = data
                
                break
            case .failure:
                break
            }
            
        })
    }
    
}
