//
//  ResultViewController.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/19/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "ResultViewController.h"
#import "LoungeCell.h"
#import "MapResultViewController.h"
#import "SmallIconViewCell.h"
#import "SearchResult.h"
#import "SearchDetailsViewController.h"
#import "FacilityModel.h"
#import "FacilityCell.h"

@interface ResultViewController () <UIPickerViewDataSource,UIPickerViewDelegate,BookingDelegate,DatabaseDelegate,DatabaseRowDelegate>
{
    __weak IBOutlet UITableView *loungeList ;
    __weak IBOutlet UITextField *arrangeTxt ;
    __weak IBOutlet UIButton    *arrangeBtn;
    __weak IBOutlet UILabel *searchResultCount ;
    __weak IBOutlet UILabel *searchResultCount2 ;
    __weak IBOutlet UIView *advancedSearchView ;
    __weak IBOutlet UIScrollView *contentView ;
    
    UIPickerView *dataPicker ;
    NSArray *sortingData;
    NSArray *sortingMapData;
    NSString *sortingKind ;
    
    //Advanced search
    float animatedDistance ;
    __weak IBOutlet UITextField *cityTxt;
    __weak IBOutlet UITextField *reservationTypTxt;
    __weak IBOutlet UITextField *periodTxt;
    __weak IBOutlet UIView      *periodView;
    
    __weak IBOutlet UILabel     *secondDateHeader;
    __weak IBOutlet UITextField *firstDate;
    __weak IBOutlet UITextField *secondDate;
    __weak IBOutlet UIView *fromDateView ;
    __weak IBOutlet UIView *toDateView ;
    
    __weak IBOutlet UIButton    *youthBtn;
    __weak IBOutlet UIButton    *familyBtn;
    __weak IBOutlet UIButton    *eventBtn;
    __weak IBOutlet UIButton    *swimmingBoolBtn;
    __weak IBOutlet UIButton    *swimmingBoolWomenBtn;
    __weak IBOutlet UIButton    *playGroundKidsBtn;
    __weak IBOutlet UIButton    *seperationBtn;
    
    __weak IBOutlet UITextField *bedRooms;
    __weak IBOutlet UITextField *pathRooms;
    __weak IBOutlet UITextField *kitchenRoom;
    __weak IBOutlet UITextField *livingRoom;
    __weak IBOutlet UITextField *space;
    
    
    NSDate *fromDate;
    NSDate *toDate;
    BOOL fromDateSelected ;
    
    NSArray *cities ;
    NSArray *resevationData;
    NSArray *periodData;
    NSArray *periodMapData;
    NSArray *roomsCount;
    
    BOOL citySelected ;
    BOOL reservationSelected ;
    BOOL periodSelected ;
    BOOL roomSelected;
    BOOL arrangeSelected ;
    
    NSString *startDate ;
    NSString *endDate ;
    NSString *Type;
    NSString *TimePeriod;
    
    UILabel *toolBarTitle ;
    
    BOOL isLastPage ;
    int lastPageIndex ;
    BOOL readFromAdvancedSearch;
    
    __weak IBOutlet UITableView *facilitiesList ;
    __weak IBOutlet UILabel *noSearchResult;
}

@property (strong, nonatomic) PBWebViewController *webViewController;
@property (strong, nonatomic) NSMutableArray *facilities;
@property (strong, nonatomic) NSMutableArray *selectedFacilities;
@property (weak  , nonatomic) IBOutlet UIButton *advancedSearchBtn;

@end

@implementation ResultViewController

- (void)viewDidAppear:(BOOL)animated
{
    NSString *query = @"SELECT * FROM Cities";
    [[Database getObject] databaseSelectQuery:query withDelegate:self AndRowDelegate:self];
    cityTxt.text = self.searchParaData.City;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    cities = [NSArray new];
    self.Lounges = [NSMutableArray new];
    self.selectedFacilities = [NSMutableArray new];
    
    resevationData = @[@"نصف يوم",@"يوم واحد",@"أكثر من يوم"];
    periodData     = @[@"صباحا",@"مساء"];
    periodMapData  = @[@"Morning",@"Evening"];
    roomsCount     = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"+10"];
    sortingData    = @[@"الأحدث",@"الأسعار(الأقل إلي الأعلي)",@"الأسعار(الأعلي إلي الأقل)"];
    sortingMapData = @[@"Popular",@"Price_Low",@"Price_High"];
    
    [self configureUI];
    
    [self configureData];
    
    [self getAllFacilities];
    
    [self nextPage];
}

