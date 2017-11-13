//
//  Results.m
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Results.h"
#import "Genres.h"


NSString *const kResultsId = @"id";
NSString *const kResultsArtistName = @"artistName";
NSString *const kResultsName = @"name";
NSString *const kResultsReleaseDate = @"releaseDate";
NSString *const kResultsCollectionName = @"collectionName";
NSString *const kResultsUrl = @"url";
NSString *const kResultsArtistId = @"artistId";
NSString *const kResultsGenres = @"genres";
NSString *const kResultsKind = @"kind";
NSString *const kResultsArtistUrl = @"artistUrl";
NSString *const kResultsCopyright = @"copyright";
NSString *const kResultsArtworkUrl100 = @"artworkUrl100";


@interface Results ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Results

@synthesize resultsIdentifier = _resultsIdentifier;
@synthesize artistName = _artistName;
@synthesize name = _name;
@synthesize releaseDate = _releaseDate;
@synthesize collectionName = _collectionName;
@synthesize url = _url;
@synthesize artistId = _artistId;
@synthesize genres = _genres;
@synthesize kind = _kind;
@synthesize artistUrl = _artistUrl;
@synthesize copyright = _copyright;
@synthesize artworkUrl100 = _artworkUrl100;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.resultsIdentifier = [self objectOrNilForKey:kResultsId fromDictionary:dict];
            self.artistName = [self objectOrNilForKey:kResultsArtistName fromDictionary:dict];
            self.name = [self objectOrNilForKey:kResultsName fromDictionary:dict];
            self.releaseDate = [self objectOrNilForKey:kResultsReleaseDate fromDictionary:dict];
            self.collectionName = [self objectOrNilForKey:kResultsCollectionName fromDictionary:dict];
            self.url = [self objectOrNilForKey:kResultsUrl fromDictionary:dict];
            self.artistId = [self objectOrNilForKey:kResultsArtistId fromDictionary:dict];
    NSObject *receivedGenres = [dict objectForKey:kResultsGenres];
    NSMutableArray *parsedGenres = [NSMutableArray array];
    
    if ([receivedGenres isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGenres) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGenres addObject:[Genres modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGenres isKindOfClass:[NSDictionary class]]) {
       [parsedGenres addObject:[Genres modelObjectWithDictionary:(NSDictionary *)receivedGenres]];
    }

    self.genres = [NSArray arrayWithArray:parsedGenres];
            self.kind = [self objectOrNilForKey:kResultsKind fromDictionary:dict];
            self.artistUrl = [self objectOrNilForKey:kResultsArtistUrl fromDictionary:dict];
            self.copyright = [self objectOrNilForKey:kResultsCopyright fromDictionary:dict];
            self.artworkUrl100 = [self objectOrNilForKey:kResultsArtworkUrl100 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.resultsIdentifier forKey:kResultsId];
    [mutableDict setValue:self.artistName forKey:kResultsArtistName];
    [mutableDict setValue:self.name forKey:kResultsName];
    [mutableDict setValue:self.releaseDate forKey:kResultsReleaseDate];
    [mutableDict setValue:self.collectionName forKey:kResultsCollectionName];
    [mutableDict setValue:self.url forKey:kResultsUrl];
    [mutableDict setValue:self.artistId forKey:kResultsArtistId];
    NSMutableArray *tempArrayForGenres = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.genres) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGenres addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGenres addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGenres] forKey:kResultsGenres];
    [mutableDict setValue:self.kind forKey:kResultsKind];
    [mutableDict setValue:self.artistUrl forKey:kResultsArtistUrl];
    [mutableDict setValue:self.copyright forKey:kResultsCopyright];
    [mutableDict setValue:self.artworkUrl100 forKey:kResultsArtworkUrl100];

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

    self.resultsIdentifier = [aDecoder decodeObjectForKey:kResultsId];
    self.artistName = [aDecoder decodeObjectForKey:kResultsArtistName];
    self.name = [aDecoder decodeObjectForKey:kResultsName];
    self.releaseDate = [aDecoder decodeObjectForKey:kResultsReleaseDate];
    self.collectionName = [aDecoder decodeObjectForKey:kResultsCollectionName];
    self.url = [aDecoder decodeObjectForKey:kResultsUrl];
    self.artistId = [aDecoder decodeObjectForKey:kResultsArtistId];
    self.genres = [aDecoder decodeObjectForKey:kResultsGenres];
    self.kind = [aDecoder decodeObjectForKey:kResultsKind];
    self.artistUrl = [aDecoder decodeObjectForKey:kResultsArtistUrl];
    self.copyright = [aDecoder decodeObjectForKey:kResultsCopyright];
    self.artworkUrl100 = [aDecoder decodeObjectForKey:kResultsArtworkUrl100];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resultsIdentifier forKey:kResultsId];
    [aCoder encodeObject:_artistName forKey:kResultsArtistName];
    [aCoder encodeObject:_name forKey:kResultsName];
    [aCoder encodeObject:_releaseDate forKey:kResultsReleaseDate];
    [aCoder encodeObject:_collectionName forKey:kResultsCollectionName];
    [aCoder encodeObject:_url forKey:kResultsUrl];
    [aCoder encodeObject:_artistId forKey:kResultsArtistId];
    [aCoder encodeObject:_genres forKey:kResultsGenres];
    [aCoder encodeObject:_kind forKey:kResultsKind];
    [aCoder encodeObject:_artistUrl forKey:kResultsArtistUrl];
    [aCoder encodeObject:_copyright forKey:kResultsCopyright];
    [aCoder encodeObject:_artworkUrl100 forKey:kResultsArtworkUrl100];
}

- (id)copyWithZone:(NSZone *)zone {
    Results *copy = [[Results alloc] init];
    
    
    
    if (copy) {

        copy.resultsIdentifier = [self.resultsIdentifier copyWithZone:zone];
        copy.artistName = [self.artistName copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.releaseDate = [self.releaseDate copyWithZone:zone];
        copy.collectionName = [self.collectionName copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.artistId = [self.artistId copyWithZone:zone];
        copy.genres = [self.genres copyWithZone:zone];
        copy.kind = [self.kind copyWithZone:zone];
        copy.artistUrl = [self.artistUrl copyWithZone:zone];
        copy.copyright = [self.copyright copyWithZone:zone];
        copy.artworkUrl100 = [self.artworkUrl100 copyWithZone:zone];
    }
    
    return copy;
}


@end
