//
//  MNPhotoData.swift
//  MNParallaxList
//
//  Created by Motoki on 2015/02/12.
//  Copyright (c) 2015年 MotokiNarita. All rights reserved.
//

import UIKit

class MNPhotoData: NSObject, NSCoding {

    // MARK: Public Variables
    var photoDatas: NSArray?

    // MARK: Private Variables
    private let archiveKeyName = "photoDatas"
    
    override init() {
        self.photoDatas = nil
        super.init()
    }
    
    // MARK: NSCoding Protcol
    required init(coder aDecoder: NSCoder) {
        self.photoDatas = aDecoder.decodeObjectForKey(self.archiveKeyName) as? NSArray
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.photoDatas!, forKey: self.archiveKeyName)
    }
}
