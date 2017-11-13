//
//  Results.h
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Results : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *resultsIdentifier;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *collectionName;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *artistUrl;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *artworkUrl100;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
