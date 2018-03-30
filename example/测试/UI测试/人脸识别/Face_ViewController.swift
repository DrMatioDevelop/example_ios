//
//  Face_ViewController.swift
//  example
//
//  Created by d2c_cyf on 17/5/16.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import Foundation
import UIKit
import CoreImage  //人脸识别
public class Face_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let personPic = UIImageView(image: UIImage(imageLiteralResourceName: "Person"))
    let imagePicker  = UIImagePickerController()
    var takePhotoBtn = UIButton(frame: CGRect(x: 100, y: 350, width: 100, height: 61.8))
    
    //FIXME:-标记问题
    //MARK:- 标记
    //TODO:- 标记未完成
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        title = "人脸识别 Face_ViewController"
        personPic.frame = CGRect(x: 0, y: 100, width: 250.0, height: 166)
        view.addSubview(personPic);
    
        takePhotoBtn.setTitle("拍照", for: .normal)
        takePhotoBtn.setTitleColor(UIColor.black, for: .normal)
        takePhotoBtn.addTarget(self, action: #selector(clickPhone(sender:)), for: .touchUpInside)
        view.addSubview(takePhotoBtn)
        
        imagePicker.delegate = self
        faceDetect();
    }
    
    @objc func clickPhone(sender:UIButton)  {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }

        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true) { 
            print("what's fuck")
        }
    }
    //MARK:- pickerController
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            personPic.contentMode = UIViewContentMode.scaleAspectFit
            personPic.image = pickedImage
            let scale = pickedImage.size.width / pickedImage.size.height
            personPic.frame.size = CGSize(width: 300, height: 300*scale)
            for v in personPic.subviews {
                v.removeFromSuperview()
            }
        }
        dismiss(animated: true) { 
            self.detect()

        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    //MARK:- 照片识别
    /// 人脸识别
    func faceDetect () {
        //要查看的图片 赋值到变量中
//        guard let persionImage = CIImage(image: personPic.image!) else {
//            return
//        }
        let persionImage = CIImage(image: personPic.image!)
        
        //创建一个变量 并且设置高精度还是低精度
        let arrcuarcy = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: arrcuarcy)
        //检测出图片的所有人脸 并最终以数组的方式返回人脸
        let faces = faceDetector?.features(in: persionImage!)
        
        //将Core Image的坐标转换成UIView坐标  UIKit是从左上角开始的（x向左 y向下） CoreImage从左下角开始（x向左 y向上）
        let ciImageSize = persionImage?.extent.size
        var transfrom   = CGAffineTransform(scaleX: 1, y: -1)
        transfrom = transfrom.translatedBy(x: 0, y: -(ciImageSize?.height)!)
        
        //遍历所有的人脸并且转换为CIFaceFeature类型
        for face in faces as! [CIFaceFeature] {
            
            //坐标转换  UIKit是从左上角开始的（x向左 y向下） CoreImage从左下角开始（x向左 y向上）
            var faceViewBounds = face.bounds.applying(transfrom)
            
            //计算实际的位置和大小
            let viewSize = personPic.bounds.size
            let scale = min(viewSize.width / (ciImageSize?.width)!, viewSize.height / (ciImageSize?.height)!)
            let offsetX = (viewSize.width - (ciImageSize?.width)! * scale)/2
            let offsetY = (viewSize.height - (ciImageSize?.height)! * scale)/2;
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            print("Found bounds are\(face.bounds)")
            
            //创建一个faceBox实例 用于标示检测到的人脸
            let faceBox = UIView(frame: faceViewBounds)
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.backgroundColor   = UIColor.clear
            
            //红色视图添加到检测的图片上
            personPic.addSubview(faceBox)
            
            if face.hasLeftEyePosition {
                print("left eye bounds are\(face.leftEyeClosed)")
            }
            
            if face.hasRightEyePosition {
                print("right eye bounds are\(face.rightEyeClosed)")
            }
        }
        
        
    }
    
    //MARK:- 拍照后上传 然后验证face  face还可以检测是否出现嘴巴  是否睁开有眼  是否睁开左眼
    func detect() {
        let imageOptions = NSDictionary(object: NSNumber(value: 5) as NSNumber, forKey: CIDetectorImageOrientation as NSString)
        let personciImage = CIImage(cgImage: personPic.image!.cgImage!)
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage, options: imageOptions as? [String : AnyObject])
        
        if let face = faces?.first as? CIFaceFeature {
            print("found bounds are \(face.bounds)")
            
            let alert = UIAlertController(title: "Say Cheese!", message: "We detected a face!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            if face.hasSmile {
                print("face is smiling");
            }
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        } else {
            let alert = UIAlertController(title: "No Face!", message: "No face was detected", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func testPrint() {
        print("testPrint")
    }
}
