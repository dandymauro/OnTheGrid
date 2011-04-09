//
//  FlipsideViewController.m
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController
@synthesize cellSizeSlider = _cellSizeSlider;
@synthesize cellSizeSliderLabel = _cellSizeSliderLabel;

@synthesize delegate=_delegate;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor]; 
    int cellSizeSliderValue = self.cellSizeSlider.value * 100;
    self.cellSizeSliderLabel.text = [NSString stringWithFormat:@"%d", cellSizeSliderValue];
}

- (void)viewDidUnload
{
    [self setCellSizeSlider:nil];
    [self setCellSizeSliderLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)sliderValueChanged:(id)sender {
    //NSLog(@"sliderValueChanged");
    int cellSizeSliderValue = self.cellSizeSlider.value * 100;
    //NSLog(@"%@",[NSString stringWithFormat:@"%d", cellSizeSliderValue]);
    self.cellSizeSliderLabel.text = [NSString stringWithFormat:@"%d", cellSizeSliderValue];
}
@end
