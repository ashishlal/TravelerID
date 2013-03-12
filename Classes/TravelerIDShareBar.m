//
//  TravelerIDShareBar.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDShareBar.h"
#import "TravelerIDDetailViewController.h"

@implementation TravelerIDShareBar

@synthesize delegate;
@synthesize deleteButton;
@synthesize sharedButton;

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
		
		self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		deleteButton.adjustsImageWhenHighlighted = YES;
        [deleteButton setImage:[UIImage imageNamed:@"delete-button-1.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"delete-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(goToDelete:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *deleteButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:deleteButton] autorelease];
		
		self.sharedButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		sharedButton.adjustsImageWhenHighlighted = YES;
        [sharedButton setImage:[UIImage imageNamed:@"share-button-1.png"] forState:UIControlStateNormal];
        [sharedButton setImage:[UIImage imageNamed:@"share-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [sharedButton addTarget:self action:@selector(goToShared:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *sharedButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:sharedButton] autorelease];
		
#else		
		// create a bordered style button with custom title
		UIBarButtonItem *deleteButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Delete"
																			  style:UIBarButtonItemStyleBordered	
																			 target:self
																			 action:@selector(goToDelete:)] autorelease];
		
		
		// create a bordered style button with custom title
		UIBarButtonItem *sharedButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Shared"
																			  style:UIBarButtonItemStyleBordered	
																			 target:self
																			 action:@selector(goToShared:)] autorelease];
#endif 			
        self.items = [NSArray arrayWithObjects:
					  deleteButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					  sharedButtonItem,
					  //[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
		
	}
    
    return self;
}


- (void)dealloc {
    
	self.deleteButton = nil;
	self.sharedButton = nil;
	
    [super dealloc];
}


- (void) goToDelete:(id)sender {
    if(delegate) {
    	[delegate goToDelete];
    }
}

- (void) goToShared:(id)sender {
    if(delegate) {
    	[delegate goToShared];
    }
}

#if 1
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"toolbar-gradient-reverse.png"] drawInRect:rect];
}
#endif

@end
