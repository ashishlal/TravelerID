//
//  TravelerIDViewController.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDViewController.h"
#import "TravelerID.h"
#import "TravelerIDSaveAsController.h"

@implementation TravelerIDViewController

@synthesize newID;
@synthesize imageView;
@synthesize enhancedImageView;
@synthesize zoomView;
@synthesize TravelerIDList;
@synthesize topBar;
@synthesize saveBar;
@synthesize enhancementTopBar;
@synthesize enhancementBottomBar;
@synthesize enhancement;
@synthesize navController;
@synthesize enhancementState;
@synthesize backgroundImage;
@synthesize newIDImageType;
@synthesize newIDSaved;
@synthesize contentView = _contentView;
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;
@synthesize factor;

static int once=0;
/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	topBar = [[TravelerIDTopBar alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, BAR_HEIGHT)];
    topBar.delegate = self;
	topBar.tag = TOP_BAR_TAG;
    [self.view addSubview:topBar];
    [topBar release];
	
	saveBar = [[TravelerIDSaveBar alloc] initWithFrame:CGRectMake(WIDTH, HEIGHT-BAR_HEIGHT, WIDTH, BAR_HEIGHT)];
    saveBar.delegate = self;
	saveBar.tag = SAVE_BAR_TAG;
    [self.view addSubview:saveBar];
    [saveBar release];
	
	enhancementTopBar = [[TravelerIDEnhancementTopBar alloc] initWithFrame:CGRectMake(2*WIDTH, 0, WIDTH, BAR_HEIGHT)];
    enhancementTopBar.delegate = self;
	enhancementTopBar.tag = ENHANCEMENT_TOP_BAR_TAG;
    [self.view addSubview:enhancementTopBar];
    [enhancementTopBar release];
	
	enhancementBottomBar = [[TravelerIDEnhancementBottomBar alloc] initWithFrame:CGRectMake(640, HEIGHT-BAR_HEIGHT, WIDTH, BAR_HEIGHT)];
    enhancementBottomBar.delegate = self;
	enhancementBottomBar.tag = ENHANCEMENT_BOTTOM_BAR_TAG;
    [self.view addSubview:enhancementBottomBar];
    [enhancementBottomBar release];
	
	enhancementState = ENHANCEMENT_STATE_NORMAL;
	enhancedImageView = nil;
	newIDImageType = IMAGE_TYPE_NONE;
	
	[self createAdBannerView];
	
	//enhancedImageView = [[TravelerIDZoomImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-53-53-statusBarHt))];
	enhancedImageView = nil;
	zoomView = nil;
	newIDSaved = FALSE;
	[self.view insertSubview:backgroundImage atIndex:0];
	factor = 1.0f;
	factor = [UIScreen mainScreen].scale;
}

- (void) viewWillAppear:(BOOL)animated {
    //[self refresh];
    [self fixupAdView:[UIDevice currentDevice].orientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self fixupAdView:toInterfaceOrientation];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[backgroundImage release];
	self.contentView = nil;
	self.adBannerView = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark iAd Related Functions

- (int)getBannerHeight:(UIDeviceOrientation)orientation {
	return 50;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 50;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}


- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[[classAdBannerView alloc] 
							  initWithFrame:CGRectZero] autorelease];
        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects: 
														  ADBannerContentSizeIdentifier320x50, 
														  //ADBannerContentSizeIdentifier480x32, 
														  nil]];
        //if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        //    [_adBannerView setCurrentContentSizeIdentifier:
		// } 
		//else {
            [_adBannerView setCurrentContentSizeIdentifier:
			 ADBannerContentSizeIdentifier320x50];            
       // }
        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, 
											 -[self getBannerHeight])];
        [_adBannerView setDelegate:self];
		
        [self.view addSubview:_adBannerView];        
    }
}

- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
    if (_adBannerView != nil) {        
       // if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        //    [_adBannerView setCurrentContentSizeIdentifier:
		//	 ADBannerContentSizeIdentifier480x32];
       // } 
		//else {
            [_adBannerView setCurrentContentSizeIdentifier:
			 ADBannerContentSizeIdentifier320x50];
      //  }          
        [UIView beginAnimations:@"fixupViews" context:nil];
        if (_adBannerViewIsVisible) {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
          //  adBannerViewFrame.origin.y = 0;
			adBannerViewFrame.origin.y = 410;
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 
			[self getBannerHeight:toInterfaceOrientation];
            contentViewFrame.size.height = self.view.frame.size.height - 
			[self getBannerHeight:toInterfaceOrientation];
            _contentView.frame = contentViewFrame;
        } else {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = 
			-[self getBannerHeight:toInterfaceOrientation];
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 0;
            contentViewFrame.size.height = self.view.frame.size.height;
            _contentView.frame = contentViewFrame;            
        }
        [UIView commitAnimations];
    }   
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_adBannerViewIsVisible) {                
        _adBannerViewIsVisible = YES;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_adBannerViewIsVisible)
    {        
        _adBannerViewIsVisible = NO;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

#pragma mark -
#pragma mark UIAlertView

- (void)showConfirmAlert:(NSString *)str
{
	UIAlertView *myalert = [[UIAlertView alloc] init];
	[myalert setTitle:@"Confirm"];
	[myalert setMessage:str];
	[myalert setDelegate:self];
	[myalert addButtonWithTitle:@"Yes"];
	[myalert addButtonWithTitle:@"No"];
	[myalert show];
	[myalert release];
}

- (void)showInfoAlert:(NSString *)str
{
	UIAlertView *myalert = [[UIAlertView alloc] init];
	[myalert setTitle:@"Info"];
	[myalert setMessage:str];
	[myalert setDelegate:self];
	[myalert addButtonWithTitle:@"OK"];
	[myalert show];
	[myalert release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
    if (buttonIndex == 0) {
		
	}
	else if (buttonIndex == 1)
	{
		// No
	}
	return;
}


#pragma mark -
#pragma mark IBAction 

-(void)ShowIDList:(NSString *)str
{
	TravelerIDListTableViewController *TravelerIDListTemp = [[[TravelerIDListTableViewController alloc] init] autorelease];
	TravelerIDListTemp.managedObjectContext = TravelerIDList.managedObjectContext;
	TravelerIDListTemp.title = str;
	TravelerIDListTemp.category = str;
	
	if([TravelerIDListTemp fetchCountByCategory] > 0) {
		
		[TravelerIDListTemp  setFromSaveAs:1];
		navController = [[UINavigationController alloc] initWithRootViewController:TravelerIDListTemp];
		
		//[(UINavigationController *)TravelerIDList setDelegate:self];
		
		navController.delegate = self;
		[self presentModalViewController:navController animated:YES];
		
		[navController release];
		navController = nil;
	}
	else {
		NSString *info = [NSString stringWithFormat:@"No %@ documents found", TravelerIDList.category];
		[self showInfoAlert:info];
	}
	
}

-(IBAction) passportButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-01.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-01.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-01.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-01@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-01@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-01@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-01.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-01.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Passport";
	TravelerIDList.category = @"Passport";
	
	[self ShowIDList:TravelerIDList.category];
	
}
-(IBAction) licenseButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-02.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-02.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-02.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-02@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-02@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-02@2x.png"] forState:UIControlStateDisabled];
		
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-02.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-02.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Drivers License";
	TravelerIDList.category = @"Drivers License";
	
	[self ShowIDList:TravelerIDList.category];
}
-(IBAction) visasButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-03.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-03.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-03.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-03@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-03@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-03@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-03.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-03.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Visas";
	TravelerIDList.category = @"Visas";
	
	[self ShowIDList:TravelerIDList.category];
	
}
-(IBAction) immunizationsButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-04.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-04.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-04.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-04@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-04@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-04@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-04.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-04.png"] forState:UIControlStateDisabled];
#endif

	TravelerIDList.title = @"Immunizations";
	TravelerIDList.category = @"Immunizations";
	
	[self ShowIDList:TravelerIDList.category];
}
-(IBAction) birthCertificateButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-05.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-05.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-05.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-05@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-05@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-05@2x.png"] forState:UIControlStateDisabled];
		
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-05.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-05.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Birth Certificate";
	TravelerIDList.category = @"Birth Certificate";
	
	[self ShowIDList:TravelerIDList.category];
}
-(IBAction) medicalInsuranceButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-06.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-06.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-06.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-06@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-06@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-06@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-06.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-06.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Medical Insurance";
	TravelerIDList.category = @"Medical Insurance";
	
	[self ShowIDList:TravelerIDList.category];
}
-(IBAction) residencePermitButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-07.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-07.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-07.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-07@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-07@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-07@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-07.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-07.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Residence Permit";
	TravelerIDList.category = @"Residence Permit";
	
	[self ShowIDList:TravelerIDList.category];
}

-(IBAction) workPermitButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-08.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-08.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-08.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-08@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-08@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-08@2x.png"] forState:UIControlStateDisabled];
		
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-08.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-08.png"] forState:UIControlStateDisabled];

#endif
	TravelerIDList.title = @"Work Permit";
	TravelerIDList.category = @"Work Permit";
	
	[self ShowIDList:TravelerIDList.category];
}

-(IBAction) marriageCertificateButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-09.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-09.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-09.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-09@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-09@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-09@2x.png"] forState:UIControlStateDisabled];
	}
#else 
	[sender setImage:[UIImage imageNamed:@"active-pushed-09.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-09.png"] forState:UIControlStateDisabled];
