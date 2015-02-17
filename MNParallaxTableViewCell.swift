
//
//  MNParallaxTableViewCell.swift
//  MNParallaxList
//
//  Created by Motoki on 2015/02/10.
//  Copyright (c) 2015年 MotokiNarita. All rights reserved.
//

import UIKit

class MNParallaxTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Public Method
 
    /**
    セルの設定
    */
    func configureCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    /**
    セルの視差効果のためのメソッド
    
    :param: tableView パララックス効果を出すtableView
    :param: view      tableViewの親View
    */
    func parallaxCell(tableView:UITableView, view: UIView){
        // 画面内のセルの現在地取得
        let currentCellFrame = tableView.convertRect(self.frame, toView: view)
        
        // セルの画面中央からの距離
        let distanceFromCenter = CGRectGetHeight(view.frame) - CGRectGetMinY(currentCellFrame)
        
        // 上端からの相対値取得
        let relativeDifference = distanceFromCenter / CGRectGetHeight(view.frame)
        
        // 画像とセルの高さの差分
        let differenceImageFromCellPoint
        = CGRectGetHeight(self.photoImageView.frame) - CGRectGetHeight(self.frame)
        
        // 相対値を元に画像をずらす位置を調整
        self.photoImageView.frame.origin.y = -differenceImageFromCellPoint * relativeDifference * 0.75;
    }

}
