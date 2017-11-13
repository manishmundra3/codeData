//
//  Genres.m
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Genres.h"


NSString *const kGenresGenreId = @"genreId";
NSString *const kGenresName = @"name";
NSString *const kGenresUrl = @"url";


@interface Genres ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Genres

@synthesize genreId = _genreId;
@synthesize name = _name;
@synthesize url = _url;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.genreId = [self objectOrNilForKey:kGenresGenreId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kGenresName fromDictionary:dict];
            self.url = [self objectOrNilForKey:kGenresUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.genreId forKey:kGenresGenreId];
    [mutableDict setValue:self.name forKey:kGenresName];
    [mutableDict setValue:self.url forKey:kGenresUrl];

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

    self.genreId = [aDecoder decodeObjectForKey:kGenresGenreId];
    self.name = [aDecoder decodeObjectForKey:kGenresName];
    self.url = [aDecoder decodeObjectForKey:kGenresUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_genreId forKey:kGenresGenreId];
    [aCoder encodeObject:_name forKey:kGenresName];
    [aCoder encodeObject:_url forKey:kGenresUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    Genres *copy = [[Genres alloc] init];
    
    
    
    if (copy) {

        copy.genreId = [self.genreId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
