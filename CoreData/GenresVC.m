//
//  GenresVC.m
//  CoreData
//
//  Created by manish on 09/11/17.
//  Copyright © 2017 manish. All rights reserved.
//

#import "GenresVC.h"
#import "CollectionCell.h"
#import "Results.h"
#import "GenresSongs.h"

@interface GenresVC ()
{
    __weak IBOutlet UICollectionView *clnView;
}
@end

@implementation GenresVC
@synthesize arrGenres;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma UICollectionViewDelegate And UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return arrGenres.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionCell *cell = (CollectionCell *)[clnView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    GenresSongs *resiultObj = arrGenres[indexPath.row];
    
    cell.lblName.text = resiultObj.name;

    
    
    
    return cell;
    
}

- (IBAction)btnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end
