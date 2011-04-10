//
//  CGPoingObject.h
//  OnTheGrid
//
//  Created by Andy Mauro on 11-04-09.
//  Copyright 2011 Nuance Communications. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGPointObject : NSObject {
    CGPoint point;
    
}
@property(assign, readwrite)CGPoint point;

- (int) getX;
- (int) getY;

- (void) setX:(int) xValue;
- (void) setY:(int) yValue;

@end
