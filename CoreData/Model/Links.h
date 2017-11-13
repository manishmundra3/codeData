//
//  Links.h
//
//  Created by   on 08/11/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Links : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *alternate;
@property (nonatomic, strong) NSString *linksSelf;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
