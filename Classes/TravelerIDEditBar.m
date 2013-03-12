//
//  TravelerIDEditBar.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//
#import "TravelerIDEditBar.h"
#import "TravelerIDDetailViewController.h"

@implementation TravelerIDEditBar

@synthesize delegate;
@synthesize backButton;
@synthesize statusLabel;
@synthesize editButton;



- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
#if 0		
		UIColor *color = [UIColor clearColor];
		UIImage *img = [UIImage imageNamed:@"toolbar-gradient.png"];
		[img drawInRect:CGRectMake(0, 0, self.frame.size.width, 
								   self.frame.size.height)];
		self.tintColor = color;
#endif		
		
		self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        statusLabel.textAlignment = UITextAlignmentCenter;
        statusLabel.font = [UIFont boldSystemFontOfSize:15.0];
       // statusLabel.textColor = [UIColor colorWithRed:0.126 green:0.126 blue:0.129 alpha:1.000];
		statusLabel.textColor = [UIColor whiteColor];
        statusLabel.shadowColor = [UIColor colorWithRed:0.773 green:0.779 blue:0.793 alpha:1.000];
        statusLabel.backgroundColor = [UIColor clearColor];
       // statusLabel.shadowOffset = CGSizeMake(0, 1);
        statusLabel.text = @"Traveler ID";
        UIBarButtonItem *labelButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:statusLabel] autorelease];
		
		
		
#if 1		
		self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		backButton.adjustsImageWhenHighlighted = YES;
        [backButton setImage:[UIImage imageNamed:@"back-button-1.png"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
		
		self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		editButton.adjustsImageWhenHighlighted = YES;
        [editButton setImage:[UIImage imageNamed:@"edit-button-1.png"] forState:UIControlStateNormal];
        [editButton setImage:[UIImage imageNamed:@"edit-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [editButton addTarget:self action:@selector(goToEdit:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *editButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
		
#else		
		// create a bordered style button with custom title
		UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"<< Back"
																			style:UIBarButtonItemStyleBordered	
																		   target:self
																		   action:@selector(goBack:)] autorelease];
		
		
		
		// create a bordered style button with custom title
		UIBarButtonItem *editButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit"
																			style:UIBarButtonItemStyleBordered	
																		   target:self
																		   action:@selector(goToEdit:)] autorelease];
#endif 			
        self.items = [NSArray arrayWithObjects:
					  backButtonItem,
					  labelButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					  editButtonItem,
					  //[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
		
	}
    
    return self;
}


- (void)dealloc {
    
	self.backButton = nil;
	self.editButton = nil;
	
    [super dealloc];
}


- (void) goBack:(id)sender {
    if(delegate) {
    	[delegate goBack];
    }
}

- (void) goToEdit:(id)sender {
    if(delegate) {
    	[delegate goToEdit];
    }
}

#if 1
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"toolbar-gradient.png"] drawInRect:rect];
}
#endif
@end
