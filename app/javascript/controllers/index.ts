import { application } from "./application"

import LightboxController from "./lightbox_controller"
import LikenessUploaderController from "./likeness_uploader_controller"
import MessagesController from "./messages_controller"
import NapcController from "./napc_controller"
import PlayerController from "./player_controller"
import PronounFormController from "./pronoun_form_controller"
import PronunciationFormController from "./pronunciation_form_controller"
import PublicProfileController from "./public_profile_controller"
import RecorderController from "./recorder_controller"
import UrlController from "./url_controller"

application.register("lightbox", LightboxController)
application.register("likeness-uploader", LikenessUploaderController)
application.register("messages", MessagesController)
application.register("napc", NapcController)
application.register("player", PlayerController)
application.register("pronoun-form", PronounFormController)
application.register("pronunciation-form", PronunciationFormController)
application.register("public-profile", PublicProfileController)
application.register("recorder", RecorderController)
application.register("url", UrlController)
