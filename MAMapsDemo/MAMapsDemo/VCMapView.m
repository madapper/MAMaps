//
//  VCMapView.m
//  TestMAMaps
//
//  Created by Paul Napier on 30/06/2014.
//  Copyright (c) 2014 MadApper. All rights reserved.
//

#import "VCMapView.h"

@interface VCMapView ()

@end

@implementation VCMapView

-(CGRect)getFrame{
    
    CGRect rect = CGRectMake(0, 20 + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-20);
    return rect;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    MAMapsShape *shape = [[MAMapsShape alloc]initWithShapes:MAMapShapeWorldFull];
    
    MAMapsOverlays *overlays = [[MAMapsOverlays alloc]initWithShape:shape];
    
    mv = [[MKMapView alloc]initWithFrame:[self getFrame]];
    [self.view addSubview:mv];
    
    mv.delegate = self;
    
    for (MKPolygon *polygon in overlays.overlaysAll) {
        [mv addOverlay:polygon];
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    mv.frame = [self getFrame];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if (![overlay isKindOfClass:[MKPolygon class]]) {
        return nil;
    }
    MKPolygon *polygon = overlay;
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon];
    if ([polygon.subtitle isEqualToString:@"touched"]) {
        renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    }else{
        renderer.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    renderer.strokeColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    
    return renderer;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    mv.frame = [self getFrame];
}



@end
