//
//  VCScrollView.m
//  TestMAMaps
//
//  Created by Paul Napier on 30/06/2014.
//  Copyright (c) 2014 MadApper. All rights reserved.
//

#import "VCScrollView.h"

@interface VCScrollView ()

@end

@implementation VCScrollView

-(CGRect)getFrame{
    CGRect rect = CGRectMake(0, 20 + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-20);
    return rect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView = [[UIScrollView alloc]initWithFrame:[self getFrame]];
    [self.view addSubview:scrollView];

    MAMapsShape *shape = [[MAMapsShape alloc]initWithShapes:MAMapShapeWorldFull];
    
    MAMapsButtons *buttons = [[MAMapsButtons alloc]initWithShape:shape scale:5 border:true view:scrollView];
    
    NSLog(@"%@",buttons.buttonsByName.allKeys);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    scrollView.frame = [self getFrame];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    scrollView.frame = [self getFrame];
}

@end
