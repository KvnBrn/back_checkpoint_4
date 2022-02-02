import videoGameController from '../controllers/videoGameController.js';
import securityController from '../controllers/securityController.js';
import adminController from '../controllers/adminController.js';

export const setupRoutes = (app) => {
    app.use('/', videoGameController);
    app.use('/security', securityController);
    app.use('/admin', adminController);
}
