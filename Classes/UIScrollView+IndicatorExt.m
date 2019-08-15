
#import "UIScrollView+IndicatorExt.h"
#import <objc/runtime.h>

NSInteger kILSDefaultSliderSizeW;
NSInteger kILSDefaultSliderSizeH;

@interface ILSSlider ()
{
    CGPoint _startCenter;
    
}
@end

@implementation ILSSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
        _sliderIcon = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_sliderIcon];
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _startCenter = self.center;
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:self];
        self.center = CGPointMake(self.center.x, _startCenter.y + point.y);
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
    //    if (_status != ILSSliderStatusBottom) {
    //        return;
    //    }
    
    self.center = CGPointMake(self.center.x, kILSDefaultSliderSizeH * 0.5);
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

- (void)setStatus:(ILSSliderStatus)status
{
    _status = status;
    
    //    switch (status) {
    //        case ILSSliderStatusTop:
    //            _sliderIcon.image = [UIImage imageNamed:@"btn_slider_normal"];
    //            break;
    //        case ILSSliderStatusCenter:
    //            _sliderIcon.image = [UIImage imageNamed:@"btn_slider_selected"];
    //            break;
    //        case ILSSliderStatusBottom:
    //            _sliderIcon.image = [UIImage imageNamed:@"btn_slider_top"];
    //            break;
    //        default:
    //            break;
    //    }
}

@end


@implementation ILSIndicatorView

- (void)dealloc
{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}
- (void)setNewThumImage:(UIImage *)image size:(CGSize)size{
    _slider.frame = CGRectMake(0, 0, size.width, size.height);
    _slider.sliderIcon.image = image;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _slider = [[ILSSlider alloc] initWithFrame:CGRectMake(0, 0, kILSDefaultSliderSizeW, kILSDefaultSliderSizeH)];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        //        _slider.status = ILSSliderStatusTop;
        [self addSubview:_slider];
        self.clipsToBounds = TRUE;
    }
    return self;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:0x01 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        float sliderOffsetY = _scrollView.contentOffset.y/(_scrollView.contentSize.height - _scrollView.frame.size.height) * (self.frame.size.height - kILSDefaultSliderSizeH);
        
        float centerY = sliderOffsetY + kILSDefaultSliderSizeH * 0.5;
        
        //        if (centerY <= kILSDefaultSliderSize * 0.5) {
        //            centerY = kILSDefaultSliderSize * 0.5;
        //            _slider.status = ILSSliderStatusTop;
        //
        //        } else if (centerY >= self.frame.size.height - kILSDefaultSliderSize * 0.5) {
        //
        //            centerY = self.frame.size.height - kILSDefaultSliderSize * 0.5;
        //            _slider.status = ILSSliderStatusBottom;
        //        } else {
        //            _slider.status = ILSSliderStatusCenter;
        //        }
        
        _slider.center = CGPointMake(kILSDefaultSliderSizeW * 0.5, centerY);
    }
}

- (void)sliderValueChanged:(UISlider *)slider
{
    self.value = (slider.center.y - 0.5 * kILSDefaultSliderSizeH)/(self.frame.size.height - kILSDefaultSliderSizeH);
    
    self.value = MAX(self.value, 0.0);
    self.value = MIN(self.value, 1.0);
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end

@implementation UIScrollView (IndicatorExt)

const char kIndicatorKey;

- (void)setIndicator:(ILSIndicatorView *)indicator
{
    objc_setAssociatedObject(self, &kIndicatorKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ILSIndicatorView *)indicator
{
    return objc_getAssociatedObject(self, &kIndicatorKey);
}

- (void)registerILSIndicator:(UIImage *)image imageSize:(CGSize)size
{
    if (!self.scrollEnabled || self.contentSize.height <= self.frame.size.height || self.indicator) {
        return;
    }
    
    kILSDefaultSliderSizeW = size.width;
    kILSDefaultSliderSizeH = size.height;
    
    
    self.showsVerticalScrollIndicator = FALSE;
    
    ILSIndicatorView *indicator = [[ILSIndicatorView alloc] initWithFrame:CGRectMake(self.frame.origin.x + self.frame.size.width - kILSDefaultSliderSizeW, self.frame.origin.y + kILSDefaultSliderMargin, size.width, CGRectGetHeight(self.bounds) - 2 * kILSDefaultSliderMargin)];
    [indicator addTarget:self action:@selector(indicatorValueChanged:) forControlEvents:UIControlEventValueChanged];
    [indicator setNewThumImage:image size:size];
    indicator.scrollView = self;
    self.indicator = indicator;
    [self.superview addSubview:indicator];
}


- (void)indicatorValueChanged:(ILSIndicatorView *)indicator
{
    float contentOffset = indicator.value * (self.contentSize.height - self.frame.size.height);
    
    self.contentOffset = CGPointMake(0, contentOffset);
}

@end
