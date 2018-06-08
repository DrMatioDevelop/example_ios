//
//  demoTest.swift
//  example
//
//  Created by 陈雁锋 on 2018/6/6.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

import Foundation


/*
 OC项目混编swift
 1.如果项目之前没有桥接文件，新建一个（项目名称-Bridging-Header.h）的文件，并在build Setting中的`Objective-c Bridging heading`输入相对位置。
 2.building Setting中 Defines Module修改为YES， Product Name修改为项目名称
 3.需要使用到swift的地方需要导入系统生成的`项目名称-Swift.h`
 */
public class demoTest : NSObject {
    public override init() {
        super.init()
        print("init")
    }
    
    @objc public func mydog() -> Void {
        print("god like")
    }
    

}
