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

@interface SearchDetailsViewController ()<JOLImageSliderDelegate>
{
   __block IstrahtyModel *model;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *istrahaNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *istrahaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *istrahaPhone;
@property (weak, nonatomic) IBOutlet UILabel *istrahaDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *rateView;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet JOLImageSlider *slider;

@end

@implementation SearchDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureUI];
    
    [self loadData];
}

- (void)configureUI
{
    self.carousel.type = iCarouselTypeLinear;
    
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"JFFlat-Regular" size:13.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

-(void)loadData
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
    NSMutableArray *slideSet = [[NSMutableArray alloc]init];
    for (NSString *imageURL in model.imagesArray)
    {
        JOLImageSlide *slide = [[JOLImageSlide alloc] init];
        slide.image = imageURL;
        [slideSet addObject:slide];
    }

    self.slider.slideArray = slideSet;

    self.slider.delegate = self;
    [self.slider setAutoSlide: YES];
    [self.slider setPlaceholderImage:@"placeholder.png"];
    [self.slider setContentMode: UIViewContentModeScaleAspectFill];
    [self.slider loadData];
    [self.carousel reloadData];
    [self.carousel scrollToItemAtIndex:1 animated:YES];
    [self.carousel setBackgroundColor:[UIColor clearColor]];
    
    self.istrahaDetailsLabel.text = model.istrahaDescription;
    self.istrahaNameLabel.text = model.istrahaName;
    self.istrahaPhone.text = model.contactNo;
    self.rateView.value = [model.rating floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"ر.س %@",model.price];
    self.cityLabel.text = model.city;
    self.istrahaNoLabel.text = [NSString stringWithFormat:@"رقم الاستراحه %@",self.istrahaID];
}

- (void) imagePager:(JOLImageSlider *)imagePager didSelectImageAtIndex:(NSUInteger)index
{

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
    
//    [self goToPostView:[catArr objectAtIndex:index]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
