//
//  UIImage+Util.m
//  UIKonf15
//
//  Created by Nikolas Burk on 26/02/15.
//  Copyright (c) 2015 Nikolas Burk. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

-(UIImage *)makeRoundedImage:(UIImage *)image radius:(float)radius
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}


@end