#endif

	TravelerIDList.title = @"Marriage Certificate";
	TravelerIDList.category = @"Marriage Certificate";
	
	[self ShowIDList:TravelerIDList.category];
}
-(IBAction) loyaltyProgramsButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-10.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-10.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-10.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-10@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-10@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-10@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-10.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-10.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Loyalty Programs";
	TravelerIDList.category = @"Loyalty Programs";
	
	[self ShowIDList:TravelerIDList.category];
}

-(IBAction) miscButtonPressed:(id)sender
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-11.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-11.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-11.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-11@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-11@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-11@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-11.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-11.png"] forState:UIControlStateDisabled];
#endif
	TravelerIDList.title = @"Miscellaneous";
	TravelerIDList.category = @"Miscellaneous";
	
	[self ShowIDList:TravelerIDList.category];
	
}

-(IBAction) addNewIdButtonPressed:(id)sender;
{
#if 0
	if(factor == 1.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-12.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-12.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-12.png"] forState:UIControlStateDisabled];
	}
	else if(factor == 2.0f) {
		//[sender setImage:[UIImage imageNamed:@"active-normal-12@2x.png"] forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"active-pushed-12@2x.png"] forState:UIControlStateHighlighted];
		[sender setImage:[UIImage imageNamed:@"disabled-normal-12@2x.png"] forState:UIControlStateDisabled];
	}
#else
	[sender setImage:[UIImage imageNamed:@"active-pushed-12.png"] forState:UIControlStateHighlighted];
	[sender setImage:[UIImage imageNamed:@"disabled-normal-12.png"] forState:UIControlStateDisabled];
#endif
	if(!actionSheetAction) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
											delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
											otherButtonTitles:@"Use Image from Library", @"Take Photo With Camera", nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		actionSheetAction = ActionSheetToSelectTypeOfSource;
		[actionSheet showInView:self.view];
		[actionSheet release];
	}
	
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch(actionSheetAction) {
		case ActionSheetToSelectTypeOfSource: 
#if 1
		{
			UIImagePickerControllerSourceType sourceType;
			if (buttonIndex == 0) {
				sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			} else if(buttonIndex == 1) {
				sourceType = UIImagePickerControllerSourceTypeCamera;
			} else {
				// Cancel
				break;
			}
			if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.sourceType = sourceType;
				picker.delegate = self;
				if(sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
					picker.allowsEditing = YES;
				}
				else {
					picker.allowsEditing = NO;
				}
				[self presentModalViewController:picker animated:YES];
				[picker release];
			}
			break;
		}
