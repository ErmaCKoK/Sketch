//
//  ColorPickerViewController.h
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ColorPickerViewDelegate;
@interface ColorPickerViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView* backgroundView;
@property (nonatomic, weak) IBOutlet UIView* cardView;

@property (nonatomic, strong) NSArray<UIColor*>* colors;

@property (nonatomic, weak) id<ColorPickerViewDelegate> delegate;

@end

@protocol ColorPickerViewDelegate <NSObject>

- (void) colorPickerViewController:(ColorPickerViewController*)colorPickerViewController didSelect:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END


