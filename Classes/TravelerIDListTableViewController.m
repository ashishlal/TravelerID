//
//  TravelerIDListTableViewController.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDListTableViewController.h"
#import "TravelerIDSaveAsController.h"
#import "TravelerIDDetailViewController.h"
#import "TravelerIDListTableCell.h"
#import "TravelerID.h"

@implementation TravelerIDListTableViewController

@synthesize managedObjectContext, fetchedResultsController;
@synthesize category;
@synthesize results;
@synthesize fromSaveAs;
@synthesize editButton, doneButton, backButton;

#pragma mark -
#pragma mark UIViewController overrides
int init1=0;

- (void)viewDidLoad {
	
	    // Configure the navigation bar
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
	
	self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 57, 33)];
	backButton.adjustsImageWhenHighlighted = YES;
	[backButton setImage:[UIImage imageNamed:@"back-button-1.png"] forState:UIControlStateNormal];
	[backButton setImage:[UIImage imageNamed:@"back-button-depressed-1.png"] forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
	self.navigationItem.leftBarButtonItem = backButtonItem;
	
	//self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<< Main" style:UIBarButtonItemStylePlain 
	//																  target:self action:@selector(goBack:)];          
    //self.navigationItem.leftBarButtonItem = backButtonItem;
	
    // Set the table view's row height
    self.tableView.rowHeight = BAR_HEIGHT;
	init1 =1;
	NSError *error = nil;
#if 1
	if (![[self fetchedResultsController] performFetch:&error]) {
		
		
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}	
#endif
	//[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
	
	//UIColor *color = [UIColor clearColor];
	//UIImage *img = [UIImage imageNamed:@"toolbar-gradient.png"];
	//[img drawInRect:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 
	//						   self.navigationController.navigationBar.frame.size.height)];
	//self.navigationController.navigationBar.tintColor = color;
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Support all orientations except upside down
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark TravelerID support

- (void)Edit:(id)sender {
	
	if(!self.tableView.editing) {
		self.tableView.editing = TRUE;
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:doneButton] autorelease];
		self.backButton.enabled=NO;
	}
	else {
		self.tableView.editing = FALSE;
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:editButton] autorelease];
		self.backButton.enabled=YES;
	}
	[self setEditing:self.tableView.editing];
}

- (void)showTravelerID:(TravelerID *)tr animated:(BOOL)animated {
	
    // Create a detail view controller, set the TravelerID, then push it.
    TravelerIDDetailViewController *detailViewController = [[TravelerIDDetailViewController alloc] init];
    [detailViewController setTravelerID:tr];
	[detailViewController setDelegate:self];
	detailViewController.title = self.title;
    //[self.view addSubview:[detailViewController view]];
	self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
	
}

- (void)setCategory:(NSString *)cat
{
	category = cat;
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#if 0
    NSInteger count = [[fetchedResultsController sections] count];
    
	if (count == 0) {
		count = 1;
	}
#else
	NSInteger count = 1;
#endif
    return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#if 0
    NSInteger numberOfRows = 0;
	
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
#else
	return [results count];
#endif
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#if 1
    // Dequeue or if necessary create a TravelerIDTableViewCell, then set its recipe to the TravelerID for the current row.
    static NSString *TravelerIDCellIdentifier = @"TravelerIDCellIdentifier";
    
    TravelerIDListTableCell *TravelerIDCell = (TravelerIDListTableCell *)[tableView dequeueReusableCellWithIdentifier:TravelerIDCellIdentifier];
    if (TravelerIDCell == nil) {
        TravelerIDCell = [[[TravelerIDListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TravelerIDCellIdentifier] autorelease];
		TravelerIDCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	[self configureCell:TravelerIDCell atIndexPath:indexPath];
    
    return TravelerIDCell;
#endif
}

- (void)configureCell:(TravelerIDListTableCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	TravelerID *travelID = (TravelerID *)[fetchedResultsController objectAtIndexPath:indexPath]; 
	//TravelerID *travelID = (TravelerID *)[results objectAtIndex: [indexPath row]]; 
	cell.idNum = (indexPath.row + 1);
    cell.TravelerID = travelID;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TravelerID *tr = (TravelerID *)[fetchedResultsController objectAtIndexPath:indexPath]; 
	//int row = [indexPath row];
	//int count = [results count];
	//if(count > 0) {
	//	TravelerID *tr = (TravelerID *)[results objectAtIndex: row]; 
	[self showTravelerID:tr animated:YES];
	//}
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		NSInteger count = [self fetchCountByCategory];
		if(count > 0) {
			
			[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
			[results removeObjectAtIndex:indexPath.row];
			count--;
			//[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
			
			// Commit the change.
			NSError *error;
			if (![context save:&error]) {
				// Handle the error.
			}
			
		}
		if(count == 0) {
			//[self.tableView reloadData];
			[self dismissModalViewControllerAnimated:YES];
		}		
	}   
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    // Set up the fetched results controller if needed.
    if (fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"TravelerID" inManagedObjectContext:managedObjectContext];
		
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"category.name == %@", category]];
		
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        [NSFetchedResultsController deleteCacheWithName:nil];
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = 
		[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
		//managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
		
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
        
        [aFetchedResultsController release];
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
    }
	
	return fetchedResultsController;
}    

