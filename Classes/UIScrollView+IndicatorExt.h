
#import <UIKit/UIKit.h>


const static NSInteger kILSDefaultSliderMargin = 0;

@interface ILSSlider : UIControl


@property (nonatomic, strong) UIImageView *sliderIcon;

@end

@interface ILSIndicatorView : UIControl

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) ILSSlider *slider;
@property (nonatomic, assign) float value;

@end

@interface UIScrollView (IndicatorExt)

@property (nonatomic, strong) ILSIndicatorView *indicator;

- (void)registerILSIndicator:(UIImage *)image imageSize:(CGSize)size;

@end
