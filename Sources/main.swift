import Gtk

let app = Application()!

let status = app.run {
    var window = ApplicationWindowRef(application: app)
    window.title = "Hello, world"
    window.setDefaultSize(width: 640, height: 480)
    window.showAll()
}

guard status == 0 else {
    fatalError("Application exited with status \(status)")
}
