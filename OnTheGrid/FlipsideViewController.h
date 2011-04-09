//
//  FlipsideViewController.h
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController {

    UISlider *_cellSizeSlider;
    UILabel *_cellSizeSliderLabel;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
@property (nonatomic, retain) IBOutlet UISlider *cellSizeSlider;
@property (nonatomic, retain) IBOutlet UILabel *cellSizeSliderLabel;

- (IBAction)sliderValueChanged:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
