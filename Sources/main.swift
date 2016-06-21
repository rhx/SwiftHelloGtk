import Gtk

let status = Application.run { app in
    var window = ApplicationWindowRef(application: app)
    window.title = "Hello, world"
    window.setDefaultSize(width: 640, height: 480)
    window.showAll()
}

guard let status = status else {
    fatalError("Could not create Application")
}
guard status == 0 else {
    fatalError("Application exited with status \(status)")
}
