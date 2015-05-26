//
//  ViewController.m
//  Realm
//
//  Created by JHY on 2015. 4. 10..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

DBManager* manager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    manager = [[DBManager alloc] init];
    
    NSLog(@"%@", [RLMRealm defaultRealmPath]);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
