//
//  AppInfoViewController.m
//  DataContainer
//
//  Created by Liu Junqi on 12/28/17.
//  Copyright © 2017 DeviLeo. All rights reserved.
//

#import "AppInfoViewController.h"
#import "AppInfo.h"

@interface AppInfoViewController ()

@property (nonatomic, weak) IBOutlet UITextView *tvDetail;

@end

@implementation AppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tvDetail.text = [_appInfo description];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
