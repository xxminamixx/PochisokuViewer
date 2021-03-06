//
//  ArticleTableViewCell.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    static let id = "ArticleTableViewCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        thumbnail.frame = CGRect(origin: CGPoint(x: 5, y: 5), size: CGSize(width: 120, height: 90))
    }
    
}
