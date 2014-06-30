//
//  MAMapsShapeCustom.h
//  MAMaps
//
//  Created by Paul Napier on 17/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import <MAMaps/MAMaps.h>

@interface MAMapsShapeCustom : MAMapsShape

-(MAMapsShape *)initWithFeatures:(NSArray *)features minmax:(NSDictionary *)minmax;

@end
