//
//  HeaderView.m
//  YbYoutianNew
//
//  Created by macbook on 16/1/3.
//  Copyright © 2016年 YBON. All rights reserved.
//

#import "CirculateView.h"
#import "UIImageView+WebCache.h"

@implementation CirculateView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UILabel * _titleLabel1;
   // UILabel *_titleLabel2;
    UILabel *_backLabel;
    NSMutableArray *_dataArray;//存放数据源信息
    //定时器
    NSTimer *_timer;
    NSInteger _pageIndex;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubViews];
        
    }
    return self;
}
-(void)createSubViews
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    //指定滚动视图的代理
    _scrollView.delegate = self;
    
    //设置按页滚动
    _scrollView.pagingEnabled = YES;
    //隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    [self addSubview:_scrollView];
    
    _backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height -30, MainScreenWidth, 30)];
    _backLabel.backgroundColor = [UIColor colorWithRed:0.32f green:0.32f blue:0.32f alpha:0.00f];
    _backLabel.alpha = 0.5;
    [self addSubview:_backLabel];
    
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(200, 150-40, MainScreenWidth-200, 40)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0.94f green:0.75f blue:0.00f alpha:1.0f];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    _titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.frame.size.height - 30, 200, 30)];
    _titleLabel1.backgroundColor = [UIColor clearColor];
    _titleLabel1.font = [UIFont systemFontOfSize:15];
    _titleLabel1.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel1];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tapAction:(UIGestureRecognizer *) gesture {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(circulateViewClicked:)]) {
            [self.delegate circulateViewClicked: _pageIndex];
        }
    }
}

-(void)addScrollImages:(NSArray *)array
{
    _dataArray = [[NSMutableArray alloc] initWithArray: array];
    if (_dataArray.count == 0) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImageView.image = [UIImage imageNamed:@"beijingtu"];
        [self addSubview:bgImageView];
    }
    
    //根据数据多少，设置显示尺寸大小
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * ([_dataArray count]), 0);
    //刷新显示的图片
    for (UIView * subView in _scrollView.subviews)
    {
        //移除所有的子视图
        [subView removeFromSuperview];
    }
    //添加新的显示图片
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor orangeColor], nil];
    int i = 0;
    for(int j = 0; j <_dataArray.count ;j++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        //设置图片位置和大小
        imageView.frame = CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        imageView.layer.cornerRadius = 10;
        imageView.backgroundColor = colors[j];
        [_scrollView addSubview:imageView];
        i++;
    }
    
    //设置_pageControl
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = [_dataArray count];
    if ([_dataArray count] > 0) {
//        _titleLabel1.text = adModel.name;
    }
    
    if ([_dataArray count] <= 1) {
        _scrollView.scrollEnabled = NO;
    }
    //创建定时器，创建之后马上启动
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    [self performSelector:@selector(nextPage) withObject:nil afterDelay:2];
}

//结束减速，滚动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    _pageControl.currentPage = index;
    _pageIndex = index;
}

-(void)nextPage{
    
    NSLog(@"nextPage....");
    if ([_dataArray count] <= 1)
        return;
    //滚动视图变化
    _pageIndex++;
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * _pageIndex, 0);
    if (_pageIndex == [_dataArray count]) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        _pageIndex = 0;
    }
    //页面控件变化
    _pageControl.currentPage = _pageIndex;
    
//    AdDataModel *adModel = _dataArray[_pageIndex];
//    _titleLabel1.text = adModel.name;
    
//    [self performSelector:@selector(nextPage) withObject:nil afterDelay:2];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

@end
