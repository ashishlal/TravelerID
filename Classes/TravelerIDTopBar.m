//
//  TravelerIDTopBar.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDTopBar.h"
#import "TravelerIDViewController.h"

@implementation TravelerIDTopBar

@synthesize delegate;
@synthesize backButton;
@synthesize enhancementButton;

- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		
#if 1	
		//UIColor *color = [UIColor clearColor];
		//UIImage *img = [UIImage imageNamed:@"toolbar-gradient.png"];
		//[img drawInRect:CGRectMake(0, 0, self.frame.size.width, 
		//						   self.frame.size.height)];
		//self.tintColor = color;
		
		
		self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		backButton.adjustsImageWhenHighlighted = YES;
        [backButton setImage:[UIImage imageNamed:@"back-button-1.png"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
		
		self.enhancementButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		enhancementButton.adjustsImageWhenHighlighted = YES;
        [enhancementButton setImage:[UIImage imageNamed:@"enhance-button-1.png"] forState:UIControlStateNormal];
        [enhancementButton setImage:[UIImage imageNamed:@"enhance-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [enhancementButton addTarget:self action:@selector(goToEnhancement:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *enButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:enhancementButton] autorelease];
		
#else		
		// create a bordered style button with custom title
		UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"<< Main"
																			style:UIBarButtonItemStyleBordered	
																		   target:self
																		   action:@selector(goBack:)] autorelease];
		
		
		// create a bordered style button with custom title
		UIBarButtonItem *enButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Enhancement"
																		  style:UIBarButtonItemStyleBordered	
																		 target:self
																		 action:@selector(goToEnhancement:)] autorelease];
#endif 			
        self.items = [NSArray arrayWithObjects:
					  backButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					  enButtonItem,
					  // [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
		
	}
    
    return self;
}


- (void)dealloc {
    
	self.backButton = nil;
	self.enhancementButton = nil;
	
    [super dealloc];
}


- (void) goBack:(id)sender {
    if(delegate) {
    	[delegate goToMain];
    }
}

- (void) goToEnhancement:(id)sender {
    if(delegate) {
    	[delegate goToEnhancement];
    }
}

#if 1
- (void)drawRect:(CGRect)rect {
		
    [[UIImage imageNamed:@"toolbar-gradient.png"] drawInRect:rect];
}
#endif

@end
