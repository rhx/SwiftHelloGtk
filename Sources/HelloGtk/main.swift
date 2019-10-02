import Gtk

let status = Application.run { app in
    let window = ApplicationWindowRef(application: app)
    window.title = "Hello, world"
    window.setDefaultSize(width: 320, height: 240)
    let label = Label(str: "Hello, SwiftGtk")
    window.add(widget: label)
    window.showAll()
}

guard let status = status else {
    fatalError("Could not create Application")
}
guard status == 0 else {
    fatalError("Application exited with status \(status)")
}
