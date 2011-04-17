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
@synthesize generationTimerDelay;
@synthesize settingsViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    generationTimerDelay = 0.5;
    [self createGestureRecognizers];
    settingsViewController = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    settingsViewController.delegate = self;


}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
    int cellSize = controller.cellSizeSlider.value * 100;
    NSLog(@"Setting cellSize to %d", cellSize);
    ((GridView *)[self.view.subviews objectAtIndex:0]).cellSize = cellSize;
    generationTimerDelay = controller.generationTimerSlider.value;
    NSLog(@"Setting generation timer delay to %f", generationTimerDelay);
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}

- (IBAction)showInfo:(id)sender
{    
    [self handlePauseButton];
    settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:settingsViewController animated:YES];
    
    //[controller release];
}

- (void)createGestureRecognizers {
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(handleSingleTap:)];
    singleFingerTap.numberOfTapsRequired = 1;
    [[self.view.subviews objectAtIndex:0] addGestureRecognizer:singleFingerTap];
    [singleFingerTap release];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    [[self.view.subviews objectAtIndex:0] addGestureRecognizer:pinch];
    [pinch release];
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

- (IBAction)handlePinch:(UIGestureRecognizer *)sender {
    float scale = ((UIPinchGestureRecognizer *)sender).scale;
    float velocity = ((UIPinchGestureRecognizer *)sender).velocity;
    NSLog(@"handlePinch: scale: %f  velocity: %f", scale, velocity);
    int oldCellSize = ((GridView *)[self.view.subviews objectAtIndex:0]).cellSize;    
    int newCellSize = (scale * 100);
    if(velocity > 0){
        ((GridView *)[self.view.subviews objectAtIndex:0]).cellSize = (newCellSize > oldCellSize) ? newCellSize*0.5:oldCellSize;
    }
    else{
        newCellSize-= 30;
        newCellSize = (newCellSize > 0) ? newCellSize:4;
        ((GridView *)[self.view.subviews objectAtIndex:0]).cellSize = (newCellSize < oldCellSize) ? newCellSize:oldCellSize;
    }

    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    UITouch *touch = [touches anyObject];
    CGPoint tapPoint = [touch locationInView:[self.view.subviews objectAtIndex:0]];
    ((GridView *)[self.view.subviews objectAtIndex:0]).touchPoint = tapPoint;
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"TouchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint tapPoint = [touch locationInView:[self.view.subviews objectAtIndex:0]];
    ((GridView *)[self.view.subviews objectAtIndex:0]).touchPoint = tapPoint;
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
    
}

- (IBAction)handleClearButton{
    [((GridView *)[self.view.subviews objectAtIndex:0]) resetGrid];
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}

- (IBAction)handlePlayButton{
    generationTimer = [NSTimer scheduledTimerWithTimeInterval:generationTimerDelay 
                                    target:self 
                                    selector:@selector(doGeneration) 
                                    userInfo:nil 
                                    repeats:YES];
}

- (IBAction)handlePauseButton{
    NSLog(@"handlePauseButton");
    [generationTimer invalidate];
    generationTimer = nil; // ensures we never invalidate an already invalid Timer
    ((GridView *)[self.view.subviews objectAtIndex:0]).doGeneration = NO;
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}

- (void)doGeneration{
    NSLog(@"doGeneration");
    ((GridView *)[self.view.subviews objectAtIndex:0]).doGeneration = YES;
    [[self.view.subviews objectAtIndex:0] setNeedsDisplay];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning");
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
