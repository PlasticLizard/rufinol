
Rufinol.configure!

# rack middlewares, business as usual...

use Rack::CommonLogger
use Rack::Lint
use Rack::ShowExceptions

run Rufinol::Application






