/*
 *  ConstantsAndMacros.h
 *  TravelerID
 *
 *  Created by Ashish Lal on 26/09/10.
 *  Copyright 2010 NetTech India. All rights reserved.
 *
 */

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
#define statusBarHt 0
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
#define ZOOM_STEP 1.5
#define BAR_HEIGHT 40
#define ENHANCEMENT_HEIGHT 62
enum {
	NONE=0,
	TOP_BAR_TAG,
	SAVE_BAR_TAG,
	SAVEAS_TAG,
	EDIT_BAR_TAG,
	SHARE_BAR_TAG,
	ENHANCEMENT_TOP_BAR_TAG,
	ENHANCEMENT_BOTTOM_BAR_TAG,
	ZOOM_VIEW_TAG,
	ZOOM_IMAGEVIEW_TAG
};

enum {
	NO_ROTATION,
	ROTATE_LEFT,
	ROTATE_RIGHT
};

enum {
	ENHANCEMENT_STATE_NORMAL=1,
	ENHANCEMENT_STATE_SELECTED,
	ENHANCEMENT_STATE_RESET
};

enum {
	PASSPORT=0,
	DRIVERS_LIC,
	VISAS,
	IMMUNIZATIONS,
	BIRTH_CERTIFICATE,
	MEDICAL_INSURANCE,
	RESIDENCE_PERMIT,
	WORK_PERMIT,
	MARRIAGE_CERTIFICATE,
	LOYALTY_PROGRAMS,
	MISCELLANEOUS,
	MAX_ID
};

enum {
	ENABLE_NAME_FIELD=1,
	ENABLE_DOCID_FIELD=2,
	ENABLE_CATEGORY_FIELD=4
};

enum {
	IMAGE_TYPE_NONE=0,
	IMAGE_TYPE_STANDARD,
	IMAGE_TYPE_ENHANCED,
	IMAGE_TYPE_ENHANCED_AFTER_SAVE
};

typedef enum {
	ActionSheetToSelectTypeOfSource=1,
	ActionSheetSaveAsID,
	ActionSheetChangeID,
	ActionSheetRenameID,
	ActionSheetSendAsPDF,
	ActionSheetDeleteID
} TravelerIDViewControllerActionSheetAction;