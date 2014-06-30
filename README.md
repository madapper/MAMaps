MAMaps
======

A framework that allows creation of maps using geodata. The current version is only in it's alpha format, but developers are invited to make this better. Currently, it uses a jason data fie to create a world map using either overlays or buttons. However, methods have been put in place to allow users to generate a json file for a specific area and input this into the framework.

This was used in the creation of the "Rise of the Droid" video as seen here:

www.youtube.com/ILoMIb8SNlI

<b>Implementation</b>

Adding the framework is as simple as dragging the framework MAMaps.framework into the project, then importing it:
<pre>
#import <MAMaps/MAMAps.h>
</pre>
Once you have created it you can add this as an overlay, by adding the following lines of code to the View Controller containing the MKMapView:

<pre>

-(CGRect)getFrame{
    CGRect rect = CGRectMake(0, 20 + self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-20);
    return rect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    MAMapsShape *shape = [[MAMapsShape alloc]initWithShapes:MAMapShapeWorldFull];
    
    MAMapsOverlays *overlays = [[MAMapsOverlays alloc]initWithShape:shape];
    
    mv = [[MKMapView alloc]initWithFrame:[self getFrame]];
    [self.view addSubview:mv];
    
    mv.delegate = self;
    
    for (MKPolygon *polygon in overlays.overlaysAll) {
        [mv addOverlay:polygon];
    }

}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if (![overlay isKindOfClass:[MKPolygon class]]) {
        return nil;
    }
    MKPolygon *polygon = overlay;
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon];
    if ([polygon.subtitle isEqualToString:@"touched"]) {
        renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    }else{
        renderer.fillColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    renderer.strokeColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    
    return renderer;
}
</pre>

Alternatively, if you want to work with a button system, you can create the buttons as such:
<pre>
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
</pre>

<b>Known Issues and Future Improvements<b>

- Currently the demo version of this only runs on real devices. Iam loking into this to ascertain why and correct it.
- There is a memory issue due to objects being created when not visible. This is being corrected
- MAMapButtons delegate methods are being added.







