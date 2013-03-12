//
//  UIImage-Extensions.h
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
//http://catamount.com/forums/viewtopic.php?f=21&t=967

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage*)imageWithImage:(CGSize)targetSize;
- (UIImage *)scaleImage:(CGRect)rect;
- (UIImage *) imageCroppedToRect:(CGRect)cropRect;
-(UIImage*) straightenAndScaleImage:(CGRect)rect;
- (UIImage *)imageByCropping:(CGRect)rect ;

@end;