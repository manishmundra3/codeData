//
//  Feed.h
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Author;

@interface Feed : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSString *updated;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *feedIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSArray *links;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
