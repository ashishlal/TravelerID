//
//  TravelerIDListTableCell.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerID.h"

@interface TravelerIDListTableCell : UITableViewCell {
    TravelerID *travelerID;
    unsigned int idNum;
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *documentIDLabel;
	
}

@property (nonatomic, retain) TravelerID *TravelerID;
@property (nonatomic, assign) unsigned int idNum;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *documentIDLabel;

- (void)setTravelerID:(TravelerID *)newID;
- (void)setIdNum:(unsigned int)index;

@end
