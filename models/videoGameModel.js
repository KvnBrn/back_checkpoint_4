import dbConnect from '../config/db-config.js';

// READ ALL
const getAll = () => {
    return new Promise((resolve, reject) => {
        dbConnect.query('SELECT * FROM video_game',
        (err, results) => {
            if (err) reject(err);
            else resolve(results);
        })
    })
}

// READ ONE
const getOneById = (id) => {
    return new Promise((resolve, reject) => {
        dbConnect.query('SELECT vg.id, vg.name, vg.image, vg.description, vg.rate, cat.name AS cat_name FROM video_game AS vg INNER JOIN video_game_category AS vgc ON vg.id = vgc.id_video_game INNER JOIN category AS cat ON cat.id = vgc.id_category WHERE vg.id = ?', id, (err, result) => {
            if (err) reject(err);
            else resolve(result[0]);
        })
    })
}

// DELETE
const deleteById = (id) => {
    return new Promise((resolve, reject) => {
        dbConnect.query('DELETE FROM video_game WHERE id = ?', id, (err, result) => {
            if (err) reject(err);
            else resolve(result.affectedRows);
        })
    })
}

// CREATE
const createNew = (video_game) => {
    const { name, image, description, rate } = video_game;
    return new Promise((resolve, reject) => {
        dbConnect.query('INSERT INTO video_game (name, image, description, rate) VALUES (?, ?, ?, ?)', 
        [name, image, description, rate], (err, result) => {
            if (err) reject(err);
            else resolve(result.insertId);
        })
    })
}

// UPDATE
const updateVideoGame = (id, video_game) => {
    return new Promise((resolve, reject) => {
        dbConnect.query('UPDATE video_game SET ? WHERE id = ?', [video_game, id], (err, result) => {
            if (err) reject(err);
            else resolve(result);
        })
    })
}

export default { getAll, getOneById, deleteById, createNew, updateVideoGame };
