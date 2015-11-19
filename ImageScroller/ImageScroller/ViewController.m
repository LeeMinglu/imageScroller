//
//  ViewController.m
//  ImageScroller
//
//  Created by 李明禄 on 15/11/19.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat x = 0;
    
    NSInteger imageCount = 5;
    
    CGFloat y = self.imageScrollView.bounds.origin.y;
    CGFloat width = self.imageScrollView.bounds.size.width;
    CGFloat height = self.imageScrollView.bounds.size.height;
    
    //设置scrollView的contentSize
    self.imageScrollView.contentSize = CGSizeMake(5 * width, 0);
    self.imageScrollView.bounces = NO;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    
    //添加UIImageView
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        x += i * self.imageScrollView.bounds.size.width;
        
        CGRect frame = CGRectMake(x, y, width, height);
        
        imageView.frame = frame;
        
        imageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        
        [self.imageScrollView addSubview:imageView];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
