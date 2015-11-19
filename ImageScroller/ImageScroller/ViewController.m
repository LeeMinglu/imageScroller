//
//  ViewController.m
//  ImageScroller
//
//  Created by 李明禄 on 15/11/19.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat x = 0;
    
    int imageCount = 5;
    
    CGFloat width = self.imageScrollView.bounds.size.width;
    
    //设置scrollView的contentSize
    self.imageScrollView.contentSize = CGSizeMake(5 * width, 0);
    self.imageScrollView.bounces = NO;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    
    //让控制器作为scrollView的代理
    self.imageScrollView.delegate = self;
    
    //添加UIImageView
    for (int i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = self.imageScrollView.bounds;
//
//        x += i * self.imageScrollView.bounds.size.width;
//        
//        CGRect frame = CGRectMake(x, y, width, height);
//        
//        
//        
////        imageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//        
//        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i+1];
//        
//        UIImage *image = [UIImage imageNamed:imageName];
//        
//        imageView.image = image;
//        imageView.frame = frame;
        
        imageView.frame = self.imageScrollView.bounds;
        //        img_01
        NSString *imageName = [NSString stringWithFormat:@"img_%02d", i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        imageView.image = image;
        
        x = i * imageView.frame.size.width;
        CGRect frame = CGRectMake(x, 0, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.height );
        
        imageView.frame = frame;
        
        [self.imageScrollView addSubview:imageView];
        
    }
    
    //添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void)nextImage {
    
    //获取当前的页数
    NSInteger page = self.pageControl.currentPage;
    
    //判断是否是最后一页
    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;
    }
    page ++;
    
    //根据页数计算当前的offSet
    CGFloat offSetX = page * self.imageScrollView.bounds.size.width;
    
    //设置scrollView的offSet
    self.imageScrollView.contentOffset = CGPointMake(offSetX, 0);
    
}


#pragma mark - 实现scrollView的代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.bounds.size.width;
    
    CGFloat offSetX = scrollView.contentOffset.x;
    
    int page = (offSetX + width * 0.5) / width;
    
    self.pageControl.currentPage = page;
    
    
}

//当开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    
    self.timer = nil;
}


//当停止拖拽的时候打开计时器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];

}

@end
