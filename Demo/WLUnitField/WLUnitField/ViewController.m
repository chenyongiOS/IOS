//
//  ViewController.m
//  WLUnitField
//
//  Created by chenyong@bbtree.com on 2017/10/19.
//  Copyright © 2017年 chenyong@bbtree.com. All rights reserved.
//

#import "ViewController.h"
#import "WLUnitField.h"
#import "NSString+Encode.h"
@interface ViewController ()
<WLUnitFieldDelegate>
{
    UIButton *applyAtentionBtn;//申请关注按钮
    WLUnitField *verificationTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *statusImage = [UIImage imageNamed:@"icon_fail"];
    UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, statusImage.size.width, statusImage.size.height)];
    tipImageView.image = statusImage;
    tipImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 40.0f + statusImage.size.height/2);
    [self.view addSubview:tipImageView];
    
    UILabel *applyResultLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 12+tipImageView.frame.origin.y+tipImageView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 22)];
    applyResultLabel.font = [UIFont systemFontOfSize:20];
    applyResultLabel.textColor =[@"#333333" colorWithHexString];
    applyResultLabel.textAlignment = NSTextAlignmentCenter;
    applyResultLabel.text = @"申请入园失败";
    [self.view addSubview:applyResultLabel];
    
    NSString *_joinFailReason = @"18623234392孟踩踩踩2号宝宝已经被爸爸(1862323492)加入了幼儿园，若你也是该宝贝的家长，请输入爸爸手机号中间四位进行验证，申请关注宝宝";
    NSString *failReason =_joinFailReason;
    NSString *showContent = @"";
    if (failReason.length>=11) {
        showContent = [failReason substringWithRange:NSMakeRange(11, failReason.length-11)];
    }
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 25+applyResultLabel.frame.origin.y+applyResultLabel.frame.size.height, [UIScreen mainScreen].bounds.size.width-80, [self getSpaceLabelHeight:showContent withFont:[UIFont systemFontOfSize:14] withWidth:[UIScreen mainScreen].bounds.size.width-80])];
    
    NSMutableAttributedString *contentAttributedString = [[NSMutableAttributedString alloc]initWithString:showContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [contentAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentAttributedString.string length])];
    [contentAttributedString addAttribute:NSForegroundColorAttributeName value:[@"#666666" colorWithHexString] range:NSMakeRange(0, [contentAttributedString.string length])];
    contentLabel.attributedText = contentAttributedString;
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:contentLabel];
    
    
    UIView *phoneView =[[UIView alloc] initWithFrame:CGRectMake(30, 270,[UIScreen mainScreen].bounds.size.width-60 , 34+40+12+40+34)];
    UIImage *bgimage =[UIImage imageNamed:@"bg_joinpark_number"];
    bgimage =[bgimage stretchableImageWithLeftCapWidth:bgimage.size.width/2 topCapHeight:bgimage.size.height/2];
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, phoneView.frame.size.width, phoneView.frame.size.height)];
    bgimageView.image = bgimage;
    [phoneView addSubview:bgimageView];
    [self.view addSubview:phoneView];
    
    float phoneNumberHeight = 40;//单个电话号码的高
    float verificationTextFieldWidth = 100;//
    
    NSString *frontPhone = @"";
    NSString *backPhone = @"";
    if (failReason.length>=11) {
        frontPhone = [failReason substringToIndex:3];
        backPhone = [failReason substringWithRange:NSMakeRange(7, 4)];
    }
    UILabel *frontPhoneLabel =[[UILabel alloc] initWithFrame:CGRectMake((phoneView.frame.size.width-verificationTextFieldWidth)/2-16*3-10, 34, 16*3, phoneNumberHeight)];
    frontPhoneLabel.font = [UIFont systemFontOfSize:27];
    frontPhoneLabel.textColor =[@"#999999" colorWithHexString];
    frontPhoneLabel.textAlignment = NSTextAlignmentRight;
    frontPhoneLabel.text = frontPhone;
    [phoneView addSubview:frontPhoneLabel];
    ////验证码输入框
    verificationTextField = [[WLUnitField alloc] initWithInputUnitCount:4];
    verificationTextField.frame = CGRectMake((phoneView.frame.size.width-verificationTextFieldWidth)/2-6,34, verificationTextFieldWidth, phoneNumberHeight);
    verificationTextField.delegate = self;
    verificationTextField.unitSpace = 3;
    verificationTextField.cursorColor = nil;
    verificationTextField.borderWidth = 0;
    verificationTextField.textFont = [UIFont systemFontOfSize:27];
    verificationTextField.textColor = [@"#333333" colorWithHexString];
    [verificationTextField addTarget:self action:@selector(unitFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [verificationTextField becomeFirstResponder];
    
    CGFloat lineWidth = (verificationTextFieldWidth-10)/4;
    for (int i = 0; i < 4; i++) {
        
        UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(verificationTextField.frame.origin.x+i*(3+lineWidth),verificationTextField.frame.origin.y , lineWidth, verificationTextField.frame.size.height)];
        
        lineImageView.layer.borderWidth =1;
        lineImageView.layer.borderColor = [@"#ddeaef" colorWithHexString].CGColor;
        [phoneView addSubview:lineImageView];
    }
    [phoneView addSubview:verificationTextField];
    
    UILabel *backPhoneLabel =[[UILabel alloc] initWithFrame:CGRectMake(verificationTextField.frame.size.width+5+verificationTextField.frame.origin.x, 34, 20*4, phoneNumberHeight)];
    backPhoneLabel.font = [UIFont systemFontOfSize:27];
    backPhoneLabel.textColor =[@"#999999" colorWithHexString];
    backPhoneLabel.textAlignment = NSTextAlignmentLeft;
    backPhoneLabel.text = backPhone;
    [phoneView addSubview:backPhoneLabel];
    
    
    applyAtentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    applyAtentionBtn.frame = CGRectMake(30, verificationTextField.frame.size.height+12+verificationTextField.frame.origin.y, phoneView.frame.size.width-60, 40);
    [applyAtentionBtn setTitle:@"申请关注" forState:UIControlStateNormal];
    applyAtentionBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    applyAtentionBtn.titleLabel.textColor = [@"#ffffff" colorWithHexString];
    [applyAtentionBtn setBackgroundColor:[@"#28d19d" colorWithHexString]];
    applyAtentionBtn.layer.cornerRadius = 6;
    applyAtentionBtn.alpha = 0.4;
    applyAtentionBtn.clipsToBounds=YES;
    [phoneView addSubview:applyAtentionBtn];
    
    
    UILabel *tipsLabel =[[UILabel alloc] initWithFrame:CGRectMake(phoneView.frame.origin.x, phoneView.frame.size.height+phoneView.frame.origin.y+2, phoneView.frame.size.width, 14)];
    tipsLabel.font = [UIFont systemFontOfSize:12];
    tipsLabel.textColor =[@"#999999" colorWithHexString];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.text = @"如有其它疑问，请联系该班教师咨询";
    [self.view addSubview:tipsLabel];
}
#pragma mark - 验证码输入回调
- (void)unitFieldEditingChanged:(WLUnitField *)sender {
    if (sender.text.length == 4) {
        applyAtentionBtn.alpha = 1.0;
        [verificationTextField resignFirstResponder];
    }else
    {
        applyAtentionBtn.alpha = 0.4;
    }
}

-(CGFloat)getSpaceLabelHeight:(NSString*)string withFont:(UIFont*)font withWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    /** 行间距 */
    paraStyle.lineSpacing = 13;
    NSDictionary *dic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
