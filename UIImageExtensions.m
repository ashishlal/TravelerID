//
//  UIImageExtensions.m
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//

#import "UIImageExtensions.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};
#define MY_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

@implementation UIImage (CS_Extensions)

-(UIImage *)imageAtRect:(CGRect)rect
{
	
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage* subImage = [UIImage imageWithCGImage: imageRef];
	CGImageRelease(imageRef);
	
	return subImage;
	
}

- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor) 
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor > heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
		} else if (widthFactor < heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	//UIGraphicsBeginImageContext(targetSize);
	//if (UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
	//} else {
	//	UIGraphicsBeginImageContext(targetSize);
	//}
	
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}


- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor < heightFactor) 
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
		} else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	//UIGraphicsBeginImageContext(targetSize);
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}


- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	//   CGSize imageSize = sourceImage.size;
	//   CGFloat width = imageSize.width;
	//   CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	//   CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	// this is actually the interesting part:
	
	//UIGraphicsBeginImageContext(targetSize);
	UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}


- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
	return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees 
{   
	// calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
	[rotatedViewBox release];
	
	// Create the bitmap context
	//UIGraphicsBeginImageContext(rotatedSize);
	UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, 0.0);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
	
}

- (UIImage*)imageWithImage:(CGSize)targetSize;
{  
	UIImage *sourceImage = self;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
		
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }     
	
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
	
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
	
    CGContextRef bitmap;
	
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
    }   
	
    // In the right or left cases, we need to switch scaledWidth and scaledHeight,
    // and also the thumbnail point
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
		
        CGContextRotateCTM (bitmap, MY_DEGREES_TO_RADIANS(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
		
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumbnailPoint = CGPointMake(thumbnailPoint.y, thumbnailPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
		
        CGContextRotateCTM (bitmap, MY_DEGREES_TO_RADIANS(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
		
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, MY_DEGREES_TO_RADIANS(-180.));
    }
	
    CGContextDrawImage(bitmap, CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
	
    CGContextRelease(bitmap);
    CGImageRelease(ref);
	
    return newImage; 
}

- (CGAffineTransform) orientationTransformForImage:(CGSize *)newSize 
{
	UIImage *image = self;
    CGImageRef img = [image CGImage];
    CGFloat width = CGImageGetWidth(img);
    CGFloat height = CGImageGetHeight(img);
    CGSize size = CGSizeMake(width, height);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGFloat origHeight = size.height;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) { /* EXIF 1 to 8 */
        case UIImageOrientationUp:
            break;
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(width, 0.0f);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            break;
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0f, height);
            transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
            break;
        case UIImageOrientationLeftMirrored:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            transform = CGAffineTransformRotate(transform, 3.0f * M_PI / 2.0f);
            break;
        case UIImageOrientationLeft:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeTranslation(0.0f, width);
            transform = CGAffineTransformRotate(transform, 3.0f * M_PI / 2.0f);
            break;
        case UIImageOrientationRightMirrored:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeScale(-1.0f, 1.0f);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0f);
            break;
        case UIImageOrientationRight:
            size.height = size.width;
            size.width = origHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0f);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0f);
            break;
        default:
            ;
    }
    *newSize = size;
    return transform;
}

-(UIImage*) straightenAndScaleImage:(CGRect)rect
{
	UIImage *image = self;
    CGImageRef img = [image CGImage];
    CGFloat width = CGImageGetWidth(img);
    CGFloat height = CGImageGetHeight(img);
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGSize size = bounds.size;
    if (width > rect.size.width || height >  rect.size.height) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = rect.size.height;
            bounds.size.height = round(bounds.size.width / ratio);
        } else {
            bounds.size.height = rect.size.width;
            bounds.size.width = round(bounds.size.height * ratio);
        }
    }
    CGFloat scale = size.width/width;
    CGAffineTransform transform = [self orientationTransformForImage: &size];
   // UIGraphicsBeginImageContext(size);
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    /* Flip */
    UIImageOrientation orientation = [image imageOrientation];
    if (orientation == UIImageOrientationRight || orientation == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scale, scale);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scale, -scale);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(context, bounds, img);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)scaleImage:(CGRect)rect {
    
    CGImageRef imgRef = self.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > rect.size.width || height > rect.size.height) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = rect.size.height;
            bounds.size.height = round(bounds.size.width / ratio);
        } else {
            bounds.size.height = rect.size.width;
            bounds.size.width = round(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
#ifdef MALLOC_DEBUG
	UInt8 *pixelData = (UInt8 *) malloc(bounds.size.width * bounds.size.height * 4, (char *)__FILE__, __LINE__);
#else
    UInt8 *pixelData = (UInt8 *) malloc(bounds.size.width * bounds.size.height * 4);
#endif
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 bounds.size.width, 
                                                 bounds.size.height, 8, 
                                                 bounds.size.width * 4,
                                                 colorspace,
                                                 kCGImageAlphaNoneSkipLast);        
    
    CGContextScaleCTM(context, scaleRatio, scaleRatio);
    //CGContextTranslateCTM(context, 0, -height);
	
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
	
    CGContextRelease(context);
    CGColorSpaceRelease(colorspace);
#ifdef MALLOC_DEBUG
	NTIFree(pixelData, (char *)__FILE__, __LINE__);
#else
    free(pixelData);
#endif
	
    UIImage *imageCopy = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    [imageCopy autorelease];
    
    return imageCopy;
}


- (UIImage *) imageCroppedToRect:(CGRect)cropRect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}


- (UIImage *)imageByCropping:(CGRect)rect {
	
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage *cropped = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
	return cropped;
}

@end;