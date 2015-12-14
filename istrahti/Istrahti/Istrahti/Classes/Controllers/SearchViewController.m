//
//  SearchViewController.m
//  Estra7ty
//
//  Created by Ahmed Askar on 8/17/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultViewController.h"
#import "MapResultViewController.h"
#import "SearchParaData.h"
#import "SearchResult.h"
#import "AboutViewController.h"
#import "SearchDetailsViewController.h"
#import "AlertManager.h"

@interface SearchViewController () <DatabaseDelegate,DatabaseRowDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    float animatedDistance ;
    
    __weak IBOutlet UITextField *cityTxt;
    
    __weak IBOutlet UILabel *textFieldTitle;
    
    __weak IBOutlet UIButton    *searchByListBtn;
    __weak IBOutlet UIButton    *searchByMapBtn;
    __weak IBOutlet UIButton    *searchByRestNo;
    __weak IBOutlet UIButton    *userMyLocationBtn;
    __weak IBOutlet UIButton    *useAllCountriesBtn;
    __weak IBOutlet UIButton    *youthBtn;
    __weak IBOutlet UIButton    *familyBtn;
    __weak IBOutlet UIButton    *eventBtn;
    
    __weak IBOutlet UIView *entryTextView;
    __weak IBOutlet UIView *searchView;
    
    UIPickerView *dataPicker ;
    NSArray *cities ;
    BOOL restNo;
    SearchParaData *searchData ;
    CGRect originalFrame;
    UIToolbar *toolBar ;
    UILabel *toolBarTitle ;
}

@end

@implementation SearchViewController

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configureUI];
    
    searchData = [SearchParaData new];
    cities = [NSArray new];
    
    NSString *query = @"SELECT * FROM Cities";
    [[Database getObject] databaseSelectQuery:query withDelegate:self AndRowDelegate:self];
    cityTxt.text = cities[0];
}

- (void)configureUI
{
    dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 162.0f)];
    dataPicker.dataSource = self;
    dataPicker.delegate = self;
    dataPicker.showsSelectionIndicator = YES;
    dataPicker.backgroundColor = RGBA(238, 238, 238, 1);
    
    searchByListBtn.selected = YES ;
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    [toolBar setTintColor:[UIColor whiteColor]];
    [toolBar setBarTintColor:RGBA(47, 120, 143, 1)];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"تم" style:UIBarButtonItemStylePlain target:self action:@selector(setPickerData)];
    
    toolBarTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 55, 200, 20)];
    toolBarTitle.backgroundColor = [UIColor clearColor];
    toolBarTitle.textColor = [UIColor whiteColor];
    [toolBarTitle setFont:[UIFont fontWithName:@"JFFlat-Regular" size:16.0]];
    toolBarTitle.textAlignment = NSTextAlignmentCenter;
    UIBarButtonItem *typeField = [[UIBarButtonItem alloc] initWithCustomView:toolBarTitle];
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    fixedItem.width = (self.view.frame.size.width - 240.0f) / 2.0f;
    if (IS_IPHONE_6)
    {
        fixedItem.width = (self.view.frame.size.width - 200.0f) / 2.0f;
    }
    else if (IS_IPHONE_6P)
    {
        fixedItem.width = (self.view.frame.size.width - 160.0f) / 2.0f;
    }
    
    toolBarTitle.text = @"اختر الدولة";
    toolBar.items = @[barButtonDone,fixedItem,typeField];
    cityTxt.inputView = dataPicker ;
    cityTxt.inputAccessoryView = toolBar;
    
    useAllCountriesBtn.selected = NO;
    searchByListBtn.selected = YES ;
}

- (void)setPickerData
{
    if ([cityTxt isFirstResponder])
    {
        if (cityTxt.text.length == 0)
        {
            cityTxt.text = cities[0];
        }
    }
    
    [self.view endEditing:YES];
}

#pragma mark - Event Handler

