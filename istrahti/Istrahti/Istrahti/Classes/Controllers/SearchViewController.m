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

@interface SearchViewController () <DatabaseDelegate,DatabaseRowDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    float animatedDistance ;

    __weak IBOutlet UITextField *cityTxt;
    __weak IBOutlet UITextField *firstDate;
    __weak IBOutlet UITextField *secondDate;
    __weak IBOutlet UITextField *reservationTypTxt;
    __weak IBOutlet UIView *reservationTypeBGView;
    __weak IBOutlet UIImageView *dropListIcon;
    
    __weak IBOutlet UILabel *textFieldTitle;
    __weak IBOutlet UITextField *periodTxt;
    __weak IBOutlet UIView      *periodView;
    __weak IBOutlet UIButton    *searchByListBtn;
    __weak IBOutlet UIButton    *searchByMapBtn;
    __weak IBOutlet UIButton    *searchByRestNo;
    __weak IBOutlet UIButton    *userMyLocationBtn;
    __weak IBOutlet UIButton    *useAllCountriesBtn;
    __weak IBOutlet UIButton    *youthBtn;
    __weak IBOutlet UIButton    *familyBtn;
    __weak IBOutlet UIButton    *eventBtn;
    
    __weak IBOutlet UIView *cityTextView;
    __weak IBOutlet UIView *fromDateView ;
    __weak IBOutlet UIView *toDateView ;
    
    __weak IBOutlet UIView *searchView;
    UIPickerView *dataPicker ;
    
    NSDate *fromDate;
    NSDate *toDate;
    BOOL fromDateSelected ;
    
    NSArray *cities ;
    NSArray *resevationData;
    NSArray *periodData;
    NSArray *periodMapData;

    BOOL citySelected ;
    BOOL reservationSelected ;
    BOOL periodSelected ;
    BOOL restNo;
    //search post parameters
    SearchParaData *searchData ;
    NSString *startDate ;
    NSString *endDate ;
    NSString *Type;
    NSString *TimePeriod;
    CGRect originalFrame;
    UIToolbar *toolBar ;
    UILabel *toolBarTitle ;
}

@end

@implementation SearchViewController

