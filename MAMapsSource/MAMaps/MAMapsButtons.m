//
//  MAMapsViews.m
//  MAMaps
//
//  Created by Paul Napier on 17/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsButtons.h"

@interface MAMapsButton()

@end

@implementation MAMapsButtons

-(NSArray *)initWithShape:(MAMapsShape *)shape scale:(float)scale border:(BOOL)border view:(UIView *)view{
    
    self = [self initWithShape:shape scale:scale border:border];
    
    if (self) {
        
        float height = 0;
        float width = 0;
        
        for (MAMapsButton *b in self.allButtons) {
            [view addSubview:b];
            UIImage *image = b.imageView.image;
            image = [b colorizeImage:image color:[UIColor colorWithRed:0.568 green:1.000 blue:0.576 alpha:1.000]];
            [b setImage:image forState:UIControlStateHighlighted];
            if (height<b.frame.origin.y+b.frame.size.height) {
                height=b.frame.origin.y+b.frame.size.height;
            }
            if (width<b.frame.origin.x+b.frame.size.width) {
                width=b.frame.origin.x+b.frame.size.width;
            }
        }
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv = (UIScrollView *)view;
            sv.contentSize = CGSizeMake(width, height);
        }
        
    }
    
    return self;
    
}

-(NSArray *)initWithShape:(MAMapsShape *)shape scale:(float)scale border:(BOOL)border{
    self = [super init];
    
    if (self) {
        
        NSMutableArray *buttons = [NSMutableArray new];
        NSMutableArray *allNames = [NSMutableArray new];
        
        NSArray *features = shape.features;
        
        CGPoint minPoint = CGPointMake([shape.minmax[@"min"][0] floatValue], [shape.minmax[@"min"][1] floatValue]);
//        CGPoint maxPoint = [shape.minmax[@"max"] CGPointValue];
        
//        float totLat = maxPoint.x-minPoint.x;
//        float totLng = maxPoint.y-minPoint.y;
        
        NSMutableDictionary *dictShape = [NSMutableDictionary new];
        
        for (int a = 0; a<features.count; a++) {
            NSDictionary *feature = features[a];
            NSDictionary *properties = feature[@"properties"];
            NSString *name = properties[@"NAME"];
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
                        
                        float minlat = 0;
                        float maxlat = 0;
                        float minlng = 0;
                        float maxlng = 0;
                        
                        MAMapsButton *button = [MAMapsButton buttonWithType:UIButtonTypeCustom];
                        
                        CGMutablePathRef path=CGPathCreateMutable();
                        
                        for (int d = 0; d<coords3.count; d++) {
                            
                            NSArray *array = coords3[d];
                            
                            float lng = (0-[array[1] floatValue]+ABS(minPoint.y))*scale;
                            float lat = ([array[0] floatValue]+ABS(minPoint.x))*scale;
                            
                            if (d == 0) {
                                minlat = lat;
                                minlng = lng;
                            }else{
                                if (minlat>lat) {
                                    minlat = lat;
                                }
                                if (minlng>lng) {
                                    minlng = lng;
                                }
                            }
                            
                            if (maxlat<lat) {
                                maxlat = lat;
                            }
                            
                            
                            if (maxlng<lng) {
                                maxlng = lng;
                            }
                            
                        }
                        
                        for (int d = 0; d<coords3.count; d++) {
                            
                            NSArray *array = coords3[d];
                            
                            float lng = (0-[array[1] floatValue]+ABS(minPoint.y))*scale;
                            float lat = ([array[0] floatValue]+ABS(minPoint.x))*scale;
                            if (d == 0) {
                                CGPathMoveToPoint(path, NULL, lat-minlat, lng-minlng);
                                
                            }else if (d==coords3.count-1){
                                CGPathAddLineToPoint(path, NULL, lat-minlat, lng-minlng);
                                CGPathCloseSubpath(path);
                            }else{
                                CGPathAddLineToPoint(path, NULL, lat-minlat, lng-minlng);
                            }
                        }
                        
                        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                        shapeLayer.frame = CGRectMake(0, 0, maxlat-minlat, maxlng-minlng);
                        shapeLayer.path = path;
                        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
                        if (border) {
                            shapeLayer.strokeColor = [[UIColor colorWithWhite:0.900 alpha:1.000]CGColor];
                            shapeLayer.lineWidth = 0.5;
                        }
                        
                        button.frame = CGRectMake(minlat, minlng, maxlat-minlat, maxlng-minlng);
                        
                        button.clipsToBounds = false;
                        button.baseImage = [self imageFromLayer:shapeLayer];
                        [button setImage:[self imageFromLayer:shapeLayer] forState:UIControlStateNormal];
                        
                        [buttons addObject:button];
                        [coords addObject:button];
                        
                        button.tag = buttons.count;
                        
                        [allNames addObject:name];
                        
                    }
                }
                [dictShape setObject:coords forKey:name];
            }else{
                NSMutableArray *coords = [NSMutableArray new];
                
                for (int b = 0; b<coords1.count; b++) {
                    NSArray *coords2 = coords1[b];
                    
                    float minlat = 0;
                    float maxlat = 0;
                    float minlng = 0;
                    float maxlng = 0;
                    
                    MAMapsButton *button = [MAMapsButton buttonWithType:UIButtonTypeCustom];
                    
                    CGMutablePathRef path=CGPathCreateMutable();
                    
                    for (int d = 0; d<coords2.count; d++) {
                        
                        NSArray *array = coords2[d];
                        
                        float lng = (0-[array[1] floatValue]+ABS(minPoint.y))*scale;
                        float lat = ([array[0] floatValue]+ABS(minPoint.x))*scale;
                        
                        if (d == 0) {
                            minlat = lat;
                            minlng = lng;
                        }else{
                            if (minlat>lat) {
                                minlat = lat;
                            }
                            if (minlng>lng) {
                                minlng = lng;
                            }
                        }
                        
                        if (maxlat<lat) {
                            maxlat = lat;
                        }
                        
                        
                        if (maxlng<lng) {
                            maxlng = lng;
                        }
                        
                    }
                    
                    for (int d = 0; d<coords2.count; d++) {
                        
                        NSArray *array = coords2[d];
                        
                        float lng = (0-[array[1] floatValue]+ABS(minPoint.y))*scale;
                        float lat = ([array[0] floatValue]+ABS(minPoint.x))*scale;
                        if (d == 0) {
                            CGPathMoveToPoint(path, NULL, lat-minlat, lng-minlng);
                            
                        }else if (d==coords2.count-1){
                            CGPathAddLineToPoint(path, NULL, lat-minlat, lng-minlng);
                            CGPathCloseSubpath(path);
                        }else{
                            CGPathAddLineToPoint(path, NULL, lat-minlat, lng-minlng);
                        }
                    }
                    
                    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                    shapeLayer.frame = CGRectMake(0, 0, maxlat-minlat, maxlng-minlng);
                    shapeLayer.path = path;
                    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
                    if (border) {
                        shapeLayer.strokeColor = [[UIColor colorWithWhite:0.900 alpha:1.000]CGColor];
                        shapeLayer.lineWidth = 0.5;
                    }
                    
                    button.frame = CGRectMake(minlat, minlng, maxlat-minlat, maxlng-minlng);
                    
                    button.clipsToBounds = false;
                    button.baseImage = [self imageFromLayer:shapeLayer];
                    [button setImage:[self imageFromLayer:shapeLayer] forState:UIControlStateNormal];
                    
                    [buttons addObject:button];
                    [coords addObject:button];
                    
                    button.tag = buttons.count;
                    
                    [allNames addObject:name];
                    
                }
                [dictShape setObject:coords forKey:name];
            }
            
        }
        self.allButtons = buttons;
        self.allNames = allNames;
        self.buttonsByName = dictShape;
    }
    return self;
}

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}





@end
