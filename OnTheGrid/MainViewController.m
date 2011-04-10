//
//  MainViewController.m
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "MainViewController.h"
#import "GridView.h"

@implementation MainViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.bounds = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 44);

    [self createGestureRecognizers];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
    int cellSize = controller.cellSizeSlider.value * 100;
    NSLog(@"Setting cellSize to %d", cellSize);
    ((GridView *)[self.view.subviews objectAtIndex:0]).cellSize = cellSize;
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (void)createGestureRecognizers {
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(handleSingleTap:)];
    singleFingerTap.numberOfTapsRequired = 1;
    [[self.view.subviews objectAtIndex:0] addGestureRecognizer:singleFingerTap];
    [singleFingerTap release];
}

- (IBAction)handleSingleTap:(UIGestureRecognizer *)sender {
    NSLog(@"handleSingleTap");
    CGPoint tapPoint = [sender locationInView:sender.view];
    ((GridView *)[self.view.subviews objectAtIndex:0]).touchPoint = tapPoint;
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
//    [UIView beginAnimations:nil context:NULL];
//    sender.view.center = tapPoint;
//    [UIView commitAnimations];
}

- (IBAction)handleClearButton{
    [((GridView *)[self.view.subviews objectAtIndex:0]) resetGrid];
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
