//
//  MAMapsOverlays.m
//  MAMaps
//
//  Created by Paul Napier on 16/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsOverlays.h"

@implementation MAMapsOverlays

-(NSArray *)initWithShape:(MAMapsShape *)shape{
    self = [super init];
    
    if (self) {
        
        NSArray *features = shape.features;
        NSMutableDictionary *dictShape = [NSMutableDictionary new];
        NSMutableArray *polygons = [NSMutableArray new];
        
        for (int a = 0; a<features.count; a++) {
            NSDictionary *feature = features[a];
            NSDictionary *properties = feature[@"properties"];
            NSString *country = properties[@"NAME"];
            //        NSLog(@"%@",feature);
            NSDictionary *geometry = feature[@"geometry"];
            //    NSLog(@"%@",geometry);
            NSArray *coords1 = geometry[@"coordinates"];
            
            if ([geometry[@"type"]isEqualToString:@"MultiPolygon"]) {
                NSMutableArray *coords = [NSMutableArray new];
                for (int b = 0; b<coords1.count; b++) {
                    NSArray *coords2 = coords1[b];
                    for (int c = 0; c<coords2.count; c++) {
                        NSArray *coords3 = coords2[c];
                        //    NSLog(@"%@",coords2);
                        
                        CLLocationCoordinate2D *coordinateArray
                        = malloc(sizeof(CLLocationCoordinate2D) * coords3.count);
                        
                        for (int d = 0; d<coords3.count; d++) {
                            
                            NSArray *array = coords3[d];
                            
                            float lat = [array[1] floatValue];
                            float lng = [array[0] floatValue];
                            
                            
                            CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lat, lng);
                            
                            coordinateArray[d] = loc;
                            
                        }
                        
                        MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coordinateArray
                                                                         count:coords3.count];
                        polygon.title = country;
                        
                        [coords addObject:polygon];
                        [polygons addObject:polygon];
                        
                        free(coordinateArray);
                    }
                }
                [dictShape setObject:coords forKey:country];
                
            }else{
                NSMutableArray *coords = [NSMutableArray new];
                
                for (int b = 0; b<coords1.count; b++) {
                    NSArray *coords2 = coords1[b];
                    
                    //    NSLog(@"%@",coords2);
                    
                    CLLocationCoordinate2D *coordinateArray
                    = malloc(sizeof(CLLocationCoordinate2D) * coords2.count);
                    
                    
                    for (int d = 0; d<coords2.count; d++) {
                        
                        NSArray *array = coords2[d];
                        
                        float lat = [array[1] floatValue];
                        float lng = [array[0] floatValue];
                        
                        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lat, lng);
                        
                        coordinateArray[d] = loc;
                        
                    }
                    
                    
                    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coordinateArray
                                                                     count:coords2.count];
                    
                    polygon.title = country;
                    [coords addObject:polygon];
                    [polygons addObject:polygon];
                    
                    free(coordinateArray);
                    
                }
                [dictShape setObject:coords forKey:country];
            }
            
        }
        self.overlaysByName = dictShape;
        self.overlaysAll = polygons;
    }
    return self;
}

@end
