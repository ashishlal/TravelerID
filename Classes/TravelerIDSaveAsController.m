//
//  TravelerIDSaveAsController.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDSaveAsController.h"

#import "TravelerIDCategorySelectionViewController.h"
#import "TravelerID.h"
#import "TravelerIDViewController.h"

@implementation TravelerIDSaveAsController

@synthesize delegate;
@synthesize TravelerIDs;
@synthesize saveAsTableHeaderView;
@synthesize nameTextField, documentIDTextField;
@synthesize enFlag;
@synthesize backButton;
@synthesize editButton;
@synthesize doneButton;
@synthesize idWasSavedInDB;
@synthesize listOfItems;
@synthesize actionSheet;
@synthesize category;

int init=1;

#define TYPE_SECTION 0

#pragma mark -
#pragma mark View controller

#if 1
- (void)loadView {
	[super loadView];
	CGRect tableSize = CGRectMake(0,0,WIDTH ,480);
	self.tableView = [[UITableView alloc] initWithFrame:tableSize style:UITableViewStyleGrouped];
	//self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.rowHeight = 52;
	
	listOfItems = [[NSMutableArray alloc] initWithObjects: @"", @"Passport", @"Drivers License", @"Visas", @"Immunizations", @"Birth Certificate",
					  @"Medical Insurance", @"Residence Permit", @"Work Permit", @"Marriage Certificate", @"Loyalty Programs",
					  @"Miscellaneous", nil];
	category=nil;
}
#endif

- (void)viewDidLoad {
	
#if 0
	//self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	UIColor *color = [UIColor clearColor];
	UIImage *img = [UIImage imageNamed:@"toolbar-gradient.png"];
	[img drawInRect:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 
							   self.navigationController.navigationBar.frame.size.height)];
	self.navigationController.navigationBar.tintColor = color;
