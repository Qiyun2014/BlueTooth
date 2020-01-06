//
//  ViewController.m
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "ViewController.h"
#import "CBTCentralManager.h"

@interface ViewController ()

@property (strong, nonatomic) CBTCentralManager *centralManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.centralManager = [[CBTCentralManager alloc] init];
}


@end
