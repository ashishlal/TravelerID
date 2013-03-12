//
//  TravelerIDShareBar.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TravelerIDDetailViewController;


@interface TravelerIDShareBar : UIToolbar {
    TravelerIDDetailViewController *delegate;
    
    UIButton *deleteButton;
	UIButton *sharedButton;
	
}

@property (nonatomic, assign) TravelerIDDetailViewController *delegate;
@property (nonatomic, retain) UIButton *deleteButton;
@property (nonatomic, retain) UIButton *sharedButton;

- (void) goToDelete:(id)sender;
- (void) goToShared:(id)sender;

@end
