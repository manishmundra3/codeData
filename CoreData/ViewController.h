//
//  ViewController.h
//  CoreData
//
//  Created by manish on 08/11/17.
//  Copyright © 2017 manish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(NSMutableArray *)fetchDataFromDB;
-(void)setDataInDB:(NSDictionary *)aDictResponse;
-(void)serviceCallingToFetchData;


@end

