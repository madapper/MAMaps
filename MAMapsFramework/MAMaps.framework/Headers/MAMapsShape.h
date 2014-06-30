//
//  MAMapsShapes.h
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMapsEnums.h"

@interface MAMapsShape : NSDictionary

@property (nonatomic, retain) NSDictionary *minmax;
@property (nonatomic, retain) NSArray *features;
@property (nonatomic, retain) NSDictionary *info;

-(MAMapsShape *)initWithShapes:(MAMapShape)shape;
-(MAMapsShape *)initWithString:(NSString *)shape;

@end
