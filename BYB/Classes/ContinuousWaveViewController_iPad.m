//
//  ContinuousWaveView.m
//  oScope
//
//  Created by Alex Wiltschko on 10/30/09.
//  Modified by Zachary King
//      6/27/2011 Added LarvaJolt stimulation controller.
//  Copyright 2009 Backyard Brains. All rights reserved.
//

#import "ContinuousWaveViewController_iPad.h"

@implementation ContinuousWaveViewController_iPad

@synthesize recordedFilesPopover, larvaJoltPopover;

- (void)dealloc {	
    [super dealloc];
	
    [fileViewController release];
    [recordedFilesPopover release];
    [larvaJoltPopover release];
}

- (IBAction)displayInfoPopover:(UIButton *)sender {
	
    [self.audioSignalManager pause];
    
	FlipsideInfoViewController *flipController = [[FlipsideInfoViewController alloc] initWithNibName:@"FlipsideInfoView" bundle:nil];
	flipController.delegate = self;
	flipController.modalPresentationStyle = UIModalPresentationFormSheet;
	flipController.view.frame = CGRectMake(0, 0, 620, 540);
	[self presentModalViewController:flipController animated:YES];
	[flipController release];
	
	[self.audioSignalManager pause];
}

//for FlipsideInfoViewDelegate
- (void)flipsideIsDone
{
	[self dismissModalViewControllerAnimated:YES];
	[self.audioSignalManager play];
}


- (IBAction)showFilePopover:(UIButton *)sender {
	
	[self.audioSignalManager pause];
	
	
    if (!self.recordedFilesPopover)
    {
        
        if (!fileViewController)
        {
            self.fileViewController = [[BBFileViewController alloc] initWithNibName:@"BBFileView" bundle:nil];
            self.fileViewController.delegate = (id)self;
            
            //self.fileViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        }
        
        self.recordedFilesPopover = [[UIPopoverController alloc] initWithContentViewController:self.fileViewController];
        
        self.recordedFilesPopover.delegate = self;
    }
	[self.recordedFilesPopover setPopoverContentSize:CGSizeMake(320.0f, 480.0f)];
	//self.recordedFilesPopover.passthroughViews = [NSArray arrayWithObject:self.cwView];
	[self.recordedFilesPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}

//for BBFileViewControllerDelegate
- (void)hideFiles {
	[self.audioSignalManager play];
	[self.recordedFilesPopover dismissPopoverAnimated:YES];
}

//If the user dismissed by touching outside popover:
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popover {
	[self.audioSignalManager play];
}



- (IBAction)showLarvaJoltPopover:(UIButton *)sender
{
    
	[self.audioSignalManager pause];
    
    if (!self.larvaJoltPopover)
    {
        if (!self.larvaJoltController)
        {
            self.larvaJoltController = [[LarvaJoltViewController alloc] initWithNibName:@"LarvaJoltViewController" bundle:nil];
            self.larvaJoltController.delegate = self;
            self.pulse.delegate = self.larvaJoltController;
            //self.larvaJoltController.modalPresentationStyle = UIModalPresentationFormSheet;
            //self.larvaJoltController.view.frame = CGRectMake(0, 0, 620, 540);
        }
        
        self.larvaJoltPopover = [[UIPopoverController alloc] initWithContentViewController:self.larvaJoltController];
        self.larvaJoltPopover.delegate = self;
    }
    
    //self.stimButton.enabled = YES;
    //[self presentModalViewController:self.larvaJoltController animated:YES];
	[self.larvaJoltPopover setPopoverContentSize:CGSizeMake(320.0f, 480.0f)];
	[self.larvaJoltPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    
}

//for LarvaJoltViewControllerDelegate
- (void)hideLarvaJolt
{
	//[self dismissModalViewControllerAnimated:YES];
    [self.larvaJoltPopover dismissPopoverAnimated:YES];
	[self.audioSignalManager play];
}


@end
