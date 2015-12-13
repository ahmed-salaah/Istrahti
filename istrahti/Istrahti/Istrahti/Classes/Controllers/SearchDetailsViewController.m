//
//  SearchDetailsViewController.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/26/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SearchDetailsViewController.h"
#import "IstrahtyModel.h"
#import "AsyncImageView.h"

@interface SearchDetailsViewController ()
{
   __block IstrahtyModel *model;
    int imageIndex ;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *istrahaNoLabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *mainImageView;
@property (weak ,nonatomic) IBOutlet UIButton *nextBtn ;
@property (weak ,nonatomic) IBOutlet UIButton *previousBtn ;

@property (weak, nonatomic) IBOutlet UILabel *istrahaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *istrahaPhone;
@property (weak, nonatomic) IBOutlet UILabel *istrahaDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateView;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;


@end

@implementation SearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    imageIndex = 0 ;
    
    [self configureUI];
    
    [self loadData];
}

- (void)configureUI
{
    self.carousel.type = iCarouselTypeLinear;
    
    self.istrahaPhone.layer.cornerRadius = 16.0f;
    self.istrahaPhone.clipsToBounds = YES ;
    
    [self.scrollView setContentSize:self.scrollView.frame.size];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"JFFlat-Regular" size:13.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)loadData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [hud setLabelText:@""];
    
    [[WebDataRepository sharedInstance]getCategories:self.istrahaID :^(id result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSDictionary *dic =result;
        model = [[IstrahtyModel alloc] initWithDic:[dic objectForKey:@"Data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setViews];
                });
    } andFailure:^(NSString *message) {
        NSLog(@"%@",message);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)setViews
{
    if (model.imagesArray.count > 0)
    {
        [self showImageWithIndex];
    }

    [self.carousel reloadData];
    [self.carousel setBackgroundColor:[UIColor clearColor]];
    
    self.istrahaDetailsLabel.text = model.istrahaDescription;
    self.istrahaNameLabel.text = model.istrahaName;
    [self.istrahaPhone setTitle:model.contactNo forState:UIControlStateNormal];
    self.rateView.value = [model.rating floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"ر.س %@",model.price];
    self.cityLabel.text = model.city;
    self.istrahaNoLabel.text = [NSString stringWithFormat:@"رقم الاستراحه %@",self.istrahaID];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return model.imagesArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIImageView *carouselView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [carouselView setImageURL:[NSURL URLWithString:[model.imagesArray objectAtIndex:index]]];
    [carouselView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleBottomMargin ];
    return carouselView;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 70;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (model.imagesArray.count > 0)
    {
        imageIndex = (int)index ;
        [self showImageWithIndex];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Event Handler
- (IBAction)switchAction:(id)sender
{
    if ([sender tag] == 1 && imageIndex > 0)
    {
        imageIndex--;
    }
    else if ([sender tag] == 2 && imageIndex < model.imagesArray.count-1)
    {
        if (model.imagesArray.count >= imageIndex+1) {
            imageIndex++;
        }
    }
    
    [self showImageWithIndex];
}

- (void)showImageWithIndex
{
    if (model.imagesArray.count > 0)
    {
        [self.mainImageView setImageURL:[NSURL URLWithString:model.imagesArray[imageIndex]]];
    }

    if (imageIndex == (model.imagesArray.count - 1))
    {
        self.nextBtn.hidden = YES ;
        self.previousBtn.hidden = NO ;
    }
    else if (imageIndex == 0)
    {
        self.nextBtn.hidden = NO ;
        self.previousBtn.hidden = YES ;
    }else{
        self.nextBtn.hidden = NO ;
        self.previousBtn.hidden = NO ;
    }
    
    if (model.imagesArray.count == 1)
    {
        self.nextBtn.hidden = YES ;
        self.previousBtn.hidden = YES ;
    }
}

- (IBAction)forwardAction:(id)sender
{
    self.carousel.currentItemIndex++;
}

- (IBAction)backAction:(id)sender
{
   self.carousel.currentItemIndex--;
}
@end