#endif
		case ActionSheetSaveAsID: {
			if (buttonIndex == 0) {
				
				NSError *error = nil;
				if(![[TravelerIDList fetchedResultsController] performFetch: &error]) {
					NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
					abort();
				}
				
				[TravelerIDList setFromSaveAs:1];
				TravelerIDSaveAsController *saveAsViewController = [[[TravelerIDSaveAsController alloc] init] autorelease];
				
				newID = [NSEntityDescription insertNewObjectForEntityForName:@"TravelerID" 
													inManagedObjectContext:TravelerIDList.managedObjectContext];
				NSManagedObject *category = [NSEntityDescription insertNewObjectForEntityForName:@"TravelerIDType" 
													inManagedObjectContext: TravelerIDList.managedObjectContext];
				newID.category = category;
				
				NSManagedObject *image = [NSEntityDescription insertNewObjectForEntityForName:@"Image" 
																	   inManagedObjectContext: TravelerIDList.managedObjectContext];
#if 1
				newID.image = image;
				if(image != nil) {
					//UIImage *selectedImage = nil;
					if((enhancedImageView) && (enhancedImageView.image)) {
						[image setValue:enhancedImageView.image forKey:@"image"];
						//selectedImage = enhancedImageView.image;
						newIDImageType = IMAGE_TYPE_ENHANCED;
					}
					else {
						[image setValue:imageView.image forKey:@"image"];
						//selectedImage = imageView.image;
						newIDImageType = IMAGE_TYPE_STANDARD;
					}
				}
				
#endif
				[saveAsViewController setTravelerIDs:newID];
				unsigned int enFlag = (ENABLE_NAME_FIELD | ENABLE_DOCID_FIELD | ENABLE_CATEGORY_FIELD);
				[saveAsViewController setEnFlag:enFlag];
				
				navController = [[UINavigationController alloc] initWithRootViewController:saveAsViewController];
				
				[(UINavigationController *)saveAsViewController setDelegate:self];
				
				navController.delegate = self;
				[self presentModalViewController:navController animated:YES];
				
				[navController release];
				navController = nil;
				
				
			} 
			else {
				// Cancel
				break;
			}
			break;
		}
		case ActionSheetRenameID: {
			if (buttonIndex == 0) {
				
				NSError *error = nil;
				if(![[TravelerIDList fetchedResultsController] performFetch: &error]) {
					NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
					//abort();
				}
				[TravelerIDList setFromSaveAs:1];
				TravelerIDSaveAsController *saveAsViewController = [[[TravelerIDSaveAsController alloc] init] autorelease];
				
				[saveAsViewController setTravelerIDs:newID];
				unsigned int enFlag = (ENABLE_NAME_FIELD | ENABLE_DOCID_FIELD | ENABLE_CATEGORY_FIELD);
				[saveAsViewController setEnFlag:enFlag];
				
				
				navController = [[UINavigationController alloc] initWithRootViewController:saveAsViewController];
				
				[(UINavigationController *)saveAsViewController setDelegate:self];
				
				navController.delegate = self;
				[self presentModalViewController:navController animated:YES];
				
				[navController release];
				navController = nil;
				
				
			} 
			else {
				// Cancel
				break;
			}
			break;
		}			
	}
	actionSheetAction = 0;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
	static int kMaxResolution = 640;
	
	CGImageRef imgRef = image.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolution) {
		CGFloat ratio = width/height;
		if (ratio > 1) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
		} else {
			bounds.size.height = kMaxResolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	
	UIImageOrientation orient = image.imageOrientation;
	switch(orient) {
		case UIImageOrientationUp:
			transform = CGAffineTransformIdentity;
			break;
		case UIImageOrientationUpMirrored:
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
		case UIImageOrientationDown:
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
		case UIImageOrientationDownMirrored:
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
		case UIImageOrientationLeftMirrored:
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
		case UIImageOrientationLeft:
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
		case UIImageOrientationRightMirrored:
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
		case UIImageOrientationRight:
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
	}
	
	//UIGraphicsBeginImageContext(bounds.size);
	UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	} else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	CGContextConcatCTM(context, transform);
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
#if 1
	imageView = [[TravelerIDImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
	//imageView = [[TravelerIDImageView alloc] initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT)];
	if(!imageView) return;
	//NSURL *mediaUrl;
	
	//mediaUrl = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
	//UIImage *img = [self scaleAndRotateImage:[info objectForKey:UIImagePickerControllerEditedImage]];
	//UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
	UIImage* img1 = (UIImage*)[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *img;
	if(img1)
		img =	[self scaleAndRotateImage:[info objectForKey:UIImagePickerControllerEditedImage]];
	else 
		img =	[self scaleAndRotateImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
		//img = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
	CGRect scaled = CGRectMake(0, (BAR_HEIGHT+statusBarHt), WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt));
	//imageView.image = [img  scaleImage:scaled];
	CGSize targetSize;
	targetSize.width = WIDTH;
	targetSize.height=scaled.size.height;
	imageView.image = [img  imageByScalingProportionallyToSize:targetSize];
	if(!imageView.image) return;
#else
	imageView = [[TravelerIDImageView alloc] initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT)];
	UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
	imageView.image = img;
#endif
	[self.view addSubview:imageView];
	
	//[picker dismissModalViewControllerAnimated:YES];
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	
	[self InitPhotoID];
}

-(void) InitPhotoID {
	
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	[self performSelectorInBackground:@selector(SetInitPhotoIDScreen) withObject:nil];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void) SetInitPhotoIDScreen { 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self retain];
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
	
	topBar.frame = CGRectMake(0, statusBarHt, WIDTH, BAR_HEIGHT);
	saveBar.frame = CGRectMake(0, (HEIGHT-BAR_HEIGHT), WIDTH, BAR_HEIGHT);
	enhancementTopBar.frame = CGRectMake(WIDTH, statusBarHt, WIDTH, BAR_HEIGHT);
	enhancementBottomBar.frame = CGRectMake(WIDTH, (HEIGHT-BAR_HEIGHT), WIDTH, BAR_HEIGHT);
	
	[self.view bringSubviewToFront:topBar];
	[self.view bringSubviewToFront:saveBar];
	
	[UIView commitAnimations];
	[pool release];
	[self release];
	
}



#pragma mark -
#pragma mark Action/Delegated Functions
- (void) SetState:(int) enable barTag:(int)barTag
{
#if 0
	unsigned int flag = YES;
	if(enable == BAR_DISABLE) {
		flag = NO;
	}
	
	switch (barTag) {
		case TOP_BAR_TAG:
			topBar.backButton.enabled=flag;
			topBar.enhancementButton.enabled=flag;
			break;
		case SAVE_BAR_TAG:
			saveBar.saveButton.enabled=flag;
			saveBar.deleteButton.enabled=flag;
			break;
		default:
			break;
	}
#endif
	return;
}


