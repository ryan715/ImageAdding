//
//  ViewController.m
//  ImageAddingDemo
//
//  Created by ryan on 1/14/16.
//  Copyright © 2016 ryan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  NSArray *tableData;
  NSArray *thumbnails;
}
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
  [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  tableData = [NSArray
      arrayWithObjects:@"欧式风格主卧", @"欧美风格客厅",
                       @"欧美风格客厅", @"现代风格主卧",
                       @"现代风格主卧", @"现代风格主卧", nil];
  thumbnails = [NSArray arrayWithObjects:@"c1.jpg", @"c2.jpg", @"c3.jpg",
                                         @"c4.jpg", @"c5.jpg", @"c6.jpg", nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *simpleTableIdentifier = @"SimpleTableItem";

  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:simpleTableIdentifier];
  }
  [cell.imageView
      setImage:[UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]]];
  cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"toDesignVC" sender:self];
}

@end
