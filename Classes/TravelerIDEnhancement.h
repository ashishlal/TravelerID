//
//  TravelerIDEnhancement.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
	NO_MAP=0,
	CIRCLE_TOP_LEFT,
	CIRCLE_TOP_RIGHT,
	CIRCLE_BOTTOM_LEFT,
	CIRCLE_BOTTOM_RIGHT
};

typedef struct { CGPoint center; CGFloat radius; } CGCircle; 

@class TravelerIDViewController;

@interface TravelerIDEnhancement : UIView {
	TravelerIDViewController *delegate;
	int whatToPut;
	CGRect boundary;
	CGCircle circleTopLeft;
	CGCircle circleTopRight;
	CGCircle circleBottomLeft;
	CGCircle circleBottomRight;
	UIImage *sourceImage;
	UIImage *clippedImage;
	BOOL showRect;
	BOOL showClip;
	int rotateImage;
	CGFloat initialDistance;
	
}

@property (nonatomic,retain) TravelerIDViewController *delegate;
@property (nonatomic,assign) int whatToPut;
@property (nonatomic,assign) CGRect boundary;
@property (nonatomic,assign) CGCircle circleTopLeft;
@property (nonatomic,assign) CGCircle circleTopRight;
@property (nonatomic,assign) CGCircle circleBottomLeft;
@property (nonatomic,assign) CGCircle circleBottomRight;
@property (nonatomic,assign) BOOL showRect;
@property (nonatomic,assign) BOOL showClip;
@property (nonatomic,assign) int rotateImage;
@property (nonatomic,assign) CGFloat initialDistance;

@property (nonatomic,retain) UIImage *sourceImage;
@property (nonatomic,retain) UIImage *clippedImage;

-(void)toggleShowRect:(int)val;
-(void)toggleShowClip:(int)val;
-(void)setBoundary:(CGRect )rect;
-(void)setSourceImage:(UIImage * )img;
-(UIImage *)getClippedImage;
-(void) drawBoundary:(CGContextRef)ctx;
-(void) drawClippedImage:(CGContextRef)ctx;
-(void) drawRotatedLeftImage:(CGContextRef)ctx;
-(void) drawRotatedRightImage:(CGContextRef)ctx;
-(void) drawClippedLayers:(CGContextRef)ctx;
-(void) reset;
@end
