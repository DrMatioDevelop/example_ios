//
//  RegurOrHtmlViewController.m
//  example
//
//  Created by d2c_cyf on 17/2/22.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "RegurOrHtmlViewController.h"

@interface RegurOrHtmlViewController ()
@property (nonatomic, strong)UILabel *htmlLabel;
@end

@implementation RegurOrHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    [self htmlAddLabel];

    [self zhengze];
    

}

#pragma mark - 正则表达式
- (void)zhengze {
    //URLString = @"www.tmall.app/zegolive/watch/1114";    //直播或者录播
    NSString *searchText = @"/zegolive/watch/1114";
    NSString *regexStr   = @".*zegolive/watch/(\\d+)";

    
    NSString *searchText_1 = @"<p><img src=\"http://img.d2c.cn/2017/02/21/060132d03057ebe536af746c9f4054d5f3f5e8.jpg\"><br></p>";
    NSString *regexStr_1   = @".*src=\\s?\"([^\"]*)\".*";
    NSLog(@"%@",[[self class] matchString:searchText_1 toRegexString:regexStr_1]);

}


/**
 返回匹配正常的 字符串数组

 @param string   需要匹配的字符串
 @param regexStr 正则表达式
 @return 符合要求的字符串数组  按照（）分级
 */
+ (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        NSLog(@"%@",error);
        return @[];
    }
    
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    //match: 所有匹配到的字符,根据() 包含级
    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in matches) {
        for (int i = 0; i < [match numberOfRanges]; i++) {
          //以正则中的(),划分成不同的匹配部分
            NSString *comment = [string substringWithRange:[match rangeAtIndex:i]];
            [muArray addObject:comment];
        }
    }
    return muArray;
}
#pragma mark - NSPredicate
- (void)predicateTest {
    //    NSArray *array1 = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@5,@6,@7, nil];
    //    NSArray *array2 = [NSArray arrayWithObjects:@3,@5, nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"shanghai",@"guangzhou",@"wuhan",@"jinan",@"anhui", nil];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"self  like [c] 'an*'"];
    NSArray *temp1 = [array3 filteredArrayUsingPredicate:predicate1];
    NSLog(@"%@, %@",predicate1,temp1);
    // >, ==,  !=, like, contains, beginswith , endswith
}
#pragma mark - UILabel 加载html
/**
 UILabel 加载html
 * 使用NSDocumentTypeDocumentAttribute 加载html代码  会使NSAttribute属性不管用；直接可以设置的label属性可用
 * 当文字不足一行时 sizeTofit值计算出来的不是正常的字
 */
- (void)htmlAddLabel {
    NSString *htmlString=@"<html><body><img src=https://upload-images.jianshu.io/upload_images/937405-50a8ad2d8866fc12.png>                <font size=\"5\" color=\"#220022\">我改了你的影子在什么地方 你好呀 来相互伤害好不好，我改了你的影子在什么地方 你好呀 来相互伤害好不好，我改了你的影子在什么地方 你好呀 来相互伤害好不好</font></body></html>";
    NSString *htmlString_2 = @"<p><span style=\"color: rgb(1, 1, 1); font-family: tahoma, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(236, 235, 234); display: inline !important; float: none;\">我改了你的影子在什么地方 你好呀 来相互伤害好不好</span><!--EndFragment--><br><br><br></p>";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.lineSpacing   = 7.0;
    NSDictionary *dic = @{
                          NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                          NSFontAttributeName             : Font(10),
                          NSParagraphStyleAttributeName   : paragraphStyle
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithData:[htmlString_2 dataUsingEncoding:NSUnicodeStringEncoding] options:dic documentAttributes:nil error:nil];
    
    
    self.htmlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, SSize.width - 20, 54)];
    self.htmlLabel.textColor = [UIColor darkTextColor];
    self.htmlLabel.backgroundColor = [UIColor cyanColor];
    self.htmlLabel.text = NSStringFromClass([self class]);
    self.htmlLabel.attributedText = attributeStr;
    self.htmlLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.htmlLabel.numberOfLines = 3;
    self.htmlLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.htmlLabel.layer.borderWidth = 2.0;
    [self.htmlLabel sizeToFit];
    CGSize size = [self.htmlLabel sizeThatFits:CGSizeMake(SSize.width - 20.0, 0)];
    NSLog(@"--w:%f--h:%f",size.width,size.height);
    NSLog(@"++w:%f++h:%f",self.htmlLabel.width,self.htmlLabel.height);
    NSLog(@"%lf",self.htmlLabel.font.lineHeight);
    [self.view addSubview:self.htmlLabel];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.center.y, SSize.width - 20.0, 0)];
    label2.textColor = [UIColor redColor];
    label2.backgroundColor = [UIColor blueColor];
    label2.text = @"我的名字好长啊";
    [label2 sizeToFit];
    CGSize size2 = [label2 sizeThatFits:CGSizeZero];
    NSLog(@"--w:%f--h:%f",size2.width,size2.height);
    NSLog(@"++w:%f++h:%f",label2.width,label2.height);
    [self.view addSubview:label2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
