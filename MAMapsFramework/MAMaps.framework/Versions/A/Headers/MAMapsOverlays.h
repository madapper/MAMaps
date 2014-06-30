//
//  MAMapsOverlays.h
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMapsShape.h"

@import CoreLocation;
@import MapKit;

@interface MAMapsOverlays : NSArray

@property (nonatomic, retain) NSDictionary *overlaysByName;
@property (nonatomic, retain) NSArray *overlaysAll;

-(NSArray *)initWithShape:(MAMapsShape *)shape;

@end
