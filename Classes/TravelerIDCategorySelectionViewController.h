//
//  TravelerIDCategorySelectionViewController.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

@class TravelerID;

@interface TravelerIDCategorySelectionViewController : UITableViewController {
@private
	TravelerID *travelerID;
	NSArray *idTypes;
}

@property (nonatomic, retain) TravelerID *travelerID;
@property (nonatomic, retain) NSArray *idTypes;

@end

