import { application } from "./application"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import YoutubeController from "./youtube_controller"
application.register("youtube", YoutubeController)

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import FormValidationController from "./form_validation_controller"
application.register("form-validation", FormValidationController)

import AnimateController from "./animate_controller"
application.register("animate", AnimateController)

import SliderController from "./slider_controller"
application.register("slider", SliderController)
