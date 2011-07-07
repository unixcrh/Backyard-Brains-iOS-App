//
//  ContinuousWaveView.m
//  oScope
//
//  Created by Alex Wiltschko on 10/30/09.
//  Modified by Zachary King
//      6/27/2011 Added LarvaJolt stimulation controller.
//  Copyright 2009 Backyard Brains. All rights reserved.
//

#import "ContinuousWaveViewController_iPhone.h"

@implementation ContinuousWaveViewController_iPhone

- (void)dealloc {	
    [super dealloc];
	

}

# pragma mark - Delegate method

- (void)flipsideIsDone {
	
	[self dismissModalViewControllerAnimated:YES];
}

# pragma mark - IBActions

- (IBAction)displayInfoFlipside:(UIButton *)sender {
	
	FlipsideInfoViewController *flipController = [[FlipsideInfoViewController alloc] initWithNibName:@"FlipsideInfoView" bundle:nil];
	flipController.delegate = self;
	flipController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:flipController animated:YES];
	[flipController release];	
	
}


- (IBAction)showFiles:(UIButton *)sender {
	
	[self.audioSignalManager pause];
	
	BBFileViewController *theViewController	= [[BBFileViewController alloc] initWithNibName:@"BBFileView" bundle:nil];
	theViewController.delegate = (id)self;
	UINavigationController *theNavigationController = [[UINavigationController alloc] initWithRootViewController:theViewController];
	
	theNavigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:theNavigationController animated:YES];
	
	[theViewController release];
	[theNavigationController release];
	
}

- (void)hideFiles {
	// This is also a delegate action	
	[self dismissModalViewControllerAnimated:TRUE];		
	[self.audioSignalManager play];
	
}

- (IBAction)showLarvaJolt:(UIButton *)sender {
    
	[self.audioSignalManager pause];
    
    if (!self.larvaJoltController)
    {
        self.larvaJoltController = [[LarvaJoltViewController alloc] initWithNibName:@"LarvaJoltViewController" bundle:nil];
        self.larvaJoltController.delegate = self;
        self.larvaJoltController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    [self presentModalViewController:self.larvaJoltController animated:YES];
    
}

- (void)hideLarvaJolt {
	[self.audioSignalManager play];
}




@end
