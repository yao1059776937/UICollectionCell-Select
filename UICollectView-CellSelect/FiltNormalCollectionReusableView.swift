//
//  FiltNormalCollectionReusableView.swift
//  xinghuoManager
//
//  Created by yaoyinglong on 2018/7/19.
//  Copyright © 2018年 Robin Zhang. All rights reserved.
//

import UIKit

class FiltNormalCollectionReusableView: UICollectionReusableView {
    
    
    var typeName: String {
        didSet{
            self.itemType.text = typeName
        }
    }
    
    fileprivate lazy var itemType: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        
        self.typeName = ""
        super.init(frame: frame)
        
        self.itemType.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(self.mas_left)?.offset()(15.0)
            make?.top.right().bottom().equalTo()(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
