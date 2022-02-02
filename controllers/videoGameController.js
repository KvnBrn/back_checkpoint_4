import express from 'express';
import Joi from 'joi';
import VideoGame from '../models/videoGameModel.js';

const router = express.Router(); 

const schemaVideoGame = Joi.object({
    name: Joi.string().max(255).required(),
    image: Joi.string().max(255).required(),
    description: Joi.string().required(),
    id_rate: Joi.number().integer().required(),
  });

router.get("/", async (req, res) => {
    try {
      const videoGames = await VideoGame.getAll();
      res.json(videoGames);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
router.get("/:id", async (req, res) => {
  const id = req.params.id;
  try {
    const videoGame = await VideoGame.getOneById(id);
    videoGame
      ? res.json(videoGame)
      : res.status(404).json({ message: `Video Game not found` });
  } catch (error) {
      res.status(500).json({ message: error.message });
  }
});

router.delete("/:id", async (req, res) => {
  const id = req.params.id;
  try {
    const result = await VideoGame.deleteById(id);
    result
      ? res.json({ message: `Video Game ${id} has been deleted !` })
      : res.status(404).json({ message: "Video Game not found" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.post("/", async (req, res) => {
  const { name, image, description, id_rate } = req.body;
  try {
    const { error, value } = await schemaVideoGame.validate({
      name,
      image,
      description,
      id_rate,
    });
    const lastInsertId = await VideoGame.createNew(value);
    if (lastInsertId) {
      const newVideoGame = await VideoGame.getOneById(lastInsertId);
      res.json(newVideoGame);
    } else res.status(422).json({ message: error.message });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.put("/:id", async (req, res) => {
  const { name, image, description, id_rate } = req.body;
  try {
    const { error, value } = await schemaVideoGame.validate({
      name,
      image,
      description,
      id_rate,
    });
    const videoGameUpdate = await VideoGame.updateVideoGame(req.params.id, value);
      if (videoGameUpdate) res.json(value);
      else res.status(422).json({ message: error.message });
  } catch (err) {
      res.status(500).json({ message: err.message });
  }
});

export default router;