#endif	

	self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
	editButton.adjustsImageWhenHighlighted = YES;
	[editButton setImage:[UIImage imageNamed:@"edit-button-1.png"] forState:UIControlStateNormal];
	[editButton setImage:[UIImage imageNamed:@"edit-button-depressed-1.png"] forState:UIControlStateHighlighted];
	[editButton addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
	
	self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
	doneButton.adjustsImageWhenHighlighted = YES;
	[doneButton setImage:[UIImage imageNamed:@"done-button-1.png"] forState:UIControlStateNormal];
	[doneButton setImage:[UIImage imageNamed:@"done-button-depressed-1.png"] forState:UIControlStateHighlighted];
	[doneButton addTarget:self action:@selector(Edit:) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
	
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<< Back" style:UIBarButtonItemStylePlain 
	//																  target:self action:@selector(goBack:)];          
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
	backButton.adjustsImageWhenHighlighted = YES;
	[backButton setImage:[UIImage imageNamed:@"back-button-1.png"] forState:UIControlStateNormal];
	[backButton setImage:[UIImage imageNamed:@"back-button-depressed-1.png"] forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
	self.navigationItem.leftBarButtonItem = backButtonItem;
	
    // Create and set the table header view.
    if (saveAsTableHeaderView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TravelerIDSaveAs" owner:self options:nil];
        self.tableView.tableHeaderView = saveAsTableHeaderView;
        self.tableView.allowsSelectionDuringEditing = YES;
    }
	idWasSavedInDB=FALSE;
	[self.view addSubview:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.navigationItem.title = @"Save ID As";
	//self.navigationItem.title = TravelerIDs.name;
	nameTextField.text = TravelerIDs.name;    
    documentIDTextField.text = TravelerIDs.documentID;   
	if(!self.editing) {
		nameTextField.enabled = NO;
		documentIDTextField.enabled = NO;
	}
	// Update ID category and name, ID on return.
    [self.tableView reloadData]; 
}

- (UITableView *)tableView
{
	return tableView;
}

- (void)setTableView:(UITableView *)newTableView
{
	[tableView release];
	tableView = [newTableView retain];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
}



- (void)viewDidUnload {
    self.saveAsTableHeaderView = nil;
	
	self.nameTextField = nil;
	self.documentIDTextField = nil;
	[super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
#pragma mark Editing

- (void)Edit:(id)sender {
	
	if(!self.tableView.editing) {
		self.tableView.editing = TRUE;
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:doneButton] autorelease];
		self.backButton.enabled=NO;
		[self setEditing:self.tableView.editing];
		
	}
	else {
		
		self.tableView.editing = FALSE;
		[self setEditing:self.tableView.editing];
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
		self.backButton.enabled=YES;
	}
	
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
	nameTextField.enabled = editing;
	documentIDTextField.enabled = editing;
	
	if((self.editing) && !(enFlag & ENABLE_NAME_FIELD)) {
		nameTextField.enabled = NO;
	}
	if((self.editing) && !(enFlag & ENABLE_DOCID_FIELD)) {
		documentIDTextField.enabled = NO;
	}
	
	[self.navigationItem setHidesBackButton:editing animated:YES];
	self.navigationItem.leftBarButtonItem.enabled = !editing;
	/*
	 If editing is finished, save the managed object context.
	 */
	if (!editing) {
		NSManagedObjectContext *context = TravelerIDs.managedObjectContext;
		NSError *error = nil;
#if 0
		if((TravelerIDs.category == nil) || (TravelerIDs.documentID == nil) || (TravelerIDs.name == nil)
		   || (TravelerIDs.documentID == @"") || (TravelerIDs.name == @"")){
			[self showInfoAlert:@"Name, DocumentID and Category cannot be nil"];
			
		}
#else
		
		if((TravelerIDs.category == nil) || (TravelerIDs.name == nil) || (TravelerIDs.name == @"")) {
			[self showInfoAlert:@"Name and Category cannot be nil, ID will not be created"];
			
		}
#endif
		else { 
			NSString *idCat=@"";
			if(TravelerIDs.documentID == nil) {
				TravelerIDs.documentID = @"";
			}
			if(TravelerIDs.category != nil) {
				idCat = [TravelerIDs.category valueForKey:@"name"];
				if( (idCat == nil) || (idCat == @"")) {
					[self showInfoAlert:@"Name and Category cannot be nil, ID will not be created"];
					if(!init) init=1;
					return;
				}
			}
			else {
				if(!init) init=1;
				return;
			}
			if ((context) && (![context save:&error])) {
				/*
				 Replace this implementation with code to handle the error appropriately.
			 
				 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
				 */
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				abort();
			}
		}
		if(TravelerIDs.category != nil) {
			// there was save
			idWasSavedInDB=TRUE;
		}
	}
	if(!init) init=1;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
	if ((textField == nameTextField) && ([nameTextField.text length] > 0)) {
		TravelerIDs.name = nameTextField.text;
	}
	else if ((textField == documentIDTextField) && ([documentIDTextField.text length] > 0)) {
		TravelerIDs.documentID = documentIDTextField.text;
	}
	
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


#pragma mark -
#pragma mark UITableView Delegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger k=1;
    return k;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = nil;
    // Return a title or nil as appropriate for the section.
    switch (section) {
        case TYPE_SECTION:
            title = @"Category";
            break;
        default:
            break;
    }
    return title;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    /*
     The number of rows depends on the section.
     In the case of ingredients, if editing, add a row in editing mode to present an "Add Ingredient" cell.
	 */
    switch (section) {
        case TYPE_SECTION:
			rows=1;
            break;
		default:
            break;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    UITableViewCell *cell = nil;
    
	if (indexPath.section == TYPE_SECTION) {
		// If necessary create a new cell and configure it appropriately for the section.  Give the cell a different identifier from that used for cells in the Ingredients section so that it can be dequeued separately.
        static NSString *MyIdentifier = @"GenericCell";
        
        cell = [tblView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        NSString *text = nil;
        
        switch (indexPath.section) {
            case TYPE_SECTION: // type -- should be selectable -> checkbox
                text = [TravelerIDs.category valueForKey:@"name"];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
        
        cell.textLabel.text = text;
    }
    return cell;
}

#pragma mark -
#pragma mark UIPickerView -

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)picker didSelectRow:(NSInteger)row inComponent: (NSInteger)component
{
	category = [listOfItems objectAtIndex:row];
	
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component;
{
    return [listOfItems count];
	
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent: (NSInteger)component;
{
    return [listOfItems objectAtIndex:row];
}

- (void)dismissActionSheet:(id)sender {
	//NSLog(@"dismissActionSheet: sender=%@", sender);
	
	[actionSheet dismissWithClickedButtonIndex:0 animated:YES];
	if(category != nil) {
		[TravelerIDs.category setValue:category forKey:@"name"];
		[self.tableView reloadData]; 
	}
}


#pragma mark -
#pragma mark Editing rows

- (NSIndexPath *)tableView:(UITableView *)tblView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *rowToSelect = indexPath;
    NSInteger section = indexPath.section;
    BOOL isEditing = self.editing;
    
	// If editing, don't allow instructions to be selected
    if ((!isEditing) && (section == TYPE_SECTION)) {
		[tblView deselectRowAtIndexPath:indexPath animated:YES];
		rowToSelect = nil;    
    }
	else if((isEditing) && (section == TYPE_SECTION) && !(enFlag & ENABLE_CATEGORY_FIELD)) {
		[tblView deselectRowAtIndexPath:indexPath animated:YES];
		rowToSelect = nil;    
	}
	
	return rowToSelect;
}


- (void)tableView:(UITableView *)tblView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
   // UIViewController *nextViewController = nil;
    
    /*
     What to do on selection depends on what section the row is in.
     For Type, Instructions, and Ingredients, create and push a new view controller of the type appropriate for the next screen.
     */
    switch (section) {
        case TYPE_SECTION:

           // nextViewController = [[TravelerIDCategorySelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
           // ((TravelerIDCategorySelectionViewController *)nextViewController).travelerID = TravelerIDs;
			//nextViewController.navigationItem.backBarButtonItem.enabled = YES;
		{
			
			actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
			
			[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
			
			CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
			
			UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
			pickerView.showsSelectionIndicator = YES;
			pickerView.dataSource = self;
			pickerView.delegate = self;
			
			[actionSheet addSubview:pickerView];
			[pickerView release];
			
			UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
			closeButton.momentary = YES; 
			closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
			closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
			closeButton.tintColor = [UIColor blackColor];
			[closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
			[actionSheet addSubview:closeButton];
			[closeButton release];
			
			[actionSheet showInView:[self view]];
			
			[actionSheet setBounds:CGRectMake(0, 0, 320, 480)];
			category=nil;
			[tblView deselectRowAtIndexPath:indexPath animated:YES];
		}
            break;
        default:
            break;
    }
    
    // If we got a new view controller, push it .
    //if (nextViewController) {
    //    [self.navigationController pushViewController:nextViewController animated:YES];
    //    [nextViewController release];
   // }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    // Only allow editing in the ingredients section.
    // In the ingredients section, the last row (row number equal to the count of ingredients) is added automatically (see tableView:cellForRowAtIndexPath:) to provide an insertion cell, so configure that cell for insertion; the other cells are configured for deletion.
#if 0
	if (indexPath.section == INGREDIENTS_SECTION) {
        // If this is the last item, it's the insertion row.
        if (indexPath.row == [recipe.ingredients count]) {
            style = UITableViewCellEditingStyleInsert;
        }
        else {
            style = UITableViewCellEditingStyleDelete;
        }
    }
#endif    
    return style;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return;
}


#pragma mark -
#pragma mark Moving rows

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canMove = NO;
	
    return canMove;
}


- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSIndexPath *target = proposedDestinationIndexPath;
    
	return target;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	
	return;
}

#pragma mark -
#pragma mark delegate

-(void)setDelegate:(id)dgate {
	
	delegate = dgate;
}

-(void)setTravelerIDs:(TravelerID *)tr {
	
	TravelerIDs = tr;
}

-(void)setEnFlag:(unsigned int)flag 
{
	enFlag = flag;
}

-(void) goBack:(id)sender {
	//[self dismissModalViewControllerAnimated:YES];
	if(delegate) {
		[delegate returnFromSaveAs:(id)(idWasSavedInDB)];
	}
	
}

-(void) saveID:(id)sender { 
	TravelerIDs.name = nameTextField.text;
	TravelerIDs.documentID = documentIDTextField.text;
	
	NSError *error = nil;
	if (![TravelerIDs.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
	
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
    [saveAsTableHeaderView release];
    
    [nameTextField release];
    [documentIDTextField release];
    
    [super dealloc];
}

@end

