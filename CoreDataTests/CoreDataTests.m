//
//  CoreDataTests.m
//  CoreDataTests
//
//  Created by indianic on 14/11/17.
//  Copyright © 2017 indianic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "Results.h"


@interface CoreDataTests : XCTestCase

@property(nonatomic, strong) ViewController *vcObj;
@end

@implementation CoreDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _vcObj = [[ViewController alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetDatafromServer {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [_vcObj serviceCallingToFetchData];
    
}

-(void)testfetchDataFromDB {
    
    [_vcObj fetchDataFromDB];
    
}


-(void)testsetDataInDB {

    NSDictionary *aDictResponse = [[NSDictionary alloc] init];
    
    Results *resiultObj = [Results new];
    resiultObj.artistName = @"Test Artist Name";
    resiultObj.artworkUrl100 = @"";
    
    // Genres array
    NSArray *arrTempGenres = [[NSArray alloc]initWithObjects:@"Music", @"Hip/Pop", nil];
    resiultObj.genres = arrTempGenres;
    [_vcObj setDataInDB:aDictResponse];
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