-(void)goToMain
{
	
	[imageView removeFromSuperview];
	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
	
	topBar.frame = CGRectMake(WIDTH, statusBarHt, WIDTH, BAR_HEIGHT);
	saveBar.frame = CGRectMake(WIDTH, HEIGHT- BAR_HEIGHT, WIDTH, BAR_HEIGHT);
	enhancementTopBar.frame = CGRectMake(640, statusBarHt, WIDTH, BAR_HEIGHT);
	enhancementBottomBar.frame = CGRectMake(640, HEIGHT-BAR_HEIGHT, WIDTH, BAR_HEIGHT);
	CGRect adBannerViewFrame = [_adBannerView frame];
	
	adBannerViewFrame.origin.y = 0;
	adBannerViewFrame.origin.y = 410;
	[_adBannerView setFrame:adBannerViewFrame];
	
	[UIView commitAnimations];
#if 1	
	// if no name was given then delete the id
	if(newID != nil) {
		NSString *name = [newID valueForKey:@"name"];
		NSString *category = nil;
		if(newID.category != nil) {
			category = [newID.category valueForKey:@"name"];
		}
		if((name == nil) || (category == nil)) {
			NSError *error = nil;
			//if(newID.category != nil) [TravelerIDList.managedObjectContext deleteObject:newID.category];
			//if(newID.image != nil) [TravelerIDList.managedObjectContext deleteObject:newID.image];
			[newID.managedObjectContext deleteObject:newID];
			if ((newID.managedObjectContext) && (![newID.managedObjectContext save:&error])) {
				/*
				 Replace this implementation with code to handle the error appropriately.
				 
				 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
				 */
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				abort();
			}
			
		}
		
		else if( (name) && (category) && (enhancedImageView) && (enhancedImageView.image) && (newIDImageType != IMAGE_TYPE_ENHANCED)) {
			[newID.image setValue:enhancedImageView.image forKey:@"image"];
#if 0
			NSError *error = nil;
			if ((newID.managedObjectContext) && (![newID.managedObjectContext save:&error])) {
				/*
				 Replace this implementation with code to handle the error appropriately.
				 
				 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
				 */
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				abort();
			}
#endif
		}
	}
	if(enhancedImageView) {
		[enhancedImageView removeFromSuperview];
		enhancedImageView = nil;
		once=0;
		if(zoomView) {
			[zoomView removeFromSuperview];
			zoomView = nil;
			
		}
	}
	newID = nil;
	newIDSaved = FALSE;
	[TravelerIDList setFromSaveAs:0];
#endif
}

-(void)goBackFromEnhancementTopBar
{
	if(enhancementState == ENHANCEMENT_STATE_SELECTED) {
		[self goToSelectDone];
	}
	[enhancement removeFromSuperview];
	[self SetInitPhotoIDScreen];
}

-(void)goToEnhancementBar
{


	CGRect boundary = CGRectMake(0, ENHANCEMENT_HEIGHT-12, WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt-12));
	enhancement = [[TravelerIDEnhancement alloc] initWithFrame:boundary];
	enhancement.backgroundColor = [UIColor clearColor];
	[enhancement setBoundary:boundary];
	[self.view addSubview:enhancement];

	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
	
	topBar.frame = CGRectMake(-WIDTH, statusBarHt, WIDTH, BAR_HEIGHT);
	saveBar.frame = CGRectMake(-WIDTH, HEIGHT- BAR_HEIGHT, WIDTH, BAR_HEIGHT);
	enhancementTopBar.frame = CGRectMake(0,statusBarHt, WIDTH, BAR_HEIGHT);
	enhancementBottomBar.frame = CGRectMake(0, HEIGHT-BAR_HEIGHT, WIDTH, BAR_HEIGHT);
	CGRect adBannerViewFrame = [_adBannerView frame];
	adBannerViewFrame.origin.x = -WIDTH;
	//  adBannerViewFrame.origin.y = 0;
	adBannerViewFrame.origin.y = 410;
	[_adBannerView setFrame:adBannerViewFrame];
	[self.view bringSubviewToFront:enhancementTopBar];
	[self.view bringSubviewToFront:enhancementBottomBar];
	[UIView commitAnimations];
	[enhancement setDelegate:self];
	[enhancement setSourceImage:imageView.image];
	
}

#if 0
#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
   // return [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
	//[enhancement setSourceImage:enhancedImageView.image];
	//[enhancement setNeedsDisplay];
	//[self.view bringSubviewToFront:enhancement];
	//return enhancedImageView;
	return [zoomView viewWithTag:ZOOM_VIEW_TAG];
}