- (void)getAllFacilities
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [hud setLabelText:@""];
    
    [[WebDataRepository sharedInstance]getFacilities:^(id result)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dic = result;
       
        NSArray * facilitiesArray = [dic objectForKey:@"Data"];
      
        self.facilities = [NSMutableArray new];
        
        [facilitiesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             NSDictionary* item = obj;
             [self.facilities addObject:[[FacilityModel alloc] initWithDictionary:item]];
         }];

        [facilitiesList reloadData];
        
        facilitiesList.frame = CGRectMake(facilitiesList.frame.origin.x, facilitiesList.frame.origin.y, facilitiesList.frame.size.width, 39.0f *self.facilities.count);
        
        self.advancedSearchBtn.frame = CGRectMake(self.advancedSearchBtn.frame.origin.x, facilitiesList.frame.origin.y + facilitiesList.frame.size.height + 14.0f, self.advancedSearchBtn.frame.size.width, self.advancedSearchBtn.frame.size.height);
        
        [contentView setContentSize:CGSizeMake(contentView.frame.size.width, self.advancedSearchBtn.frame.origin.y + 120.0f)];

    } andFailure:^(NSString *message){
        NSLog(@"%@",message);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)configureData
{
    lastPageIndex = 1 ;
    isLastPage = NO ;
    readFromAdvancedSearch = NO ;
    
    if (self.searchParaData.Singles != nil)
    {
        youthBtn.selected = YES ;
    }
    else if (self.searchParaData.Family != nil)
    {
        familyBtn.selected = YES ;
    }
    else if (self.searchParaData.Events != nil)
    {
        eventBtn.selected = YES ;
    }

    //Setting Previous search para values
    startDate   = self.searchParaData.DateFrom;
    endDate     = self.searchParaData.DateTo;
    Type        = self.searchParaData.Type;
    TimePeriod  = self.searchParaData.Time;
    sortingKind = self.searchParaData.SortBy;
    
    fromDateSelected = YES ;
    [self setDate:self.startFromDate];
    
    int x = [Type intValue];
    if (x == 2)
    {
        toDateView.hidden = NO ;
        secondDateHeader.hidden = NO ;
        fromDateSelected = NO ;
        [self setDate:self.endToDate];
        fromDateSelected = YES ;
    }
    
    reservationTypTxt.text = resevationData[x];
    if (TimePeriod.length > 0)
    {
        periodView.hidden = NO ;
        if ([TimePeriod isEqualToString:@"Morning"])
        {
            periodTxt.text  = @"صباحا";
        }
        else if([TimePeriod isEqualToString:@"Evening"])
        {
            periodTxt.text  = @"مساء";
        }
    }
}

