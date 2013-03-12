//
//  TravelerIDDetailViewController.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDDetailViewController.h"
#import "TravelerIDSaveAsController.h"
//#import "TravelerIDEmailPDFController.h"
#import "ConstantsAndMacros.h"

@interface TravelerIDDetailViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end

@implementation TravelerIDDetailViewController

@synthesize delegate;
@synthesize TravelerID;
@synthesize imageView;
@synthesize editBar;
@synthesize shareBar;
@synthesize imageScrollView;

- (void)loadView {
    [super loadView];
	
	UIImage *image = [travelerID.image valueForKey:@"image"];
	if ( image == nil ) {
		image =[UIImage imageNamed:@"QuestionMark.jpg"];
	}
	
	CGRect boundaryScrollView = CGRectMake(0,BAR_HEIGHT,WIDTH,HEIGHT-BAR_HEIGHT-BAR_HEIGHT);
	CGRect boundaryImageView = CGRectMake(0,0,boundaryScrollView.size.width*4,boundaryScrollView.size.height*4);
	
	imageView = [[UIImageView alloc] initWithFrame:boundaryImageView];
	[imageView setBackgroundColor:[UIColor blackColor]];
	//imageView = [[UIImageView alloc] initWithImage:image];
	//CGRect scaled = CGRectMake(0, BAR_HEIGHT, WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt));
	CGRect scaled = CGRectMake(0, 0, boundaryImageView.size.width, boundaryImageView.size.height);
	CGSize targetSize;
	targetSize.width = scaled.size.width;
	targetSize.height= scaled.size.height;
	imageView.image = [image  imageByScalingProportionallyToSize:targetSize];
	//imageView.image = [image scaleImage:scaled];
	[imageView setTag:ZOOM_VIEW_TAG];
    [imageView setUserInteractionEnabled:YES];
	
	//set up zooming
	// set up main scroll view
    imageScrollView = [[UIScrollView alloc] initWithFrame:boundaryScrollView];
	//imageScrollView = [[UIScrollView alloc] initWithFrame:[[self view] bounds]];
    [imageScrollView setBackgroundColor:[UIColor blackColor]];
    [imageScrollView setDelegate:self];
    [imageScrollView setBouncesZoom:YES];
	//statusBarHt=0;
	[imageScrollView setContentSize:[imageView frame].size];
    [imageScrollView addSubview:imageView];
	
    [[self view] addSubview:imageScrollView];
	
    // add gesture recognizers to the image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [imageView addGestureRecognizer:singleTap];
    [imageView addGestureRecognizer:doubleTap];
    [imageView addGestureRecognizer:twoFingerTap];
    
    [singleTap release];
    [doubleTap release];
    [twoFingerTap release];
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [imageScrollView frame].size.width  / [imageView frame].size.width;
	 //float minimumScale = 1.0f;
    [imageScrollView setMinimumZoomScale:minimumScale];
    [imageScrollView setZoomScale:minimumScale];
	
	[imageView release];
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	int statusBarHt1 = 0;

	//self.TravelerIDList = [[TravelerIDListTableViewController alloc] init];
	editBar = [[TravelerIDEditBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, BAR_HEIGHT)];
    editBar.delegate = self;
	editBar.statusLabel.text = self.title;
	editBar.tag = EDIT_BAR_TAG;
    [self.view addSubview:editBar];
    [editBar release];
	
		//statusBarHt=20;
	shareBar = [[TravelerIDShareBar alloc] initWithFrame:CGRectMake(0, HEIGHT-BAR_HEIGHT-statusBarHt1, WIDTH, BAR_HEIGHT)];
    shareBar.delegate = self;
	shareBar.tag = SHARE_BAR_TAG;
    [self.view addSubview:shareBar];
    [shareBar release];
	
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	//UIColor *color = [UIColor clearColor];
	//UIImage *img = [UIImage imageNamed:@"toolbar-gradient.png"];
	//[img drawInRect:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 
	//						   self.navigationController.navigationBar.frame.size.height)];
	//self.navigationController.navigationBar.tintColor = color;
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[imageScrollView release];
}


