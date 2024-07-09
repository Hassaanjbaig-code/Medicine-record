// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import { Application } from "@hotwired/stimulus"
import push_controller from "./controllers/push_controller"

const application = Application.start()
application.register("push", push_controller)