/************************************** NOTE **************************************/
/* The following delegate method works around a known bug in zoomToRect:animated: */
/* In the next release after 3.0 this workaround will no longer be necessary      */
/**********************************************************************************/
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    float newScale = [zoomView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [zoomView zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [zoomView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [zoomView zoomToRect:zoomRect animated:YES];
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [zoomView frame].size.height / scale;
    zoomRect.size.width  = [zoomView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
#endif

#pragma mark -
#pragma mark enhancement


#if 1
CGPoint scrollCenter;
- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView
{
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	[self.view bringSubviewToFront:enhancement];
	return enhancedImageView;
	//return imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)pScrollView 
{
#if 1
	CGFloat radius=10.0f;
	CGRect boundary = CGRectMake(radius, ENHANCEMENT_HEIGHT, WIDTH- radius, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt-10));
	CGSize screenSize = boundary.size;
    CGSize photoSize = [enhancedImageView.image size];
    CGFloat topInset = (screenSize.height - photoSize.height * [pScrollView zoomScale]) / 2.0;
    if (topInset < 0.0)
    {
        topInset = 0.0;
    }
	
    [pScrollView setContentInset:UIEdgeInsetsMake(topInset, 0.0, -topInset, 0.0)];
	
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	//[self.view bringSubviewToFront:enhancement];
#endif
}

- (CGPoint)translatePoint:(CGPoint)origin currentSize:(CGSize)currentSize newSize:(CGSize)newSize {
    // shortcut if they are equal
    if(currentSize.width == newSize.width && currentSize.height == newSize.height){ return origin; }
	
    // translate
    origin.x = newSize.width * (origin.x / currentSize.width);
    origin.y = newSize.height * (origin.y / currentSize.height);
    return origin;
}

- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (float) scale
{
#if 1
	for (UIView *checkView in [self.view subviews] ) {
		if (([checkView tag] == ENHANCEMENT_TOP_BAR_TAG) || ([checkView tag] == ENHANCEMENT_BOTTOM_BAR_TAG)) {
			//[[[self.view subviews] objectAtIndex:i] setHidden:YES];
			[self.view bringSubviewToFront:checkView];
		}
		
	}
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	[self.view bringSubviewToFront:enhancedImageView];
	[self.view bringSubviewToFront:enhancement];
#else

	for (UIView *checkView in [self.view subviews] ) {
		if (([checkView tag] == ENHANCEMENT_TOP_BAR_TAG) || ([checkView tag] == ENHANCEMENT_BOTTOM_BAR_TAG)) {
			//[[[self.view subviews] objectAtIndex:i] setHidden:YES];
			[self.view bringSubviewToFront:checkView];
		}
		
	}
	zoomView.center = scrollCenter;
#endif
	
}


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {  
	
	CGRect zoomRect;  
	
	// the zoom rect is in the content view's coordinates.   
	//    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.  
	//    As the zoom scale decreases, so more content is visible, the size of the rect grows.  
	zoomRect.size.height = [zoomView frame].size.height / scale;  
	zoomRect.size.width  = [zoomView frame].size.width  / scale;  
	
	// choose an origin so as to get the right center.  
	zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);  
	zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);  
	
	return zoomRect;  
}  

#endif

-(void)goToDeActivateZoomView
{
	if(zoomView) [self.view sendSubviewToBack:zoomView];
}

-(void) goToActivateZoomView
{
	if(zoomView) [self.view bringSubviewToFront:zoomView];
}

#if 0
-(void)goToZoomIn:(CGFloat)dist center:(CGPoint)center
{
#if 1
	CGFloat radius=10.0f;
	CGRect boundary = CGRectMake(radius, ENHANCEMENT_HEIGHT, WIDTH- 2 *radius, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt));
	UIImage *src;
	if(enhancedImageView) {
		src = [[UIImage alloc] initWithCGImage:[enhancedImageView.image CGImage]];
		
	}
	else {
		src = [[UIImage alloc] initWithCGImage:[imageView.image CGImage]];
		//CGContextDrawImage(ctx, rect, [src CGImage]);
		//enhancedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT3-5BAR_HEIGHT-statusBarHt))];
		enhancedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,
										boundary.size.width,
										boundary.size.height)];
		enhancedImageView.image = src;
		
	}
	if(!zoomView) {
	
#if 1
		zoomView = [[UIScrollView alloc] initWithFrame:CGRectMake(radius,ENHANCEMENT_HEIGHT- 2 * radius + 15,
												boundary.size.width,
												boundary.size.height-  radius - 15)];
#else
		zoomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,2,
																  boundary.size.width,
																  boundary.size.height + 42)];
		
