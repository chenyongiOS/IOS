//
//  ViewController.m
//  GCD
//
//  Created by chenyong@bbtree.com on 2017/9/27.
//  Copyright © 2017年 chenyong@bbtree.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"1"); // 任务1
    __block NSMutableArray *array = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for (int i =0; i<=200; i++) {
            UIImage *image = [UIImage imageNamed:@"1.png"];
            [array addObject:image];
        }
        NSLog(@"4---%lu",(unsigned long)[array count]); // 任务2
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2---%lu",(unsigned long)[array count]); // 任务2
        });
    });
    NSLog(@"3---%lu",(unsigned long)[array count]); // 任务3
    

    
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.lai.www", DISPATCH_QUEUE_SERIAL);
//    
//    dispatch_async(serialQueue, ^{
//        sleep(3);
//        NSLog(@"1");
//    });
//    dispatch_sync(serialQueue, ^{
//        
//        sleep(1);
//        NSLog(@"2");
//        
//    });
//    dispatch_async(serialQueue, ^{
//        NSLog(@"3");
//    });
//    dispatch_sync(serialQueue, ^{
//        sleep(5);
//        NSLog(@"4");
//    });
//    
//    dispatch_async(serialQueue, ^{
//        
//        NSLog(@"5");
//    });


//    NSLog(@"5");
//    [self startGCDTimer];
    
}

-(void) startGCDTimer{
    NSLog(@"6");
    // GCD定时器
    __block NSInteger count = 0;
    static dispatch_source_t _timer;
    NSTimeInterval period = 3.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Count");
            count++;
            
            
            if (count>=2) {
                // 关闭定时器
                dispatch_source_cancel(_timer);
            }
        });
    });
    
    // 开启定时器
    dispatch_resume(_timer);
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