- (void)dealloc {
	
    [super dealloc];
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
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
    float newScale = [imageScrollView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [imageScrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


#pragma mark -
#pragma mark PDFCreation and email

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

-(void) CreatePDFFile:(CGRect) pageRect filename:(const char *)filename {
	
	// This code block sets up our PDF Context so that we can draw to it
	CGContextRef pdfContext;
	CFStringRef path;
	CFURLRef url;
	CFMutableDictionaryRef myDictionary = NULL;
	
	if(!travelerID) return;
	// Create a CFString from the filename we provide to this method when we call it
	path = CFStringCreateWithCString (NULL, filename,
									  kCFStringEncodingUTF8);
	// Create a CFURL using the CFString we just defined
	url = CFURLCreateWithFileSystemPath (NULL, path,
										 kCFURLPOSIXPathStyle, 0);
	CFRelease (path);
	// This dictionary contains extra options mostly for 'signing' the PDF
	myDictionary = CFDictionaryCreateMutable(NULL, 0,
											 &kCFTypeDictionaryKeyCallBacks,
											 &kCFTypeDictionaryValueCallBacks);
	
	NSString *idCat = [travelerID.category valueForKey:@"name"];
	//const char *pdfTitle = ((const char *)[idCat UTF8String]);
	//CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
	CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("Travel Document"));
	CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("TravelerID"));
	// Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
	pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//NSString *file = @"myTravelerID.pdf"
	//NSString *newFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:file];

	//if (!UIGraphicsBeginPDFContextToFile(newFilePath, pageRect, myDictionary )) {
	//	NSLog(@"error creating PDF context");
	//	return;
	//}
	
	// Cleanup our mess
	CFRelease(myDictionary);
	CFRelease(url);
	// Done creating our PDF Context, now it's time to draw to it
	
	// Starts our first page
	CGContextBeginPage (pdfContext, &pageRect);
	
	// Draws a black rectangle around the page inset by 50 on all sides
	//CGContextStrokeRect(pdfContext, CGRectMake(50, 50, pageRect.size.width - 100, pageRect.size.height - 100));
	
	// This code block will create an image that we then draw to the page
	UIImage *photo = [travelerID.image valueForKey:@"image"];
	if ( photo == nil ) {
		photo =[UIImage imageNamed:@"QuestionMark.jpg"];
	}
	
	CGImageRef image = [photo CGImage];
    //CGDataProviderRef provider;
    //CFStringRef picturePath;
    //CFURLRef pictureURL;
	
    //picturePath = CFStringCreateWithCString (NULL, picture,
	//										 kCFStringEncodingUTF8);
    //pictureURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), picturePath, CFSTR("png"), NULL);
    //CFRelease(picturePath);
    //provider = CGDataProviderCreateWithURL (pictureURL);
	// CFRelease (pictureURL);
    //image = CGImageCreateWithPNGDataProvider (provider, NULL, true, kCGRenderingIntentDefault);
    //CGDataProviderRelease (provider);
    //CGContextDrawImage (pdfContext, CGRectMake(200, 200, 207, 385),image);
	CGContextDrawImage (pdfContext, CGRectMake(200, 200, WIDTH, (HEIGHT-BAR_HEIGHT-BAR_HEIGHT-statusBarHt)),image);
	// CGImageRelease (image);
	// End image code
	
	// Adding some text on top of the image we just added
	CGContextSelectFont (pdfContext, "Helvetica", 16, kCGEncodingMacRoman);
	CGContextSetTextDrawingMode (pdfContext, kCGTextFill);
	CGContextSetRGBFillColor (pdfContext, 0, 0, 0, 1);
	NSString *nameStr = [NSString stringWithFormat:@"Name: %@", travelerID.name];
	NSString *documentIDStr = [NSString stringWithFormat:@"Document ID: %@",  travelerID.documentID];
	NSString *categoryStr = [NSString stringWithFormat:@"Document Type: %@",  idCat];
	
	const char *name = (const char *)[nameStr UTF8String];
	const char *documentID = (const char *)[documentIDStr UTF8String];
	const char *category = (const char *)[categoryStr UTF8String];
	
	CGContextShowTextAtPoint (pdfContext, 140, 640, name, strlen(name));
	CGContextShowTextAtPoint (pdfContext, 140, 620, documentID, strlen(documentID));
	CGContextShowTextAtPoint (pdfContext, 140, 600, category, strlen(category));
	
	// End text
	
	// We are done drawing to this page, let's end it
	// We could add as many pages as we wanted using CGContextBeginPage/CGContextEndPage
	CGContextEndPage (pdfContext);
	
	// We are done with our context now, so we release it
	CGContextRelease (pdfContext);
}

#pragma mark -
#pragma mark UIAlertView

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
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch(actionSheetAction) {
		case ActionSheetChangeID: 
		{
			TravelerIDSaveAsController *saveAsViewController = [[[TravelerIDSaveAsController alloc] init] autorelease];
			[saveAsViewController setTravelerIDs:travelerID];
			unsigned int enFlag=0;
			if (buttonIndex == 0) {
				
				enFlag = (ENABLE_NAME_FIELD);
				
			}
			else if(buttonIndex == 1) {
				
				enFlag = (ENABLE_DOCID_FIELD);
				
			}
			else if(buttonIndex == 2) {
				
				enFlag = (ENABLE_CATEGORY_FIELD);
				
			}
			else if(buttonIndex == 3) {
				//cancel 
				break;
			}
			[saveAsViewController setEnFlag:enFlag];
			
			UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:saveAsViewController];
			
			[(UINavigationController *)saveAsViewController setDelegate:self];
			
			navController.delegate = self;
			[self presentModalViewController:navController animated:YES];
			
			[navController release];
			navController = nil;
			
		}
			break;
		case ActionSheetSendAsPDF:
		{
			if(buttonIndex == 0) {
				
				if (![MFMailComposeViewController canSendMail])
				{
					[self showInfoAlert:@"Cannot send mail from this device"];
				}
				else {
					NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
					NSString *saveDirectory = [paths objectAtIndex:0];
					NSString *saveFileName = @"myTravelerID.pdf";
					NSString *newFilePath = [saveDirectory stringByAppendingPathComponent:saveFileName];
					const char *filename = [newFilePath UTF8String];
					[self CreatePDFFile:CGRectMake(0, 0, 612, 792) filename:filename];
				
					NSData *pdfData = [NSData dataWithContentsOfFile:newFilePath];
					MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
				
					controller.mailComposeDelegate = self;
					[[controller navigationBar] setTintColor:self.navigationController.navigationBar.tintColor];
					
					NSString *subject = [NSString stringWithFormat:@"%@ sent from Traveler ID iPhone App", 
									 travelerID.name];
					//[controller setSubject:@"sent from Traveler ID iPhone App"];
					[controller setSubject:subject];
					[controller addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"myTravelerID.pdf"];
					NSString *idCat = [travelerID.category valueForKey:@"name"];
					NSString *messageBody = [NSString stringWithFormat:@"Attached is a copy of %@ sent from Traveler ID iPhone App", 
									 idCat];
					[controller setMessageBody:messageBody isHTML:NO];
					[self presentModalViewController:controller animated:YES];
					[controller release];
				}
			}
			else if(buttonIndex == 1) {
				
				// cancel - do nothing
				
			}
		}
			break;
		case ActionSheetDeleteID:
		{
			if (buttonIndex == 0) {
				
				if(delegate) {
					[delegate returnFromDetailWithDelete:travelerID];
				}
				
			}
			else if(buttonIndex == 1) {
				
				// cancel - do nothing
				
			}
			
		}
			break;
	}
	actionSheetAction = 0;
}

