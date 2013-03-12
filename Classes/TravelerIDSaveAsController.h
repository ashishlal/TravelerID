//
//  TravelerIDSaveAsController.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerIDNotifyParentProtocol.h"

@class TravelerID;

//@interface TravelerIDSaveAsController : UITableViewController <UINavigationControllerDelegate, UITextFieldDelegate> {
@interface TravelerIDSaveAsController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate, 
	UITableViewDelegate,  UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource> {
	id <TravelerIDNotifyParentProtocol> delegate;
@private
	unsigned int enFlag;
	TravelerID *TravelerIDs;
	UIView *saveAsTableHeaderView;    
	//UIButton *photoButton;
	UITextField *nameTextField;
	UITextField *documentIDTextField;
	UITableView *tableView;
	
	UIButton *backButton;
	UIButton *editButton;
	UIButton *doneButton;
	bool idWasSavedInDB;
	NSMutableArray *listOfItems;
	UIActionSheet *actionSheet;
	NSString *category;
};

@property (retain, nonatomic) id <TravelerIDNotifyParentProtocol> delegate;
@property (nonatomic, assign) unsigned int enFlag;
@property (nonatomic, retain) TravelerID *TravelerIDs;
@property (nonatomic, retain) IBOutlet UIView *saveAsTableHeaderView;
//@property (nonatomic, retain) IBOutlet UIButton *photoButton;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextField *documentIDTextField;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIButton *editButton;
@property (nonatomic, retain) UIButton *doneButton;

@property (nonatomic, assign) bool idWasSavedInDB;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) NSString *category;

-(void)Edit:(id)sender;
-(void)goBack:(id)sender;
-(void)setDelegate:(id)dgate;
-(void)setTravelerIDs:(TravelerID *)tr;
-(void)showConfirmAlert:(NSString *)str;
-(void)showInfoAlert:(NSString *)str;
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex ;
-(void)setEnFlag:(unsigned int)flag;

@end
