//
//  XLCycleView.m
//  IOSMasterPlate
//
//  Created by zhangfeng on 13-6-5.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import "XLCycleView.h"

#define kOffset            0.0f
#define kDefaultOffset     2 * self.width

@interface CTScrollView : UIScrollView

@property (nonatomic,weak) id autoDelegate;

@property (nonatomic,strong) NSTimer *scrollTimer;

@end

@implementation CTScrollView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = YES;
        self.scrollsToTop = NO;
    }
    
    return self;
}

- (void)startTimer:(NSTimeInterval)scrollInterval {
    
    if (0.0f < scrollInterval)
    {
        [self stopTimer];
        
        self.scrollTimer = [NSTimer timerWithTimeInterval:scrollInterval target:self
                                                 selector:@selector(autoScroll:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)autoScroll:(id)sender {
    
    [self setContentOffset:CGPointMake(kDefaultOffset,0) animated:YES];
    
    if (self.autoDelegate && [self.autoDelegate respondsToSelector:@selector(autoScrollAction:)])
    {
        [self.autoDelegate autoScrollAction:nil];
    }
}

- (void)stopTimer {
    
    [[NSRunLoop currentRunLoop] cancelPerformSelectorsWithTarget:self];
    [self.scrollTimer invalidate];self.scrollTimer = nil;
}

@end

@interface XLCycleView () <UIScrollViewDelegate>

@property (nonatomic,strong) UIButton *showButton;
@property (nonatomic,strong) CTScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *contentViews;
@property (nonatomic,assign) CGFloat scrollDuration;

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger numberOfPage;

@end

@implementation XLCycleView

- (void)dealloc {

    for (UIButton *button in self.contentViews)
    {
        //[button stopImageRequest];
        [button removeFromSuperview];
    }
    
    self.delegate = nil;
    [self.scrollView stopTimer];
    self.scrollView.delegate = nil;
    self.scrollView.autoDelegate = nil;
    self.scrollView = nil;
}

+ (XLCycleView *)XLCycleView:(CGRect)frame bitmap:(UIImage *)bitmap {

    XLCycleView *cycleView = [[XLCycleView alloc] initWithFrame:frame];
    cycleView.scrollDuration = 0.0f;
    cycleView.currentPage = 0;cycleView.numberOfPage = 0;
    cycleView.backgroundColor = [UIColor whiteColor];
    
    cycleView.contentViews = [NSMutableArray array];
    cycleView.showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cycleView.showButton.frame = CGRectOffset(cycleView.bounds,kOffset,kOffset);
    //[cycleView.showButton setImage:bitmap mode:UIViewContentModeCenter];
    cycleView.showButton.exclusiveTouch = YES;cycleView.showButton.adjustsImageWhenHighlighted = NO;
    [cycleView addSubview:cycleView.showButton];
    [cycleView.contentViews addObject:cycleView.showButton];
    return cycleView;
}

- (void)reloadData:(NSTimeInterval)duration number:(NSInteger)number {
    
    if (number <= 0)
    {
        return;
    }
    
    for (UIButton *button in self.contentViews)
    {
        //[button stopImageRequest];
        [button removeFromSuperview];
    }
    
    self.currentPage = 0;
    self.numberOfPage = number;
    self.contentViews = [NSMutableArray array];
    
    [self.showButton removeFromSuperview];self.showButton = nil;
    [self.pageControl removeFromSuperview];self.pageControl = nil;
    self.scrollView.delegate = nil;[self.scrollView stopTimer];
    [self.scrollView removeFromSuperview];self.scrollView = nil;
    
    if (self.numberOfPage == 1)
    {
        self.showButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showButton.frame = self.bounds;
        self.showButton.exclusiveTouch = YES;
        self.showButton.adjustsImageWhenHighlighted = NO;
        [self.showButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.showButton.contentMode = UIViewContentModeScaleAspectFill;

        [self addSubview:self.showButton];
        [self.contentViews addObject:self.showButton];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshImage:withIndex:)])
        {
            [self.delegate refreshImage:self.showButton withIndex:self.currentPage];
        }
    }
    else
    {
        self.scrollView = [[CTScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;self.scrollView.autoDelegate = self;
        self.scrollView.contentSize = CGSizeMake(3*self.width,self.height);
        self.scrollView.contentOffset = CGPointMake(self.width,0);
        [self addSubview:self.scrollView];
        
        for (int i=0;i<3;i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectOffset(self.bounds,kOffset+i*self.width,kOffset);
            button.exclusiveTouch = YES;button.adjustsImageWhenHighlighted = NO;
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];[self.contentViews addObject:button];
        }
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,0,200,20)];
        self.pageControl.center = CGPointMake(self.width/2,self.height-10);
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.numberOfPages = self.numberOfPage;
        [self addSubview:self.pageControl];
        
        [self refreshDataSource];
    }
    
    if (1 < self.numberOfPage && 0.0f < duration)
    {
        self.scrollDuration = duration;[self.scrollView startTimer:self.scrollDuration];
    }
    else
    {
        self.scrollDuration = 0.0f;[self.scrollView stopTimer];
    }
}

- (void)refreshDataSource {

    self.pageControl.currentPage = self.currentPage;
    
    [self displayCurrentPage];
    
    [self.scrollView setContentOffset:CGPointMake(self.width,0) animated:NO];
}

- (void)displayCurrentPage {
    
    NSInteger prePage = [self validPageValue:self.currentPage-1];
    
    NSInteger lastPage = [self validPageValue:self.currentPage+1];
    
    for (UIButton *button in self.contentViews)
    {
        NSUInteger index = [self.contentViews indexOfObject:button];
        
        if (0 == index)
        {
            button.tag = prePage;
        }
        else if (1 == index)
        {
            button.tag = self.currentPage;
            
            self.showButton = button;
        }
        else if (2 == index)
        {
            button.tag = lastPage;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshImage:withIndex:)])
        {
            [self.delegate refreshImage:button withIndex:button.tag];
        }
    }
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if (value == -1)
    {
        value = self.numberOfPage-1;
    }
    
    if (value == self.numberOfPage)
    {
        value = 0;
    }
    
    return value;
}

- (void)autoScrollAction:(XLCycleView *)cycleView {

    if (self.delegate && [self.delegate respondsToSelector:@selector(autoScrollAction:)])
    {
        [self.delegate autoScrollAction:self];
    }
}

- (void)clickAction:(UIButton *)btn {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xlcycleView:didSelectAtIndex:)])
    {
        [self.delegate xlcycleView:self didSelectAtIndex:self.currentPage];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(CTScrollView *)scrollView {
    
    [self.scrollView stopTimer];
}

- (void)scrollViewDidScroll:(CTScrollView *)aScrollView {
    
    NSInteger currentX = aScrollView.contentOffset.x;
    
    if (kDefaultOffset <= currentX)
    {
        self.currentPage = [self validPageValue:self.currentPage+1];
        
        [self refreshDataSource];
    }
    
    if (currentX <= 0)
    {
        self.currentPage = [self validPageValue:self.currentPage-1];
        
        [self refreshDataSource];
    }
}

- (void)scrollViewDidEndDragging:(CTScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self.scrollView startTimer:self.scrollDuration];
}

- (void)scrollViewDidEndDecelerating:(CTScrollView *)aScrollView {
    
    [self.scrollView setContentOffset:CGPointMake(self.width,0) animated:YES];
}

@end
