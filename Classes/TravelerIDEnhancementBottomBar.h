//
//  TravelerIDEnhancementBottomBar.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelerIDViewController;

@interface TravelerIDEnhancementBottomBar : UIToolbar {
	
	TravelerIDViewController *delegate;
    
    UIButton *selectButton;
	UIButton *resetButton;
}

@property (nonatomic, assign) TravelerIDViewController *delegate;
@property (nonatomic, retain) UIButton *selectButton;
@property (nonatomic, retain) UIButton *resetButton;

@end