- (void)configureUI
{
    facilitiesList.tag = 20 ;
    facilitiesList.allowsMultipleSelection = YES;
    
    dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 700,self.view.frame.size.width , 206.0f)];
    dataPicker.dataSource = self;
    dataPicker.delegate = self;
    dataPicker.showsSelectionIndicator = YES;
    dataPicker.backgroundColor =  RGBA(238, 238, 238, 1);
    dataPicker.tag = 0 ;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    [toolBar setTintColor:[UIColor whiteColor]];
    [toolBar setBarTintColor:RGBA(47, 120, 143, 1)];
    
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"تم" style:UIBarButtonItemStylePlain target:self action:@selector(setPickerData:)];
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
    else if (IS_IPHONE_6P){
        fixedItem.width = (self.view.frame.size.width - 160.0f) / 2.0f;
    }
    
    toolBarTitle.text = @"الترتيب";
    toolBar.items = @[barButtonDone,fixedItem,typeField];
    
    arrangeTxt.inputView = dataPicker ;
    arrangeTxt.inputAccessoryView = toolBar;
    
    cityTxt.inputView = dataPicker ;
    cityTxt.inputAccessoryView = toolBar;
    
    reservationTypTxt.inputView = dataPicker ;
    reservationTypTxt.inputAccessoryView = toolBar;
    
    periodTxt.inputView = dataPicker;
    periodTxt.inputAccessoryView = toolBar;
    
    bedRooms.inputView = dataPicker;
    bedRooms.inputAccessoryView = toolBar;
    
    pathRooms.inputView = dataPicker;
    pathRooms.inputAccessoryView = toolBar;
    
    kitchenRoom.inputView = dataPicker;
    kitchenRoom.inputAccessoryView = toolBar;
    
    livingRoom.inputView = dataPicker;
    livingRoom.inputAccessoryView = toolBar;
    
    space.inputView = dataPicker;
    space.inputAccessoryView = toolBar;
    
    [arrangeBtn setTitle:@"الأحدث" forState:UIControlStateNormal];
    
    searchResultCount.text = [NSString stringWithFormat:@"نتائج البحث %lu",(unsigned long)_Lounges.count];
    searchResultCount2.text = [NSString stringWithFormat:@"نتائج البحث %lu",(unsigned long)_Lounges.count];

    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setFromDatePicker)];
    tapGuesture.numberOfTapsRequired = 1;
    [fromDateView addGestureRecognizer:tapGuesture];
    
    UITapGestureRecognizer *tapGuesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setToDatePicker)];
    tapGuesture2.numberOfTapsRequired = 1;
    [toDateView addGestureRecognizer:tapGuesture2];
    
    
    UISwipeGestureRecognizer *swipeGuesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideAdvancedSearch)];
    swipeGuesture.direction = UISwipeGestureRecognizerDirectionRight ;
    [advancedSearchView addGestureRecognizer:swipeGuesture];
}

- (void)hideAdvancedSearch
{
    [UIView animateWithDuration:0.5f animations:^{
        
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:1.0f animations:^{
            
            if(IS_IPHONE_5)
            {
                advancedSearchView.frame = CGRectMake(700.0f, 0.0f, 322.0f,504.0f);
            }
            
            if(IS_IPHONE_6)
            {
                advancedSearchView.frame = CGRectMake(700.0f, 0.0f, 322.0f,603.0f);
            }
            
            if(IS_IPHONE_6P)
            {
                advancedSearchView.frame = CGRectMake(700.0f, 0.0f, 356.0f,672.0f);
            }
            
        } completion:^(BOOL finished) {
            
        }];
    }];
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

