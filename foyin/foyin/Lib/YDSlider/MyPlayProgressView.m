//
//  MyTestView.m
//  DrawTest
//
//  Created by Mango on 16/6/26.
//  Copyright © 2016年 Mango. All rights reserved.
//

#import "MyPlayProgressView.h"

#define kMyPlayProgressViewWidth (self.frame.size.width - 7.5*2)
#define kPlayProgressBarHeight 2

@implementation MyPlayProgressView {
    
    UIView *_bgProgressView;
    UIView *_ableBufferProgressView;
    UIView *_finishPlayProgressView;
    
    CGPoint _lastPoint;
    UIButton *_sliderBtn;

    UIActivityIndicatorView *_indicatorView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _minimumValue = 0.f;
        _maximumValue = 1.f;
        
        self.backgroundColor = [UIColor clearColor];

        CGFloat showY = (self.frame.size.height - kPlayProgressBarHeight)*0.5;
        
        /* 背景 */
        _bgProgressView = [[UIView alloc] initWithFrame:CGRectMake(7.5, showY, kMyPlayProgressViewWidth, kPlayProgressBarHeight)];
        _bgProgressView.backgroundColor = [UIColor blackColor];
        _bgProgressView.layer.cornerRadius = kPlayProgressBarHeight / 2;
        _bgProgressView.layer.masksToBounds = YES;
        [self addSubview:_bgProgressView];
        
        /* 缓存进度 */
        _ableBufferProgressView = [[UIView alloc] initWithFrame:CGRectMake(7.5, showY, 0, kPlayProgressBarHeight)];
        _ableBufferProgressView.backgroundColor = [UIColor yellowColor];
        _ableBufferProgressView.layer.cornerRadius = kPlayProgressBarHeight / 2;
        _ableBufferProgressView.layer.masksToBounds = YES;
        [self addSubview:_ableBufferProgressView];
        
        /* 播放进度 */
        _finishPlayProgressView = [[UIView alloc] initWithFrame:CGRectMake(7.5, showY, 0, kPlayProgressBarHeight)];
        _finishPlayProgressView.backgroundColor = [UIColor redColor];
        _finishPlayProgressView.layer.cornerRadius = kPlayProgressBarHeight / 2;
        _finishPlayProgressView.layer.masksToBounds = YES;
        [self addSubview:_finishPlayProgressView];
        
        /* 滑动按钮 */
        _sliderBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, showY, 15, 15)];
        [_sliderBtn setBackgroundImage:[UIImage imageNamed:@"sliderbg"] forState:UIControlStateNormal];
        _sliderBtn.layer.cornerRadius = _sliderBtn.frame.size.height*0.5;
        _sliderBtn.layer.masksToBounds = YES;
        
        CGPoint center = _sliderBtn.center;
        center.y = _finishPlayProgressView.center.y;
        _sliderBtn.center = center;
        [_sliderBtn addTarget:self action:@selector(beiginSliderScrubbing) forControlEvents:UIControlEventTouchDown];
        [_sliderBtn addTarget:self action:@selector(endSliderScrubbing) forControlEvents:UIControlEventTouchCancel];
        [_sliderBtn addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_sliderBtn addTarget:self action:@selector(endSliderScrubbing) forControlEvents:UIControlEventTouchUpInside];
        [_sliderBtn addTarget:self action:@selector(endSliderScrubbing) forControlEvents:UIControlEventTouchUpOutside];
        [_sliderBtn addTarget:self action:@selector(sliderScrubbing) forControlEvents:UIControlEventValueChanged];
        _lastPoint = _sliderBtn.center;
        [self addSubview:_sliderBtn];
        
        /*添加加载菊花*/
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_indicatorView setCenter:_sliderBtn.center];
        [_indicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
        CGAffineTransform transform = CGAffineTransformMakeScale(.6f, .6f);
        _indicatorView.transform = transform;
        [_sliderBtn addSubview:_indicatorView];
        [_indicatorView startAnimating];
    }
    return self;
}

- (void)setPlayProgressBackgoundColor:(UIColor *)playProgressBackgoundColor{
    if (_playProgressBackgoundColor != playProgressBackgoundColor) {
         _finishPlayProgressView.backgroundColor = playProgressBackgoundColor;
    }
    
}

- (void)setTrackBackgoundColor:(UIColor *)trackBackgoundColor{
    if (_trackBackgoundColor != trackBackgoundColor) {
        _ableBufferProgressView.backgroundColor = trackBackgoundColor;
    }
}

- (void)setProgressBackgoundColor:(UIColor *)progressBackgoundColor{
    if (_progressBackgoundColor != progressBackgoundColor) {
        _bgProgressView.backgroundColor = progressBackgoundColor;
    }
}

/**
   进度值
 */
- (void)setValue:(CGFloat)progressValue{
    
    _value = progressValue;
    
    CGFloat finishValue = _bgProgressView.frame.size.width * progressValue;
    CGPoint tempPoint = _sliderBtn.center;
    tempPoint.x =  _bgProgressView.frame.origin.x + finishValue;
    
    if (tempPoint.x >= _bgProgressView.frame.origin.x && tempPoint.x <= (self.frame.size.width - 7.5)){
 
        if (_value == 0) {
            
            if (_indicatorView.isAnimating == NO) {
                [_indicatorView startAnimating];
            }

            _sliderBtn.center = tempPoint;
            _lastPoint = _sliderBtn.center;
            
            CGRect tempFrame = _finishPlayProgressView.frame;
            tempFrame.size.width = tempPoint.x - 0.5;
            _finishPlayProgressView.frame = tempFrame;
            
        }else {
            
            
            if (_indicatorView.isAnimating == YES) {
                [_indicatorView stopAnimating];
            }
            
            _sliderBtn.center = tempPoint;
            _lastPoint = _sliderBtn.center;
            
            CGRect tempFrame = _finishPlayProgressView.frame;
            tempFrame.size.width = tempPoint.x - 0.5;
            _finishPlayProgressView.frame = tempFrame;
        }
    }
}


- (void)setSliderFrame {


}

/**
   设置缓冲进度值
 */
-(void)setTrackValue:(CGFloat)trackValue {
    
    _trackValue = trackValue;
    
    CGFloat finishValue = _bgProgressView.frame.size.width * trackValue;
    CGRect tempFrame = _ableBufferProgressView.frame;
    tempFrame.size.width = finishValue;
    
    if (trackValue == 0) {
        _ableBufferProgressView.frame = tempFrame;
    }else{
        [UIView animateWithDuration:3.0 animations:^{
            _ableBufferProgressView.frame = tempFrame;
        }];
    }
}

/**
   拖动进度值
 */
- (void) dragMoving: (UIButton *)btn withEvent:(UIEvent *)event{

    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    CGFloat offsetX = point.x - _lastPoint.x;
    CGPoint tempPoint = CGPointMake(btn.center.x + offsetX, btn.center.y);

    // 得到进度值
    CGFloat progressValue = (tempPoint.x - _bgProgressView.frame.origin.x)*1.0f/_bgProgressView.frame.size.width;
    [self setValue:progressValue];
    [_delegate sliderScrubbing];
}
// 开始拖动
- (void)beiginSliderScrubbing{
    [_delegate beiginSliderScrubbing];
}
// 结束拖动
- (void)endSliderScrubbing{
    [_delegate endSliderScrubbing];
}
// 拖动值发生改变
- (void)sliderScrubbing{
    [_delegate sliderScrubbing];
}

@end
