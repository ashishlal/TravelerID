//
//  TravelerIDImageView.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDImageView.h"


@implementation TravelerIDImageView

@synthesize image;


- (void)dealloc {
    self.image = nil;
    
    [super dealloc];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
	
    [image drawInRect:rect];
    
}


@end
