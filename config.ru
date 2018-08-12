require './controllers/app'
require './controllers/clients_controller'
require './controllers/messages_controller'

use MessagesController
use ClientsController
run App