//
//  ListVC.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 09/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import UIKit
import ObjectMapper
import SVProgressHUD
class ListVC: UIViewController {

    @IBOutlet weak var Collection_album: UICollectionView!
    @IBOutlet weak var ViewModel: ContainerViewModel!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //variable declaration
    var albumDataSource:CollectionDataSource!
    var CollectionviewDidSelecteAtIndexPath : CollectionDataSource.GenreCollectionViewDidSelectAtIndexPath!
    var colletionViewFlowLayout: CollectionDataSource.CustumFlowlayout!
    var colletionViewCellConfigure:CollectionDataSource.CollectionViewCellConfigureBlock!
    var colletionViewSizeForItem : CollectionDataSource.sizeForItemAtIndex!
    
    var albumList:[MAllAlbums] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewDelegate()
        ViewModel.requestAlbumList()
    }
  
    //MARK:-  Collectionview Delegate Method
    func CollectionViewDelegate() {
        
        colletionViewCellConfigure = { (cell,item) -> () in
            let myCell = cell as? AlbumListCell
            myCell?.prepareCell(objModel: item as! MAllAlbums)
        }
        CollectionviewDidSelecteAtIndexPath = { (collectionview, indexpath, model) -> () in
                print("Tap on cell")
        }
        colletionViewSizeForItem = {(colletionView) -> (CGSize) in
            return CGSize(width: 150, height: 180)
        }
        colletionViewFlowLayout = {(colletionview) -> () in
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 5
            let screen = UIScreen.main.bounds
            let Width:CGFloat
            Width = screen.width
    
            let numbCellInRow = Int.init(Width / 150)
    
            let inset = ((Width - CGFloat(Int(150) * numbCellInRow)) /  CGFloat(numbCellInRow + 1))
    
            layout.sectionInset = UIEdgeInsetsMake(5, inset, 0, inset)
            
            colletionview.collectionViewLayout = layout
        }
        
        ViewModel.btnRefreshComplition = { (refreshBtn) -> Void in
            self.ViewModel.requestAlbumList()
        }
        ViewModel.beforeComplition = {() -> Void in
            DispatchQueue.main.async {
             SVProgressHUD.show()
            }
            
        }
        ViewModel.Completion = { (responseDict) -> Void in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            self.parseAlubListResponse(objResponse: responseDict!)
        }
        ViewModel.Failure = { () -> Void in
            SVProgressHUD.dismiss()
        }
    }
    func parseAlubListResponse(objResponse:[String:Any]) -> Void {
         albumList = Mapper<MAllAlbums>().mapArray(JSONArray:(objResponse["result"])! as! [[String : Any]])
        self.configureMovieCollectionView()
    }
    // MARK:- ConfigureCollectionView
    func configureMovieCollectionView() -> Void
    {        
        if self.albumDataSource == nil {            
            // assign datasource object of moview collectionview
          self.albumDataSource =  CollectionDataSource(items: self.albumList,
                                                       forCollectionView: self.Collection_album,
                                                       withConfigureCell: self.colletionViewCellConfigure,
                                                       withSizeForItem: nil,
                                                       withPagination: nil,
                                                       withCustumFlowLayout: self.colletionViewFlowLayout,
                                                       withDidSelection: self.CollectionviewDidSelecteAtIndexPath,
                                                       withCellIdentifier: "AlbumList",
                                                       isCellXib: true)
            //If we forgot to pass the option value (which alredy have defalue value than complier won't give you error)
            /*           self.albumDataSource = CollectionDataSource(items: self.albumList,
             forCollectionView: self.Collection_album,
             withConfigureCell: self.colletionViewCellConfigure,
             withCustumFlowLayout: self.colletionViewFlowLayout,
             withCellIdentifier: "AlbumList",
             isCellXib: true)
             */
            self.albumDataSource.defaultCellSize = (self.Collection_album.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
             self.Collection_album.dataSource = self.albumDataSource
            self.Collection_album.delegate = self.albumDataSource
            
        } else {
            
            self.albumDataSource.updateCollectionView(items: albumList)
        }
        
        DispatchQueue.main.async {
            self.Collection_album.reloadData()
        }
    }

}
