//
//  UIViewControllerUtil.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//


#import "UIViewControllerUtil.h"


@implementation UIViewController (FixedApi)

- (UIViewController *)viewController;
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else {
        return nil;
    }
}
@end

