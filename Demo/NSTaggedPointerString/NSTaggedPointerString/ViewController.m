//
//  ViewController.m
//  NSTaggedPointerString
//
//  Created by chenyong@bbtree.com on 2017/12/1.
//  Copyright © 2017年 chenyong@bbtree.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    {  //1taskId  2type  3userId  4childId  5circleId
        
        NSNumber *number =[NSNumber numberWithInteger:12];
        [number stringValue];
        NSArray * arr = [@"12,wews,232sdshjadhjwdhsahd" componentsSeparatedByString:@","];
        if (arr.count >0) {
            NSString * task_id = [[arr objectAtIndex:0] mutableCopy];
            if ([arr objectAtIndex:0]) {
                if ([[arr objectAtIndex:0] isKindOfClass:[NSString class]]) {
                    task_id = [arr objectAtIndex:0];
                } else {
                    task_id = [[arr objectAtIndex:0] stringValue];
                }
            }
            
            NSString * type;
            if ([arr objectAtIndex:1]) {
                if ([[arr objectAtIndex:1] isKindOfClass:[NSString class]]) {
                    type = [arr objectAtIndex:1];
                } else {
                    type = [[arr objectAtIndex:1] stringValue];
                }
            }
            
            NSString * user_id;
            if ([arr objectAtIndex:2]) {
                if ([[arr objectAtIndex:2] isKindOfClass:[NSString class]]) {
                    user_id = [arr objectAtIndex:2];
                } else {
                    user_id = [[arr objectAtIndex:2] stringValue];
                }
            }
        }
    }
}


__weak typeof(self) weakSelf=self;

[PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
    
    NSArray *localImages = weakSelf.images;
    
    NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
    for (NSUInteger i = 0; i< localImages.count; i++) {
        
        PhotoModel *pbModel=[[PhotoModel alloc] init];
        pbModel.mid = i + 1;
        pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
        pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
        pbModel.image = localImages[i];
        
        //源frame
        UIImageView *imageV =(UIImageView *) weakSelf.contentView.subviews[i];
        pbModel.sourceImageView = imageV;
        
        [modelsM addObject:pbModel];
    }
    
    return modelsM;
}];
}
- (IBAction)showAction:(id)sender {
    
    //本地图片展示
    [self localImageShow];
    
    //展示网络图片
    // [self networkImageShow];
}

/*
 * 本地图片展示
 */
-(void)localImageShow{
    
    [PhotoBroswerVC show:self index:2 photoModelBlock:^NSArray *{
        
        NSArray *localImages = @[
                                 
                                 [UIImage imageNamed:@"15"],
                                 [UIImage imageNamed:@"14"],
                                 [UIImage imageNamed:@"13"],
                                 [UIImage imageNamed:@"12"],
                                 [UIImage imageNamed:@"11"]
                                 ];
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image = localImages[i];
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
        
    }];
}


/*
 * 展示网络图片
 */
-(void)networkImageShow{
    
    [PhotoBroswerVC show:self index:2 photoModelBlock:^NSArray *{
        
        
        NSArray *networkImages=@[
                                 @"http://www.fevte.com/data/attachment/forum/day_110425/110425102470ac33f571bc1c88.jpg",
                                 @"http://www.netbian.com/d/file/20150505/5a760278eb985d8da2455e3334ad0c0f.jpg",
                                 @"http://www.netbian.com/d/file/20141006/e9d6f04046d483843d353d7a301d36f8.jpg",
                                 @"http://www.netbian.com/d/file/20130906/134dca4108f3f0ed10a4cc3f78848856.jpg",
                                 @"http://www.netbian.com/d/file/20121111/a03b9adb18a982f6a49aa7bfa7b82371.jpg",
                                 @"http://www.netbian.com/d/file/20130421/e0dabeee4e1e62fe114799bc7e4ccd66.jpg",
                                 @"http://www.netbian.com/d/file/20121012/c890c1da17bb5b4291e9733fad8efb42.jpg",
                                 @"http://www.netbian.com/d/file/20150318/c5c68492a4d6998229d1b6068c77951e.jpg0"
                                 ];
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
        
        
    }];
}

/*
 * 展示网络图片
 */
-(void)networkImageShow:(NSUInteger)index{
    
    //避免循环引用
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        
        NSArray *networkImages=@[
                                 @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
                                 @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
                                 @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
                                 @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
                                 @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
                                 
                                 @"http://www.netbian.com/d/file/20140522/3e939daa0343d438195b710902590ea0.jpg",
                                 
                                 @"http://www.netbian.com/d/file/20141018/7ccbfeb9f47a729ffd6ac45115a647a3.jpg",
                                 
                                 @"http://www.netbian.com/d/file/20140724/fefe4f48b5563da35ff3e5b6aa091af4.jpg",
                                 
                                 @"http://www.netbian.com/d/file/20140529/95e170155a843061397b4bbcb1cefc50.jpg"
                                 ];
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
            //源frame
            UIImageView *imageV =(UIImageView *) weakSelf.contentView.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];

    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
