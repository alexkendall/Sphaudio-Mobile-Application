//
//  ViewController.swift
//  SceneKitTutorial
//
//  Created by Alex Harrison on 10/17/15.
//  Copyright © 2015 Alex Harrison. All rights reserved.
//

import UIKit
import SceneKit

var timer:NSTimer!;
var sphere_node:SCNNode!;
var rising:Bool = true;
var spheres = [SCNNode]();
var rise_button:UIButton!;
var fall_button:UIButton!;
var t_val:Float = 0.0;
var num_rows = 5;
var num_cols = 5;
var play_button:PlayButton!;
var prev_button:PrevButton!;
var next_button:NextButton!;
var song_label:UILabel!;
var artist_label:UILabel!;
var in_main:Bool = true;


class MainController: UIViewController {
    
    var super_view:UIView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        super_view = self.view;
        let sceneView = SCNView(frame: self.view.bounds);
        sceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X;
        self.view.addSubview(sceneView);
        
        
        let scene = SCNScene();
        sceneView.scene = scene;
        
        let camera = SCNCamera();
        let cameraNode = SCNNode();
        cameraNode.camera = camera;
        
        // spot light 1
        let spot_light = SCNLight();
        spot_light.type = SCNLightTypeSpot;
        spot_light.spotInnerAngle = 0.0;
        spot_light.spotOuterAngle = 90.0;
        spot_light.castsShadow = true;
        let spot_node = SCNNode();
        spot_node.light = spot_light;
        spot_node.position = SCNVector3(0.0, 10.0, 0.0);
        
