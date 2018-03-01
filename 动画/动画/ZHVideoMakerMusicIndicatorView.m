//
//  ZHVideoMakerMusicIndicatorView.m
//  ZHModuleVideoMaker
//
//  Created by niuhui on 2017/9/20.
//

#import "ZHVideoMakerMusicIndicatorView.h"
@interface ZHVideoMakerMusicIndicatorView ()

@property (nonatomic ,strong) NSMutableArray <CALayer *> * layers;

@end

const NSInteger barCount = 3;
const CGFloat   barWidth = 2;
const CGFloat   horizontalBarSpacing = 2.0f;
const CGFloat   barMaxPeakHeight = 12.0;
const CGFloat   barMinPeakHeight = 6.0;
NSString * const decayAnimationKey = @"decay";
NSString * const scillationAnimationKey = @"oscillation";

@implementation ZHVideoMakerMusicIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareBarLayers];
    }
    return self;
}
- (void)setState:(ZHVideoMakerMusicIndicatorViewState)state
{
    switch (state) {
        case ZHVideoMakerMusicIndicatorViewStatePlaying:
            [self startAnimating];
            break;
        case ZHVideoMakerMusicIndicatorViewStateStopped:
            [self stopAnimating];
            break;
        default:
            break;
    }
}
- (void)stopAnimating
{
    [self stopOscillation];
    [self startDecay];
}
- (void)startAnimating
{
    [self stopDecay];
    [self startOscillation];
}
- (void)startDecay
{
    for (CALayer * layer in self.layers) {
        [self startDecayingBarLayer:layer];
    }
}
- (void)stopDecay
{
    for (CALayer * layer in self.layers) {
        [layer removeAnimationForKey:decayAnimationKey];
    }
}
- (void)startOscillation
{
    CFTimeInterval basePeriod = (CFTimeInterval)(0.6 + drand48() * (0.8 - 0.6));
    for (CALayer * layer in self.layers) {
        [self startOscillatingBarLayer:layer basePeriod:basePeriod];
    }
}
- (void)stopOscillation
{
    for (CALayer * layer in self.layers) {
        [layer removeAnimationForKey:scillationAnimationKey];
    }
}
- (void)startOscillatingBarLayer:(CALayer *)layer basePeriod:(CFTimeInterval)basePeriod
{
    CGFloat height = barMinPeakHeight + (arc4random_uniform((barMaxPeakHeight - barMinPeakHeight + 1)));
    CGRect fromBounds = layer.bounds;
    fromBounds.size.height = 3.0;
    CGRect toBounds = layer.bounds;
    toBounds.size.height = height;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.fromValue = @(fromBounds);
    animation.toValue   = @(toBounds);
    animation.repeatCount = MAX_CANON;
    animation.autoreverses = YES;
    animation.duration = basePeriod/2 * (barMaxPeakHeight/height);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:scillationAnimationKey];
}
- (void)startDecayingBarLayer:(CALayer *)layer
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    if ([layer presentationLayer]) {
        animation.fromValue = @([[CALayer alloc] initWithLayer:[layer presentationLayer]].bounds);
    }
    animation.toValue = @(layer.bounds);
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:decayAnimationKey];
}
- (void)prepareBarLayers
{
    CGFloat offset = 0.0f;
    for (int i = 1; i <= barCount; i ++) {
        CALayer *layer = [self createBarLayer:offset Index:i];
        layer.backgroundColor = [UIColor redColor].CGColor;
        [self.layers addObject:layer];
        [self.layer addSublayer:layer];
        offset = CGRectGetMaxX(layer.frame) + horizontalBarSpacing;
    }
}
- (CALayer *)createBarLayer:(CGFloat)offset Index:(NSInteger)index
{
    CALayer *layer = [[CALayer alloc] init];
    layer.anchorPoint = CGPointMake(0, 1);
    layer.position = CGPointMake(offset, barMaxPeakHeight);
    layer.bounds = CGRectMake(0, 0, barWidth, (CGFloat)(index * barMaxPeakHeight/(CGFloat)barCount));
    return layer;
}
#pragma mark -
- (NSMutableArray<CALayer *> *)layers
{
    if (!_layers) {
        _layers = [NSMutableArray array];
    }
    return _layers;
}
@end