- (void)viewDidAppear:(BOOL)animated
{
//    NSString *query = @"SELECT * FROM Cities";
//    [[Database getObject] databaseSelectQuery:query withDelegate:self AndRowDelegate:self];
//    cityTxt.text = cities[0];
    originalFrame =searchView.frame;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [userMyLocationBtn setBackgroundImage:[UIImage imageNamed:@"inactive-checkbox.png"] forState:UIControlStateNormal];
    [userMyLocationBtn setBackgroundImage:[UIImage imageNamed:@"active-checkbox.png"] forState:UIControlStateSelected];
    [useAllCountriesBtn setBackgroundImage:[UIImage imageNamed:@"inactive-checkbox.png"] forState:UIControlStateNormal];
    [useAllCountriesBtn setBackgroundImage:[UIImage imageNamed:@"active-checkbox.png"] forState:UIControlStateSelected];
    [youthBtn setBackgroundImage:[UIImage imageNamed:@"inactive-checkbox.png"] forState:UIControlStateNormal];
    [youthBtn setBackgroundImage:[UIImage imageNamed:@"active-checkbox.png"] forState:UIControlStateSelected];
    [familyBtn setBackgroundImage:[UIImage imageNamed:@"inactive-checkbox.png"] forState:UIControlStateNormal];
    [familyBtn setBackgroundImage:[UIImage imageNamed:@"active-checkbox.png"] forState:UIControlStateSelected];
    [eventBtn setBackgroundImage:[UIImage imageNamed:@"inactive-checkbox.png"] forState:UIControlStateNormal];
    [eventBtn setBackgroundImage:[UIImage imageNamed:@"active-checkbox.png"] forState:UIControlStateSelected];
    [searchByListBtn setBackgroundImage:[UIImage imageNamed:@"radio-inactive.png"] forState:UIControlStateNormal];
    [searchByListBtn setBackgroundImage:[UIImage imageNamed:@"radio-active.png"] forState:UIControlStateSelected];
    [searchByMapBtn setBackgroundImage:[UIImage imageNamed:@"radio-inactive.png"] forState:UIControlStateNormal];
    [searchByMapBtn setBackgroundImage:[UIImage imageNamed:@"radio-active.png"] forState:UIControlStateSelected];
    [searchByRestNo setBackgroundImage:[UIImage imageNamed:@"radio-inactive.png"] forState:UIControlStateNormal];
    [searchByRestNo setBackgroundImage:[UIImage imageNamed:@"radio-active.png"] forState:UIControlStateSelected];
    searchByListBtn.selected = YES ;
    
    dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 162.0f)];
    dataPicker.dataSource = self;
    dataPicker.delegate = self;
    dataPicker.showsSelectionIndicator = YES;
    dataPicker.backgroundColor = RGBA(238, 238, 238, 1);
   
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
    if (IS_IPHONE_6) {
        fixedItem.width = (self.view.frame.size.width - 200.0f) / 2.0f;
    }else if (IS_IPHONE_6P){
        fixedItem.width = (self.view.frame.size.width - 160.0f) / 2.0f;
    }
    
    toolBarTitle.text = @"اختر الدولة";
    toolBar.items = @[barButtonDone,fixedItem,typeField];
   
    cityTxt.inputView = dataPicker ;
    reservationTypTxt.inputView = dataPicker ;
    periodTxt.inputView = dataPicker;
    cityTxt.inputAccessoryView = toolBar;
    reservationTypTxt.inputAccessoryView = toolBar;
    periodTxt.inputAccessoryView = toolBar;

    reservationTypeBGView.frame = CGRectMake(12.0f, reservationTypeBGView.frame.origin.y, self.view.frame.size.width - 20.0f, reservationTypeBGView.frame.size.height);
    dropListIcon.frame = CGRectMake(8.0f, dropListIcon.frame.origin.y,dropListIcon.frame.size.width,dropListIcon.frame.size.height);
    
    searchData = [SearchParaData new];
    cities = [NSArray new];
    
    resevationData = @[@"نصف يوم",@"يوم واحد",@"أكثر من يوم"];
    periodData     = @[@"صباحا",@"مساء"];
    periodMapData  = @[@"Morning",@"Evening"];
    
    startDate   = @"";
    endDate     = @"";
    Type        = @"1";
    TimePeriod  = @"";
    reservationTypTxt.text = @"يوم واحد";
    periodTxt.text  = @"صباحا";
    fromDateSelected = YES ;
    
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setFromDatePicker)];
    tapGuesture.numberOfTapsRequired = 1;
    [fromDateView addGestureRecognizer:tapGuesture];
    
    UITapGestureRecognizer *tapGuesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setToDatePicker)];
    tapGuesture2.numberOfTapsRequired = 1;
    [toDateView addGestureRecognizer:tapGuesture2];
    
    [self setDate:[NSDate date]];
    
    NSString *query = @"SELECT * FROM Cities";
    [[Database getObject] databaseSelectQuery:query withDelegate:self AndRowDelegate:self];
    cityTxt.text = cities[0];
}

#pragma mark - Methods

- (void)setDate:(NSDate *)selectedDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:selectedDate];
    
    NSDate *date = [dateFormatter dateFromString:formatedDate];
    
    if (fromDateSelected)
    {
        fromDateSelected = NO ;
        fromDate = date ;
        firstDate.text = formatedDate;
        startDate = [NSString stringWithFormat:@"/Date(%lld-0000)/",(long long)([date timeIntervalSince1970] * 1000)];
    }else{
        toDate = date ;
        secondDate.text =formatedDate;
        endDate = [NSString stringWithFormat:@"/Date(%lld-0000)/",(long long)([date timeIntervalSince1970] * 1000)];
    }
}

