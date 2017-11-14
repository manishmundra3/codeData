//
//  ViewController.m
//  CoreData
//
//  Created by manish on 08/11/17.
//  Copyright © 2017 manish. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>

#import "CollectionCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "GenresVC.h"

#import "Results.h"
#import "Genres.h"
#import "Topsongs+CoreDataProperties.h"
#import "GenresSongs+CoreDataProperties.h"
#import "Topsongs.h"
#import "GenresSongs.h"


#define ServiceToGetJSONData @"https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/100/non-explicit.json"

@interface ViewController () <NSURLSessionDelegate>
{
    
    NSMutableArray *arrMain;
    
    __weak IBOutlet UICollectionView *collectionview;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrMain = [[NSMutableArray alloc] init];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ServiceCalled"])
        [self serviceCallingToFetchData];
    else
        [self fetchDataFromDB];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Custom Methods

/**
 *  Fetch data from server
 */
-(void)serviceCallingToFetchData {
    // String url
    NSString *stringUrl = [NSString stringWithFormat:ServiceToGetJSONData];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:stringUrl]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            
            NSError *error = nil;
            NSDictionary *aDictResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [self setDataInDB:aDictResponse];
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"ServiceCalled"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
        }
        
    }] resume];
}


-(NSMutableArray *)fetchDataFromDB {
    
    NSError *error = nil;

    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Topsongs"];

    NSArray *arrTempFrpmDB = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    for (Topsongs *obj in arrTempFrpmDB) {
        Results *resultObj = [Results new];
        
        resultObj.artistName = obj.artistName;
        resultObj.artworkUrl100 = obj.artworkUrl100;

        NSArray *test = [obj.relationship allObjects];
        resultObj.genres = test;
    
        [arrMain addObject:resultObj];
        
    }
    
    return arrMain;
    
    
}


-(void)setDataInDB:(NSDictionary *)aDictResponse {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Result array
    NSArray *arrTemp = aDictResponse[@"feed"][@"results"];
    
    // Enumration to get artistname , artworkurl
    [arrTemp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"Main %lu", (unsigned long)idx);
        ;        // Set artistname , artworkurl in model object
        Results *resiultObj = [Results new];
        resiultObj.artistName = obj[@"artistName"];
        resiultObj.artworkUrl100 = obj[@"artworkUrl100"];
        
        // Genres array
        NSArray *arrTempGenres = obj[@"genres"];
        
        // Set genres iin model object
        NSMutableArray *arrTempModelGenres = [NSMutableArray new];
        
        // Create a new managed object
        Topsongs *topsongs = [NSEntityDescription insertNewObjectForEntityForName:@"Topsongs" inManagedObjectContext:context];
        
        topsongs.artistName = resiultObj.artistName;
        topsongs.artworkUrl100 = resiultObj.artworkUrl100;


        [arrTempGenres enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GenresSongs *songGenres = [NSEntityDescription insertNewObjectForEntityForName:@"Genres" inManagedObjectContext:context];
            NSLog(@"Genres %lu", (unsigned long)idx);
            Genres *genresObj = [Genres new];
            genresObj.name = obj[@"name"];
        
            [songGenres setValue:genresObj.name forKey:@"name"];
            
            [arrTempModelGenres addObject:songGenres];
            [topsongs addRelationship:[NSSet setWithArray:arrTempModelGenres]];
            songGenres.genresToSongs = topsongs;

        }];
        
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        

    }];
    
    [self fetchDataFromDB];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [collectionview reloadData]; 
    });
    
        
    
    
    
    

}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


#pragma UICollectionViewDelegate And UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return arrMain.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Results *resiultObj = arrMain[indexPath.row];
    
    cell.lblName.text = resiultObj.artistName;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:resiultObj.artworkUrl100] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
   

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Results *resiultObj = arrMain[indexPath.row];
    
     GenresVC *vcGenresVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GenresVC"];
    vcGenresVC.arrGenres = resiultObj.genres;
    [self.navigationController pushViewController:vcGenresVC animated:true];
    
}


@end