#pragma mark -
#pragma mark delegate

- (void) goToDelete
{
	if(!actionSheetAction) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Confirm Deletion"
																 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
														otherButtonTitles:@"DeleteID", nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		actionSheetAction = ActionSheetDeleteID;
		[actionSheet showInView:self.view];
		[actionSheet release];
	}
	
}

- (void) goToShared
{
	if(!actionSheetAction) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:travelerID.name
														delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
														otherButtonTitles:@"Send As PDF", nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		actionSheetAction = ActionSheetSendAsPDF;
		[actionSheet showInView:self.view];
		[actionSheet release];
	}
	
}

- (void) goBack
{
	[imageView removeFromSuperview];
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
	
	editBar.frame = CGRectMake(WIDTH, 0, WIDTH, BAR_HEIGHT);
	shareBar.frame = CGRectMake(WIDTH, HEIGHT- BAR_HEIGHT, WIDTH, BAR_HEIGHT);
	
	[UIView commitAnimations];
	
	if(self.delegate) {
		[self.delegate returnFromDetail];
	}
	
}

- (void) goToEdit
{
	if(!actionSheetAction) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Edit ID"
																 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
														otherButtonTitles:@"Rename ID", @"Change Document ID", @"Change Category", nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
		actionSheetAction = ActionSheetChangeID;
		[actionSheet showInView:self.view];
		[actionSheet release];
	}
}

-(void)setTravelerID:(TravelerID *)tr {
	
	travelerID = tr;
}

-(void)setDelegate:(id)dgate {
	
	delegate = dgate;
}

-(void)returnFromSaveAs:(id)sender
{
	//[self.navController popViewControllerAnimated:YES]; 
	[self dismissModalViewControllerAnimated:YES];
	
	
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

