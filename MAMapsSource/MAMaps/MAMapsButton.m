//
//  IrregularButton.m
//  TestOverlays
//
//  Created by Paul Napier on 14/11/2013.
//  Copyright (c) 2013 MadApper. All rights reserved.
//

#import "MAMapsButton.h"


@implementation MAMapsButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!CGRectContainsPoint([self bounds], point))
        return nil;
    else
    {
        UIImage *displayedImage = [self imageForState:[self state]];
        if (displayedImage == nil) // No image found, try for background image
            displayedImage = [self backgroundImageForState:[self state]];
        if (displayedImage == nil) // No image could be found, fall back to
            return self;
        BOOL isTransparent = [self isPointTransparent:point image:displayedImage];
        if (isTransparent)
            return nil;

    }
    
    return self;
}

- (NSData *)ARGBData:(UIImage *)image
{
    CGContextRef cgctx = CreateARGBBitmapContext(image.CGImage);
    if (cgctx == NULL)
        return nil;
    
    size_t w = CGImageGetWidth(image.CGImage);
    size_t h = CGImageGetHeight(image.CGImage);
    CGRect rect = {{0,0},{w,h}};
    CGContextDrawImage(cgctx, rect, image.CGImage);
    
    void *data = CGBitmapContextGetData (cgctx);
    CGContextRelease(cgctx);
    if (!data)
        return nil;
    
    size_t dataSize = 4 * w * h; // ARGB = 4 8-bit components
    return [NSData dataWithBytes:data length:dataSize];
}

- (BOOL)isPointTransparent:(CGPoint)point image:(UIImage *)image
{
    NSData *rawData = [self ARGBData:image];  // See about caching this
    if (rawData == nil)
        return NO;
    
    size_t bpp = 4;
    size_t bpr = image.size.width * 4;
    
    NSUInteger index = point.x * bpp + (point.y * bpr);
    char *rawDataBytes = (char *)[rawData bytes];
    
    return rawDataBytes[index] == 0;
    
}

CGContextRef CreateARGBBitmapContext (CGImageRef inImage)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
        return nil;
    
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        CGColorSpaceRelease( colorSpace );
        return nil;
    }
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
}


-(UIImage *)colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor {
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
