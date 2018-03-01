//
//  ZHVideoMakerMusicIndicatorView.h
//  ZHModuleVideoMaker
//
//  Created by niuhui on 2017/9/20.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZHVideoMakerMusicIndicatorViewState) {
    ZHVideoMakerMusicIndicatorViewStateStopped,
    ZHVideoMakerMusicIndicatorViewStatePlaying,
};
@interface ZHVideoMakerMusicIndicatorView : UIView

@property (nonatomic ,assign) ZHVideoMakerMusicIndicatorViewState state;

- (void)prepareLayoutPriorities;
@end
