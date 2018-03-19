//
//  test.swift
//  example
//
//  Created by d2c_cyf on 16/12/1.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//



/// swift与OC的桥接方法
/// 1.创建一个桥接文件 example-Bridging-Header.h
/// 2.BuildSetting->swift complie General ->objectc Bridging Header ->相对路径
/// 3.导入 (项目名-Swift.h)到需要调用的文件中  编译使用
import Foundation
public class test : NSObject{
    public func createlog() {
        let t = 100
        print("德玛西亚\(t)");
    }
}
 