- (void)setPickerData:(id)sender
{
    if ([arrangeTxt isFirstResponder]) {
        
        [self.Lounges removeAllObjects];
        self.searchParaData.SortBy = sortingKind;
        
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        [hud setLabelText:@""];
//        
//        [[WebDataRepository sharedInstance] searchForLounge:self.searchParaData :^(id result) {
//            
//            SearchResult *response = [SearchResult modelFromJSONDictionary:result];
        
//            NSArray *resultArray = [NSArray new];
//            
//            if (response.Data != nil)
//            {
//                resultArray = response.Data ;
//            }
            [self nextPage];
//            self.Lounges = resultArray ;
        
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//            [loungeList reloadData];
        
//        } andFailure:^(NSString *message) {
//            
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//        }];
        
    }else if ([cityTxt isFirstResponder]) {
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

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 20)
    {
        return self.facilities.count ;
    } else {
        return self.Lounges.count ;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"LoungeCell";
    static NSString *CellIdentifier2  = @"FacilityCell";
    
    LoungeCell *cell        = (LoungeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    FacilityCell *cell2     = (FacilityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];

    if (tableView.tag == 20)
    {
        if (cell2 == nil)
        {
            cell2 = (FacilityCell *)[[[NSBundle mainBundle] loadNibNamed:@"FacilityCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        FacilityModel *model = _facilities[indexPath.row];
        
        if ([self.selectedFacilities containsObject:model.ID])
        {
            cell2.checkMarkImage.image = [UIImage imageNamed:@"active-checkbox.png"];
        }
        else
        {
            cell2.checkMarkImage.image = [UIImage imageNamed:@"inactive-checkbox.png"];
        }
        
        cell2.facilityTitle.text = model.type ;
        return cell2;
    
    }else{
        
        if (cell == nil)
        {
            cell = (LoungeCell *)[[[NSBundle mainBundle] loadNibNamed:@"LoungeCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        SearchData *result = _Lounges[indexPath.row];
        
        cell.delegate = self;
        [cell setLoungeData:result];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.Lounges.count - 1 && !isLastPage)
    {
        lastPageIndex++ ;
        [self nextPage];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 20)
    {
        FacilityModel *model = self.facilities[indexPath.row];
        if ([self.selectedFacilities containsObject:model.ID])
        {
            [self.selectedFacilities removeObject:model.ID];
        }else{
            [self.selectedFacilities addObject:model.ID];
        }
        
        [facilitiesList reloadData];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        SearchData *result = _Lounges[indexPath.row];
        SearchDetailsViewController *searchDetail = [[SearchDetailsViewController alloc]initWithNibName:@"SearchDetailsViewController" bundle:[NSBundle mainBundle]];
        searchDetail.istrahaID = [NSString stringWithFormat:@"%i",result.IstrahaID];
        [self.navigationController pushViewController:searchDetail animated:YES];
    }
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
    }else if (arrangeSelected){
        return sortingData.count;
    }else if (roomSelected){
        return roomsCount.count ;
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
                periodView.hidden = NO;
        }else{
                periodView.hidden = YES;
        }
        
        toDateView.hidden = YES;
        secondDateHeader.hidden = YES ;
        if(row == 2)
        {
            toDate = [NSDate date];
            toDateView.hidden = NO;
            secondDateHeader.hidden = NO ;
        }
    }
    else if (periodSelected)
    {
        periodTxt.text = periodData[row];
        TimePeriod     = periodMapData[row];
    
    }
    else if (arrangeSelected)
    {
        lastPageIndex = 1 ;
        isLastPage = NO ;
        
        [arrangeBtn setTitle:sortingData[row] forState:UIControlStateNormal];
        sortingKind = sortingMapData[row];
   
    }else if (roomSelected) {
        
        if ([bedRooms isFirstResponder])
        {
            bedRooms.text = roomsCount[row];
        }
        else if ([pathRooms isFirstResponder])
        {
            pathRooms.text = roomsCount[row];

        }else if ([kitchenRoom isFirstResponder])
        {
            kitchenRoom.text = roomsCount[row];

        }else if ([livingRoom isFirstResponder])
        {
            livingRoom.text = roomsCount[row];

        }else if ([space isFirstResponder])
        {
            space.text = roomsCount[row];

        }
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
    else if (arrangeSelected)
    {
        title = sortingData[row];
    }
    else if (roomSelected)
    {
        title = roomsCount[row];
    }
    return title ;
}

#pragma mark - BookDelegate
- (void)bookNow:(NSString *)key
{
    self.webViewController = [[PBWebViewController alloc] init];
    PBSafariActivity *activity = [[PBSafariActivity alloc] init];
    self.webViewController.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://istrahti.com/details.aspx?key=%@",key]];
    self.webViewController.applicationActivities = @[activity];
    self.webViewController.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo];
    [self.navigationController pushViewController:self.webViewController animated:YES];
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


#pragma mark - TextFieldDelegate

// This code handles the scrolling when tabbing through input fields
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
            toolBarTitle.text = @"اختر الدولة";
            citySelected = YES ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = NO ;
            arrangeSelected = NO ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break;
        case 1:
            toolBarTitle.text = @"أدخل السعر";
            break;
        case 2:
            toolBarTitle.text = @"أدخل السعر";
            break;
        case 3:
            toolBarTitle.text = @"نوع الحجز";
            citySelected = NO ;
            reservationSelected = YES ;
            periodSelected = NO ;
            roomSelected = NO ;
            arrangeSelected = NO ;
            [dataPicker selectRow:1 inComponent:0 animated:NO];
            break;
        case 4:
            toolBarTitle.text = @"اختر الفترة";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = YES ;
            roomSelected = NO ;
            arrangeSelected = NO ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break;
        case 5:
            toolBarTitle.text = @"غرف نوم";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = YES ;
            arrangeSelected = NO ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break ;
        case 6:
            toolBarTitle.text = @"حمامات";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = YES ;
            arrangeSelected = NO ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break ;
        case 7:
            toolBarTitle.text = @"مطبخ";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = YES ;
            arrangeSelected = NO ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break ;
        case 8:
            toolBarTitle.text = @"غرف المعيشة";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = YES ;
            arrangeSelected = NO ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break ;
        case 9:
            toolBarTitle.text = @"المساحة";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = YES ;
            arrangeSelected = NO ;
            
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break ;
        case 12:
            toolBarTitle.text = @"الترتيب";
            citySelected = NO ;
            reservationSelected = NO ;
            periodSelected = NO ;
            roomSelected = NO ;
            arrangeSelected = YES ;
            [dataPicker selectRow:0 inComponent:0 animated:NO];
            break ;
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
        [advancedSearchView endEditing:YES];
    }
}

- (void)touchEvent:(id)sender
{
    
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

}

#pragma mark - Actions
- (IBAction)showMap:(id)sender
{
    if (_displayList) {
        MapResultViewController *mapView = [[MapResultViewController alloc] initWithNibName:@"MapResultViewController" bundle:nil];
        mapView.displayMap = NO ;
        UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:mapView];
        navg.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:navg animated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)arrangeResult:(id)sender
{
    [arrangeTxt becomeFirstResponder];
}

- (IBAction)showAdvancedSearch:(id)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0f animations:^{
            
            if(IS_IPHONE_5)
            {
                advancedSearchView.frame = CGRectMake(45.0f, 0.0f, 275.0f,504.0f);
            }
            
            if(IS_IPHONE_6)
            {
                advancedSearchView.frame = CGRectMake(53.0f, 0.0f, 322.0f,603.0f);
            }
            
            if(IS_IPHONE_6P)
            {
                advancedSearchView.frame = CGRectMake(59.0f, 0.0f, 356.0f,672.0f);
            }
            
        } completion:nil];
        
    }];

}

- (IBAction)advancedSearchAction:(id)sender
{
    isLastPage = NO ;
    lastPageIndex = 1 ;
    readFromAdvancedSearch = YES ;
    [self.Lounges removeAllObjects];
    
    [UIView animateWithDuration:0.5f animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0f animations:^{
            
            if(IS_IPHONE_5)
            {
                advancedSearchView.frame = CGRectMake(700.0f, 0.0f, 322.0f,504.0f);
            }
            
            if(IS_IPHONE_6)
            {
                advancedSearchView.frame = CGRectMake(700.0f, 0.0f, 322.0f,603.0f);
            }
            
            if(IS_IPHONE_6P)
            {
                advancedSearchView.frame = CGRectMake(700.0f, 0.0f, 356.0f,672.0f);
            }
            
        } completion:^(BOOL finished) {
            
            [self nextPage];
            
        }];
    }];
}

