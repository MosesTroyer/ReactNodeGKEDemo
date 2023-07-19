import 'dotenv/config'

const port = process.env.PORT;

import expressServer from './expressServer';

expressServer.listen(port, () => {
    console.log(`Server listening on: ${ port }`);
});

