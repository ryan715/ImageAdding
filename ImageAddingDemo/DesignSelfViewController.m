//
//  DesignSelfViewController.m
//  ImageAddingDemo
//
//  Created by ryan on 1/14/16.
//  Copyright © 2016 ryan. All rights reserved.
//

#import "DesignSelfViewController.h"
#import "KxMenu.h"
#import "MBProgressHUD.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@interface DesignSelfViewController () {
  NSInteger furnitureSeq;
  NSInteger wallSeq;
  NSInteger floorSeq;
  NSInteger roofSeq;
  NSInteger curtainSeq;
  NSInteger sofaSeq;
}
@property(nonatomic, strong) NSString *wall;
@property(nonatomic, strong) NSString *floor;
@property(nonatomic, strong) NSString *roof;
@property(nonatomic, strong) NSString *curtain;
@property(nonatomic, strong) NSString *furniture;
@property(nonatomic, strong) NSString *sofa;

@end

@implementation DesignSelfViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  // Do any additional setup after loading the view.
  [self loadBasic];
  [self customLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSNumber *value =
      [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
  [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
  // make view landscape on start
  return NO;
}

- (void)loadBasic {
  furnitureSeq = 0;
  wallSeq = 0;
  floorSeq = 0;
  roofSeq = 0;
  curtainSeq = 0;
  sofaSeq = 0;
  self.wall = [NSString stringWithFormat:@"%@%d", @"wall", wallSeq];
  self.floor = [NSString stringWithFormat:@"%@%d", @"floor", floorSeq];
  self.curtain = [NSString stringWithFormat:@"%@%d", @"curtain", curtainSeq];
  self.furniture =
      [NSString stringWithFormat:@"%@%d", @"furniture", furnitureSeq];
  self.roof = [NSString stringWithFormat:@"%@%d", @"roof", roofSeq];
  self.sofa = [NSString stringWithFormat:@"%@%d", @"sofa", sofaSeq];
}

- (void)customLoad {

  //  [self rotateController:self degrees:-90];
  //  [[UIApplication sharedApplication]
  //      setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft
  //                     animated:NO];
  //  // set it according to 3.5 and 4.0 inch screen in landscape mode
  //  [self.view setBounds:CGRectMake(0, 0, 480, 320)];
  //
  [self makeDesign];

  UIBarButtonItem *changeStyleButton =
      [[UIBarButtonItem alloc] initWithTitle:@"变更"
                                       style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(showMenu)];

  self.navigationItem.rightBarButtonItem = changeStyleButton;
}

- (void)rotateController:(UIViewController *)controller
                 degrees:(NSInteger)aDgrees {
  UIScreen *screen = [UIScreen mainScreen];
  if (aDgrees > 0)
    controller.view.bounds =
        CGRectMake(0, 0, screen.bounds.size.height, screen.bounds.size.width);
  else {
    controller.view.bounds =
        CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
  }
  controller.view.transform = CGAffineTransformConcat(
      controller.view.transform,
      CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(aDgrees)));
}

- (UIImage *)basicDesign {
  UIImage *wallImage = [UIImage imageNamed:self.wall];
  UIGraphicsBeginImageContext(wallImage.size);
  [wallImage
      drawInRect:CGRectMake(0, 0, wallImage.size.width, wallImage.size.height)];
  UIImage *floorImage = [UIImage imageNamed:self.floor];
  [floorImage drawInRect:CGRectMake(0, 0, floorImage.size.width,
                                    floorImage.size.height)];

  UIImage *curtainImage = [UIImage imageNamed:self.curtain];
  [curtainImage drawInRect:CGRectMake(0, 0, curtainImage.size.width,
                                      curtainImage.size.height)];

  UIImage *sofaImage = [UIImage imageNamed:self.sofa];
  [sofaImage
      drawInRect:CGRectMake(0, 0, sofaImage.size.width, sofaImage.size.height)];

  UIImage *furnitureImage = [UIImage imageNamed:self.furniture];
  [furnitureImage drawInRect:CGRectMake(0, 0, furnitureImage.size.width,
                                        furnitureImage.size.height)];

  UIImage *roofImage = [UIImage imageNamed:self.roof];
  [roofImage
      drawInRect:CGRectMake(0, 0, roofImage.size.width, roofImage.size.height)];

  UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resultingImage;
}

- (void)showMenu {
  NSArray *menuItems = @[

    [KxMenuItem menuItem:@"自助设计" image:nil target:nil action:NULL],

    [KxMenuItem menuItem:@"天花板"
                   image:[UIImage imageNamed:@"action_icon"]
                  target:self
                  action:@selector(changeRoof)],

    [KxMenuItem menuItem:@"地板"
                   image:nil
                  target:self
                  action:@selector(changeFloor)],

    [KxMenuItem menuItem:@"沙发背景墙"
                   image:[UIImage imageNamed:@"reload"]
                  target:self
                  action:@selector(changeSofa)],

    [KxMenuItem menuItem:@"家具"
                   image:[UIImage imageNamed:@"search_icon"]
                  target:self
                  action:@selector(changeFurniture)],

    [KxMenuItem menuItem:@"窗帘"
                   image:[UIImage imageNamed:@"home_icon"]
                  target:self
                  action:@selector(changeCurtain)],
  ];

  KxMenuItem *first = menuItems[0];
  first.foreColor = [UIColor colorWithRed:47 / 255.0f
                                    green:112 / 255.0f
                                     blue:225 / 255.0f
                                    alpha:1.0];
  first.alignment = NSTextAlignmentCenter;
  UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
  UIView *view = [item valueForKey:@"view"];
  [KxMenu showMenuInView:self.view fromRect:view.frame menuItems:menuItems];
}

- (void)changeFloor {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (floorSeq < 2) {
    floorSeq++;
  } else {
    floorSeq = 0;
  }
  self.floor = [NSString stringWithFormat:@"%@%d", @"floor", floorSeq];

  [self makeDesign];
}

- (void)changeRoof {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (roofSeq < 2) {
    roofSeq++;
  } else {
    roofSeq = 0;
  }
  self.roof = [NSString stringWithFormat:@"%@%d", @"roof", roofSeq];

  [self makeDesign];
}

- (void)changeSofa {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (sofaSeq < 2) {
    sofaSeq++;
  } else {
    sofaSeq = 0;
  }
  self.sofa = [NSString stringWithFormat:@"%@%d", @"sofa", sofaSeq];

  [self makeDesign];
}

- (void)changeCurtain {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (curtainSeq < 2) {
    curtainSeq++;
  } else {
    curtainSeq = 0;
  }
  self.curtain = [NSString stringWithFormat:@"%@%d", @"curtain", curtainSeq];

  [self makeDesign];
}

- (void)changeFurniture {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  if (furnitureSeq < 2) {
    furnitureSeq++;
  } else {
    furnitureSeq = 0;
  }
  self.furniture =
      [NSString stringWithFormat:@"%@%d", @"furniture", furnitureSeq];
  [self makeDesign];
}

- (void)makeDesign {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                 ^{
                   UIImage *desigenImage = [self basicDesign];
                   if (desigenImage != nil) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                       self.basicImage.image = desigenImage;
                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                     });
                   }
                 });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
