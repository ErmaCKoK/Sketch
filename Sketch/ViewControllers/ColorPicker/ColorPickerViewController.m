//
//  ColorPickerViewController.m
//  Sketch
//
//  Created by Andrii Kurshyn on 7/21/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "ColorPickerAnimatedTransitioning.h"

@interface ColorPickerViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;

@end

@implementation ColorPickerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self comonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self comonInit];
    }
    return self;
}

- (void)comonInit {
    self.transitioningDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.colors) {
        self.colors = @[UIColor.blackColor, UIColor.redColor, UIColor.blueColor, UIColor.greenColor, UIColor.yellowColor, UIColor.purpleColor];
    }
}

- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"color" forIndexPath:indexPath];
    cell.backgroundColor = self.colors[indexPath.item];
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate colorPickerViewController:self didSelect:self.colors[indexPath.item]];
}

#pragma mark - UIViewController TransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:[ColorPickerViewController class]]) {
        return [[ColorPickerAnimatedTransitioning alloc] initWithPresent:YES];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:[ColorPickerViewController class]]) {
        return [[ColorPickerAnimatedTransitioning alloc] initWithPresent:NO];
    }
    return nil;
}

@end
