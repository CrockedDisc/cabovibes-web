const path = require('path');
const { startServer } = require('next/dist/server/lib/start-server');

const dir = path.join(__dirname);
const port = process.env.PORT || 3000;

startServer({
  dir,
  isDev: false,
  hostname: "0.0.0.0",   // 🔥 Lo más importante
  port: port
}).catch((err) => {
  console.error(err);
  process.exit(1);
});
