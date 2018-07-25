//
//  ViewController.swift
//  UICollectView-CellSelect
//
//  Created by yaoyinglong on 2018/7/25.
//  Copyright © 2018年 yaoyinglong. All rights reserved.
//

import UIKit

//设置屏幕的高度和宽度
public struct KLScreen{
    
    public static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static let statusHeight:CGFloat = UIApplication.shared.statusBarFrame.height
}

public struct Device {
    
    public static var is_IphoneX:Bool {
        
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
}

class ViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    let itemCount:CGFloat = 4.0
    let spaceWidth:CGFloat = 10.0
    
    //记录选中的cell
    fileprivate var lastSelectOneSection:IndexPath? = nil
    fileprivate var lastSelectTwoSection:IndexPath? = nil
    fileprivate var lastSelectThreeSection:IndexPath? = nil
    
    
    @objc var filtViewDidPickUp:(()->())?
    
    fileprivate lazy var typeNameArray:[String] = {
        let array = ["产品类型","档案类型","科目"]
        return array
    }()
    
    fileprivate lazy var resetBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.white
        button.setTitle("重置", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        self.view.addSubview(button)
        return button
    }()
    
    fileprivate lazy var confirmBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.white
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(button)
        return button
    }()
    
    fileprivate lazy var collect: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: KLScreen.width, height: KLScreen.height-(Device.is_IphoneX ?34:0)-50), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.register(StudentFiltCollectionViewCell.self, forCellWithReuseIdentifier: "filt")
        collection.register(FiltFirstSecCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "firstSecond")
        collection.register(FiltNormalCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FiltNormal")
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.layer.masksToBounds = true
        self.view.addSubview(self.collect)
        initMasnory()
    }
    
    
    fileprivate func initMasnory(){
        
        let shardlineView = UIButton.init(type: .custom)
        shardlineView.backgroundColor = KRGB(253, 253, 253)
        shardlineView.layer.shadowColor = UIColor.black.cgColor
        shardlineView.layer.shadowOpacity = 1.0
        shardlineView.layer.shadowOffset = CGSize.init(width: 0, height:0)
        self.view.addSubview(shardlineView)
        
        self.resetBtn.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.view)
            make?.bottom.equalTo()(self.view.mas_bottom)?.offset()(Device.is_IphoneX ? -34:0)
            make?.size.equalTo()(CGSize.init(width: (KLScreen.width-1.0)/2.0,height: 50.0))
        }
        self.confirmBtn.mas_makeConstraints { (make) in
            make?.right.equalTo()(self.view)
            make?.bottom.equalTo()(self.view.mas_bottom)?.offset()(Device.is_IphoneX ? -34:0)
            make?.size.equalTo()(CGSize.init(width: (KLScreen.width-1.0)/2.0,height: 50.0))
        }
        shardlineView.mas_makeConstraints { (make) in
            make?.left.right().equalTo()(self.view)
            make?.top.equalTo()(self.collect.mas_bottom)?.offset()(0.0)
            make?.height.equalTo()(1.0)
        }
    }
    
    func reloadData() {
  
        self.collect.reloadData()
    }
    
    @objc fileprivate func reset(){
        self.lastSelectOneSection = nil
        self.lastSelectTwoSection = nil
        self.lastSelectThreeSection = nil
        self.collect.reloadData()
    }

}
extension ViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:StudentFiltCollectionViewCell = self.collect.dequeueReusableCell(withReuseIdentifier: "filt", for: indexPath) as! StudentFiltCollectionViewCell
        
        
        if indexPath == self.lastSelectOneSection {
            cell.isHighlight()
        }else if indexPath == self.lastSelectTwoSection{
            cell.isHighlight()
        }else if indexPath == self.lastSelectThreeSection{
            cell.isHighlight()
        }else{
            cell.isUnHighlight()
        }
        
        cell.contentTitle = "sdsdsds"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (KLScreen.width-(itemCount-1.0)*spaceWidth-30.0)/itemCount, height: (KLScreen.width-(itemCount-1.0)*spaceWidth-30.0)/itemCount/2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            if indexPath.section == 0{
                let headView:FiltFirstSecCollectionReusableView = self.collect.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "firstSecond", for: indexPath) as! FiltFirstSecCollectionReusableView
                headView.typeName = self.typeNameArray[indexPath.section]
                
                weak var myself:ViewController? = self
                headView.closeFilt = {
                    UIView.animate(withDuration: 0.5, animations: {
                        myself!.view.frame = CGRect.init(x: 0, y: 0, width: KLScreen.width, height: 0)
                    }, completion: { (true) in
                        if myself?.filtViewDidPickUp != nil{
                            myself?.filtViewDidPickUp!()
                        }
                    })
                }
                return headView
            }else{
                let headView:FiltNormalCollectionReusableView = self.collect.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FiltNormal", for: indexPath) as! FiltNormalCollectionReusableView
                headView.typeName = self.typeNameArray[indexPath.section]
                return headView
            }
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section==0 {
            return CGSize.init(width: KLScreen.width, height: 80.0)
        }else{
            return CGSize.init(width: KLScreen.width, height: 40.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell:StudentFiltCollectionViewCell = self.collect.cellForItem(at: indexPath) as! StudentFiltCollectionViewCell
        
        switch indexPath.section {
        case 0:
            var lastCell:StudentFiltCollectionViewCell?
            if let _ = self.lastSelectOneSection{
                lastCell = self.collect.cellForItem(at: self.lastSelectOneSection!) as? StudentFiltCollectionViewCell
                lastCell?.isUnHighlight()
            }
            if indexPath == self.lastSelectOneSection{
                self.lastSelectOneSection = nil
            }else{
                cell.isHighlight()
                self.lastSelectOneSection = indexPath
            }
            if lastCell == nil && self.lastSelectOneSection != nil{
                let set = NSIndexSet.init(index: indexPath.section)
                //刷新当期section导致section闪烁问题
                UIView.animate(withDuration: 0) {
                    self.collect.performBatchUpdates({
                        self.collect.reloadSections(set as IndexSet)
                    }, completion: nil)
                }
            }
            break
        case 1:
            var lastCell:StudentFiltCollectionViewCell?
            if let _ = self.lastSelectTwoSection{
                lastCell = self.collect.cellForItem(at: self.lastSelectTwoSection!) as? StudentFiltCollectionViewCell
                lastCell?.isUnHighlight()
            }
            if indexPath == self.lastSelectTwoSection{
                self.lastSelectTwoSection = nil
            }else{
                cell.isHighlight()
                self.lastSelectTwoSection = indexPath
            }
            if lastCell == nil && self.lastSelectTwoSection != nil{
                let set = NSIndexSet.init(index: indexPath.section)
                //刷新当期section导致section闪烁问题
                UIView.animate(withDuration: 0) {
                    self.collect.performBatchUpdates({
                        self.collect.reloadSections(set as IndexSet)
                    }, completion: nil)
                }
            }
            break
        case 2:
            
            var lastCell:StudentFiltCollectionViewCell?
            if let _ = self.lastSelectThreeSection{
                lastCell = self.collect.cellForItem(at: self.lastSelectThreeSection!) as? StudentFiltCollectionViewCell
                lastCell?.isUnHighlight()
            }
            if indexPath == self.lastSelectThreeSection{
                self.lastSelectThreeSection = nil
            }else{
                cell.isHighlight()
                self.lastSelectThreeSection = indexPath
            }
            if lastCell == nil && self.lastSelectThreeSection != nil{
                let set = NSIndexSet.init(index: indexPath.section)
                //刷新当期section导致section闪烁问题
                UIView.animate(withDuration: 0) {
                    self.collect.performBatchUpdates({
                        self.collect.reloadSections(set as IndexSet)
                    }, completion: nil)
                }
            }
            break
        default: break
        }
    }
}
//十进制的RGB颜色
func KRGB(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat) -> UIColor {
    return KRGBA(red, green, blue, 1.0)
}
func KRGBA(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat,_ alpha:CGFloat) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}