#endif
		[zoomView setDelegate:self];
		[zoomView setBouncesZoom:YES];
		[self.zoomView setShowsVerticalScrollIndicator:NO];
		[self.zoomView setShowsHorizontalScrollIndicator:NO];
		zoomView.maximumZoomScale = 4.0;  
		zoomView.minimumZoomScale = 1.0;  
		zoomView.zoomScale = 1.0;  
		[zoomView setContentSize:[enhancedImageView frame].size]; 
		[zoomView setScrollEnabled:YES];
		[enhancedImageView setTag:ZOOM_VIEW_TAG];
		[enhancedImageView setUserInteractionEnabled:YES];
		[zoomView addSubview:enhancedImageView];
		
		scrollCenter = zoomView.center;
		[self.view addSubview:zoomView];
	}
	else {
		//[self.view bringSubviewToFront:zoomView];
	}
	zoomView.contentSize = [enhancedImageView frame].size; 
		
	if(!once) {
		once=1;
		//[self.view addSubview:enhancedImageView];
	}
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	[zoomView setNeedsDisplay];
	[self.view bringSubviewToFront:enhancement];
	//[self.view bringSubviewToFront:zoomView];
	[src release];
#endif
}

-(void)goToZoomOut:(CGFloat)dist center:(CGPoint)center
{
#if 1
	CGFloat radius=10.0f;
	CGRect boundary = CGRectMake(radius, ENHANCEMENT_HEIGHT, WIDTH- 2 *radius, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt));
	UIImage *src;
	if(enhancedImageView) {
		src = [[UIImage alloc] initWithCGImage:[enhancedImageView.image CGImage]];
		
	}
	else {
		
		src = [[UIImage alloc] initWithCGImage:[imageView.image CGImage]];
		//CGContextDrawImage(ctx, rect, [src CGImage]);
		enhancedImageView = [[UIImageView alloc] initWithFrame:
							 CGRectMake(0,0,
										boundary.size.width,
										boundary.size.height)];
		
							// CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		enhancedImageView.image = src;
		
	}
	if(!zoomView) {
#if 1
		zoomView = [[UIScrollView alloc] initWithFrame:CGRectMake(radius,ENHANCEMENT_HEIGHT - 2 * radius + 15,
																  boundary.size.width,
																  boundary.size.height- radius - 15)];
#else
		zoomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,2,
																  boundary.size.width + radius,
																  boundary.size.height + 42)];
#endif
		
		[zoomView setDelegate:self];
		[zoomView setBouncesZoom:YES];
		[self.zoomView setShowsVerticalScrollIndicator:NO];
		[self.zoomView setShowsHorizontalScrollIndicator:NO];
		zoomView.maximumZoomScale = 4.0;  
		zoomView.minimumZoomScale = 1.0;  
		zoomView.zoomScale = 1.0;  
		[zoomView setContentSize:[enhancedImageView frame].size]; 
		[zoomView setScrollEnabled:YES];
		[enhancedImageView setTag:ZOOM_VIEW_TAG];
		[enhancedImageView setUserInteractionEnabled:YES];
		[zoomView addSubview:enhancedImageView];
		scrollCenter = zoomView.center;
		[self.view addSubview:zoomView];
	}
	else {
		
		//[self.view bringSubviewToFront:zoomView];
	}
	zoomView.contentSize = [enhancedImageView frame].size; 

	if(!once) {
		once=1;
		//[self.view addSubview:enhancedImageView];
	}
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	[zoomView setNeedsDisplay];
	[self.view bringSubviewToFront:enhancement];
	//[self.view bringSubviewToFront:zoomView];
	[src release];
#endif	
}
#endif
-(void)goToRotateLeft
{
	UIImage *src;
	if(enhancedImageView) {
		src = [[UIImage alloc] initWithCGImage:[enhancedImageView.image CGImage]];
		
	}
	else {
		
		src = [[UIImage alloc] initWithCGImage:[imageView.image CGImage]];
		//CGContextDrawImage(ctx, rect, [src CGImage]);
		enhancedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		enhancedImageView.image = src;
		
	}
	
	CGRect scaled = CGRectMake(0, ENHANCEMENT_HEIGHT, WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt-10));
	UIImage *copy = [src imageRotatedByDegrees:-90];
	//UIImage *copy = [copy1 imageByScalingToSize:scaled.size];
	[copy retain];
	
	enhancedImageView.image = [copy  scaleImage:scaled];
	//test++;
	
	
	if(!once) {
		once=1;
		[self.view addSubview:enhancedImageView];
	}
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	[self.view bringSubviewToFront:enhancement];
	[src release];
	
	
}

-(void)goToRotateRight
{

	UIImage *src;
	

	if(enhancedImageView) {
		src = [[UIImage alloc] initWithCGImage:[enhancedImageView.image CGImage]];
		
	}
	else {
		
		src = [[UIImage alloc] initWithCGImage:[imageView.image CGImage]];
		//CGContextDrawImage(ctx, rect, [src CGImage]);
		enhancedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		enhancedImageView.image = src;
		
	}
	
	CGRect scaled = CGRectMake(0, ENHANCEMENT_HEIGHT, WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt-10));
	UIImage *copy = [src imageRotatedByDegrees:90];
	//UIImage *copy = [copy1 imageWithImage:scaled.size];
	[copy retain];
	
	enhancedImageView.image = [copy  scaleImage:scaled];
	//test++;
	
	if(!once) {
		once=1;
		[self.view addSubview:enhancedImageView];
	}
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement setNeedsDisplay];
	[self.view bringSubviewToFront:enhancement];
	[src release];

		
}



