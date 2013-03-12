//
//  TravelerIDEditBar.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TravelerIDDetailViewController;


@interface TravelerIDEditBar : UIToolbar {
    TravelerIDDetailViewController *delegate;
    
    UIButton *backButton;
	UILabel *statusLabel;
	UIButton *editButton;
	
}

@property (nonatomic, assign) TravelerIDDetailViewController *delegate;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) UIButton *editButton;

- (void) goBack:(id)sender;
- (void) goToEdit:(id)sender;

@end
