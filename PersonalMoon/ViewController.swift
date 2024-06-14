import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var isDay = true // To track whether it's currently day or night
    let node = SCNNode() // Node for the sphere

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        // sceneView.showsStatistics = true

        let sphere = SCNSphere(radius: 0.1)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/8k_earth_daymap.jpg")
        sphere.materials = [material]

        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        node.geometry = sphere

        // Create a new scene
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true

        // Add the switch button
        addSwitchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    /*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
    */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }

    private func addSwitchButton() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: view.bounds.height - 60, width: 100, height: 40)
        button.backgroundColor = .white
        button.setTitle("Switch", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(switchDayNight), for: .touchUpInside)
        
        view.addSubview(button)
    }

    @objc private func switchDayNight() {
        isDay.toggle()
        let material = SCNMaterial()
        material.diffuse.contents = isDay ? UIImage(named: "art.scnassets/8k_earth_daymap.jpg") : UIImage(named: "art.scnassets/8k_earth_nightmap.jpg")
        node.geometry?.materials = [material]
    }
}
