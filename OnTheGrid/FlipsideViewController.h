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
    UISlider *_generationTimerSlider;
    UILabel *_generationTimerSliderLabel;

}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;
@property (nonatomic, retain) IBOutlet UISlider *cellSizeSlider;
@property (nonatomic, retain) IBOutlet UILabel *cellSizeSliderLabel;
@property (nonatomic, retain) IBOutlet UISlider *generationTimerSlider;
@property (nonatomic, retain) IBOutlet UILabel *generationTimerSliderLabel;


- (IBAction)sliderValueChanged:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