- (NSInteger)fetchCountByCategory {
    // Set up the fetched results controller if needed.
    //if (fetchedResultsController == nil) 
	{
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"TravelerID" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
		[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"category.name == %@", category]];
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
		
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
		// NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
		// aFetchedResultsController.delegate = self;
		// self.fetchedResultsController = aFetchedResultsController;
        
        //[aFetchedResultsController release];
		
        [sortDescriptor release];
        [sortDescriptors release];
		[NSFetchedResultsController deleteCacheWithName:nil];
		NSError *error = nil;
		results = (NSMutableArray *)[[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
		
		if ((results != nil) && ([results count] >= 0) && (error == nil)){
			[fetchRequest release];
			//return [NSMutableArray arrayWithArray:result];
			return [results count];
		}
		
		else {
			//YourEntityName *object = (YourEntityName *) [NSEntityDescription insertNewObjectForEntityForName:@"YourEntityName" inManagedObjectContext:self.managedObjectContext];
            // setup your object attributes, for instance set its name
            //object.name = @"name"
			
            // save object
            NSError *error;
            if (![[self managedObjectContext] save:&error]) {
				// Handle error
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				
            }
			[fetchRequest release];
            return 0;
			
		}
    }
	
	return 0;
}    

/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */

- (void) setFromSaveAs:(NSInteger)k
{
	fromSaveAs = k;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	//+++lal
	if(fromSaveAs) return;
	// The fetch controller is about to start sending change notifications, so prepare the table view for updates.
	[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	if(fromSaveAs)return;
	UITableView *tableView = self.tableView;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:(TravelerIDListTableCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	//+++lal:
	if(fromSaveAs) return;
	// The fetch controller has sent all current change notifications, so tell the table view to process all updates.
	[self.tableView endUpdates];
}



#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[fetchedResultsController release];
	[managedObjectContext release];
    [super dealloc];
}

#pragma mark -
#pragma mark Parent Notify Protocol
-(void)returnFromSaveAs:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
	
}

-(void)returnFromRename
{
	[self dismissModalViewControllerAnimated:YES];
	
}

-(void)returnFromDetail
{
	[self.navigationController popViewControllerAnimated:YES];
	self.navigationController.navigationBarHidden = NO;
	[self fetchCountByCategory];
	[self.tableView reloadData];
	
}

-(void)returnFromDetailWithDelete:(id)object
{
	
	[self.navigationController popViewControllerAnimated:YES];
	self.navigationController.navigationBarHidden = NO;
	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	NSManagedObject *objToDel = (NSManagedObject *)object;
	[context deleteObject:objToDel];
	
	// Save the context.
	NSError *error;
	if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
	NSInteger count = [self fetchCountByCategory];
	if( count > 0)
		[self.tableView reloadData];
	else if(count == 0) {
		[self dismissModalViewControllerAnimated:YES];
	}
	
}


-(void) goBack:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
	
}
@end
