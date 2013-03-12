//
//  TravelerID.h
//  TravelerID
//
//  Created by Ashish Lal on 26/09/10.
//  Copyright 2010 NetTech India. All rights reserved.
//

@interface ImageToDataTransformer : NSValueTransformer {
}
@end

@interface TravelerID : NSManagedObject {
}

@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *documentID;
@property (nonatomic, retain) UIImage *thumbnailImage;

@property (nonatomic, retain) NSManagedObject *image;
@property (nonatomic, retain) NSManagedObject *category;

@end

@interface TravelerID (CoreDataGeneratedAccessors)
- (void)addIdObject:(NSManagedObject *)value;
- (void)removeIdObject:(NSManagedObject *)value;
- (void)addIDs:(NSString *)value;
- (void)removeIDs:(NSString *)value;
@end
