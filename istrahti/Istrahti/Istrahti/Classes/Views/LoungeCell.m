//
//  LoungeCell.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/19/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "LoungeCell.h"
#import "SmallIconViewCell.h"

@implementation LoungeCell

- (void)awakeFromNib {
    // Initialization code
    
    _bgView.layer.borderWidth = 1.0f;
    _bgView.layer.borderColor = RGBA(221, 221, 221, 1).CGColor;
    _reserveBtn.layer.cornerRadius = 2.0f;
    _reserveBtn.clipsToBounds = YES ;
    _reserveBtn.layer.borderWidth = 1.0f;
    _reserveBtn.layer.borderColor = RGBA(147, 199, 45, 1).CGColor;
}

- (void)setLoungeData:(SearchData *)data
{
    self.Key = data.Key ;
    
    [_loungeImage setImageURL:[NSURL URLWithString:data.DefaultImage]];
    _loungeName.text = data.IstrahaName ;
    _city.text = data.City ;
    _rateView.transform = CGAffineTransformMakeScale(-1, 1);

    _rateView.value = data.Rating;
    _loungeDetails.text = data.Description;
    _review.text = [NSString stringWithFormat:@"%d تقييم",data.Reviews];
    
    _price.text = [NSString stringWithFormat:@"ر.س %d",data.Price];
    [_collection registerNib:[UINib nibWithNibName:@"SmallIconViewCell" bundle:nil] forCellWithReuseIdentifier:@"SmallIconViewCell"];
    _collection.transform = CGAffineTransformMakeScale(-1, 1);
    _collection.dataSource = self ;
    
    _smallIcons = [NSMutableArray new];
    
    if (data.Space > 0)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:[NSString stringWithFormat:@"%d",data.Space] andImage:@"space-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.SwimmingPool)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"مسبح" andImage:@"swimp-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.SwimmingPool) {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"مسبح نساء" andImage:@"swimp-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.KidsPlay)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"ملاعب أطفال" andImage:@"cp-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.Singles)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"شباب" andImage:@"single-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.Events)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"مناسبات" andImage:@"events-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.Family)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"عائلات" andImage:@"families-sr.png"];
        [_smallIcons addObject:model];
    }
    
    if (data.Seperation)
    {
        SmallIconsModel *model = [[SmallIconsModel alloc] initWithName:@"قسم للنساء" andImage:@"div-sr.png"];
        [_smallIcons addObject:model];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _smallIcons.count;
}

- (SmallIconViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SmallIconViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallIconViewCell" forIndexPath:indexPath];
  
    cell.transform = CGAffineTransformMakeScale(-1, 1);

    SmallIconsModel *model = _smallIcons[indexPath.row];
    
    [cell setSmallIcon:model];
    
    return cell;
}


- (IBAction)bookNow:(id)sender
{
    [self.delegate bookNow:self.Key];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)makeReservation:(id)sender {
}
@end
