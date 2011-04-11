//
//  MainViewController.h
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    NSTimer *generationTimer;
    float generationTimerDelay;
    FlipsideViewController *settingsViewController;
}

@property(assign, readwrite)float generationTimerDelay;
@property(nonatomic, retain)FlipsideViewController *settingsViewController;
- (IBAction)showInfo:(id)sender;
- (void)createGestureRecognizers;
- (IBAction)handleSingleTap:(UIGestureRecognizer *)sender;
- (IBAction)handleClearButton;
- (IBAction)handlePlayButton;
- (IBAction)handlePauseButton;
- (void)doGeneration;
    
@end
