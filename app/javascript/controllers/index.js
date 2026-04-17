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

import BookmarkController from "./bookmark_controller"
application.register("bookmark", BookmarkController)

import ReadingListController from "./reading_list_controller"
application.register("reading-list", ReadingListController)

import SearchController from "./search_controller"
application.register("search", SearchController)

import RevealController from "./reveal_controller"
application.register("reveal", RevealController)

import BusinessCardController from "./business_card_controller"
application.register("business-card", BusinessCardController)

import AutoSubmitController from "./auto_submit_controller"
application.register("auto-submit", AutoSubmitController)

import RichEditorController from "./rich_editor_controller"
application.register("rich-editor", RichEditorController)
