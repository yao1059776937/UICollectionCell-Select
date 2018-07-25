//
//  FiltFirstSecCollectionReusableView.swift
//  xinghuoManager
//
//  Created by yaoyinglong on 2018/7/19.
//  Copyright © 2018年 Robin Zhang. All rights reserved.
//

import UIKit

class FiltFirstSecCollectionReusableView: UICollectionReusableView {
    
    @objc var closeFilt:(()->())?
    
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
    
    
    fileprivate lazy var close: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("收起", for: .normal)
        btn.setTitleColor(KRGB(00, 00, 00), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        self.addSubview(btn)
        return btn
    }()
    
    override init(frame: CGRect) {
        
        self.typeName = ""
        super.init(frame: frame)
    
        let label = UILabel()
        label.text = "筛选条件"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.addSubview(label)
        
        label.mas_makeConstraints { (make) in
            make?.left.right().top().equalTo()(self)
            make?.height.equalTo()(40)
        }
        
        self.close.mas_makeConstraints { (make) in
            make?.right.equalTo()(self)
            make?.centerY.equalTo()(label.mas_centerY)
            make?.size.equalTo()(CGSize.init(width: 60, height: 40))
        }
        
        self.itemType.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.mas_left)?.offset()(15.0)
            make?.bottom.equalTo()(self)
            make?.size.equalTo()(CGSize.init(width: KLScreen.width, height: 30))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeView(){
        
        if self.closeFilt != nil {
            self.closeFilt!()
        }
    }
}
