//
//  SearchCollectionDataSource.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 09/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import UIKit
let kByDefaultCellWidth = 50
let kByDefaultCellheight = 50
class CollectionDataSource: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //MARK:- Variables
    var collectioView : UICollectionView!
    var cellIdentifier: String!
    var items: [AnyObject]!
    var genreCollectionViewDidSelectAtIndexPath: GenreCollectionViewDidSelectAtIndexPath!
    var configureCellBlock:CollectionViewCellConfigureBlock?
    var paginationBlock : paginationCallBack?
    var custumFlowlayout: CustumFlowlayout?
    var SizeForItem: sizeForItemAtIndex?
    var defaultCellSize: CGSize = CGSize(width: kByDefaultCellWidth, height: kByDefaultCellheight)
    //Complition block
    typealias GenreCollectionViewDidSelectAtIndexPath = ((_ collectionView: UICollectionView, _ itemIndexPath: NSIndexPath, _ modelObject: AnyObject) -> (Void))!
    typealias CollectionViewCellConfigureBlock = (_ cell:UICollectionViewCell, _ item:AnyObject?) -> ()
    typealias paginationCallBack = ((_ index : Int) -> ())!
    typealias CustumFlowlayout = ((_ colletionView: UICollectionView) -> ())!
    typealias sizeForItemAtIndex = ((_ collectionView:UICollectionView) -> (CGSize))!
    
    //MARK:- init Methods
    init(items anItems:[AnyObject]!, forCollectionView aCollectionView: UICollectionView!,withConfigureCell aConfigureCell:@escaping CollectionViewCellConfigureBlock,withSizeForItem aSizeForItem:sizeForItemAtIndex = nil,withPagination aPagination:paginationCallBack = nil,withCustumFlowLayout aFlowLayout:CustumFlowlayout = nil,withDidSelection aDidSelectRow:GenreCollectionViewDidSelectAtIndexPath = nil, withCellIdentifier aCellIdentifier:String!,isCellXib:Bool = false)  {
        
        super.init()
        
        //asign closer to class varibales
        self.collectioView = aCollectionView
        self.cellIdentifier = aCellIdentifier
        self.configureCellBlock = aConfigureCell
        if (aSizeForItem != nil){
            self.SizeForItem = aSizeForItem
        }
        if (aPagination != nil){
            self.paginationBlock = aPagination
        }
        if (aFlowLayout != nil){
            self.custumFlowlayout = aFlowLayout
        }
        if (aDidSelectRow != nil){
            self.genreCollectionViewDidSelectAtIndexPath = aDidSelectRow
        }
        
        items = anItems
        setupFlowlayout()
        if isCellXib {
            registerCell()
        }
        
    }    
    func setupFlowlayout() -> Void {
        if (self.custumFlowlayout != nil){
            self.custumFlowlayout!(self.collectioView)
        }
    }
    //method to update collectionview
     func updateCollectionView(items anItems:[AnyObject]!)  {
        items = anItems
        
    }   
    
    //MARK: - Collectionview Datasource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectioView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        let item: AnyObject = self.itemArIndexPath(indexpath: indexPath)
        if (self.configureCellBlock != nil){
            self.configureCellBlock!(cell, item)
        }
        if self.paginationBlock != nil && indexPath.row == self.items.count - 2
        {
            self.paginationBlock!(indexPath.row)
        }
        return cell
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout Delegate methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (self.SizeForItem != nil){
           return (self.SizeForItem!(self.collectioView))
        }else{
             let size = (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
           return CGSize(width: defaultCellSize.width , height: defaultCellSize.height)
        }
    }
    
    //MARK:- collection Datasource Delegate methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if genreCollectionViewDidSelectAtIndexPath != nil {
            let modalObject = itemAtIndexPath(indexPath: indexPath as NSIndexPath)
            genreCollectionViewDidSelectAtIndexPath!(self.collectioView, indexPath as NSIndexPath, modalObject)
        }
    }

    //MARK: - Getting Modal for Index Path
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        let modelObject = items[indexPath.row]
        return modelObject
    }
    //MARK:- Register cell
    func registerCell()  {
        
        //Regester cell according to type
         self.collectioView.register(UINib(nibName: "AlbumListCell", bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
    }
    func itemArIndexPath(indexpath:IndexPath) -> AnyObject {
        return items[indexpath.row]
    }

}

