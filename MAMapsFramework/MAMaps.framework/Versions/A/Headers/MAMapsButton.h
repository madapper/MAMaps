//
//  IrregularButton.h
//  TestOverlays
//
//  Created by Paul Napier on 14/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAMapsButton : UIButton

@property (nonatomic, retain) UIImage *baseImage;

-(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;

@end