- (IBAction)searchBy:(id)sender
{
    switch ([sender tag])
    {
        case 0:{
            searchByListBtn.selected = YES ;
            searchByMapBtn.selected  = NO ;
            searchByRestNo.selected  = NO;
            restNo = NO;
          
            textFieldTitle.text = @"المدينة";
            cityTxt.placeholder = @"اختر المدينة";
            useAllCountriesBtn.enabled = YES ;

            cityTxt.inputView = dataPicker ;
            cityTxt.inputAccessoryView = toolBar;
            
            [self setPickerData];

            break;
            
        }
        case 1:{
            searchByListBtn.selected = NO ;
            searchByMapBtn.selected  = YES ;
            searchByRestNo.selected  = NO;
            restNo = NO;
            textFieldTitle.text = @"المدينة";
            cityTxt.placeholder = @"اختر المدينة";
            useAllCountriesBtn.enabled = YES ;
            
            cityTxt.inputView = dataPicker ;
            cityTxt.inputAccessoryView = toolBar;
            
            break ;
        }
        
        case 2:
        {
            searchByListBtn.selected = NO ;
            searchByMapBtn.selected  = NO ;
            searchByRestNo.selected  = YES;
            
            useAllCountriesBtn.selected = YES;
            useAllCountriesBtn.enabled = NO ;
            
            cityTxt.inputView = nil ;
            cityTxt.inputAccessoryView = nil;
            
            [self useAllCities:nil];
            
            textFieldTitle.text = @"البحث عبر رقم الاستراحة";
            cityTxt.placeholder = @"أدخل رقم الاستراحة";
            cityTxt.text = @"";
            
            break ;
        }
            
        default:
            break;
    }
}

- (IBAction)useMyLocation:(id)sender
{
    
}

