//
//  TravelerIDCategorySelectionViewController.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDCategorySelectionViewController.h"
#import "TravelerID.h"
#import "ConstantsAndMacros.h"

//@interface TravelerIDCategorySelectionViewController()
//@property (nonatomic, retain) NSArray *tIdTypes;
//@end



@implementation TravelerIDCategorySelectionViewController

@synthesize travelerID;
@synthesize idTypes;


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
	
	NSArray *types = [[NSArray alloc] initWithObjects: @"Passport", @"Drivers License", @"Visas", @"Immunizations", @"Birth Certificate",
					  @"Medical Insurance", @"Residence Permit", @"Work Permit", @"Marriage Certificate", @"Loyalty Programs",
					  @"Miscellaneous", nil];
	self.idTypes = types;
	self.navigationItem.backBarButtonItem.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#if 0
	// Fetch the ID types in alphabetical order by name from the id's context.
	NSManagedObjectContext *context = [TravelerID managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"category" inManagedObjectContext:context]];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSError *error = nil;
	NSArray *types = [context executeFetchRequest:fetchRequest error:&error];
	self.idTypes = types;
	
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
#endif
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	self.navigationItem.backBarButtonItem.enabled = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark -
#pragma mark UITableView Delegate/Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of id types
    return [idTypes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    }
#if 0    
    // Configure the cell
	NSManagedObject *idType = [idTypes objectAtIndex:indexPath.row];
    cell.textLabel.text = [idType valueForKey:@"name"];
	if (idType == TravelerID.category) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
	
#else
	NSString *idType = [idTypes objectAtIndex:indexPath.row];
	cell.textLabel.text = idType;
	if (idType == [travelerID.category valueForKey:@"name"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
#endif
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    // If there was a previous selection, unset the accessory view for its cell.
	//NSManagedObject *currentType = TravelerID.category;
	
    //if (currentType != nil) {
	//	NSInteger index = [idTypes indexOfObject:currentType];
	//	NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //    UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
    //    checkedCell.accessoryType = UITableViewCellAccessoryNone;
	// }
	
    // Set the checkmark accessory for the selected row.
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];    
	
	// Update the type of the TravelerID instance
	// TravelerID.category = [idTypes objectAtIndex:indexPath.row];
    [travelerID.category setValue:[idTypes objectAtIndex:indexPath.row] forKey:@"name"];
	
    // Deselect the row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)dealloc {
    [TravelerID release];
    [idTypes release];
    [super dealloc];
}


@end
