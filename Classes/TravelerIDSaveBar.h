//
//  TravelerIDSaveBar.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TravelerIDViewController;


@interface TravelerIDSaveBar : UIToolbar {
    TravelerIDViewController *delegate;
    
    UIButton *deleteButton;
	UIButton *saveButton;
	
}


@property (nonatomic, assign) TravelerIDViewController *delegate;
@property (nonatomic, retain) UIButton *deleteButton;
@property (nonatomic, retain) UIButton *saveButton;


@end

