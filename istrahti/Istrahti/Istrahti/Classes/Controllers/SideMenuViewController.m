//
//  SideMenuViewController.m
//  Estra7ty
//
//  Created by Ahmed Askar on 8/17/15.
//  Copyright (c) 2015 Ahmed Askar. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuViewCell.h"
#import "AboutViewController.h"

@interface SideMenuViewController ()
{
    __weak IBOutlet UITableView *sideList ;
    __weak IBOutlet UITextField *istrahaTxt ;
    
    NSArray *array ;
}
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    array = [NSArray arrayWithObjects:@"SearchViewController",
             @"AboutViewController",
             @"ContactUsViewController",
             nil];
    
    istrahaTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"البحث عن الإستراحات" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self preferredStatusBarStyle];
}

- (IBAction)deleteSearch:(id)sender
{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent ;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier  = @"SideMenuViewCell";
    
    SideMenuViewCell *cell = (SideMenuViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        cell = (SideMenuViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"SideMenuViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.icon.image = [UIImage imageNamed:@"search-icon.png"];
            cell.title.text = @"البحث عن الاستراحات";
            
            break;
        case 1:
            cell.icon.image = [UIImage imageNamed:@"about-icon.png"];
            cell.title.text = @"عن استراحتي";
            
            break;
        case 2:
            cell.icon.image = [UIImage imageNamed:@"contact.png"];
            cell.title.text = @"تواصل معنا";
            break;
        case 3:
            cell.icon.image = [UIImage imageNamed:@"add-is.png"];
            cell.title.text = @"طلب إضافة استراحة";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // We know the frontViewController is a NavigationController
    // UIViewController *frontNavigationController = (id)revealController.frontViewController;  // <-- we know it is a NavigationController
    UINavigationController *frontNavigationController = (id)revealController.frontViewController;  // <-- we know it is a NavigationController
    
    NSInteger row = indexPath.row;
    
    // Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
    
    Class className = (NSClassFromString(array[row]));
    
    // Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
    if ( ![frontNavigationController.topViewController isKindOfClass:[className class]] )
    {
        id frontViewController = [[className alloc] init];
//        if ([frontViewController isKindOfClass:[AboutViewController class]])
//        {
//            frontViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
//        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
        [revealController setFrontViewController:navigationController animated:YES];
    }
    // Seems the user attempts to 'switch' to exactly the same controller he came from!
    else
    {
        [revealController revealToggle:self];
    }
    
    [sideList deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)openSocial:(id)sender
{
    switch ([sender tag])
    {
        case 0:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/Istrahti"]];
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ISTRAHTI"]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.linkedin.com/company/%D8%A7%D8%B3%D8%AA%D8%B1%D8%A7%D8%AD%D8%AA%DB%8C"]];
            break;
        case 3:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/u/0/b/115231550025405649845/115231550025405649845/about"]];
            break;
        case 4:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
            break;
        case 5:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/istrahti/"]];
            break;
        case 6:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UCrffzRJPqY8JOV936i_Mpjg"]];
            break;
        default:
            break;
    }
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
