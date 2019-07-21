//
//  ColorPickerAnimatedTransitioning.m
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

#import "ColorPickerAnimatedTransitioning.h"
#import "ColorPickerViewController.h"

@interface ColorPickerAnimatedTransitioning()

@property BOOL isPresent;

@end

@implementation ColorPickerAnimatedTransitioning

- (instancetype)initWithPresent:(BOOL)isPresent {
    self = [super init];
    if (self) {
        self.isPresent = isPresent;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView* containerView = transitionContext.containerView;
    
    ColorPickerViewController* picker;
    if (self.isPresent) {
        picker = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        picker.backgroundView.alpha = 0.0;
        
        
        [containerView addSubview:picker.view];
        [picker.view layoutIfNeeded];
    } else {
        picker = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
    CGPoint wasCenter = picker.cardView.center;
    CGPoint offCenter = wasCenter;
    offCenter.y += picker.view.bounds.size.height;
    if (self.isPresent) {
        picker.cardView.center = offCenter;
    }
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (self.isPresent) {
            picker.cardView.center = wasCenter;
            picker.backgroundView.alpha = 1.0;
        } else {
            picker.cardView.center = offCenter;
            picker.backgroundView.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        if (!self.isPresent) {
            [picker.view removeFromSuperview];
            picker.cardView.center = wasCenter;
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
