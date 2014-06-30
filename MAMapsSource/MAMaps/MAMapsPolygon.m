//
//  MAMapsPolygon.m
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsPolygon.h"

@implementation MAMapsPolygon

- (instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        for (int a =0; a<array.count; a++) {
            if ([array[a] isKindOfClass:[NSValue class]]) {
                NSValue *value = array[a];
                if (CGPointEqualToPoint([value CGPointValue], [value CGPointValue]))
                {
                    [self addObject:array[a]];
                }
            }
        }
    }
    return self;
}

-(void)addObject:(id)anObject{
    if ([anObject isKindOfClass:[NSValue class]]) {
        NSValue *value = anObject;
        if (CGPointEqualToPoint([value CGPointValue], [value CGPointValue]))
        {
            [super addObject:anObject];
        }
    }
}

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index{
    if ([anObject isKindOfClass:[NSValue class]]) {
        NSValue *value = anObject;
        if (CGPointEqualToPoint([value CGPointValue], [value CGPointValue]))
        {
            [super insertObject:anObject atIndex:index];
        }
    }
}

@end
