//
//  Links.m
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Links.h"


NSString *const kLinksAlternate = @"alternate";
NSString *const kLinksSelf = @"self";


@interface Links ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Links

@synthesize alternate = _alternate;
@synthesize linksSelf = _linksSelf;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.alternate = [self objectOrNilForKey:kLinksAlternate fromDictionary:dict];
            self.linksSelf = [self objectOrNilForKey:kLinksSelf fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.alternate forKey:kLinksAlternate];
    [mutableDict setValue:self.linksSelf forKey:kLinksSelf];

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

    self.alternate = [aDecoder decodeObjectForKey:kLinksAlternate];
    self.linksSelf = [aDecoder decodeObjectForKey:kLinksSelf];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_alternate forKey:kLinksAlternate];
    [aCoder encodeObject:_linksSelf forKey:kLinksSelf];
}

- (id)copyWithZone:(NSZone *)zone {
    Links *copy = [[Links alloc] init];
    
    
    
    if (copy) {

        copy.alternate = [self.alternate copyWithZone:zone];
        copy.linksSelf = [self.linksSelf copyWithZone:zone];
    }
    
    return copy;
}


@end
