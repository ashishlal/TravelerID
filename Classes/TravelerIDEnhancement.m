//
//  TravelerIDEnhancement.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDEnhancement.h"
#import "ConstantsAndMacros.h"
#import "UIViewControllerUtil.h"
#import "UIImageExtensions.h"
#import "TravelerIDDetailViewController.h"
#import "TravelerIDViewController.h"

@implementation TravelerIDEnhancement
@synthesize delegate;
@synthesize sourceImage;
@synthesize clippedImage;
@synthesize boundary;
@synthesize showRect;
@synthesize showClip;
@synthesize rotateImage;
@synthesize circleTopLeft;
@synthesize circleTopRight;
@synthesize circleBottomLeft;
@synthesize circleBottomRight;
@synthesize whatToPut;
@synthesize initialDistance;

int firstTime=1;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
		// not exactly the center, but the orgin of the containing rect
		// but this will do our work
		boundary = CGRectMake(0, 0, 0, 0);
		firstTime=1;
	}
	
	return self;
}

-(void)toggleShowRect:(int)val { 
	if(val) showRect = TRUE;
	else showRect = FALSE;
}

-(void)toggleShowClip:(int)val { 
	if(val) showClip = TRUE;
	else showClip = FALSE;
}

-(void)setBoundary:(CGRect)rect
{
	boundary.origin.x = rect.origin.x;
	boundary.origin.y = rect.origin.y;
	boundary.size.width = rect.size.width;
	boundary.size.height = rect.size.height;
	
	CGFloat radius=10.0f;
	whatToPut=NO_MAP;
#ifdef INVERTED_COORDINATES
	circleBottomRight.center.x = boundary.origin.x;
	circleBottomRight.center.y = boundary.origin.y;
	circleBottomRight.radius = radius;
	
	circleBottomLeft.center.x = boundary.origin.x + (boundary.size.width - 2 * radius);
	circleBottomLeft.center.y = boundary.origin.y ;
	circleBottomLeft.radius = radius;
	
	circleTopRight.center.x = boundary.origin.x;
	circleTopRight.center.y = boundary.origin.y + boundary.size.height - 2 *radius;
	circleTopRight.radius = radius;
	
	circleTopLeft.center.x = boundary.origin.x + (boundary.size.width - 2 * radius);
	circleTopLeft.center.y =  boundary.origin.y + (boundary.size.height- 2 * radius);
	circleTopLeft.radius = radius;
#else
	circleTopLeft.center.x = boundary.origin.x;
	circleTopLeft.center.y = boundary.origin.y;
	circleTopLeft.radius = radius;
	
	circleTopRight.center.x = boundary.origin.x + (boundary.size.width - 2 * radius);
	circleTopRight.center.y = boundary.origin.y ;
	circleTopRight.radius = radius;
	
	circleBottomLeft.center.x = boundary.origin.x;
	circleBottomLeft.center.y = boundary.origin.y + boundary.size.height - 2 *radius;
	circleBottomLeft.radius = radius;
	
	circleBottomRight.center.x = boundary.origin.x + (boundary.size.width - 2 * radius);
	circleBottomRight.center.y =  boundary.origin.y + (boundary.size.height- 2 * radius);
	circleBottomRight.radius = radius;
	
#endif
	
}

-(void)setSourceImage:(UIImage * )img
{
	sourceImage = img;
}

-(UIImage *)getClippedImage
{
	return clippedImage;
	UIImage *clippedImageCopy = [[UIImage alloc] initWithCGImage:[clippedImage CGImage]];
	[clippedImageCopy retain];
	return clippedImageCopy;
}

- (void)drawRectExperiment:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	if(firstTime) {
		firstTime =0;
		[self setBoundary:boundary];
	}
	if(!showClip)
		[self drawBoundary:context];
    CGMutablePathRef path = CGPathCreateMutable();
	//or for e.g. CGPathAddRect(path, NULL, CGRectInset([self bounds], 10, 20));
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, 100, 100));
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGPathRelease(path);
    [sourceImage drawInRect:CGRectMake(0, 0, 100, 100)];
}

