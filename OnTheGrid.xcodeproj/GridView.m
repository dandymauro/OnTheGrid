//
//  GridView.m
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "GridView.h"
#import "CGPointObject.h"


@implementation GridView

@synthesize cellSize, touchPoint;
@synthesize liveCells;

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
    touchPoint = CGPointMake(-10.0,-10.0);
    liveCells = [[NSMutableArray alloc]init];
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
    
    // add latest touch point to array of touched points
    int xCell = (touchPoint.x / cellSize);
    xCell = xCell * cellSize;
    int yCell = touchPoint.y / cellSize;
    yCell = yCell * cellSize;

    CGPointObject *cellPointObj = [[CGPointObject alloc]init];
    [cellPointObj setX:xCell];
    [cellPointObj setY:yCell];
    [liveCells addObject:cellPointObj];

    
    // draw touched points
    for(int i=0;i < liveCells.count;i++){
        CGPointObject *aCellPointObj = [liveCells objectAtIndex:i];
        int xCell = ([aCellPointObj getX] / cellSize);
        xCell = xCell * cellSize;
        int yCell = [aCellPointObj getY] / cellSize;
        yCell = yCell * cellSize;
        CGRect cellRect = CGRectMake(xCell, yCell, cellSize, cellSize);
        UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:cellRect];
        [fillPath fill]; 
    }
}

- (void) resetGrid{
    [liveCells release];
    liveCells = [[NSMutableArray alloc] init];
    touchPoint = CGPointMake(-10.0,-10.0);
}

- (void)dealloc
{
    [liveCells release];
    [super dealloc];
}

@end