- (void)setFromDatePicker
{
    fromDateSelected = YES ;
    if(!self.datePickr)
        self.datePickr = [THDatePickerViewController datePicker];
    self.datePickr.date = fromDate;
    self.datePickr.delegate = self;
    [self.datePickr setAllowClearDate:NO];
    [self.datePickr setClearAsToday:YES];
    [self.datePickr setAutoCloseOnSelectDate:NO];
    [self.datePickr setAllowSelectionOfSelectedDate:YES];
    [self.datePickr setDisableHistorySelection:YES];
    [self.datePickr setDisableYearSwitch:YES];
    [self.datePickr setDisableFutureSelection:NO];
    [self.datePickr setDateTimeZoneWithName:@"UTC"];
    [self.datePickr setSelectedBackgroundColor:RGBA(125, 208, 0, 1)];
    [self.datePickr setCurrentDateColor:RGBA(242, 121, 53, 1)];
    [self.datePickr setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePickr setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    [self presentSemiViewController:self.datePickr withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

- (void)setToDatePicker
{
    fromDateSelected = NO ;
    if(!self.datePickr)
        self.datePickr = [THDatePickerViewController datePicker];
    self.datePickr.date = toDate;
    self.datePickr.delegate = self;
    [self.datePickr setAllowClearDate:NO];
    [self.datePickr setClearAsToday:YES];
    [self.datePickr setAutoCloseOnSelectDate:NO];
    [self.datePickr setAllowSelectionOfSelectedDate:YES];
    [self.datePickr setDisableHistorySelection:YES];
    [self.datePickr setDisableYearSwitch:YES];
    [self.datePickr setDisableFutureSelection:NO];
    [self.datePickr setDateTimeZoneWithName:@"UTC"];
    [self.datePickr setSelectedBackgroundColor:RGBA(125, 208, 0, 1)];
    [self.datePickr setCurrentDateColor:RGBA(242, 121, 53, 1)];
    [self.datePickr setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePickr setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    [self presentSemiViewController:self.datePickr withOptions:@{
                                                                 KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                 KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                 KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                 }];
}


- (void)setPickerData
{
    if ([cityTxt isFirstResponder]) {
        if (cityTxt.text.length == 0) {
            cityTxt.text = cities[0];
        }
    }
    
    if ([reservationTypTxt isFirstResponder]) {
        
    }
    
    if ([periodTxt isFirstResponder]) {
        
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
            [self setPickerData];
            [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
                
                searchView.frame = originalFrame;
            }completion:^(BOOL finished) {
                cityTextView.hidden = NO;

            }];
            break;

        }
        case 1:{
            searchByListBtn.selected = NO ;
            searchByMapBtn.selected  = YES ;
            searchByRestNo.selected  = NO;
            restNo = NO;
            textFieldTitle.text = @"المدينة";
            cityTxt.placeholder = @"اختر المدينة";
            [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
                
                searchView.frame = originalFrame;
            }completion:^(BOOL finished) {
                cityTextView.hidden = NO;

            }];
            break ;
        }
      
        case 2:{
            searchByListBtn.selected = NO ;
            searchByMapBtn.selected  = NO ;
            searchByRestNo.selected  = YES;
            restNo = YES;
            textFieldTitle.text = @"رقم الاستراحة";
            cityTxt.placeholder = @"إدخل رقم الاستراحة";
            cityTxt.text = @"";
            cityTextView.hidden = YES;
            [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
                CGRect frame = searchView.frame;
                frame.origin.y = cityTextView.frame.origin.y;
                searchView.frame = frame;
            }completion:nil];
            break ;
        }
        
        default:
            break;
    }
}

- (IBAction)useMyLocation:(id)sender
{
  
}

- (IBAction)useAllCities:(id)sender {
    useAllCountriesBtn.selected = !useAllCountriesBtn.selected;
}

