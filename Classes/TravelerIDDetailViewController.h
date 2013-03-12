//
//  TravelerIDDetailViewController.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "TravelerIDImageView.h"
#import "TravelerIDEditBar.h"
#import "TravelerIDShareBar.h"
#import "UIImageExtensions.h"
#import "ConstantsAndMacros.h"
#import "TravelerID.h"
#import "TravelerIDNotifyParentProtocol.h"
#import "TravelerIDZoomImageView.h"

@interface TravelerIDDetailViewController : UIViewController<UIActionSheetDelegate, UINavigationControllerDelegate, 
	TravelerIDNotifyParentProtocol, MFMailComposeViewControllerDelegate, 
	UIScrollViewDelegate, TapDetectingImageViewDelegate> {
@private
	id <TravelerIDNotifyParentProtocol> delegate;
	TravelerID *travelerID;
	TravelerIDViewControllerActionSheetAction actionSheetAction;
	//TravelerIDImageView *imageView;
	UIImageView *imageView;
	TravelerIDEditBar *editBar;
	TravelerIDShareBar *shareBar;
	UIScrollView *imageScrollView;
}

@property (retain, nonatomic) id <TravelerIDNotifyParentProtocol> delegate;
@property (nonatomic, retain) TravelerID *TravelerID;
@property (nonatomic, retain)  UIImageView *imageView;
@property (nonatomic, retain)  TravelerIDEditBar *editBar;
@property (nonatomic, retain)  TravelerIDShareBar *shareBar;
@property (nonatomic, retain)  UIScrollView *imageScrollView;

//- (IBAction)photoTapped;

- (void) goToDelete;
- (void) goToShared;
- (void) goBack;
- (void) goToEdit;
-(void)setTravelerID:(TravelerID *)tr;
//-(void)goBack:(id)sender;
-(void)setDelegate:(id)dgate;
-(void)returnFromDetailWithDelete:(id)obj;
-(void) CreatePDFFile:(CGRect) pageRect filename:(const char *)filename;
@end
