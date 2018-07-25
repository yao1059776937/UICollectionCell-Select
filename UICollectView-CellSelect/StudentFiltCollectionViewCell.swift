//
//  StudentFiltCollectionViewCell.swift
//  xinghuoManager
//
//  Created by yaoyinglong on 2018/7/19.
//  Copyright © 2018年 Robin Zhang. All rights reserved.
//

import UIKit

class StudentFiltCollectionViewCell: UICollectionViewCell {
    

    var contentTitle: String {
        
        didSet{
            self.contentLabel.text = contentTitle
        }
    }
    
    func isHighlight() {
        
        self.contentLabel.textColor = UIColor.white
        self.backgroundColor = KRGB(153, 152, 59)
    }

    func isUnHighlight() {
        self.contentLabel.textColor = KRGB(00, 00, 00)
        self.backgroundColor = UIColor.white
    }
    
    
   fileprivate lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = KRGB(00, 00, 00)
        label.textAlignment = .center
        self.contentView.addSubview(label)
        return label
    }()
    
    
    override init(frame: CGRect) {
        
        self.contentTitle = ""
        super.init(frame: frame)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = KRGB(153, 153, 153).cgColor
        
        self.contentLabel.mas_makeConstraints { (make) in
            make?.edges.equalTo()(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
