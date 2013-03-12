//
//  TravelerIDTopBar.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TravelerIDViewController;


@interface TravelerIDTopBar : UIToolbar {
    TravelerIDViewController *delegate;
    
    UIButton *backButton;
	UIButton *enhancementButton;
	
}

@property (nonatomic, assign) TravelerIDViewController *delegate;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *enhancementButton;

@end
