//
//  MapResultViewController.m
//  Istrahti
//
//  Created by Ahmed Askar on 8/19/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "MapResultViewController.h"
#import "ResultViewController.h"

@interface MapResultViewController () <CLLocationManagerDelegate,MKMapViewDelegate>
{
    dispatch_queue_t queue;
}

@property (nonatomic ,weak) IBOutlet MKMapView *mapView ;
@property (nonatomic, strong) CLLocationManager *locationManager ;
@end

@implementation MapResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!_displayMap) {
        self.backBtn.hidden = YES ;
    }

    _mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
  
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    //[self.locationManager startUpdatingLocation];

    _mapView.showsUserLocation = YES;
    
    [self setMapRegion];
    
    _sitesAnnotations = [[NSMutableArray alloc] init];

    LocationModel *location1 = [[LocationModel alloc] init];
    location1.title  = @"manar";
    location1.latitude = 24.724572f;
    location1.longitude = 46.799093f;
    
    LocationModel *location2 = [[LocationModel alloc] init];
    location2.title  = @"garer";
    location2.latitude = 24.678608f;
    location2.longitude = 46.749229f;
    
    LocationModel *location3 = [[LocationModel alloc] init];
    location3.title  = @"zahraa";
    location3.latitude = 24.686684f;
    location3.longitude = 46.729447f;
    
    LocationModel *location4 = [[LocationModel alloc] init];
    location4.title  = @"El rabwah";
    location4.latitude = 24.694729f;
    location4.longitude = 46.762331f;
    
    LocationModel *location5 = [[LocationModel alloc] init];
    location5.title  = @"El malaz";
    location5.latitude = 24.665280;
    location5.longitude = 46.732503;
    
    [_sitesAnnotations addObject:location1];
    [_sitesAnnotations addObject:location2];
    [_sitesAnnotations addObject:location3];
    [_sitesAnnotations addObject:location4];
    [_sitesAnnotations addObject:location5];
    
    queue = dispatch_queue_create("WeGuide",nil);
    
    [self nearLocations];
}

#pragma mark - GenerateAnnotations
- (NSArray *)generateAnnotations:(NSArray *)array
{
    NSMutableArray *annotations = [NSMutableArray new];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        LocationModel *location = obj ;
        
        MapAnnotation *annotation = [MapAnnotation new];
        
        [annotation setSite:location];
        
        [annotations addObject:annotation];
    }];
    return annotations ;
}

- (void)nearLocations
{
    dispatch_async(queue, ^{
        
        NSArray *locations = [self generateAnnotations:_sitesAnnotations];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView removeAnnotations:_mapView.annotations];
            [self.mapView addAnnotations:locations];
        });
    });
}

- (BOOL)locationEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

#pragma mark -
#pragma mark MKMapViewDelegate methods

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView	{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView	{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error	{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%f", userLocation.coordinate.latitude);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation	{
    
    MapAnnotation* myAnnotation 			= (MapAnnotation *)annotation;
    NSString *identifier					= @"annotation";
    MKPinAnnotationView *newAnnotationView 	= (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(newAnnotationView == nil) {
        
        newAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:identifier];
        [newAnnotationView setCanShowCallout:YES];
//        [newAnnotationView setAnimatesDrop:YES];
    }
    
    if ([annotation isKindOfClass:[MKUserLocation class]])  {
        
        return nil;
    } else {
        [newAnnotationView setImage:[UIImage imageNamed:@"map-pin.png"]];
    }
    
    return newAnnotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control	{
    
    if ([view.annotation isKindOfClass:[MapAnnotation class]]) {
        
        _tappedAnnotation = (MapAnnotation *)view.annotation;
    }
}

#pragma mark -
#pragma mark CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error	{
    
    NSLog(@"%@",error.localizedDescription);

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"didUpdateLocations: %@", [locations lastObject]);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        
    } else if (status == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location services not authorized"
                                                        message:@"This app needs you to authorize locations services to work."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else
        NSLog(@"Wrong location status");
}

#pragma mark -
#pragma mark Private methods
- (void)setMapRegion
{
    CLLocationCoordinate2D initialCoordinate;
    
    //    initialCoordinate.latitude = _mapView.userLocation.location.coordinate.latitude;
    //    initialCoordinate.longitude = _mapView.userLocation.location.coordinate.longitude;
    initialCoordinate.latitude = 24.626954f;
    initialCoordinate.longitude = 46.645935f;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialCoordinate, 800000, 800000);
    region = [_mapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];
    [_locationManager stopUpdatingLocation];
}

- (void)showAnnotationOnMap:(MapAnnotation *)annotation
{
    if (!_locationManager)	{
        
        //	Initialize location manager
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDistanceFilter:50.0f];
    }
    
    [_mapView addAnnotation:annotation];
    CLLocation *location = [_mapView.userLocation location];
    [self adjustZoomLevel:location annotation:annotation];
}

- (void)adjustZoomLevel:(CLLocation *)currentLocation annotation:(MapAnnotation *)annotation
{
    CLLocationCoordinate2D southWest = currentLocation.coordinate;
    CLLocationCoordinate2D northEast = southWest;
    
    southWest.latitude = MIN(southWest.latitude, annotation.coordinate.latitude);
    southWest.longitude = MIN(southWest.longitude, annotation.coordinate.longitude);
    
    northEast.latitude = MAX(northEast.latitude, annotation.coordinate.latitude);
    northEast.longitude = MAX(northEast.longitude, annotation.coordinate.longitude);
    
    MKCoordinateRegion region;
    region.center.latitude = northEast.latitude - (northEast.latitude - southWest.latitude) * 0.5;
    region.center.longitude = northEast.longitude + (southWest.longitude - northEast.longitude) * 0.5;
    region.span.latitudeDelta = fabs(northEast.latitude - southWest.latitude) * 2.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(southWest.longitude - northEast.longitude) * 2.1; // Add a little extra space on the sides
    
    region = [_mapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];
    [self performSelector:@selector(selectAnnotation:) withObject:annotation afterDelay:1.0f];
}

- (void)selectAnnotation:(MapAnnotation *)annotation
{
    [_mapView selectAnnotation:annotation animated:YES];
}

- (IBAction)showList:(id)sender
{
    if (_displayMap)
    {
        ResultViewController *resultView = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
        resultView.displayList = NO ;
        UINavigationController *navg = [[UINavigationController alloc] initWithRootViewController:resultView];
        navg.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:navg animated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
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
