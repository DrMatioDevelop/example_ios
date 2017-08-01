//
//  TableVIew_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "TableVIew_ViewController.h"
#import "UITableView+Extension.h"
@interface TableVIew_ViewController ()
@property(strong, nonatomic)UITableView *testTableView;
@property(strong, nonatomic)NSMutableArray *arrayDS;
@property(strong, nonatomic)NSArray        *sectionDS;
@end

@implementation TableVIew_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *buttonPlain = [KIUIContainerControl getButton:CGRectMake(0, 0, 44, 44) title:@"Group" tag:1 target:self action:@selector(clickPlain:)];
    UIButton *buttonGroup = [KIUIContainerControl getButton:CGRectMake(0, 0, 44, 44) title:@"edit" tag:1 target:self action:@selector(clickGroup:)];
    
    self.navigationItem.rightBarButtons = @[buttonGroup,buttonPlain];
    
    
    
    //plain 会折叠  grop不会
    [self.view addSubview:self.testTableView];
    
    _testTableView.indexView = [[SectionIndexView alloc] initOfSectionTiltle:self.sectionDS letterColor:[UIColor redColor] letterFont:Font(12) letterBGColor:[UIColor blueColor]];
    [_testTableView layoutCustomIndexView];
    
    /**
     获取NSIndexpath
     1.给表格的某个控件设置一个tag  然后通过事件拿到tag
     2.通过事件的父视图的父视图  拿到cell  然后通过  indexPathForCell 拿到row
     3.通过触摸点
     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayDS.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.arrayDS objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [[self.arrayDS objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 50)];
    label.text = [NSString stringWithFormat:@"↓↓↓↓↓↓ section-header:%c count:%ld",65 + (int)section, [self.arrayDS[section] count]];
    label.backgroundColor = [UIColor cyanColor];
    return label;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 50)];
    label.text = [NSString stringWithFormat:@"↑↑↑↑↑↑↑↑↑↑ section-foot:%c",65 + (int)section];
    label.backgroundColor = [UIColor cyanColor];
    return label;
}


#pragma mark - 索引
////返回索引数组
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.sectionDS;
//}
////响应点击索引时的代理方法
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    NSLog(@"title:%@",title);
//    return index;
//}
#pragma mark - TODO what??????
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSLog(@"");
    return @"";
}


/**
 编辑表格  需要开启UITableView的Editing

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",editingStyle);
}



/**
 标记某一行

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *onCell = [tableView cellForRowAtIndexPath:indexPath];
    if (onCell.accessoryType == UITableViewCellAccessoryNone) {
        onCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        onCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint point = [touch locationInView:self.testTableView];
//    NSIndexPath *indexPath = [self.testTableView indexPathForRowAtPoint:point];
//}

#pragma mark - Click
- (void)clickGroup:(UIButton *)btn {
    if (self.testTableView.isEditing) {
        [self.testTableView setEditing:NO animated:YES];
    }
    else {
        [self.testTableView setEditing:YES animated:YES];
    }
    
}

- (void)clickPlain:(UIButton *)btn {
    if (self.testTableView.style == UITableViewStyleGrouped) {
    }
    else {
        
    }
}

- (UITableView *)testTableView {
    if (!_testTableView) {
        _testTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSize.width, SSize.height) style:UITableViewStylePlain];
        _testTableView.delegate = self;
        _testTableView.dataSource = self;
        [_testTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 30)];
        headerLabel.textColor = [UIColor redColor];
        headerLabel.text = @"HEAD";
        _testTableView.tableHeaderView = headerLabel;
        
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 30)];
        footerLabel.textColor = [UIColor redColor];
        footerLabel.text = @"FOOT";
        _testTableView.tableFooterView = footerLabel;
        
//        //索引颜色
//        _testTableView.sectionIndexColor = [UIColor redColor];
//        //索引背景颜色
//        _testTableView.sectionIndexBackgroundColor = [UIColor blueColor];
        

    }
    return _testTableView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)arrayDS {
    if (!_arrayDS) {
        _arrayDS = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.sectionDS.count; i++) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSInteger randomIndex = arc4random() % 15;
            for (int j = 0; j < randomIndex; j++) {
                [array addObject:[NSString stringWithFormat:@"section:%c row:%d",65+i,j]];
            }
            
            [_arrayDS addObject:array];
        }
    }
    return _arrayDS;
}

- (NSArray *)sectionDS {
    if (!_sectionDS) {
        _sectionDS = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    }
    return _sectionDS;
}

@end
