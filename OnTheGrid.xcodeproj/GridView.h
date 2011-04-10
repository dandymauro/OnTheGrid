//
//  GridView.h
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELLSIZE 10


@interface GridView : UIView {
    int cellSize;
    CGPoint touchPoint;
    NSMutableArray * liveCells;
    
}

@property(assign, readwrite) int cellSize;
@property(assign, readwrite) CGPoint touchPoint;
@property(nonatomic, retain) NSMutableArray * liveCells;

- (void) awakeFromNib;
- (void) resetGrid;

@end
