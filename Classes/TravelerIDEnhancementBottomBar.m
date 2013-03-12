//
//  TravelerIDEnhancementBottomBar.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDEnhancementBottomBar.h"
#import "TravelerIDViewController.h"

@implementation TravelerIDEnhancementBottomBar

@synthesize delegate;
@synthesize selectButton;
@synthesize resetButton;

- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		
#if 1	
#if 0
		UIColor *color = [UIColor clearColor];
		UIImage *img = [UIImage imageNamed:@"toolbar-gradient-reverse.png"];
		[img drawInRect:CGRectMake(0, 0, self.frame.size.width, 
								   self.frame.size.height)];
		self.tintColor = color;
#endif		
		
		self.resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 30)];
		resetButton.adjustsImageWhenHighlighted = YES;
        [resetButton setImage:[UIImage imageNamed:@"reset-button-1.png"] forState:UIControlStateNormal];
        [resetButton setImage:[UIImage imageNamed:@"reset-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [resetButton addTarget:self action:@selector(goToEnhancementReset:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *resetButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:resetButton] autorelease];
#if 0		
		// create a bordered style button with custom title
		UIBarButtonItem *rlButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"<-RL"
																		  style:UIBarButtonItemStyleBordered	
																		 target:self
																		 action:@selector(goToRotateLeft:)] autorelease];
		
		UIBarButtonItem *rrButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"RR->"
																		  style:UIBarButtonItemStyleBordered	
																		 target:self
																		 action:@selector(goToRotateRight:)] autorelease];
#endif		
		self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		selectButton.adjustsImageWhenHighlighted = YES;
        [selectButton setImage:[UIImage imageNamed:@"select-button-1.png"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"select-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [selectButton addTarget:self action:@selector(goToSelect:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *selectButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:selectButton] autorelease];
		
		
#else		
		// create a bordered style button with custom title
		UIBarButtonItem *resetButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Reset"
																			 style:UIBarButtonItemStyleBordered	
																			target:self
																			action:@selector(goToEnhancementReset:)] autorelease];
		
		
		// create a bordered style button with custom title
		UIBarButtonItem *selectButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Select"
																			  style:UIBarButtonItemStyleBordered	
																			 target:self
																			 action:@selector(goToSelect:)] autorelease];
#endif 			
        self.items = [NSArray arrayWithObjects:
					  resetButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					 // rlButtonItem,
					 // rrButtonItem,
					  selectButtonItem,
					  // [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
		
	}
    
    return self;
}


- (void)dealloc {
    
	self.resetButton = nil;
	self.selectButton = nil;
	
    [super dealloc];
}


- (void) goToEnhancementReset:(id)sender {
    if(delegate) {
    	[delegate goToEnhancementReset];
    }
}

- (void) goToSelect:(id)sender {
    if(delegate) {
    	[delegate goToSelect];
    }
}

- (void) goToRotateLeft:(id)sender {
    if(delegate) {
    	[delegate goToRotateLeft];
    }
}

- (void) goToRotateRight:(id)sender {
    if(delegate) {
    	[delegate goToRotateRight];
    }
}

#if 1
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"toolbar-gradient-reverse.png"] drawInRect:rect];
}
#endif


@end
