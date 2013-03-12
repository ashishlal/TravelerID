//
//  TravelerIDViewController.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelerIDImageView.h"
#import "TravelerIDTopBar.h"
#import "TravelerIDSaveBar.h"
#import "UIImageExtensions.h"
#import "ConstantsAndMacros.h"
#import "TravelerIDListTableViewController.h"
#import "TravelerIDNotifyParentProtocol.h"
#import "TravelerIDEnhancement.h"
#import "TravelerIDEnhancementTopBar.h"
#import "TravelerIDEnhancementBottomBar.h"
#import "TravelerIDZoomImageView.h"
#import "iAd/ADBannerView.h"

#import "TravelerID.h"
// Thanks to Ray Wenderlich for his code on iAd integration
// http://www.raywenderlich.com/1371/how-to-integrate-iad-into-your-iphone-app

@interface TravelerIDViewController :  UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, 
UINavigationControllerDelegate, TravelerIDNotifyParentProtocol, ADBannerViewDelegate> {
	
	TravelerID *newID;
	TravelerIDListTableViewController *TravelerIDList;
    TravelerIDImageView *imageView;
	TravelerIDZoomImageView *enhancedImageView;
	UIScrollView *zoomView;
	TravelerIDViewControllerActionSheetAction actionSheetAction;
	
	int enhancementState;
	unsigned int newIDImageType;
	TravelerIDTopBar *topBar;
	TravelerIDSaveBar *saveBar;
	TravelerIDEnhancementTopBar *enhancementTopBar;
	TravelerIDEnhancementBottomBar *enhancementBottomBar;
	TravelerIDEnhancement *enhancement;
	UINavigationController *navController;
	
	IBOutlet UIImageView *backgroundImage;
	bool newIDSaved;
	UIView *_contentView;
	id _adBannerView;
	BOOL _adBannerViewIsVisible;
	float factor;
	
};

@property (nonatomic, retain) TravelerID *newID;
@property (nonatomic, retain) TravelerIDListTableViewController *TravelerIDList;
@property (nonatomic, retain) TravelerIDImageView *imageView;
@property (nonatomic, retain) TravelerIDZoomImageView *enhancedImageView;
@property (nonatomic, retain) UIScrollView *zoomView;
@property (nonatomic, assign) int enhancementState;
@property (nonatomic, assign) unsigned int newIDImageType;
@property (nonatomic, retain) TravelerIDTopBar *topBar;
@property (nonatomic, retain) TravelerIDSaveBar *saveBar;
@property (nonatomic, retain) TravelerIDEnhancementTopBar *enhancementTopBar;
@property (nonatomic, retain) TravelerIDEnhancementBottomBar *enhancementBottomBar;
@property (nonatomic, retain) TravelerIDEnhancement *enhancement;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, assign) bool newIDSaved;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;
@property (nonatomic, assign) float factor;

-(void)ShowIDList:(NSString *)str;
-(IBAction) passportButtonPressed:(id)sender;
-(IBAction) licenseButtonPressed:(id)sender;
-(IBAction) visasButtonPressed:(id)sender;
-(IBAction) immunizationsButtonPressed:(id)sender;
-(IBAction) birthCertificateButtonPressed:(id)sender;
-(IBAction) medicalInsuranceButtonPressed:(id)sender;
-(IBAction) residencePermitButtonPressed:(id)sender;
-(IBAction) workPermitButtonPressed:(id)sender;
-(IBAction) marriageCertificateButtonPressed:(id)sender;
-(IBAction) loyaltyProgramsButtonPressed:(id)sender;
-(IBAction) miscButtonPressed:(id)sender;
-(IBAction) addNewIdButtonPressed:(id)sender;

- (int)getBannerHeight:(UIDeviceOrientation)orientation;
- (int)getBannerHeight;
- (void)createAdBannerView;
- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation;
- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

-(void)goToMain;
-(void)goToSelect;
-(void)goToRotateLeft;
-(void)goToRotateRight;
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
-(void)goToDeActivateZoomView;
-(void)goToActivateZoomView;
//-(void)goToZoomIn:(CGFloat)dist center:(CGPoint)center;
//-(void)goToZoomOut:(CGFloat)dist center:(CGPoint)center;
-(void)goToSelectDone;
-(void)goToSelectDoneAndBack;
-(void)goToSelectDoneAndBackThread;
-(void)goBackFromEnhancementTopBar;
-(void)goToEnhancementBar;
-(void)goToEnhancement;
-(void)goToEnhancementReset;
-(void)goToDelete;
-(void)goToSave;
-(void)InitPhotoID;
-(void)SetInitPhotoIDScreen;

-(void)showConfirmAlert:(NSString *)str;
-(void)showInfoAlert:(NSString *)str;
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex ;
-(void)newIDWasSavedInDB;
-(void)returnFromSaveAs:(id)sender;
-(void)returnFromRename;
-(void)returnFromDetail;
-(void)returnFromDetailWithDelete:(id)obj;
@end

