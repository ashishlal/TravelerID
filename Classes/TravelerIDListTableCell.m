//
//  TravelerIDListTableCell.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDListTableCell.h"
#import "ConstantsAndMacros.h"

#pragma mark -
#pragma mark SubviewFrames category

@interface TravelerIDListTableCell (SubviewFrames)
- (CGRect)_imageViewFrame;
- (CGRect)_nameLabelFrame;
- (CGRect)_documentIDLabelFrame;
//- (CGRect)_prepTimeLabelFrame;
@end




#pragma mark -
#pragma mark TravelerIDListTableCell implementation

@implementation TravelerIDListTableCell

@synthesize TravelerID, imageView, nameLabel, documentIDLabel;
@synthesize idNum;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
		
		//  nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		//   [nameLabel setFont:[UIFont systemFontOfSize:12.0]];
		//  [nameLabel setTextColor:[UIColor darkGrayColor]];
		//  [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
		//   [self.contentView addSubview:nameLabel];
		
        documentIDLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        documentIDLabel.textAlignment = UITextAlignmentCenter;
        [documentIDLabel setFont:[UIFont systemFontOfSize:12.0]];
        [documentIDLabel setTextColor:[UIColor blackColor]];
        [documentIDLabel setHighlightedTextColor:[UIColor whiteColor]];
		documentIDLabel.minimumFontSize = 7.0;
		documentIDLabel.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:documentIDLabel];
		
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		nameLabel.textAlignment = UITextAlignmentCenter;
        [nameLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:nameLabel];
    }
	idNum=0;
    return self;
}


#pragma mark -
#pragma mark Laying out subviews

/*
 To save space, the prep time label disappears during editing.
 */
- (void)layoutSubviews {
    [super layoutSubviews];
	
    [imageView setFrame:[self _imageViewFrame]];
    [nameLabel setFrame:[self _nameLabelFrame]];
    [documentIDLabel setFrame:[self _documentIDLabelFrame]];
	//   [prepTimeLabel setFrame:[self _prepTimeLabelFrame]];
	//   if (self.editing) {
	//       prepTimeLabel.alpha = 0.0;
	//   } else {
	//       prepTimeLabel.alpha = 1.0;
	//   }
}


#define IMAGE_SIZE          BAR_HEIGHT
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define PREP_TIME_WIDTH     80.0

/*
 Return the frame of the various subviews -- these are dependent on the editing state of the cell.
 */
- (CGRect)_imageViewFrame {
    if (self.editing) {
        return CGRectMake(EDITING_INSET+5, 0.0, IMAGE_SIZE, IMAGE_SIZE);
    }
	else {
        return CGRectMake(5.0, 0.0, IMAGE_SIZE, IMAGE_SIZE);
    }
}

- (CGRect)_nameLabelFrame {
	NSInteger length = [nameLabel.text length];
	
    if (self.editing) {
		int t = (self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN);
		if(length > t) {
			length = (self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN);
		}
		else {
			length = t;
		}
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 4.0, length, 16.0);
    }
	else {
		int t = (self.contentView.bounds.size.width  - TEXT_RIGHT_MARGIN * 2 - PREP_TIME_WIDTH);
		if(length > t) {
			length = (self.contentView.bounds.size.width  - TEXT_RIGHT_MARGIN * 2 - PREP_TIME_WIDTH);
		}
		else {
			length = t;
		}
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN + 22, 4.0, length, 16.0);
    }
}

#if 1
- (CGRect)_documentIDLabelFrame {
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN -3.0f, 22.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN-10.0f, 16.0);
    }
	else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN -3.0f, 22.0, self.contentView.bounds.size.width - TEXT_LEFT_MARGIN-10.0f, 16.0);
    }
}
#endif
#if 0
- (CGRect)_documentIDLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - PREP_TIME_WIDTH - TEXT_RIGHT_MARGIN, 4.0, PREP_TIME_WIDTH, 16.0);
}
#endif

#pragma mark -
#pragma mark TravelerID set accessor

- (void)setTravelerID:(TravelerID *)newID {
	
	if (newID != travelerID) {
        [travelerID release];
        travelerID = [newID retain];
	}
	
	//NSString *nameStr = [NSString stringWithFormat:@"ID#%d %@", idNum, travelerID.name];
	
	//NSString *documentIDStr = [NSString stringWithFormat:@"ID#%d %@", idNum, @"Document ID No. "];
	NSString *nameStr = [NSString stringWithFormat:@"%@", travelerID.name];
	
	NSString *documentIDStr = [NSString stringWithFormat:@"%@", @"Document ID No. "];
	
	if(!travelerID.thumbnailImage) {
		// Create a thumbnail of the selected image for the ID.
		UIImage *selectedImage = [travelerID.image valueForKey:@"image"];
		if ( selectedImage == nil ) {
			selectedImage =[UIImage imageNamed:@"QuestionMark.jpg"];
		}
		CGSize size = selectedImage.size;
		CGFloat ratio = 0;
		if (size.width > size.height) {
			ratio = IMAGE_SIZE/ size.width;
		} else {
			ratio = IMAGE_SIZE / size.height;
		}
		CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
		//UIGraphicsBeginImageContext(rect.size);
		UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
		[selectedImage drawInRect:rect];
		travelerID.thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
	imageView.image = travelerID.thumbnailImage;
	nameLabel.text = nameStr;
	
	documentIDLabel.text = [documentIDStr stringByAppendingString:travelerID.documentID];
	
}

#pragma mark -
#pragma mark idNum set accessor
- (void)setIdNum:(unsigned int)index {
	idNum = index;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [TravelerID release];
    [imageView release];
    [nameLabel release];
    [documentIDLabel release];
	//  [prepTimeLabel release];
    [super dealloc];
}

@end
