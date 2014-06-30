//
//  MAMapsFeature.h
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAMapsFeature : NSDictionary

@property (nonatomic, retain) NSDictionary *properties;
@property (nonatomic, retain) NSDictionary *geometry;
@property (nonatomic, retain) NSArray *coordinates;
@property (nonatomic, retain) NSString *geometryType;
@property (nonatomic, retain) NSArray *polygons;
@property (nonatomic, retain) NSDictionary *info;

-(NSDictionary *)initWithName:(NSString *)name region:(int)region subRegion:(int)subRegion polygons:(NSArray *)polygons;
-(NSDictionary *)initWithDictionary:(NSDictionary *)dict;
-(void)setProperty:(id)property forKey:(NSString *)key;
-(void)removePropertyForKey:(NSString *)key;

@end
