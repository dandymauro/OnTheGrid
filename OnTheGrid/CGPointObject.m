//
//  CGPointObject.m
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import "CGPointObject.h"

@implementation CGPointObject
@synthesize point;

- (int) getX{
    return point.x;
}

- (int) getY{
    return point.y;
}

- (void) setX:(int)xValue{
    point.x = xValue;
}

- (void) setY:(int)yValue{
    point.y = yValue;
}

@end
