/*
 *  TravelerIDNotifyParentProtocol.h
 *  TravelerID
 *
 *  Created by Ashish Lal on 26/09/10.
 *  Copyright 2010 NetTech India. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>


@protocol TravelerIDNotifyParentProtocol
-(void) returnFromSaveAs:(id)sender;
-(void) returnFromRename;
-(void)returnFromDetail;
-(void)returnFromDetailWithDelete:(id)object;
@end
