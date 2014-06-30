//
//  MAMapsShapeCustom.m
//  MAMaps
//
//  Created by Paul Napier on 17/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsShapeCustom.h"

@implementation MAMapsShapeCustom

-(MAMapsShape *)initWithFeatures:(NSArray *)features minmax:(NSDictionary *)minmax{
    
    self = [super init];
    if (self) {
        
        NSDictionary *customShape = @{
                                      @"minmax":minmax,
                                      @"type":@"FeatureCollection",
                                      @"features":features,
                                      };
        
        self.info = customShape;
        
        self.features = features;
        self.minmax = minmax;
    }
    return self;
    
}

@end
