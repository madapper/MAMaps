//
//  MAMapsViews.h
//  MAMaps
//
//  Created by Paul Napier on 17/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAMapsShape.h"
#import "MAMapsButton.h"

@import CoreGraphics;
@import UIKit;

@interface MAMapsButtons : NSArray

@property (nonatomic) int countryCount;
@property (nonatomic, retain) NSArray *allNames;
@property (nonatomic, retain) NSDictionary *buttonsByName;
@property (nonatomic, retain) NSArray *allButtons;

-(NSArray *)initWithShape:(MAMapsShape *)shape scale:(float)scale border:(BOOL)border;




@end
