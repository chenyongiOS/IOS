//
//  ViewController.m
//  NSArray
//
//  Created by chenyong@bbtree.com on 2017/10/17.
//  Copyright © 2017年 chenyong@bbtree.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {DE
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray * photoArr =[NSArray arrayWithObjects:@"你",@"啊",@" 额",@"大肚分",@"非", nil];
    NSLog(@"photoArr to string ---%@",[photoArr componentsJoinedByString:@","]);
    
    NSString *string =@"你,啊, 额,大肚分,非";
    NSLog(@"string to array ----%@",[string componentsSeparatedByString:@","]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