- (void)drawRect:(CGRect)rect {
	
	if((boundary.size.width==0) && (boundary.size.height ==0)) return;
	if(!showRect)
		return;
	
	//if((showClip) || (rotateImage)) UIGraphicsBeginImageContext([self frame].size);
	if((showClip) || (rotateImage)) UIGraphicsBeginImageContextWithOptions([self frame].size, NO, 0.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	boundary = rect;
	
	if(firstTime) {
		firstTime =0;
		[self setBoundary:boundary];
	}
	if(showClip) {
		[self drawClippedImage:ctx];
		ctx = UIGraphicsGetCurrentContext();
		[self drawBoundary:ctx];
		
		NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
		[UIImagePNGRepresentation(clippedImage) writeToFile:pngPath atomically:YES];
		
		[delegate goToSelectDoneAndBack];
		
	}
	else if(rotateImage) {
		if(rotateImage == ROTATE_LEFT) {
			[self drawRotatedLeftImage:ctx];
		}
		else if(rotateImage == ROTATE_RIGHT) {
			[self drawRotatedRightImage:ctx];
		}
		
	}
	else 
		[self drawBoundary:ctx];
	
	return;
}

-(void) setDelegate:(TravelerIDViewController *)d
{
	delegate = d;
}

-(void) setRotateImage:(int)r
{
	rotateImage = r;
}

-(void) drawClippedImage:(CGContextRef)ctx {
	
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
	
	CGPoint polygon[] = 
	{
		
		CGPointMake(circleBottomRight.center.x+circleBottomRight.radius, 
					circleBottomRight.center.y + circleBottomRight.radius),
		
		CGPointMake(circleBottomLeft.center.x + circleBottomLeft.radius, 
					circleBottomLeft.center.y + circleBottomLeft.radius),
		
		CGPointMake(circleTopLeft.center.x + circleTopLeft.radius, 
					circleTopLeft.center.y + circleTopLeft.radius),
		
		CGPointMake(circleTopRight.center.x + circleTopRight.radius, 
					circleTopRight.center.y + circleTopRight.radius),
		
		CGPointMake(circleBottomRight.center.x+circleBottomRight.radius, 
					circleBottomRight.center.y + circleBottomRight.radius)
	};
	
	for(int idx = 0; idx < 5; idx++)
	{
		
		CGPoint point = polygon[idx];//Edited 
		if(idx == 0)
		{
			// move to the first point
			CGContextMoveToPoint(ctx, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(ctx, point.x, point.y);
		}
	}
	
	//CGContextStrokePath(ctx);
	
	CGContextClosePath(ctx);
	CGContextAddPath(ctx, path);
	CGPathRelease(path);
	CGContextClip(ctx);
	
	//CGContextFillEllipseInRect(ctx, CGRectMake(circleBottomRight.center.x, circleBottomRight.center.y, 
	//										   2*circleBottomRight.radius, 2*circleBottomRight.radius));
	CGContextTranslateCTM(ctx, 0.0, boundary.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
	
	// Make a new image from the CG Reference
	UIImage *copyOfSource = [[UIImage alloc] initWithCGImage:[sourceImage CGImage]];
	
	// Dont forget to release your allocs when you're done with them!
	CGContextDrawImage(ctx, [self boundary], [copyOfSource CGImage]);
	//[sourceImage drawInRect:[self boundary]];
	UIImage *top = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();  
	
	//UIGraphicsBeginImageContext(boundary.size);
	UIGraphicsBeginImageContextWithOptions(boundary.size, NO, 0.0);
	ctx = UIGraphicsGetCurrentContext();
	
	//[clippedImage drawInRect:CGRectMake(0, 0, 100, 100)];
	// overlay this over an image with white color
	
	[[UIColor whiteColor] set];
	//CGContextClipToMask(ctx, [self boundary], [sourceImage CGImage]);
	CGContextFillRect(ctx, [self boundary]);
	UIImage * bottom = UIGraphicsGetImageFromCurrentImageContext();
	[copyOfSource release];
	
	[bottom drawInRect:boundary];
	
	[top drawInRect:boundary blendMode:kCGBlendModeNormal alpha:1.0];
	clippedImage = UIGraphicsGetImageFromCurrentImageContext();
	if([clippedImage retainCount] == 1)
		[clippedImage retain];
	UIGraphicsEndImageContext();  
	
}

-(void) drawClippedLayers:(CGContextRef)ctx {
	
	CGContextBeginTransparencyLayer (ctx, NULL);
	CGContextSetRGBFillColor (ctx, 1, 1, 1, 1);
	CGRect clipBoundary = [self bounds];
	CGPoint polygon1[] = 
	{
		
		CGPointMake(circleTopLeft.center.x + circleTopLeft.radius, 
					circleTopLeft.center.y + circleTopLeft.radius),
		
		CGPointMake(circleTopRight.center.x + circleTopRight.radius, 
					circleTopRight.center.y + circleTopRight.radius),
		
		CGPointMake(clipBoundary.origin.x + clipBoundary.size.width, 
					clipBoundary.origin.y),
		
		CGPointMake(clipBoundary.origin.x, 
					clipBoundary.origin.y ),
		
		CGPointMake(circleTopLeft.center.x + circleTopLeft.radius, 
					circleTopLeft.center.y + circleTopLeft.radius)
		
	};
	for(int idx = 0; idx < 5; idx++)
	{
		
		CGPoint point = polygon1[idx];//Edited 
		if(idx == 0)
		{
			// move to the first point
			CGContextMoveToPoint(ctx, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(ctx, point.x, point.y);
		}
	}
	CGPoint polygon2[] = 
	{
		
		CGPointMake(circleTopLeft.center.x + circleTopLeft.radius, 
					circleTopLeft.center.y + circleTopLeft.radius),
		
		CGPointMake(circleBottomLeft.center.x + circleBottomLeft.radius, 
					circleBottomLeft.center.y + circleBottomLeft.radius),
		
		CGPointMake(clipBoundary.origin.x , 
					clipBoundary.origin.y + clipBoundary.size.height),
		
		CGPointMake(clipBoundary.origin.x, 
					clipBoundary.origin.y ),
		
		CGPointMake(circleTopLeft.center.x + circleTopLeft.radius, 
					circleTopLeft.center.y + circleTopLeft.radius)
		
	};
	for(int idx = 0; idx < 5; idx++)
	{
		
		CGPoint point = polygon2[idx];//Edited 
		if(idx == 0)
		{
			// move to the first point
			CGContextMoveToPoint(ctx, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(ctx, point.x, point.y);
		}
	}
	
	CGPoint polygon3[] = 
	{
		
		CGPointMake(circleBottomLeft.center.x + circleBottomLeft.radius, 
					circleBottomLeft.center.y + circleBottomLeft.radius),
		
		CGPointMake(clipBoundary.origin.x , 
					clipBoundary.origin.y + clipBoundary.size.height),
		
		CGPointMake(clipBoundary.origin.x + clipBoundary.size.width, 
					clipBoundary.origin.y + clipBoundary.size.height),
		
		CGPointMake(circleBottomRight.center.x + circleBottomRight.radius, 
					circleBottomRight.center.y + circleBottomRight.radius),
		
		CGPointMake(circleBottomLeft.center.x + circleBottomLeft.radius, 
					circleBottomLeft.center.y + circleBottomLeft.radius)
		
	};
	
	for(int idx = 0; idx < 5; idx++)
	{
		
		CGPoint point = polygon3[idx];//Edited 
		if(idx == 0)
		{
			// move to the first point
			CGContextMoveToPoint(ctx, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(ctx, point.x, point.y);
		}
	}
	
	CGPoint polygon4[] = 
	{
		
		CGPointMake(circleBottomRight.center.x + circleBottomRight.radius, 
					circleBottomRight.center.y + circleBottomRight.radius),
		
		CGPointMake(clipBoundary.origin.x + clipBoundary.size.width, 
					clipBoundary.origin.y + clipBoundary.size.height),
		
		CGPointMake(clipBoundary.origin.x + clipBoundary.size.width, 
					clipBoundary.origin.y ),
		
		
		CGPointMake(circleTopRight.center.x + circleTopRight.radius, 
					circleTopRight.center.y + circleTopRight.radius),
		
		CGPointMake(circleBottomRight.center.x + circleBottomRight.radius, 
					circleBottomRight.center.y + circleBottomRight.radius)
		
	};
	
	for(int idx = 0; idx < 5; idx++)
	{
		
		CGPoint point = polygon4[idx];//Edited 
		if(idx == 0)
		{
			// move to the first point
			CGContextMoveToPoint(ctx, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(ctx, point.x, point.y);
		}
	}
	
	CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);
	CGContextEndTransparencyLayer (ctx);
}

-(void) drawBoundary:(CGContextRef)ctx {
	
	[self drawClippedLayers:ctx];
	
	//NSLog(@"f:%d, n:%d m:%d e:%d",totFaces, totNoses, totMouths, totEyes);
	//r.origin.x = self.frame.size.width - r.origin.x - r.size.width;
	//r.origin.y = self.frame.size.height - r.origin.y - r.size.height;
	
	CGContextSetRGBFillColor(ctx, 0, 0, 255, 1);
	CGContextSetRGBStrokeColor(ctx, 0, 0, 255, 1);
	
	//CGRect todrawBoundary = CGRectMake(boundary.origin.x + radius , boundary.origin.y +radius, 
	//								   boundary.size.width - 2 *radius , boundary.size.height- 2 *radius);
	
	// Draw circles (filled)
	CGContextFillEllipseInRect(ctx, CGRectMake(circleBottomRight.center.x, circleBottomRight.center.y, 
											   2*circleBottomRight.radius, 2*circleBottomRight.radius));
	
	CGContextFillEllipseInRect(ctx, CGRectMake(circleBottomLeft.center.x, circleBottomLeft.center.y, 
											   2*circleBottomLeft.radius, 2*circleBottomLeft.radius));
	
	CGContextFillEllipseInRect(ctx, CGRectMake(circleTopRight.center.x, circleTopRight.center.y, 
											   2*circleTopRight.radius, 2*circleTopRight.radius));
	
	CGContextFillEllipseInRect(ctx, CGRectMake(circleTopLeft.center.x, circleTopLeft.center.y, 
											   2*circleTopLeft.radius, 2*circleTopLeft.radius));
	
	
	[[UIColor blueColor] set];
	//CGContextStrokeRect(ctx, todrawBoundary);
	// now connect the circles
	CGContextSetLineWidth(ctx, 2.0);
	
	CGContextMoveToPoint(ctx, circleBottomRight.center.x+circleBottomRight.radius, 
						 circleBottomRight.center.y + circleBottomRight.radius);
	
	CGContextAddLineToPoint(ctx, circleBottomLeft.center.x + circleBottomLeft.radius, 
							circleBottomLeft.center.y + circleBottomLeft.radius);
	CGContextStrokePath(ctx);
	
	CGContextMoveToPoint(ctx, circleBottomRight.center.x+circleBottomRight.radius, 
						 circleBottomRight.center.y + circleBottomRight.radius);
	CGContextAddLineToPoint(ctx, circleTopRight.center.x + circleTopRight.radius, 
							circleTopRight.center.y + circleTopRight.radius);
	CGContextStrokePath(ctx);
	
	CGContextMoveToPoint(ctx, circleTopLeft.center.x+circleTopLeft.radius, 
						 circleTopLeft.center.y+circleTopLeft.radius);
	CGContextAddLineToPoint(ctx, circleBottomLeft.center.x+circleBottomLeft.radius, 
							circleBottomLeft.center.y+circleBottomLeft.radius);
	CGContextStrokePath(ctx);
	CGContextMoveToPoint(ctx, circleTopLeft.center.x+circleTopLeft.radius, 
						 circleTopLeft.center.y+circleTopLeft.radius);
	CGContextAddLineToPoint(ctx, circleTopRight.center.x+circleTopRight.radius, 
							circleTopRight.center.y+circleTopRight.radius);
	CGContextStrokePath(ctx);
	
	
}

-(void) drawRotatedLeftImage:(CGContextRef)ctx
{
	//UIGraphicsBeginImageContext(boundary.size);
	UIGraphicsBeginImageContextWithOptions(boundary.size, NO, 0.0);
	CGContextRotateCTM(UIGraphicsGetCurrentContext(), DEGREES_TO_RADIANS(-90));
	//CGContextDrawImage(UIGraphicsGetCurrentContext(),
	//				   CGRectMake(0,0,boundary.size.width, boundary.size.height),
	//				   sourceImage.CGImage);
	
	clippedImage = UIGraphicsGetImageFromCurrentImageContext();
	if([clippedImage retainCount] ==1)
		[clippedImage retain];
	UIGraphicsEndImageContext();
	return;
	
	
}

-(void) drawRotatedRightImage:(CGContextRef)ctx
{
	UIImage *src = sourceImage;
	UIImageOrientation orientation = UIImageOrientationUp;
    //UIGraphicsBeginImageContext(src.size);
	UIGraphicsBeginImageContextWithOptions(src.size, NO, 0.0);
	
	// CGContextRef context(ctx);
	
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (ctx, DEGREES_TO_RADIANS(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (ctx, DEGREES_TO_RADIANS(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (ctx, DEGREES_TO_RADIANS(90));
    }
	
    [src drawAtPoint:CGPointMake(0, 0)];
	
	// return UIGraphicsGetImageFromCurrentImageContext();
	clippedImage = UIGraphicsGetImageFromCurrentImageContext();
	if([clippedImage retainCount] ==1)
		[clippedImage retain];
	UIGraphicsEndImageContext();
	//[delegate goToSelectDone];
}

- (void) reset {
	firstTime=1;
}

- (CGFloat)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
	
	float x = toPoint.x - fromPoint.x;
	float y = toPoint.y - fromPoint.y;
	
	return sqrt(x * x + y * y);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch;
	CGPoint touchpoint;
	
	if([[event allTouches] count] == 1) {
		
		touch=[[[event allTouches] allObjects] objectAtIndex:0];
		touchpoint=[touch locationInView:self];
		//touchpoint.y = ((float)(self.frame.size.height)) - touchpoint.y;
		
		//touchpoint.x = ((float)(self.frame.size.width)) - touchpoint.x;
		
		// not using arrays for clarity
		if((touchpoint.x >= circleTopLeft.center.x) && 
		   (touchpoint.x <= circleTopLeft.center.x + 3 * circleTopLeft.radius) &&
		   (touchpoint.y >= circleTopLeft.center.y) && 
		   (touchpoint.y <= circleTopLeft.center.y + 3 * circleTopLeft.radius)
		   ) {
			whatToPut = CIRCLE_TOP_LEFT;
			//[delegate goToDeActivateZoomView];
			
		}
		else if((touchpoint.x >= circleBottomLeft.center.x) && 
				(touchpoint.x <= circleBottomLeft.center.x + 3 * circleBottomLeft.radius) &&
				(touchpoint.y >= circleBottomLeft.center.y) && 
				(touchpoint.y <= circleBottomLeft.center.y + 3 * circleBottomLeft.radius)
				) {
			whatToPut = CIRCLE_BOTTOM_LEFT;
			//[delegate goToDeActivateZoomView];
		}
		else if((touchpoint.x >= circleTopRight.center.x) && 
				(touchpoint.x <= circleTopRight.center.x + 3 * circleTopRight.radius) &&
				(touchpoint.y >= circleTopRight.center.y) && 
				(touchpoint.y <= circleTopRight.center.y + 3 * circleTopRight.radius)
				) {
			
			whatToPut = CIRCLE_TOP_RIGHT;
			//[delegate goToDeActivateZoomView];
		}
		else if((touchpoint.x >= circleBottomRight.center.x) && 
				(touchpoint.x <= circleBottomRight.center.x + 3 * circleBottomRight.radius) &&
				(touchpoint.y >= circleBottomRight.center.y) && 
				(touchpoint.y <= circleBottomRight.center.y + 3 * circleBottomRight.radius)
				) {
			whatToPut = CIRCLE_BOTTOM_RIGHT;
			//[delegate goToDeActivateZoomView];
		}
	}
	else if([[event allTouches] count] == 2) {
#if 0
		//Track the initial distance between two fingers.
		UITouch *touch1 = [[[event allTouches] allObjects] objectAtIndex:0];
		UITouch *touch2 = [[[event allTouches] allObjects] objectAtIndex:1];
		
		initialDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:self ] 
												 toPoint:[touch2 locationInView:self]];	
		
		[delegate goToActivateZoomView];
		[self setNeedsDisplay];
#endif
	}
	return;
}

- (void) touchesMoved: (NSSet*) touches withEvent: (UIEvent*) event
{
	UITouch* touch;
	CGPoint peviousFinger, touchpoint;
	
	
	if([[event allTouches] count] == 1) {
		
		if(whatToPut == NO_MAP) return;
		
		touch = [touches anyObject];
		peviousFinger  = [touch previousLocationInView: self];
		touchpoint = [touch locationInView: self];
		
#ifdef INVERTED_COORDINATES
		touchpoint.y = ((float)(self.frame.size.height)) - touchpoint.y;
		touchpoint.x = ((float)(self.frame.size.width)) - touchpoint.x;
#endif
		if(touchpoint.x >= (boundary.origin.x + boundary.size.width - (3 * circleTopLeft.radius/2))) 
		{
			//NSLog(@"here");
			return;
		}
		if(touchpoint.y >= (boundary.origin.y + boundary.size.height - (3 * circleTopLeft.radius/2))) 
		{
			//NSLog(@"here");
			return;
		}
		if(touchpoint.y <= boundary.origin.y - circleTopLeft.radius/2) 
		{
			//NSLog(@"here");
			return;
		}
		if(touchpoint.x <= boundary.origin.x - circleTopLeft.radius/2) 
		{
			//NSLog(@"here");
			return;
		}
		switch (whatToPut) {
			case CIRCLE_TOP_LEFT:
				circleTopLeft.center.x = touchpoint.x;
				circleTopLeft.center.y = touchpoint.y;
				break;
			case CIRCLE_TOP_RIGHT:
				circleTopRight.center.x = touchpoint.x ;
				circleTopRight.center.y = touchpoint.y ;
				break;
			case CIRCLE_BOTTOM_LEFT:
				circleBottomLeft.center.x = touchpoint.x ;
				circleBottomLeft.center.y = touchpoint.y ;
				break;
			case CIRCLE_BOTTOM_RIGHT:
				circleBottomRight.center.x = touchpoint.x ;
				circleBottomRight.center.y = touchpoint.y ;
				break;
			default:
				break;
		}
		[self setNeedsDisplay];
	}
	else if([[event allTouches] count] == 2) {
#ifdef NOT_USED
		//The image is being zoomed in or out.
		NSSet *allTouches = [event allTouches];
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
		
		CGPoint p1 = [touch1 locationInView:self];
		CGPoint p2 = [touch2 locationInView:self];
		//Calculate the distance between the two fingers.
		CGFloat finalDistance = [self distanceBetweenTwoPoints:p1 toPoint:p2];
		
		CGPoint centerPoint = CGPointMake((p1.x + p2.x)/2.0f, 
										  (p1.y + p2.y)/2.0f);
		
		//Check if zoom in or zoom out.
		if(initialDistance > finalDistance) {
			CGFloat dist = (initialDistance - finalDistance);
			if(dist <=0 ) return;
			[delegate goToZoomIn:dist center:centerPoint];
		}
		else {
			CGFloat dist = (finalDistance - initialDistance);
			if(dist <=0 ) return;
			[delegate goToZoomOut:dist center:centerPoint];
		}
		initialDistance = finalDistance;
		[delegate goToActivateZoomView];
		[self setNeedsDisplay];
#endif
	}
	
}	

- (void) touchesEnded: (NSSet*) touches withEvent: (UIEvent*) event
{
	whatToPut=NO_MAP;
	initialDistance = -1;
	//[delegate goToActivateZoomView];
	
}

- (void)dealloc {
    [super dealloc];
}


@end;
