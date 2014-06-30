//
//  ViewController.m
//  MAMapsDemo
//
//  Created by Paul Napier on 30/06/2014.
//  Copyright (c) 2014 madapper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(CGRect)getFrame{
    
    
    
    CGRect rect = CGRectMake(0, 20 + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-20);
    return rect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    views = @[@"ScrollView",@"MapView"];
    
    tv = [[UITableView alloc]initWithFrame:[self getFrame] style:UITableViewStylePlain];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
    
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    tv.frame = [self getFrame];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    tv.frame = [self getFrame];
}

#pragma mark - UITableViewMethods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return views.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = views[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    [self performSegueWithIdentifier:views[indexPath.row] sender:self];
}

@end