- (IBAction)SelectType:(id)sender
{
    switch ([sender tag]) {
        case 10:
            if (youthBtn.selected) {
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
    searchData = [SearchParaData new];

    if(![Validation validCountry:cityTxt.text])
    {
        return ;
    }
    
    if(![Validation validFromDate:startDate])
    {
        return ;
    }
    if (endDate.length == 0) {
        endDate = startDate ;
    }

    if(![Validation validReservationType:Type])
    {
        return ;
    }
    
    if ([Type isEqualToString:@"0"])
    {
        searchData.HalfDay = true ;

        if(![Validation validTime:TimePeriod])
        {
            return ;
        }
    }else{
        searchData.HalfDay = false ;
    }
    
    searchData.City     = useAllCountriesBtn.selected?@"all":cityTxt.text;
    searchData.DateFrom = startDate ;
    searchData.DateTo   = endDate ;
    searchData.Type     = Type ;
    searchData.Time     = TimePeriod;
    searchData.Page     = 1;
    searchData.SortBy   = @"Popular";
    
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
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [hud setLabelText:@""];

    [[WebDataRepository sharedInstance] searchForLounge:searchData :^(id result) {
        
        SearchResult *response = [SearchResult modelFromJSONDictionary:result];

        NSArray *resultArray = [NSArray new];
        
        if (response.Data != nil)
        {
            resultArray = response.Data ;
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (searchByListBtn.selected)
        {
            ResultViewController *searchResultView = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
            searchResultView.displayList = YES ;
            searchResultView.Lounges = resultArray ;
            searchResultView.searchParaData = searchData;
            searchResultView.startFromDate = fromDate ;
            searchResultView.endToDate = toDate ;
            [self.navigationController pushViewController:searchResultView animated:YES];
        }
        
        if (searchByMapBtn.selected)
        {
            MapResultViewController *mapView = [[MapResultViewController alloc] initWithNibName:@"MapResultViewController" bundle:nil];
            mapView.displayMap = YES ;
            [self.navigationController pushViewController:mapView animated:YES];
        }
        
    } andFailure:^(NSString *message) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
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
    switch ([textField tag])
    {
        case 0:
            if (!restNo) {
                toolBarTitle.text = @"اختر الدولة";
                citySelected = YES ;
                reservationSelected = NO ;
                periodSelected = NO ;
                [dataPicker selectRow:0 inComponent:0 animated:NO];
            }
            break;
        case 1:{
            toolBarTitle.text = @"نوع الحجز";
            citySelected = NO ;
            reservationSelected = YES ;
            periodSelected = NO ;
            [dataPicker selectRow:1 inComponent:0 animated:NO];
            break;
        }
        case 2:{
            toolBarTitle.text = @"اختر الفترة";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = YES ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
     
            break;
        }
    
        default:
            break;
    }
    
    [dataPicker reloadAllComponents];
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
    if (citySelected)
    {
       return cities.count;
    }
    else if (reservationSelected)
    {
        return resevationData.count;
    }
    else if (periodSelected)
    {
        return periodData.count ;
    }
    return 1;
}

#pragma mark - Picker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (citySelected)
    {
        
        cityTxt.text = cities[row];
    }
    else if (reservationSelected)
    {
        Type = [NSString stringWithFormat:@"%ld",(long)row];
        reservationTypTxt.text = resevationData[row];
        periodView.hidden = YES ;
        if (row == 0)
        {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
               
                if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
                    reservationTypeBGView.frame = CGRectMake(169, reservationTypeBGView.frame.origin.y, 143, reservationTypeBGView.frame.size.height);
                    reservationTypTxt.frame = CGRectMake(186, reservationTypTxt.frame.origin.y, 119, 30);
                    dropListIcon.frame = CGRectMake(163, dropListIcon.frame.origin.y, 19, 32);
                }else if (IS_IPHONE_6){
                    reservationTypeBGView.frame = CGRectMake(199, reservationTypeBGView.frame.origin.y, 168, reservationTypeBGView.frame.size.height);
                    reservationTypTxt.frame = CGRectMake(220, reservationTypTxt.frame.origin.y, 140, 30);
                    dropListIcon.frame = CGRectMake(193, dropListIcon.frame.origin.y, 19, 32);
                }else if (IS_IPHONE_6P){
                    reservationTypeBGView.frame = CGRectMake(220, reservationTypeBGView.frame.origin.y, 186, reservationTypeBGView.frame.size.height);
                    reservationTypTxt.frame = CGRectMake(244, reservationTypTxt.frame.origin.y, 156, 30);
                    dropListIcon.frame = CGRectMake(214, dropListIcon.frame.origin.y, 19, 32);
                }
                
            } completion:^(BOOL finished){
                
                [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
                    periodView.hidden = NO;
                    
                }completion:nil];
              
            }];
        }else{
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
                    reservationTypeBGView.frame = CGRectMake(15, reservationTypeBGView.frame.origin.y, 297, reservationTypeBGView.frame.size.height);
                    reservationTypTxt.frame = CGRectMake(35, reservationTypTxt.frame.origin.y, 270, 30);
                    dropListIcon.frame = CGRectMake(8, dropListIcon.frame.origin.y, 19, 32);
                }else if (IS_IPHONE_6){
                    reservationTypeBGView.frame = CGRectMake(18, reservationTypeBGView.frame.origin.y, 350, reservationTypeBGView.frame.size.height);
                    reservationTypTxt.frame = CGRectMake(42, reservationTypTxt.frame.origin.y, 318, 30);
                    dropListIcon.frame = CGRectMake(8, dropListIcon.frame.origin.y, 19, 32);
                }else if (IS_IPHONE_6P){
                    reservationTypeBGView.frame = CGRectMake(20, reservationTypeBGView.frame.origin.y, 386, reservationTypeBGView.frame.size.height);
                    reservationTypTxt.frame = CGRectMake(46, reservationTypTxt.frame.origin.y, 353, 30);
                    dropListIcon.frame = CGRectMake(8, dropListIcon.frame.origin.y, 19, 32);
                }
                
            } completion:^(BOOL finished){
                
                [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
                    periodView.hidden = YES;
                    
                }completion:nil];
                
            }];
        }
        
        toDateView.hidden = YES;
        if(row == 2)
        {
            toDate = [NSDate date];
            toDateView.hidden = NO;
        }
    }
    else if (periodSelected)
    {
        periodTxt.text = periodData[row];
        TimePeriod     = periodMapData[row];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title ;
    
    if (citySelected)
    {
        title = cities[row];
    }
    else if (reservationSelected)
    {
       title = resevationData[row];
    }
    else if (periodSelected)
    {
        title = periodData[row];
    }
    return title ;
}

#pragma mark - THDatePickerDelegate

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    [self setDate:self.datePickr.date];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
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

@end
