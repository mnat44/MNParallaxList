//  ViewController.swift
//  MNParallaxList
//
//  Created by Motoki on 2015/02/10.
//  Copyright (c) 2015年 MotokiNarita. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var itemList: NSArray?
    var parallaxStatus: Bool = true
    var filePath: String?
    
    // MARK: LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // MARK: プロパティリスト使用例
        // Bundleに保存されているplistからデータを読み込み
        let bundle: NSBundle = NSBundle.mainBundle()
        let path: String     = bundle.pathForResource("PhotoData", ofType: "plist")!
        self.itemList = NSArray(contentsOfFile: path)
        
        // 写真リストの保存場所(Documentsディレクトリ)初期化
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var documentDirectory = paths[0] as String
        self.filePath = documentDirectory + "/file.plist"
        
        // Documetnsフォルダへの保存を行う
        self.savePhotoToDocuments()
        
        // Documetnsフォルダからの読み出し
        self.loadFromDocuments()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // パララックス設定の確認
        self.checkParallaxStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private Method
    func checkParallaxStatus() {
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let status: Bool = userDefaults.objectForKey("NotificationStatus") as Bool
        self.parallaxStatus = status;
    }
    
    func savePhotoToDocuments() {
        
        var archivePhotos = MNPhotoData()
        archivePhotos.photoDatas = self.itemList
        
        // MARK: オブジェクトアーカイブ使用例
        // NSData形式でDocumentsフォルダに保存
        let archiveData = NSKeyedArchiver.archivedDataWithRootObject(archivePhotos)
        archiveData.writeToFile(self.filePath!, atomically: true)
    }
    
    func loadFromDocuments() {

        // MARK: オブジェクトアーカイブ使用例
        let data: MNPhotoData = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath!) as MNPhotoData
        self.itemList = data.photoDatas
    }
    
    // MARK: UITableView DataSource Delegate
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "ParallaxCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MNParallaxTableViewCell
        
        if cell == nil {
            cell = MNParallaxTableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:cellId)
        }
        let imageName = self.itemList?.objectAtIndex(indexPath.row) as NSString

        cell?.configureCell()
        let image = UIImage(named: imageName)
        cell?.photoImageView.image = image


        return cell!
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 200.0
    }
    
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        // パララックス設定がOFFの場合は効果適用処理を行わない
        if self.parallaxStatus == false {
            return
        }
        
        // 表示されているセルを取得
        let cells: NSArray = self.tableView.visibleCells()
        
        if let allCells = cells as? [MNParallaxTableViewCell] {
            for cell: MNParallaxTableViewCell in allCells {
                cell.parallaxCell(self.tableView, view: self.view)
            }
        }
    }
}

