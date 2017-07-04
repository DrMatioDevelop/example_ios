//
//  Transition_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/6/27.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Transition_ViewController.h"
#import "ChangeArray.h"

@interface Transition_ViewController ()<UIViewControllerTransitioningDelegate>
@property(strong, nonatomic)ChangeArray *object;
@property(strong, nonatomic)Model *model;
@end

@implementation Transition_ViewController
- (void)dealloc {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

@end














@implementation Model
-(NSMutableArray *)modelArray{
    if(!_modelArray){
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
