//
//  TravelerIDListTableViewController.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

@class TravelerID;
@class TravelerIDListTableCell;

@interface TravelerIDListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
@private
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	
	NSString *category;
	NSMutableArray *results;
	NSInteger fromSaveAs;
	
	UIButton *backButton;
	UIButton *editButton;
	UIButton *doneButton;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, assign) NSInteger fromSaveAs;
@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *editButton;
@property (nonatomic, retain) UIButton *doneButton;

- (void)Edit:(id)sender;
- (void)showTravelerID:(TravelerID *)TravelerID animated:(BOOL)animated;
- (void)configureCell:(TravelerIDListTableCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setCategory:(NSString *)cat;
- (NSInteger)fetchCountByCategory;
- (void) setFromSaveAs:(NSInteger)k;
-(void)returnFromDetailWithDelete:(id)object;
@end
