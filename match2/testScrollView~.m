//
//  testScrollView.m
//  match2
//
//  Created by Luo Feiheng on 7/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import "testScrollView.h"

@interface testScrollView ()

@end

@implementation testScrollView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollView= (UIScrollView *)[self.view viewWithTag:99];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setScrollEnabled:YES];
    scrollView.alwaysBounceVertical=YES;
    [scrollView setShowsVerticalScrollIndicator:YES];
    [scrollView setIndicatorStyle:UIScrollViewIndicatorStyleDefault];
    scrollView.backgroundColor=[UIColor clearColor];
    //scrollView.autoresizesSubviews=YES;
    scrollView.contentSize=CGSizeMake(320, 600);
    //[self.view addSubview:scrollView];
    
    
    UILabel *label3 = (UILabel *)[self.view viewWithTag:777];
    label3.font = [UIFont boldSystemFontOfSize:20.0f];
    label3.numberOfLines=0;
    label3.textColor = [UIColor blueColor];
    label3.textAlignment = NSTextAlignmentLeft;
    NSString *str =@"Andyajkflasjfklasjkfla\n\nAFAFAASF\n\n\n\n\n\n\n\njaklsfjlkas";
    
    CGSize size = [str sizeWithFont:label3.font constrainedToSize:CGSizeMake(label3.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [label3 setFrame:CGRectMake(0, 0, 200, size.height)];
    //label3 = (UILabel *)[self.view viewWithTag:777];
    label3.text = str;
    //label3.lineBreakMode =  UILineBreakModeCharacterWrap;
    
    //label3.textAlignment = NSTextAlignmentCenter;
    //label3.adjustsFontSizeToFitWidth = NO;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
