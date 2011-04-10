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
@synthesize liveCells, doGeneration;

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
    touchPoint = CGPointMake(0.0,0.0);
    doGeneration = NO;
    for(int i=0;i<320;i++){
        for(int j=0;j<480;j++){
            cells[i][j] = NO;
        }
    }
}

- (void)setCellSize:(int)aCellSize{
    cellSize = aCellSize;
    NSLog(@"bounds width %d height %d", self.bounds.size.width, self.bounds.size.height);
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
    int yCell = touchPoint.y / cellSize;
    cells[xCell][yCell] = YES;
    
    if(doGeneration)
        [self checkNeighborsAndSetLiveness];
    // draw touched points
    [[UIColor lightGrayColor] setStroke];
    for(int i=0;i<320;i++){
        for(int j=0;j<480;j++){
            if(cells[i][j] == YES){
                xCell = i * cellSize;
                yCell = j * cellSize;
                CGRect cellRect = CGRectMake(xCell, yCell, cellSize, cellSize);
                UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:cellRect];
                [fillPath fill]; 
            }
        }
    }
}


// Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// Any live cell with two or three live neighbours lives on to the next generation.
// Any live cell with more than three live neighbours dies, as if by overcrowding.
// Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
- (void) checkNeighborsAndSetLiveness{
    NSLog(@"Checking numNeighbors and setting liveness");
    for(int i=0;i<320;i++){
        for(int j=0;j<480;j++){
            int numNeighbors = 0;
            // left, check for 0th col
            if(i != 0) if(cells[i-1][j] == YES) numNeighbors++;
            // right, check for 320th col
            if(i != 320) if(cells[i+1][j] == YES) numNeighbors++;
            // up, check for 0th row
            if(j != 0) if(cells[i][j-1] == YES) numNeighbors++;
            // down, check for 480th row
            if(j != 420) if(cells[i][j+1] == YES) numNeighbors++;
            // diagonal up-left, check not in 0th row or col
            if((i != 0) && (j != 0)) if(cells[i-1][j-1] == YES) numNeighbors++;
            // diagonal up-right, check not in 320th col, 0th row
            if((i != 320) && (j != 0)) if(cells[i+1][j-1] == YES) numNeighbors++;
            // diagonal down-left, check not in 0th col, 480th row
            if((i != 0) && (j != 480)) if(cells[i-1][j+1] == YES) numNeighbors++;
            // diagonal down-right, check not in 320th col, 480th row
            if((i != 320) && (j != 480)) if(cells[i+1][j+1] == YES) numNeighbors++;
               
            if(cells[i][j] == YES){
                NSLog(@"%@ cell [%d][%d] has %d neighbors", cells[i][j] == YES ? @"Live":@"Dead", i,j,numNeighbors);

                if((numNeighbors < 2) || (numNeighbors > 3)) 
                    cells[i][j] = NO;
            }
            else{
                if(numNeighbors == 3)
                    cells[i][j] = YES;
            }
            [[UIColor redColor] set];
            [[NSString stringWithFormat:@"%d", numNeighbors] drawAtPoint:CGPointMake(i*cellSize, j*cellSize) withFont:[UIFont systemFontOfSize:8.0]]; 
        }
    }
    
}

- (void) resetGrid{
    for(int i=0;i<320;i++){
        for(int j=0;j<480;j++){
            cells[i][j] = NO;
        }
    }
    touchPoint = CGPointMake(0.0,0.0);
}

- (void)dealloc
{
    [super dealloc];
}

@end
