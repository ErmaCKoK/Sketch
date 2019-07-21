//
//  ColorPickerAnimatedTransitioning.h
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorPickerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithPresent:(BOOL)isPresent;

@end

NS_ASSUME_NONNULL_END
