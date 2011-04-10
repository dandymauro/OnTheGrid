//
//  MainViewController.h
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {

}


- (IBAction)showInfo:(id)sender;

- (void)createGestureRecognizers;
- (IBAction)handleSingleTap:(UIGestureRecognizer *)sender;
- (IBAction)handleClearButton;
    
@end
