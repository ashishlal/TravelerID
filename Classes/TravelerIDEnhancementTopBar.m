//
//  TravelerIDEnhancementTopBar.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDEnhancementTopBar.h"
#import "TravelerIDViewController.h"

@implementation TravelerIDEnhancementTopBar

@synthesize delegate;
@synthesize backButton;
@synthesize selectButton;

- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		
#if 1	
#if 0
		UIColor *color = [UIColor clearColor];
		UIImage *img = [UIImage imageNamed:@"toolbar-gradient.png"];
		[img drawInRect:CGRectMake(0, 0, self.frame.size.width, 
								   self.frame.size.height)];
		self.tintColor = color;
#endif
		
		self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		backButton.adjustsImageWhenHighlighted = YES;
        [backButton setImage:[UIImage imageNamed:@"back-button-1.png"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
		
#else		
		// create a bordered style button with custom title
		UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"<< Back"
																			style:UIBarButtonItemStyleBordered	
																		   target:self
																		   action:@selector(goBack:)] autorelease];
		
		
		// create a bordered style button with custom title
		UIBarButtonItem *selectButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Select"
																			  style:UIBarButtonItemStyleBordered	
																			 target:self
																			 action:@selector(goToSelect:)] autorelease];
#endif 			
        self.items = [NSArray arrayWithObjects:
					  backButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					  //selectButtonItem,
					  // [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
		
	}
    
    return self;
}


- (void)dealloc {
    
	self.backButton = nil;
	self.selectButton = nil;
	
    [super dealloc];
}


- (void) goBack:(id)sender {
    if(delegate) {
    	[delegate goBackFromEnhancementTopBar];
    }
}

- (void) goToSelect:(id)sender {
    if(delegate) {
    	[delegate goToSelect];
    }
}

#if 1
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"toolbar-gradient.png"] drawInRect:rect];
}
#endif

@end
