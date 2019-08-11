//
//  ViewController.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 29/07/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var place = Place()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//
//        // Set the view's delegate
//        sceneView.delegate = self
//
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/Palacio/Palacio.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        // Create a new scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        // Gestures
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGesure)
        
        //addLight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    

    func addModel(x: Float = 0, y: Float = 0, z: Float = -0.5) {
        guard let modelScene = SCNScene(named: "art.scnassets/Palacio/Palacio.scn") else { return }
        let modelNode = SCNNode()
        let modelSceneChildNodes = modelScene.rootNode.childNodes
        
        for childNode in modelSceneChildNodes {
            modelNode.addChildNode(childNode)
        }
        
        modelNode.position = SCNVector3(x, y, z)
        modelNode.scale = SCNVector3(0.5, 0.5, 0.5)
        sceneView.scene.rootNode.addChildNode(modelNode)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    func addFoodModelTo(position: SCNVector3) {
        // 1
        //guard let fruitCakeScene = SCNScene(named: "art.scnassets/plaza/plaza.dae") else {
        guard let fruitCakeScene = SCNScene(named: place.realidad) else {
            fatalError("Unable to find \(place.realidad)")
        }
        // 2
        guard let baseNode = fruitCakeScene.rootNode.childNode(withName: "baseNode", recursively: true) else {
            fatalError("Unable to find baseNode")
        }
        // 3
        baseNode.position = position
        baseNode.scale = SCNVector3Make(0.005, 0.005, 0.005)
        sceneView.scene.rootNode.addChildNode(baseNode)
        
        addPlaneTo(node: baseNode)
    }
    
    func addPlaneTo(node:SCNNode) {
        // Create a plane that only receives shadows
        let plane = SCNPlane(width: 200, height: 200)
        plane.firstMaterial?.colorBufferWriteMask = .init(rawValue: 0)
        let planeNode = SCNNode(geometry: plane)
        planeNode.rotation = SCNVector4Make(1, 0, 0, -Float.pi / 2)
        node.addChildNode(planeNode)
    }
    
    func addLight() {
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.intensity = 0
        directionalLight.castsShadow = true
        directionalLight.shadowMode = .deferred
        directionalLight.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        directionalLight.shadowSampleCount = 10
        
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        directionalLightNode.rotation = SCNVector4Make(1, 0, 0, -Float.pi / 3)
        sceneView.scene.rootNode.addChildNode(directionalLightNode)
    }
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // MARK: - Gesture Recognizers
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        guard let hitTestResult = sceneView.hitTest(location, types: .existingPlane).first else { return }
        let position = SCNVector3Make(hitTestResult.worldTransform.columns.3.x,
                                      hitTestResult.worldTransform.columns.3.y,
                                      hitTestResult.worldTransform.columns.3.z)
        addFoodModelTo(position: position)
    }
}
