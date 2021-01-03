import Gtk

let status = Application.run(startupHandler: nil) { app in
    let window = ApplicationWindowRef(application: app)
    window.title = "Hello, world"
    window.setDefaultSize(width: 320, height: 240)
    let label = LabelRef(str: "Hello, SwiftGtk")
    window.set(child: label)
    window.show()
}

guard let status = status else {
    fatalError("Could not create Application")
}
guard status == 0 else {
    fatalError("Application exited with status \(status)")
}
