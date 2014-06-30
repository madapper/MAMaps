//
//  VCMapView.h
//  TestMAMaps
//
//  Created by Paul Napier on 30/06/2014.
//  Copyright (c) 2014 MadApper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMaps/MAMaps.h>

@interface VCMapView : UIViewController<MKMapViewDelegate>{
    MKMapView *mv;
}

@end