        // ambient light
        let ambient_light = SCNLight();
        ambient_light.type = SCNLightTypeAmbient;
        ambient_light.color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0);
        cameraNode.light = ambient_light;
        
        
        // configure sphere
        let step:Double = 3.0;
        let origin_x = -6.0;
        
        for(var r = 0; r < num_rows; ++r)
        {
            for(var c = 0; c < num_cols; ++c)
            {
                let sphereGeometry = SCNSphere(radius: 1.0);
                sphere_node = SCNNode(geometry: sphereGeometry);
                let red_material = SCNMaterial();
                
                if((r == (num_cols - 1)) || (r == 0) || (c == 0) || (c == (num_rows - 1)))
                {
                    red_material.diffuse.contents = UIColor.greenColor();
                }
                    
                else if( Int((r * num_cols) + c) == Int(Double(num_rows) * Double(num_cols) * 0.5))
                {
                    red_material.diffuse.contents = UIColor.greenColor();
                }
                else
                {
                    red_material.diffuse.contents = UIColor.greenColor();
                }
                sphereGeometry.materials = [red_material];
                
                let x:Double = origin_x + (Double(c) * step);
                let y:Double = Double(r) * step;
                sphere_node.position = SCNVector3(x, 0.5, y);
                scene.rootNode.addChildNode(sphere_node);
                spheres.append(sphere_node);
            }
        }
        
        // configure plane
        let planeGeometry = SCNPlane(width: 1000.0, height: 1000.0);
        let planeNode = SCNNode(geometry: planeGeometry);
        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0);
        planeNode.position = SCNVector3(x: 0, y: -0.5, z: 0);
        let plane_material = SCNMaterial();
        plane_material.diffuse.contents = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0);
        planeGeometry.materials = [plane_material];
        
        // configure sky plane
        let back_planeGeometry = SCNPlane(width: 1000.0, height: 1000.0);
        let backplaneNode = SCNNode(geometry: planeGeometry);
        backplaneNode.position = SCNVector3(x: 0, y: 100.0, z: -50);
        let back_plane_material = SCNMaterial();
        back_plane_material.diffuse.contents = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0);
        back_planeGeometry.materials = [plane_material];
        
        // configure
        scene.rootNode.addChildNode(spot_node);
        scene.rootNode.addChildNode(cameraNode);
        scene.rootNode.addChildNode(planeNode);
        scene.rootNode.addChildNode(backplaneNode);
        
        
        // configure camera position and eye
        cameraNode.position = SCNVector3(0.0, 10.0, 35.0);
        print(spheres.count/2);
        let constraint = SCNLookAtConstraint(target: spheres[12]);
        constraint.gimbalLockEnabled = true;
        cameraNode.constraints = [constraint];
        spot_node.constraints = [constraint];
        
        
        // rise button efficiency test
        let margin = super_view.bounds.width * 0.05;
        let width:CGFloat = (super_view.bounds.width - (margin * 3.0)) * 0.5;
        let height:CGFloat = super_view.bounds.height * 0.05;
        rise_button = UIButton(frame: CGRect(x: margin, y: margin, width: width, height: height));
        rise_button.backgroundColor = UIColor.whiteColor();
        rise_button.setTitle("Animate Up", forState: UIControlState.Normal);
        rise_button.addTarget(self, action: "animate_up", forControlEvents: UIControlEvents.TouchUpInside);
        rise_button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        rise_button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        rise_button.layer.cornerRadius = rise_button.frame.width * 0.025;
        //super_view.addSubview(rise_button);
        
        // fall button efficiency test
        fall_button = UIButton(frame: CGRect(x: rise_button.frame.maxX + margin, y: margin, width: width, height: height));
        fall_button.backgroundColor = UIColor.whiteColor();
        fall_button.setTitle("Animate Down", forState: UIControlState.Normal);
        fall_button.addTarget(self, action: "animate_down", forControlEvents: UIControlEvents.TouchUpInside);
        fall_button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        fall_button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        fall_button.layer.cornerRadius = fall_button.frame.width * 0.025;
        //super_view.addSubview(fall_button);
        
        // configure audio buttons
        let play_dim = super_view.frame.width * 0.075;
        let play_offset_x = (super_view.frame.width - play_dim) * 0.5;
        let play_offset_y = super_view.frame.height * 0.7
        play_button = PlayButton(frame: CGRect(x: play_offset_x, y: play_offset_y, width: play_dim, height: play_dim));
        super_view.addSubview(play_button);
        
        // configure previous button
        let prev_dim = super_view.frame.width * 0.06;
        let prev_offset_x = (super_view.frame.width - play_dim) * 0.5 - (prev_dim * 4.0);
        let prev_offset_y = super_view.frame.height * 0.705;
        prev_button = PrevButton(frame: CGRect(x: prev_offset_x, y: prev_offset_y, width: prev_dim, height: prev_dim));
        super_view.addSubview(prev_button);
        
        // configure next button
        let next_dim = super_view.frame.width * 0.06;
        let next_offset_x = (super_view.frame.width - play_dim) * 0.5 + (prev_dim * 4.0);
        let next_offset_y = super_view.frame.height * 0.705;
        next_button = NextButton(frame: CGRect(x: next_offset_x, y: next_offset_y, width: next_dim, height: next_dim));
        super_view.addSubview(next_button);
        
        // song label
        song_label = UILabel(frame: CGRect(x: 0.0, y: super_view.bounds.height * 0.2, width: super_view.bounds.width, height: 40.0));
        song_label.text = "The Vallkyrie: Ride of the Vallkyries";
        song_label.textAlignment = NSTextAlignment.Center;
        song_label.textColor = UIColor.whiteColor();
        song_label.font = UIFont.boldSystemFontOfSize(18.0);
        super_view.addSubview(song_label);
        
        // artist label
        artist_label = UILabel(frame: CGRect(x: 0.0, y: (super_view.bounds.height * 0.2) + 30.0, width: super_view.bounds.width, height: 40.0));
        artist_label.text = "Richard Wagner";
        artist_label.textAlignment = NSTextAlignment.Center;
        artist_label.textColor = UIColor.whiteColor();
        super_view.addSubview(artist_label);
        
        // hamburger button
        let ham_dim:CGFloat = super_view.bounds.width * 0.12;
        let ham_margin:CGFloat = 20.0;
        let ham_button = HamburgerButton(frame: CGRect(x: ham_margin, y: ham_margin, width: ham_dim, height: ham_dim));
        super_view.addSubview(ham_button);
        ham_button.addTarget(self, action: "switch_controller", forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animate_up()
    {
        SCNTransaction.begin();
        SCNTransaction.setAnimationDuration(1.0);
        spheres[20].position = SCNVector3Make(spheres[20].position.x, 10.0, spheres[20].position.z);
        spheres[20].geometry!.materials[0].diffuse.contents = UIColor.orangeColor();
        SCNTransaction.commit();
    }
    
    func animate_down()
    {
        SCNTransaction.begin();
        SCNTransaction.setAnimationDuration(1.0);
        spheres[20].position = SCNVector3Make(spheres[20].position.x, 0.5, spheres[20].position.z);
        spheres[20].geometry!.materials[0].diffuse.contents = UIColor.greenColor();
        SCNTransaction.commit();
    }
    
    func play()
    {
        print("playing song");
    }
    
    func stop()
    {
        print("pausing song");
    }
    
    func next()
    {
        print("skipping to next song");
    }
    
    func prev()
    {
        print("playing previous song");
    }
    
    func switch_controller()
    {
        if(in_main)
        {
            self.view.addSubview(song_controller.view);
            in_main = false;
        }
        else
        {
            song_controller.view.removeFromSuperview();
            in_main = true;
        }
    }
    
}

