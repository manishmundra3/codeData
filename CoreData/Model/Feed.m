//
//  Feed.m
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Feed.h"
#import "Author.h"
#import "Links.h"
#import "Results.h"


NSString *const kFeedAuthor = @"author";
NSString *const kFeedUpdated = @"updated";
NSString *const kFeedCountry = @"country";
NSString *const kFeedId = @"id";
NSString *const kFeedTitle = @"title";
NSString *const kFeedCopyright = @"copyright";
NSString *const kFeedLinks = @"links";
NSString *const kFeedResults = @"results";
NSString *const kFeedIcon = @"icon";


@interface Feed ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Feed

@synthesize author = _author;
@synthesize updated = _updated;
@synthesize country = _country;
@synthesize feedIdentifier = _feedIdentifier;
@synthesize title = _title;
@synthesize copyright = _copyright;
@synthesize links = _links;
@synthesize results = _results;
@synthesize icon = _icon;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.author = [Author modelObjectWithDictionary:[dict objectForKey:kFeedAuthor]];
            self.updated = [self objectOrNilForKey:kFeedUpdated fromDictionary:dict];
            self.country = [self objectOrNilForKey:kFeedCountry fromDictionary:dict];
            self.feedIdentifier = [self objectOrNilForKey:kFeedId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kFeedTitle fromDictionary:dict];
            self.copyright = [self objectOrNilForKey:kFeedCopyright fromDictionary:dict];
    NSObject *receivedLinks = [dict objectForKey:kFeedLinks];
    NSMutableArray *parsedLinks = [NSMutableArray array];
    
    if ([receivedLinks isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLinks) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLinks addObject:[Links modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLinks isKindOfClass:[NSDictionary class]]) {
       [parsedLinks addObject:[Links modelObjectWithDictionary:(NSDictionary *)receivedLinks]];
    }

    self.links = [NSArray arrayWithArray:parsedLinks];
    NSObject *receivedResults = [dict objectForKey:kFeedResults];
    NSMutableArray *parsedResults = [NSMutableArray array];
    
    if ([receivedResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedResults addObject:[Results modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedResults isKindOfClass:[NSDictionary class]]) {
       [parsedResults addObject:[Results modelObjectWithDictionary:(NSDictionary *)receivedResults]];
    }

    self.results = [NSArray arrayWithArray:parsedResults];
            self.icon = [self objectOrNilForKey:kFeedIcon fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.author dictionaryRepresentation] forKey:kFeedAuthor];
    [mutableDict setValue:self.updated forKey:kFeedUpdated];
    [mutableDict setValue:self.country forKey:kFeedCountry];
    [mutableDict setValue:self.feedIdentifier forKey:kFeedId];
    [mutableDict setValue:self.title forKey:kFeedTitle];
    [mutableDict setValue:self.copyright forKey:kFeedCopyright];
    NSMutableArray *tempArrayForLinks = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.links) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLinks addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLinks addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLinks] forKey:kFeedLinks];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.results) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kFeedResults];
    [mutableDict setValue:self.icon forKey:kFeedIcon];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.author = [aDecoder decodeObjectForKey:kFeedAuthor];
    self.updated = [aDecoder decodeObjectForKey:kFeedUpdated];
    self.country = [aDecoder decodeObjectForKey:kFeedCountry];
    self.feedIdentifier = [aDecoder decodeObjectForKey:kFeedId];
    self.title = [aDecoder decodeObjectForKey:kFeedTitle];
    self.copyright = [aDecoder decodeObjectForKey:kFeedCopyright];
    self.links = [aDecoder decodeObjectForKey:kFeedLinks];
    self.results = [aDecoder decodeObjectForKey:kFeedResults];
    self.icon = [aDecoder decodeObjectForKey:kFeedIcon];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kFeedAuthor];
    [aCoder encodeObject:_updated forKey:kFeedUpdated];
    [aCoder encodeObject:_country forKey:kFeedCountry];
    [aCoder encodeObject:_feedIdentifier forKey:kFeedId];
    [aCoder encodeObject:_title forKey:kFeedTitle];
    [aCoder encodeObject:_copyright forKey:kFeedCopyright];
    [aCoder encodeObject:_links forKey:kFeedLinks];
    [aCoder encodeObject:_results forKey:kFeedResults];
    [aCoder encodeObject:_icon forKey:kFeedIcon];
}

- (id)copyWithZone:(NSZone *)zone {
    Feed *copy = [[Feed alloc] init];
    
    
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.updated = [self.updated copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.feedIdentifier = [self.feedIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.copyright = [self.copyright copyWithZone:zone];
        copy.links = [self.links copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
    }
    
    return copy;
}


@end
