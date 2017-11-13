//
//  Topsongs+CoreDataProperties.h
//  CoreData
//
//  Created by manish on 09/11/17.
//  Copyright © 2017 manish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Topsongs.h"

NS_ASSUME_NONNULL_BEGIN

@interface Topsongs (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *artistName;
@property (nullable, nonatomic, retain) NSString *artworkUrl100;
@property (nullable, nonatomic, retain) NSSet<GenresSongs *> *relationship;

@end

@interface Topsongs (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(GenresSongs *)value;
- (void)removeRelationshipObject:(GenresSongs *)value;
- (void)addRelationship:(NSSet<GenresSongs *> *)values;
- (void)removeRelationship:(NSSet<GenresSongs *> *)values;

@end

NS_ASSUME_NONNULL_END
