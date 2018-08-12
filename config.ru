require './app/controllers/app'
require './app/controllers/clients_controller'
require './app/controllers/messages_controller'

use MessagesController
use ClientsController
run App