- (void)nextPage
{
    if (readFromAdvancedSearch)
    {
        readFromAdvancedSearch = NO ;
        
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
            self.searchParaData.HalfDay = true ;
            
            if(![Validation validTime:TimePeriod])
            {
                return ;
            }
        }else{
            self.searchParaData.HalfDay = false ;
        }
        
        self.searchParaData.City = cityTxt.text;
        self.searchParaData.DateFrom = startDate ;
        self.searchParaData.DateTo = endDate ;
        self.searchParaData.Type = Type ;
        self.searchParaData.Time = TimePeriod;
        self.searchParaData.Page = lastPageIndex;
        self.searchParaData.SortBy = sortingKind;
        
        if (youthBtn.selected)
        {
            self.searchParaData.Singles = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.Singles = NULL ;
        }
        
        if (familyBtn.selected)
        {
            self.searchParaData.Family = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.Family = NULL ;
        }
        
        if (eventBtn.selected)
        {
            self.searchParaData.Events = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.Events = NULL ;
        }
        
        if (swimmingBoolBtn.selected)
        {
            self.searchParaData.SwimmingPool = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.SwimmingPool = NULL ;
        }
        
        if (swimmingBoolWomenBtn.selected)
        {
            self.searchParaData.WomenSwimming = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.WomenSwimming = NULL ;
        }
        
        if (playGroundKidsBtn.selected)
        {
            self.searchParaData.KidsPlay = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.KidsPlay = NULL ;
        }
        
        if (seperationBtn.selected)
        {
            self.searchParaData.Seperation = [NSNumber numberWithBool:YES]; ;
        }else{
            self.searchParaData.Seperation = NULL ;
        }
        
        if (bedRooms.text.length > 0)
        {
            self.searchParaData.Bedrooms  = [NSNumber numberWithInt:[bedRooms.text intValue]];
        }else{
            self.searchParaData.Bedrooms  = NULL ;
        }
        
        if (livingRoom.text.length > 0)
        {
            self.searchParaData.Livingrooms  = [NSNumber numberWithInt:[livingRoom.text intValue]];
        }else{
            self.searchParaData.Livingrooms  = NULL ;
        }
        
        if (pathRooms.text.length > 0)
        {
            self.searchParaData.Bathrooms  = [NSNumber numberWithInt:[pathRooms.text intValue]];
        }else{
            self.searchParaData.Bathrooms  = NULL ;
        }
        
        if (kitchenRoom.text.length > 0)
        {
            self.searchParaData.Kitchens  = [NSNumber numberWithInt:[kitchenRoom.text intValue]];
        }else{
            self.searchParaData.Kitchens   = NULL ;
        }
        
        if (space.text.length > 0)
        {
            self.searchParaData.Space  = [NSNumber numberWithDouble:[space.text doubleValue]];
        }else{
            self.searchParaData.Space  = NULL ;
        }

    }else{
        self.searchParaData.Page = lastPageIndex ;
    }

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [hud setLabelText:@""];
    
    [[WebDataRepository sharedInstance] searchForLounge:self.searchParaData :^(id result) {
        
        SearchResult *response = [SearchResult modelFromJSONDictionary:result];
        
        NSArray *resultArray = [NSArray new];
        
        if (response.Data != nil)
        {
            resultArray = response.Data ;
        }
        
        if (resultArray.count == 0)
        {
            isLastPage = YES ;
        }
       
        NSRange range = NSMakeRange([self.Lounges count],resultArray.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.Lounges insertObjects:resultArray atIndexes:indexSet];
        if (self.Lounges.count)
        {
            noSearchResult.hidden = NO ;
        }
        else
        {
           noSearchResult.hidden = NO ;
        }
        
        [loungeList reloadData];
        
        searchResultCount.text = [NSString stringWithFormat:@"نتائج البحث %lu",(unsigned long)_Lounges.count];
        searchResultCount2.text = [NSString stringWithFormat:@"نتائج البحث %lu",(unsigned long)_Lounges.count];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [loungeList reloadData];
        
    } andFailure:^(NSString *message) {
        
        isLastPage = NO ;
        if (lastPageIndex < 1) {
            lastPageIndex--;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (IBAction)SelectType:(id)sender
{
    switch ([sender tag]) {
        case 0:
            if (youthBtn.selected) {
                youthBtn.selected = NO ;
            }else{
                youthBtn.selected = YES ;
            }
            break;
        case 1:
            if (familyBtn.selected) {
                familyBtn.selected = NO ;
            }else{
                familyBtn.selected = YES ;
            }
            break;
        case 2:
            if (eventBtn.selected) {
                eventBtn.selected = NO ;
            }else{
                eventBtn.selected = YES ;
            }
            break ;
        case 3:
            if (swimmingBoolBtn.selected) {
                swimmingBoolBtn.selected = NO ;
            }else{
                swimmingBoolBtn.selected = YES ;
            }
            break;
        case 4:
            if (swimmingBoolWomenBtn.selected) {
                swimmingBoolWomenBtn.selected = NO ;
            }else{
                swimmingBoolWomenBtn.selected = YES ;
            }
            break;
        case 5:
            if (playGroundKidsBtn.selected) {
                playGroundKidsBtn.selected = NO ;
            }else{
                playGroundKidsBtn.selected = YES ;
            }
            break ;
        case 6:
            if (seperationBtn.selected) {
                seperationBtn.selected = NO ;
            }else{
                seperationBtn.selected = YES ;
            }
            break ;
        default:
            break;
    }
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
