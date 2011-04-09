//
//  GridView.m
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "GridView.h"


@implementation GridView

@synthesize cellSize, touchPoint;

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cellSize = CELLSIZE; //default
    }
    return self;
}

- (void)awakeFromNib{
    cellSize = CELLSIZE;
    touchPoint = CGPointMake(-1.0,-1.0);
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
    
    int width = rect.size.width ;
    int height = rect.size.height ;
    int i = 0;
    NSLog(@"width = %d, height = %d, cell-size = %d", width, height, cellSize);
    
    // Set the color in the current graphics context for future draw operations
    [[UIColor lightGrayColor] setStroke];
    
    // Create our drawing path
    UIBezierPath* drawingPath = [UIBezierPath bezierPath];
    
    // Draw a grid
    // first the vertical lines
    for( i = 0 ; i <= width ; i=i+cellSize ) { 
        [drawingPath moveToPoint:CGPointMake(i, 0)]; 
        [drawingPath addLineToPoint:CGPointMake(i, height)]; 
    } 
    // then the horizontal lines
    for( i = 0 ; i <= height ; i=i+cellSize ) { 
        [drawingPath moveToPoint:CGPointMake(0,i)]; 
        [drawingPath addLineToPoint:CGPointMake(width, i)]; 
    } 
    // actually draw the grid
    [drawingPath stroke];
    NSLog(@"touchPoint x = %f, y = %f", touchPoint.x, touchPoint.y);
    // find x & y point for cell size
    int xCell = (touchPoint.x / cellSize);
    xCell = xCell * cellSize;
    int yCell = touchPoint.y / cellSize;
    yCell = yCell * cellSize;
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:CGRectMake(xCell, yCell, cellSize, cellSize)];
    [fillPath fill];    
}

- (void)dealloc
{
    [super dealloc];
}

@end