-(void)goToSelect
{
	//int allocDone =0;
	if(!enhancedImageView) {
	//	allocDone=1;
		//enhancedImageView = [[TravelerIDImageView alloc] initWithFrame:CGRectMake(0,53+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		enhancedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		//src = [[UIImage alloc] initWithCGImage:[imageView.image CGImage]];
		enhancedImageView.image = imageView.image;
		[self.view addSubview:enhancedImageView];
		once=1;
	}
	
	if(newIDSaved) {
		newIDImageType = IMAGE_TYPE_ENHANCED_AFTER_SAVE;
	}
	enhancementState = ENHANCEMENT_STATE_SELECTED;
	[enhancement setSourceImage:enhancedImageView.image];
	[enhancement toggleShowClip:1];
	[enhancement setNeedsDisplay];
	[self.view bringSubviewToFront:enhancement];
	//[self goToSelectDone];
	
	//[enhancement removeFromSuperview];
	//[self SetInitPhotoIDScreen];
	//[src release];
	
}

-(void)goToSelectDone
{
	
	UIImage *img = [enhancement getClippedImage];
	enhancedImageView.image = img;
	enhancementState = ENHANCEMENT_STATE_NORMAL;
	//if(allocDone)
	//	[self.view addSubview:enhancedImageView];
	
}

-(void) goToSelectDoneAndBack {
	
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	[self performSelectorInBackground:@selector(goToSelectDoneAndBackThread) withObject:nil];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)goToSelectDoneAndBackThread
{
	int allocDone =0;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self retain];
	
	if(!enhancedImageView) {
		allocDone=1;
		//enhancedImageView = [[TravelerIDImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		enhancedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT+statusBarHt,WIDTH,(HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt))];
		enhancedImageView.image = [enhancement getClippedImage];
		[self.view addSubview:enhancedImageView];
		once=1;
	}
	else {
		enhancedImageView.image = [enhancement getClippedImage];
	}
	//CGRect scaled = CGRectMake(0, ENHANCEMENT_HEIGHT, WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt-10));
	
	//if(!once) {
	//	once=1;
	//	[self.view addSubview:enhancedImageView];
	//}
	//enhancedImageView.image = [img scaleImage:scaled];
	enhancementState = ENHANCEMENT_STATE_NORMAL;
	
	[enhancement removeFromSuperview];
	[self.view bringSubviewToFront:enhancedImageView];
	[self SetInitPhotoIDScreen];
	[pool release];
	[self release];
	
}


-(void)goToEnhancementReset
{
	enhancementState = ENHANCEMENT_STATE_RESET;
	[enhancement toggleShowClip:0];
	[enhancement reset];
	[enhancement setNeedsDisplay];
}

-(void)goToEnhancement
{
	
	if(enhancedImageView) {
		[enhancedImageView removeFromSuperview];
		enhancedImageView = nil;
		once=0;
	}
	[self goToEnhancementBar]; 
	
	[enhancement toggleShowRect:1];
	[enhancement setNeedsDisplay];
	
	//[self.view bringSubviewToFront:enhancement];
}

-(void)goToDelete
{
}

-(void)goToSave
{
	if(!actionSheetAction) {
		NSString *name = nil;
		
		if(newID != nil) {
			name = [newID valueForKey:@"name"];
		}
		
		if(name == nil) {
			
			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
															delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
															otherButtonTitles:@"Save As New ID", nil];
			actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
			actionSheetAction = ActionSheetSaveAsID;
			[actionSheet showInView:self.view];
			[actionSheet release];
		}
		else {
			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
															delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
															otherButtonTitles:@"Rename ID", nil];
			actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
			actionSheetAction = ActionSheetRenameID;
			[actionSheet showInView:self.view];
			[actionSheet release];
			
		}
	}
}

-(void)newIDWasSavedInDB
{
	newIDSaved = TRUE;
	//[TravelerIDList setFromSaveAs:0];
}

-(void)returnFromSaveAs:(id)sender
{
	if(sender)newIDSaved=(bool)(sender);
	[self dismissModalViewControllerAnimated:YES];
	//[TravelerIDList setFromSaveAs:0];
}

-(void)returnFromRename
{
	[self dismissModalViewControllerAnimated:YES];
	
}

-(void)returnFromDetail
{
	[self dismissModalViewControllerAnimated:YES];
	
}

-(void)returnFromDetailWithDelete:(id)obj
{
	
	
}

-(void)returnFromListTable
{
}
@end