- (IBAction)useAllCities:(id)sender
{
    if (useAllCountriesBtn.selected)
    {
        useAllCountriesBtn.selected = NO;
        [UIView animateWithDuration:0.5f animations:^{
            searchView.frame = CGRectMake(searchView.frame.origin.x, entryTextView.frame.origin.y + entryTextView.frame.size.height + 4.0f,searchView.frame.size.width, searchView.frame.size.height);
            
        } completion:^(BOOL finished) {
            entryTextView.hidden = NO;
            
        }];
        
    }else{
        
        useAllCountriesBtn.selected = YES;
        
        entryTextView.hidden = YES;
        
        [UIView animateWithDuration:0.5f animations:^{
            searchView.frame = CGRectMake(searchView.frame.origin.x, entryTextView.frame.origin.y,searchView.frame.size.width, searchView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (IBAction)SelectType:(id)sender
{
    switch ([sender tag]) {
        case 10:
            if (youthBtn.selected)
            {
                youthBtn.selected = NO ;
            }else{
                youthBtn.selected = YES ;
            }
            break;
        case 11:
            if (familyBtn.selected) {
                familyBtn.selected = NO ;
            }else{
                familyBtn.selected = YES ;
            }
            break;
        case 12:
            if (eventBtn.selected) {
                eventBtn.selected = NO ;
            }else{
                eventBtn.selected = YES ;
            }
            break ;
        default:
            break;
    }
}

- (IBAction)search:(id)sender
{
    if (searchByRestNo.selected)
    {
        NSString *str = cityTxt.text;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        if (str.length == 0)
        {
            [AlertManager showNotificationOfType:NotificationtypeSucess title:@"" message:@"من فضلك أدخل رقم الإستراحة" inController:self];
            return ;
        }
        SearchDetailsViewController *searchDetail = [[SearchDetailsViewController alloc]initWithNibName:@"SearchDetailsViewController" bundle:[NSBundle mainBundle]];
        searchDetail.istrahaID = cityTxt.text;
        [self.navigationController pushViewController:searchDetail animated:YES];
        
        return ;
    }
    
    searchData = [SearchParaData new];
    
    if (!useAllCountriesBtn.selected)
    {
        if(![Validation validCountry:cityTxt.text])
        {
            return ;
        }
    }
    
    NSString *startDate = [NSString stringWithFormat:@"/Date(%lld-0000)/",(long long)([[NSDate date] timeIntervalSince1970] * 1000)];
    NSString *endDate = [NSString stringWithFormat:@"/Date(%lld-0000)/",(long long)([[NSDate date] timeIntervalSince1970] * 1000)];
    
    searchData.City     = useAllCountriesBtn.selected?@"all":cityTxt.text;
    searchData.DateFrom = startDate ;
    searchData.DateTo   = endDate ;
    searchData.Type     = @"1" ;
    searchData.Time     = @"";
    searchData.Page     = 2;
    searchData.SortBy   = @"Popular";
    searchData.HalfDay = false ;

    searchData.SwimmingPool       = NULL ;
    searchData.WomenSwimming      = NULL ;
    searchData.Seperation      = NULL ;
    searchData.KidsPlay      = NULL ;
    
    searchData.Bedrooms     = NULL ;
    searchData.Livingrooms  = NULL ;
    searchData.Bathrooms    = NULL ;
    searchData.Kitchens     = NULL ;
    searchData.Space        = NULL ;


    if (youthBtn.selected)
    {
        searchData.Singles = [NSNumber numberWithBool:YES]; ;
    }else{
        searchData.Singles = NULL ;
    }
    
    if (familyBtn.selected)
    {
        searchData.Family = [NSNumber numberWithBool:YES]; ;
    }else{
        searchData.Family = NULL ;
    }
    
    if (eventBtn.selected)
    {
        searchData.Events = [NSNumber numberWithBool:YES]; ;
    }else{
        searchData.Events = NULL ;
    }
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [hud setLabelText:@""];
//    
//    [[WebDataRepository sharedInstance] searchForLounge:searchData :^(id result) {
//        
//        SearchResult *response = [SearchResult modelFromJSONDictionary:result];
//        
//        NSArray *resultArray = [NSArray new];
//        
//        if (response.Data != nil)
//        {
//            resultArray = response.Data ;
//        }
//        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    
        if (searchByListBtn.selected)
        {
            ResultViewController *searchResultView = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
            searchResultView.displayList = YES ;
//            searchResultView.Lounges = resultArray ;
            searchResultView.searchParaData = searchData;
            searchResultView.startFromDate = [NSDate date] ;
            searchResultView.endToDate = [NSDate date] ;
            [self.navigationController pushViewController:searchResultView animated:YES];
        }

        if (searchByMapBtn.selected)
        {
            MapResultViewController *mapView = [[MapResultViewController alloc] initWithNibName:@"MapResultViewController" bundle:nil];
            mapView.displayMap = YES ;
            [self.navigationController pushViewController:mapView animated:YES];
        }
//    } andFailure:^(NSString *message) {
//        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//    }];
}

#pragma mark - TextFieldDelegate

// This code handles the scrolling when tabbing through infput fields
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 220;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;
//when clicking the return button in the keybaord
- (BOOL)textFieldShouldEndEditing:(UITextField*)textField
{
    return [self textSouldEndEditing];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField  resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    [self textDidBeginEditing:textFieldRect];
}

- (void)textDidBeginEditing:(CGRect)textRect
{
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textRect.origin.y + 0.5 * textRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (BOOL)textSouldEndEditing
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView* view in self.view.subviews) {
        for (UIGestureRecognizer* recognizer in view.gestureRecognizers) {
            [recognizer addTarget:self action:@selector(touchEvent:)];
        }
        
        [self.view endEditing:YES];
    }
}

- (void)touchEvent:(id)sender
{
    
}

#pragma mark - Database Delegate
- (void)databaseSelectResult:(NSMutableArray *)databaseData
{
    cities = databaseData ;
}

- (id)databaseRowSelect:(NSMutableDictionary *)row
{
    NSString *countryName = [row objectForKey:@"CityName"];
    return countryName;
}
#pragma mark - PickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return cities.count;
}

#pragma mark - Picker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    cityTxt.text = cities[row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return cities[row] ;
}

- (void)didReceiveMemoryWarning
{
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

@end
