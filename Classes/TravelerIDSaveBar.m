//
//  TravelerIDSaveBar.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDSaveBar.h"
#import "TravelerIDViewController.h"

@implementation TravelerIDSaveBar


@synthesize delegate;
@synthesize deleteButton;
@synthesize saveButton;

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
        //UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:deleteButton] autorelease];
		
		self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
		saveButton.adjustsImageWhenHighlighted = YES;
        [saveButton setImage:[UIImage imageNamed:@"save-button-1.png"] forState:UIControlStateNormal];
        [saveButton setImage:[UIImage imageNamed:@"save-button-depressed-1.png"] forState:UIControlStateHighlighted];
        [saveButton addTarget:self action:@selector(goToSave:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *saveButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:saveButton] autorelease];
		
		
		self.items = [NSArray arrayWithObjects:
					  // deleteButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					  saveButtonItem,
					  //[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
		
#else		
		// create a bordered style button with custom title
		UIBarButtonItem *deleteButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Delete"
																			  style:UIBarButtonItemStyleBordered	
																			 target:self
																			 action:@selector(goToDelete:)] autorelease];
		
		
		// create a bordered style button with custom title
		UIBarButtonItem *saveButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Save"
																			style:UIBarButtonItemStyleBordered	
																		   target:self
																		   action:@selector(goToSave:)] autorelease];
		
		self.items = [NSArray arrayWithObjects:
					  // deleteButtonItem,
					  [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
					  saveButtonItem,
					  //[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease],
                      nil];
		
#endif 			
		
		
	}
    
    return self;
}


- (void)dealloc {
    
	self.deleteButton = nil;
	self.saveButton = nil;
	
    [super dealloc];
}


- (void) goToDelete:(id)sender {
    if(delegate) {
    	[delegate goToDelete];
    }
}

- (void) goToSave:(id)sender {
    if(delegate) {
    	[delegate goToSave];
    }
}

#if 1
- (void)drawRect:(CGRect)rect {
    [[UIImage imageNamed:@"toolbar-gradient-reverse.png"] drawInRect:rect];
}
#endif

@end
