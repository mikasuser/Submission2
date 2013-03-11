//
//  LocationTrackerFlipsideViewController.m
//  LocationTracker
//
//  Created by miwa on 3/10/13.
//  Copyright (c) 2013 mw. All rights reserved.
//

#import "LocationTrackerFlipsideViewController.h"

@interface LocationTrackerFlipsideViewController ()

@end

@implementation LocationTrackerFlipsideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)UIDistSlider:(UISlider *)sender {
}
@end
