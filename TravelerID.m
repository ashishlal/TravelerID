//
//  TravelerID.m
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

#import "TravelerID.h"


@implementation TravelerID

@dynamic notes, name, documentID, thumbnailImage, image, category;

#if 0
- (id)valueForUndefinedKey:(NSString *)name {
	
	NSArray * extra = [[self category] allObjects]; 
	for (int idx = 0; idx < [extra count]; idx++) {
		if ([name isEqualToString:[[extra objectAtIndex:idx] valueForKey:@"name"]]) { 
			return [[extra objectAtIndex:idx] valueForKey:@"name"];
		}
	}
	
	return nil;
	
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)name {
	
	// Look for existing object for this name. If one exists, replace its value. 
	NSArray * extra = [[self category] allObjects]; 
	for (int idx = 0; idx < [extra count]; idx++) {
		if ([name isEqualToString:[[extra objectAtIndex:idx] valueForKey:@"name"]]) { 
			[[extra objectAtIndex:idx] setValue:value forKey:@"name"];
			return;
		}
	} // If an object for this name does not exist, create one.
	NSManagedObject * eventExtra =
	[NSEntityDescription insertNewObjectForEntityForName:@"TravelerIDType" inManagedObjectContext:[self managedObjectContext]];
	[eventExtra setValue:name forKey:@"name"]; 
	
	[self addCategoryObject:eventExtra];
	
}
#endif
@end

@implementation ImageToDataTransformer


+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value {
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
	return [uiImage autorelease];
}


@end
