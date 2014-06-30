//
//  MAMapsPolygons.m
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsPolygons.h"

@implementation MAMapsPolygons

- (void)addObject:(id)anObject{
    
    if ([anObject isKindOfClass:[MAMapsPolygon class]]) {
        [super addObject:anObject];
    }
    
}
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
    if ([anObject isKindOfClass:[MAMapsPolygon class]]) {
        [super insertObject:anObject atIndex:index];
    }
}

- (instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        for (int a =0; a<array.count; a++) {
            if ([array[a] isKindOfClass:[MAMapsPolygon class]]) {
                [self addObject:array[a]];
            }
        }
    }
    return self;
}

@end
