//
//  GenresSongs+CoreDataProperties.h
//  CoreData
//
//  Created by manish on 09/11/17.
//  Copyright © 2017 manish. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GenresSongs.h"

NS_ASSUME_NONNULL_BEGIN

@interface GenresSongs (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Topsongs *genresToSongs;

@end

NS_ASSUME_NONNULL_END
