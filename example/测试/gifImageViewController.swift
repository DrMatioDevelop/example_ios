//
//  gifImageViewController.swift
//  example
//
//  Created by d2c_cyf on 17/2/16.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
import MobileCoreServices

public class gifImageViewController : UIViewController {
    
    public override func viewDidLoad() {
        let gifPath = Bundle.main.path(forResource: "view-wechat-chat", ofType: "gif")
        let gifurl     = URL (fileURLWithPath: gifPath!)
        let gifData = try! Data (contentsOf: gifurl)
        
        let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, nil)
        let imageCount    = CGImageSourceGetCount(gifDataSource!)
        
        for i in 0...imageCount-1 {
            let imageRef = CGImageSourceCreateImageAtIndex(gifDataSource!, i, nil)
            let image    = UIImage (cgImage: imageRef!, scale: UIScreen.main.scale, orientation: UIImageOrientation.up)
            let imageData = UIImagePNGRepresentation(image)
            
            var docs     = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            
            let documentDirector = docs[0] + "/\(i)" + ".png"
            
            try! imageData?.write(to: URL (fileURLWithPath: documentDirector), options: [.atomic])
            print("\(documentDirector)")
        }
        
    }
    

}
