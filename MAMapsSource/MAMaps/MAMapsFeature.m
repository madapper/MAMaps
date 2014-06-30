//
//  MAMapsFeature.m
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsFeature.h"

@implementation MAMapsFeature

-(NSDictionary *)initWithName:(NSString *)name region:(int)region subRegion:(int)subRegion polygons:(NSArray *)polygons{
    self = [super init];
    if (self) {
        NSMutableDictionary *properties = [NSMutableDictionary new];
        
        [properties setObject:name forKey:@"NAME"];
        [properties setObject:@(region) forKey:@"REGION"];
        [properties setObject:@(subRegion) forKey:@"SUBREGION"];
        
        NSMutableDictionary *geometry = [NSMutableDictionary new];
        
        if (polygons.count==1) {
            [geometry setObject:@"Polygon" forKey:@"type"];
            
            [geometry setObject:polygons forKey:@"coordinates"];
            
        }else{
            [geometry setObject:@"MultiPolygon" forKey:@"type"];
            
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSArray *arr in polygons) {
                [mArray addObject:@[arr]];
            }
            [geometry setObject:mArray forKey:@"coordinates"];
            
        }
        
        self.properties = properties;
        self.geometry = geometry;
        self.coordinates = geometry[@"coordinates"];
        self.geometryType = geometry[@"type"];
        self.polygons = polygons;
        
        
        self.info = @{
                 @"geometry": geometry,
                 @"properties": properties,
                 @"type": @"Feature",
                 };
        
    }
    return self;
}

-(NSDictionary *)initWithDictionary:(NSDictionary *)dict{
    
    if ([dict.allKeys containsObject:@"geometry"]&&[dict.allKeys containsObject:@"properties"]&&[dict.allKeys containsObject:@"properties"]&&[((NSDictionary *)dict[@"geometry"]).allKeys containsObject:@"type"]&&[((NSDictionary *)dict[@"geometry"]).allKeys containsObject:@"coordinates"]) {
        self = [super init];
        if (self) {
            self = (MAMapsFeature *)dict;
            self.properties = dict[@"properties"];
            self.geometry = dict[@"geometry"];
            self.coordinates = dict[@"geometry"][@"coordinates"];
            self.geometryType = dict[@"geometry"][@"type"];
            self.polygons = dict[@"polygons"];
        }
        return self;
    }else{
        NSLog(@"Invalid feature dictionary");
    return NULL;
    }
}

-(void)setProperty:(id)property forKey:(NSString *)key{
    NSMutableDictionary *properties = [self objectForKey:@"properties"];
    
    [properties setObject:property forKey:key];
    
}

-(void)removePropertyForKey:(NSString *)key{
    NSMutableDictionary *properties = [self objectForKey:@"properties"];
    
    [properties removeObjectForKey:key];
    
}

@end
