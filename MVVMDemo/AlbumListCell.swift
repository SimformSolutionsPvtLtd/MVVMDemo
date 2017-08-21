//
//  AlbumListCell.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 09/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import UIKit
import SDWebImage
class AlbumListCell: UICollectionViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var img_Album: UIImageView!
    
    var objMovie : MAllAlbums?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func prepareCell(objModel : MAllAlbums) -> Void {
        
        // assign model value to
        self.objMovie = objModel
        self.lbl_title.text = objModel.name
        if(objModel.avatar != ""){
            self.img_Album.sd_setImage(with: URL(string: objModel.avatar!), placeholderImage: UIImage(named: "placeHolder"))
        }
    }

}
