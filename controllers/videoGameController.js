import express from 'express';
import Joi from 'joi';
import videoGame from '../models/videoGameModel.js';

const router = express.Router(); 

router.get("/", async (req, res) => {
    try {
      const videoGames = await videoGame.getAll();
      res.json(videoGames);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  router.get("/:id", async (req, res) => {
    const id = req.params.id;
    try {
      const videoGame = await videoGame.getOneById(id);
      videoGame
        ? res.json(videoGame)
        : res.status(404).json({ message: `videoGame not found` });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

export default router;
