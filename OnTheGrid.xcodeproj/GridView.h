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
    
}

@property(assign, readwrite) int cellSize;
@property(assign, readwrite) CGPoint touchPoint;

- (void) drawGrid:(int)rows: (int)columns: (int)cellHeightPx: (int)cellWidthPx;
- (void)awakeFromNib;

@end
